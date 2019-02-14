Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DD7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:49:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4128921916
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K13WfhR+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5MN0n8QW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4128921916
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VGxP7Yc0IpdaCxbJH8KiIIhxtpkWSAW7OBIcwXNVs68=; b=K13WfhR+P8zB8z
	zQjkIGOtc8VU1SG93U2XWDRWyUjxXs26SMFHDd7ol0figvo8kb2zgKIlbkIk9S1FKEK3NCwFuTdYI
	voW90MugOZ+sfXuOt1RG+b1u9dvUECT0yaoiC+yQtdb2dvKyNHVoXN41sYcQbLREKsgfgGLezskO9
	hfhqCcKBSxtod+mUYlVcmsAV3IRtniHaixsaXFGKPRbFi4jfGGT5gCmoUg1424NqrOojUQ9dOVqFR
	cL4Z/eBhzQntVRuSXmzUyNBzDtvIwUapFLI1pIXGM7IQfStgHN/2q59Wx6tMlzHamJkrLamq3U1sm
	4MsbzYc0IfHA2RrcWADA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guN0S-0006Uj-3p; Thu, 14 Feb 2019 19:49:12 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guN0P-0006UC-30
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 19:49:10 +0000
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1EJdiW7062012;
 Thu, 14 Feb 2019 19:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=44ag5C0KnKZ9v0n5xm9kYXZ5oCu2l/oDOkg2NTBpUXI=;
 b=5MN0n8QWLGoZiAIYHc+P1ljOzXm9A3NnlHqnj7fVjd0Yi71el8kU+50Iq1aqnXxxsf/7
 pa2Ikp4AhlO9jOPpDax8AkDG/KkluV3PlvtcmGaV5K7T/jqKsCkWegiw4CRT4Y1/zkM9
 YPp6d4nca/YPsxuLvPhs+YsoBJliCKJdVzdW7InGegAgZ/hYqBjsDFYNh8UzDqOXUwhC
 aX+cMXCZwycPE1ehXFcR0ZmpM6WMwOs1pStDgtxlP85SHpfzJKRELmhLDvYk7WepRAWh
 FNrOK+bYt9t/ef9+l8ALHCxhUm8RvKMica2GTeb8egXJzTt+0TE0KqoR5p/oqTDd5tyi /A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
 by aserp2130.oracle.com with ESMTP id 2qhre5t280-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Feb 2019 19:48:38 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1EJmVIO024689
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Feb 2019 19:48:31 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1EJmStY012916;
 Thu, 14 Feb 2019 19:48:28 GMT
Received: from [192.168.1.16] (/24.9.64.241)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 14 Feb 2019 19:48:28 +0000
Subject: Re: [RFC PATCH v8 04/14] swiotlb: Map the buffer if it was unmapped
 by XPFO
To: Christoph Hellwig <hch@lst.de>
References: <cover.1550088114.git.khalid.aziz@oracle.com>
 <b595ffb3231dfef3c6b6c896a8e1cba0e838978c.1550088114.git.khalid.aziz@oracle.com>
 <20190214074747.GA10666@lst.de>
 <3c75c46c-2a5a-cd75-83d4-f77d96d22f7d@oracle.com>
 <20190214174451.GA3338@lst.de>
From: Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <056ffba0-e970-96d5-3d0b-c0a6f9460405@oracle.com>
Date: Thu, 14 Feb 2019 12:48:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214174451.GA3338@lst.de>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9167
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=891 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902140131
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_114909_215606_262380BE 
X-CRM114-Status: GOOD (  25.31  )
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
Cc: mhocko@suse.com, kernel-hardening@lists.openwall.com, peterz@infradead.org,
 catalin.marinas@arm.com, will.deacon@arm.com, dave.hansen@intel.com,
 deepa.srinivasan@oracle.com, steven.sistare@oracle.com,
 joao.m.martins@oracle.com, tglx@linutronix.de, tycho@tycho.ws,
 ak@linux.intel.com, x86@kernel.org, jmorris@namei.org,
 kanth.ghatraju@oracle.com, jsteckli@amazon.de, labbott@redhat.com,
 pradeep.vincent@oracle.com, konrad.wilk@oracle.com, jcm@redhat.com,
 liran.alon@oracle.com, luto@kernel.org, boris.ostrovsky@oracle.com,
 chris.hyser@oracle.com, linux-arm-kernel@lists.infradead.org,
 jmattson@google.com, linux-mm@kvack.org, juergh@gmail.com,
 andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org, tyhicks@canonical.com,
 john.haxby@oracle.com, Juerg Haefliger <juerg.haefliger@canonical.com>,
 kirill.shutemov@linux.intel.com, keescook@google.com,
 akpm@linux-foundation.org, torvalds@linux-foundation.org, dwmw@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/14/19 10:44 AM, Christoph Hellwig wrote:
> On Thu, Feb 14, 2019 at 09:56:24AM -0700, Khalid Aziz wrote:
>> On 2/14/19 12:47 AM, Christoph Hellwig wrote:
>>> On Wed, Feb 13, 2019 at 05:01:27PM -0700, Khalid Aziz wrote:
>>>> +++ b/kernel/dma/swiotlb.c
>>>> @@ -396,8 +396,9 @@ static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
>>>>  {
>>>>  	unsigned long pfn = PFN_DOWN(orig_addr);
>>>>  	unsigned char *vaddr = phys_to_virt(tlb_addr);
>>>> +	struct page *page = pfn_to_page(pfn);
>>>>  
>>>> -	if (PageHighMem(pfn_to_page(pfn))) {
>>>> +	if (PageHighMem(page) || xpfo_page_is_unmapped(page)) {
>>>
>>> I think this just wants a page_unmapped or similar helper instead of
>>> needing the xpfo_page_is_unmapped check.  We actually have quite
>>> a few similar construct in the arch dma mapping code for architectures
>>> that require cache flushing.
>>
>> As I am not the original author of this patch, I am interpreting the
>> original intent. I think xpfo_page_is_unmapped() was added to account
>> for kernel build without CONFIG_XPFO. xpfo_page_is_unmapped() has an
>> alternate definition to return false if CONFIG_XPFO is not defined.
>> xpfo_is_unmapped() is cleaned up further in patch 11 ("xpfo, mm: remove
>> dependency on CONFIG_PAGE_EXTENSION") to a one-liner "return
>> PageXpfoUnmapped(page);". xpfo_is_unmapped() can be eliminated entirely
>> by adding an else clause to the following code added by that patch:
> 
> The point I'm making it that just about every PageHighMem() check
> before code that does a kmap* later needs to account for xpfo as well.
> 
> So instead of opencoding the above, be that using xpfo_page_is_unmapped
> or PageXpfoUnmapped, we really need one self-describing helper that
> checks if a page is unmapped for any reason and needs a kmap to access
> it.
> 

Understood. XpfoUnmapped is a the state for a page when it is a free
page. When this page is allocated to userspace and userspace passes this
page back to kernel in a syscall, kernel will always go through kmap to
map it temporarily any way. When the page is freed back to the kernel,
its mapping in physmap is restored. If the free page is allocated to
kernel, its physmap entry is preserved. So I am inclined to say a page
being XpfoUnmapped should not affect need or lack of need for kmap
elsewhere. Does that make sense?

Thanks,
Khalid


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
