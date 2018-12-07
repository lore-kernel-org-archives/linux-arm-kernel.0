Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FACAC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:24:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F2FD20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KbuV9VHI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F2FD20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:References:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/k7SM5RJ2NGwTnNjcFlzqDMT4p7rvAdkRNwwebFZ8iE=; b=KbuV9VHIhfNoe/
	wXCbbAYNYbCfSY/wcw7GjLr331/dDDj8g4SRK0mlCmOMBA+ygCcj/FOynT0EbOvnDapkasfbz7jv5
	PFSgPJ7tzspdqi4RXgpKNG7jzSpTYzcX6ioaEpkQT2pw+jMi5nhmafxcSlVLclSpqcSgLPAhX+4Ez
	JRQP2l9ve5VKEFrOKnitLRT3p2odN0vrthl6n8UbZlOxuPBUUNJfSWBPtX+wXQSkJovP8k6Mwb+EI
	+9+z22KhuQlYhsKN7cHuUa/Fa8Dt42Z+tY18j1nle+7GCExEY0BwgKE25Sg2K1wf52zH3ZtLz/XzS
	yyCL78EbEtj1KIca6DEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVFBC-0000ys-1A; Fri, 07 Dec 2018 12:24:26 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVFB8-0000yY-84
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 12:24:23 +0000
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 07 Dec 2018 21:24:09 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
 by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 4F45960062;
 Fri,  7 Dec 2018 21:24:09 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP;
 Fri, 7 Dec 2018 21:24:09 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by iyokan.css.socionext.com (Postfix) with ESMTP id CE11340309;
 Fri,  7 Dec 2018 21:24:08 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
 by yuzu.css.socionext.com (Postfix) with ESMTP id B4226120455;
 Fri,  7 Dec 2018 21:24:08 +0900 (JST)
Date: Fri, 07 Dec 2018 21:24:08 +0900
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Will Deacon <will.deacon@arm.com>,
 James Morse <james.morse@arm.com>
Subject: Re: arm64: WARN_ON_ONCE issue when resuming from hibernation
In-Reply-To: <a21290d6-12c3-4a4a-0156-71a28b5acab6@arm.com>
References: <20181207104743.GB23587@arm.com>
 <a21290d6-12c3-4a4a-0156-71a28b5acab6@arm.com>
Message-Id: <20181207212407.9B00.4A936039@socionext.com>
MIME-Version: 1.0
X-Mailer: Becky! ver. 2.70 [ja]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_042422_389426_29519DE3 
X-CRM114-Status: GOOD (  25.88  )
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
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Will, James,

On Fri, 7 Dec 2018 12:02:57 +0000 <james.morse@arm.com> wrote:

> Hi Kunihiko, Will,
> 
> On 07/12/2018 10:47, Will Deacon wrote:
> > On Fri, Dec 07, 2018 at 10:40:50AM +0900, Kunihiko Hayashi wrote:
> >> I found that a WARN_ON_ONCE dump occured in the resuming sequence from
> >> hibernation on arm64 SoC (I use UniPhier LD20 environment).
> >>
> >>     ...
> >>     Disabling non-boot CPUs ...
> >>     CPU1: shutdown
> >>     psci: CPU1 killed.
> >>     CPU2: shutdown
> >>     psci: CPU2 killed.
> >>     CPU3: shutdown
> >>     psci: CPU3 killed.
> >>     WARNING: CPU: 0 PID: 1 at ../kernel/smp.c:416 smp_call_function_many+0xd4/0x350
> >>     Modules linked in:
> >>     CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.20.0-rc4 #1
> >>     ...
> >>
> >> I show the result of reading the code, however,
> >> I'm not sure that this issue occurs in other arm64 SoC.
> 
> It does, but you can only see it if you also have 'no_console_suspend' on the
> command-line, otherwise the console driver is frozen with the rest of the system
> when this happens.

Yes, I added 'no_console_suspend' to command-line.
Surely the console was frozen without it.

> 
> Thanks for the report!
> 
> 
> >> In the resuming sequence, once all CPUs are stopped and local IRQs
> >> are disabled [1].
> 
> >> What is the possible way to solve this issue?
> > 
> > Given that all secondary CPUs are hotplugged out at this point, we can
> > just use the non-IPI version of flush_icache_range().
> 
> Sounds good,

Thanks for your solution.
Surely we can call this non-IPI version in create_safe_exec_page().

> > --->8
> > 
> > diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> > index 6b2686d54411..29cdc99688f3 100644
> > --- a/arch/arm64/kernel/hibernate.c
> > +++ b/arch/arm64/kernel/hibernate.c
> > @@ -214,7 +214,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
> >  	}
> >  
> >  	memcpy((void *)dst, src_start, length);
> > -	flush_icache_range(dst, dst + length);
> > +	__flush_icache_range(dst, dst + length);
> >  
> >  	pgdp = pgd_offset_raw(allocator(mask), dst_addr);
> >  	if (pgd_none(READ_ONCE(*pgdp))) {
> > 
> 
> Tested-by: James Morse <james.morse@arm.com>

I also tried your diff and resume sequence from hibernation finished successfully
without WARN_ON_ONCE().

Tested-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

> This changed came from commit 3b8c9f1cdfc50 ("arm64: IPI each CPU after
> invalidating the I-cache for kernel mappings"). Which came in with v4.19 if you
> want to send it to stable. (let me know if its easier for you if I re-post your
> patch)

Agreed.

Thank you,

> 
> Thanks,
> 
> James

---
Best Regards,
Kunihiko Hayashi



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
