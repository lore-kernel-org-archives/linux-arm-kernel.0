Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF834C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:45:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1A98222D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K0HOaTTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A98222D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U1PU4yfZ664xIdYAzKVuAdj4E2kAtozhdnYtdLR57uc=; b=K0HOaTTmUmTtEH
	k8ME8m0EIE9xMSfd3R87nETO3vfef5XTkt/GvAvs/GNod+TzY35xC9sPoLoX5RmMKpLIp6uc/rhr4
	8DIS/FH+Wxpy3io3X0Zdc/jKWkuiBTJguibsVqxDEHfASgT05kKyZPPxZo10pVWRrmu2NGW0QJb2T
	2CA4Pg4BwtacY43qnfSk4ViihOIiQEGGikdEm128N914byNcI3NdeencfUHOU/juallyxQCZ8fo7E
	zLEhjMXDRN7s+veJ5GsayN9WEfZRtdQwKw/JYyU+01Fi0hlaRn6lb7cIora3roWblWrD+jBgfiUjN
	hWvOGtQX/yS9Aitw8kGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guL4C-0002ZV-78; Thu, 14 Feb 2019 17:44:56 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guL48-0002Z8-UX
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 17:44:54 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 5C65B6FA8C; Thu, 14 Feb 2019 18:44:51 +0100 (CET)
Date: Thu, 14 Feb 2019 18:44:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Khalid Aziz <khalid.aziz@oracle.com>
Subject: Re: [RFC PATCH v8 04/14] swiotlb: Map the buffer if it was
 unmapped by XPFO
Message-ID: <20190214174451.GA3338@lst.de>
References: <cover.1550088114.git.khalid.aziz@oracle.com>
 <b595ffb3231dfef3c6b6c896a8e1cba0e838978c.1550088114.git.khalid.aziz@oracle.com>
 <20190214074747.GA10666@lst.de>
 <3c75c46c-2a5a-cd75-83d4-f77d96d22f7d@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3c75c46c-2a5a-cd75-83d4-f77d96d22f7d@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_094453_135839_17D84891 
X-CRM114-Status: GOOD (  18.10  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mhocko@suse.com, tglx@linutronix.de, kernel-hardening@lists.openwall.com,
 peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
 dave.hansen@intel.com, deepa.srinivasan@oracle.com, steven.sistare@oracle.com,
 Tycho Andersen <tycho@docker.com>, Christoph Hellwig <hch@lst.de>,
 tycho@tycho.ws, ak@linux.intel.com, kirill.shutemov@linux.intel.com,
 x86@kernel.org, jmorris@namei.org, kanth.ghatraju@oracle.com,
 jsteckli@amazon.de, labbott@redhat.com, pradeep.vincent@oracle.com,
 konrad.wilk@oracle.com, jcm@redhat.com, liran.alon@oracle.com, luto@kernel.org,
 boris.ostrovsky@oracle.com, chris.hyser@oracle.com,
 linux-arm-kernel@lists.infradead.org, jmattson@google.com, linux-mm@kvack.org,
 juergh@gmail.com, andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
 tyhicks@canonical.com, john.haxby@oracle.com,
 Juerg Haefliger <juerg.haefliger@canonical.com>, oao.m.martins@oracle.com,
 keescook@google.com, akpm@linux-foundation.org, torvalds@linux-foundation.org,
 dwmw@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 09:56:24AM -0700, Khalid Aziz wrote:
> On 2/14/19 12:47 AM, Christoph Hellwig wrote:
> > On Wed, Feb 13, 2019 at 05:01:27PM -0700, Khalid Aziz wrote:
> >> +++ b/kernel/dma/swiotlb.c
> >> @@ -396,8 +396,9 @@ static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
> >>  {
> >>  	unsigned long pfn = PFN_DOWN(orig_addr);
> >>  	unsigned char *vaddr = phys_to_virt(tlb_addr);
> >> +	struct page *page = pfn_to_page(pfn);
> >>  
> >> -	if (PageHighMem(pfn_to_page(pfn))) {
> >> +	if (PageHighMem(page) || xpfo_page_is_unmapped(page)) {
> > 
> > I think this just wants a page_unmapped or similar helper instead of
> > needing the xpfo_page_is_unmapped check.  We actually have quite
> > a few similar construct in the arch dma mapping code for architectures
> > that require cache flushing.
> 
> As I am not the original author of this patch, I am interpreting the
> original intent. I think xpfo_page_is_unmapped() was added to account
> for kernel build without CONFIG_XPFO. xpfo_page_is_unmapped() has an
> alternate definition to return false if CONFIG_XPFO is not defined.
> xpfo_is_unmapped() is cleaned up further in patch 11 ("xpfo, mm: remove
> dependency on CONFIG_PAGE_EXTENSION") to a one-liner "return
> PageXpfoUnmapped(page);". xpfo_is_unmapped() can be eliminated entirely
> by adding an else clause to the following code added by that patch:

The point I'm making it that just about every PageHighMem() check
before code that does a kmap* later needs to account for xpfo as well.

So instead of opencoding the above, be that using xpfo_page_is_unmapped
or PageXpfoUnmapped, we really need one self-describing helper that
checks if a page is unmapped for any reason and needs a kmap to access
it.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
