Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA29BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:50:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 913C620700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ADOaPfwt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="hZRfvpFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 913C620700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J/xIT2wmk0zKyYLCQmWWl5x1U6IakU7OGVd4Fu01rT4=; b=ADOaPfwtL+kQkv
	p5taBtl0lcJiojtQoQQF/QMpHb3wriqshFpiCVdLVVS/1y7iH2utdo1ViDK6QJPYx0N1sziIsiqZX
	cDR+hH1snd8UAlvRIHZXQ3PX2l2M9I6IXcm58SS7lyYdaCKV9ATdgpaLK6AtZHFdSr9x4Rdw0dQNe
	mtgTbRd80iwET6rDmDh55gUktDovIO4SQ9pDdnlu7VSEdnOci4+ibIr4IFBYiK9VTMIwQNCoJtSfI
	sxMHFFkic7PiDG48hh1ASRNwuEy/kGE/bLVSJQERKho0dhKHB22OTw1uFuYo3SNxO9Y3lv0UXO6eZ
	LoJJxz6g2R0mZtQY+x7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi2pJ-0008OO-EL; Fri, 11 Jan 2019 19:50:45 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi2pG-0008Nh-GR
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 19:50:43 +0000
Received: by mail-pl1-x643.google.com with SMTP id t13so7190527ply.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 11:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tycho-ws.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=0RFvRSspj+TM4g9ZH1f9G6S3gOP73svoJzOPEnPv5t4=;
 b=hZRfvpFiL2GFU82hHdSqFcK7EDlD4eK85iHJyYQGf5ujdr1FylIalh7HkQKIgGLrkg
 tlEWyLmOAA5FCqjK1hPlrLI+JAa6U6Rq7fbsrXsU4k6MdBmju3TinXCTsSmlEPx9Xzm3
 El/+m5sQbuU6hIcKlC5YORmVoCFRMijjxAr1GH0OS/l/+58MbGFeLKxeOMTq1R6Th2vH
 84ypOYOkgSbg9toO+zu+U4z3IbqQ6inTF15sQ2INGGIK5C/lTnx5HUCosW3s5BE0QHQG
 JYdH+/E3C9d61Cs8Hv6KU+gfQblKSrvXY15ZolK78uJ04uQFjRrGwIXBOaGZ1VQF/eG3
 ocCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0RFvRSspj+TM4g9ZH1f9G6S3gOP73svoJzOPEnPv5t4=;
 b=NqN1wWk4HK1+phzN0Y0mj6FH5fCuFknkeZ3JyUU8ZTzPhFPyJcmw2Reo2XyIc/2IKa
 mc1yig4ZsobxNU5I4r/6nVIYg150qAOiam/4zlDGyLEaf8EsYIAopHy7KWH0tvZBnRIR
 tkTK8NewBsfLk7uVbWQWYjCT1CrB/S9gb8aK+EiEU+mtk9nBy86HhyHDARHqsllsVYtk
 iIDC/js3+K/EBACH052so6KqWwVGhIgcAncksOAbwq29pQub5xbP/7gC7cDRw1pY1dyv
 qXaw8jBlegs6P8AEZ+NbYN4J4ZK8dwz1w1o/NsOK7miOcypaEy0q1crxpqIp1v78kMSi
 ysbQ==
X-Gm-Message-State: AJcUukf0FZogDCHHsi/NO4biilUZiDtmbyJ5XMbNajoUjqmkjWun4cYH
 UWvPSt++W2MDGRoz1/TPocAdoA==
X-Google-Smtp-Source: ALg8bN5wvfpPxQ/tEkSZlfxL11J7jcZkxXuw/qimHLz/58x/qBrlLyEIqJLrf0gl0AMo3jTY+P7f6w==
X-Received: by 2002:a17:902:6b87:: with SMTP id
 p7mr16205516plk.282.1547236241206; 
 Fri, 11 Jan 2019 11:50:41 -0800 (PST)
