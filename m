Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3212FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:00:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01A772173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aqZKe9TZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A772173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r3UOXyTpr8MOqP3AngS+iH/KYd13ZhekXgYRndQxX6o=; b=aqZKe9TZasXOBl
	BaoOJnwK6kjdwPCFsqSHL/sWW2nggoIg/aWduUBJ11BczbMc/q9GyFotQ8fVv+N2oGVhdLZgpwKrm
	RHh+22VK7Mo/Y7LYBqRjb7gDcTZJIzQCGSK3LtZ3biLlTufP1tGqnu0/P1+QgNJ4q26kwz2lI874r
	TGKEpu4g3YOKyN6zp0FTHdTfdI+Ssa+I0NRs6pcb2a8Mazh9SxZsW9lSxY6XPBgAXcuSkDQgtLAte
	XPxeSjyLUCqAOVQ5+4nV+4BId+iPKhS02OyljOeGkkLmNdU0NcU6i56rTCRb8jB7xpIPsebf8MzOI
	rtV86Le6FfP6P3XcTIaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggWOI-0004eG-7C; Mon, 07 Jan 2019 15:00:34 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggWO8-0004Y2-3F; Mon, 07 Jan 2019 15:00:29 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6372480D;
 Mon,  7 Jan 2019 07:00:23 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0979E3F5B7;
 Mon,  7 Jan 2019 07:00:21 -0800 (PST)
Date: Mon, 7 Jan 2019 15:00:19 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Miles Chen <miles.chen@mediatek.com>
Subject: Re: [PATCH] arm64: trap illegal translations in __virt_to_phys()
Message-ID: <20190107150019.GC46743@lakrids.cambridge.arm.com>
References: <1546860080-13027-1-git-send-email-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546860080-13027-1-git-send-email-miles.chen@mediatek.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_070024_162656_EE21E15B 
X-CRM114-Status: GOOD (  19.56  )
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
Cc: wsd_upstream@mediatek.com, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 07, 2019 at 07:21:20PM +0800, Miles Chen wrote:
> Current __virt_to_phys() only print warning messages for non-linear
> addresses. It's hard to catch all warnings by those messages.

Why? Are you seeing a large number of warnings somewhere?

> So add a VIRTUAL_BUG_ON() to trap all non-linear and non-symbol
> addresses (e.g., stack addresses)
> 
> Tested by pass stack addresses and symbol addresses to __pa(). Result:
> stack addresses: kernel BUG()

Either:

* Stacks are vmap'd, and __is_lm_address(stack_addr) is false. We'll
  produce a WARNING() today (and return a junk physical address).

* Stacks are linear mapped, and cannot be distinguished from other
  linear mapped addresses. The physical address will be valid.

... so I don't understand why you need to change this.

> symbol addresses: kernel warning message

That should already be the case today, since the kernel image is mapped
separately from the linear map, so __is_lm_address(symbol_addr) should
be false.

> 
> Maybe we should trap all non-linear address translations in the future.
> 
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---
>  arch/arm64/mm/physaddr.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/mm/physaddr.c b/arch/arm64/mm/physaddr.c
> index 67a9ba9eaa96..f6b935dad19c 100644
> --- a/arch/arm64/mm/physaddr.c
> +++ b/arch/arm64/mm/physaddr.c
> @@ -14,6 +14,11 @@ phys_addr_t __virt_to_phys(unsigned long x)
>  	      (void *)x,
>  	      (void *)x);
>  
> +	/* trap all non-linear and non-symbol addresses */
> +	VIRTUAL_BUG_ON(!__is_lm_address(x) &&
> +			(x < (unsigned long)KERNEL_START ||
> +			 x > (unsigned long)KERNEL_END));

The KERNEL_START and KERNEL_END definitions refer to the kernel image,
not the linear map, so it doesn't make any sense to permit those here.

It is *not* valid to call __virt_to_phys() with a symbol address. We
only support those in __virt_to_phys_nodebug() so that broken code has a
chance of stumbling on.

If you want the kernel to die immediately when it hits a warning here,
please set panic_on_warn.

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