Received: from cisco ([2601:282:901:dd7b:c69:9cc7:f9cf:ff1b])
 by smtp.gmail.com with ESMTPSA id w23sm36179695pgc.72.2019.01.11.11.50.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 11:50:40 -0800 (PST)
Date: Fri, 11 Jan 2019 12:50:37 -0700
From: Tycho Andersen <tycho@tycho.ws>
To: Khalid Aziz <khalid.aziz@oracle.com>
Subject: Re: [RFC PATCH v7 07/16] arm64/mm, xpfo: temporarily map dcache
 regions
Message-ID: <20190111195037.GH4102@cisco>
References: <cover.1547153058.git.khalid.aziz@oracle.com>
 <eba179acbfdea5a646c5548cb82138c1c3b74aa2.1547153058.git.khalid.aziz@oracle.com>
 <20190111145445.GA4102@cisco>
 <19e61a22-bbae-d0ae-8d41-158d4b46bf01@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <19e61a22-bbae-d0ae-8d41-158d4b46bf01@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_115042_626099_DE3C0C1E 
X-CRM114-Status: GOOD (  17.50  )
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
Cc: kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
 deepa.srinivasan@oracle.com, steven.sistare@oracle.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com, ak@linux.intel.com,
 hch@lst.de, kanth.ghatraju@oracle.com, jsteckli@amazon.de,
 pradeep.vincent@oracle.com, konrad.wilk@oracle.com, jcm@redhat.com,
 liran.alon@oracle.com, tglx@linutronix.de, chris.hyser@oracle.com,
 linux-arm-kernel@lists.infradead.org, jmattson@google.com, juergh@gmail.com,
 andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org, tyhicks@canonical.com,
 john.haxby@oracle.com, Juerg Haefliger <juerg.haefliger@canonical.com>,
 dwmw@amazon.co.uk, keescook@google.com, torvalds@linux-foundation.org,
 kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 11:28:19AM -0700, Khalid Aziz wrote:
> On 1/11/19 7:54 AM, Tycho Andersen wrote:
> > On Thu, Jan 10, 2019 at 02:09:39PM -0700, Khalid Aziz wrote:
> >> From: Juerg Haefliger <juerg.haefliger@canonical.com>
> >>
> >> If the page is unmapped by XPFO, a data cache flush results in a fatal
> >> page fault, so let's temporarily map the region, flush the cache, and then
> >> unmap it.
> >>
> >> v6: actually flush in the face of xpfo, and temporarily map the underlying
> >>     memory so it can be flushed correctly
> >>
> >> CC: linux-arm-kernel@lists.infradead.org
> >> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> >> Signed-off-by: Tycho Andersen <tycho@docker.com>
> >> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
> >> ---
> >>  arch/arm64/mm/flush.c | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
> >> index 30695a868107..f12f26b60319 100644
> >> --- a/arch/arm64/mm/flush.c
> >> +++ b/arch/arm64/mm/flush.c
> >> @@ -20,6 +20,7 @@
> >>  #include <linux/export.h>
> >>  #include <linux/mm.h>
> >>  #include <linux/pagemap.h>
> >> +#include <linux/xpfo.h>
> >>  
> >>  #include <asm/cacheflush.h>
> >>  #include <asm/cache.h>
> >> @@ -28,9 +29,15 @@
> >>  void sync_icache_aliases(void *kaddr, unsigned long len)
> >>  {
> >>  	unsigned long addr = (unsigned long)kaddr;
> >> +	unsigned long num_pages = XPFO_NUM_PAGES(addr, len);
> >> +	void *mapping[num_pages];
> > 
> > Does this still compile with -Wvla? It was a bad hack on my part, and
> > we should probably just drop it and come up with something else :)
> 
> I will make a note of it. I hope someone with better knowledge of arm64
> than me can come up with a better solution ;)

It's not just arm64, IIRC everywhere I used xpfo_temp_map() has a VLA.
I think this is in part because some of these paths don't allow
allocation failures, so we can't do a dynamic allocation. Perhaps we
need to reserve some memory for each call site?

Tycho

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
