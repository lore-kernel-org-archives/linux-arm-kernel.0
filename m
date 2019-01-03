Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A24C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:39:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7719D208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h+OxBGya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7719D208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SjRC9DMTNqqWHD8GNON7HDXSuxf7uk5WxhA2nmEVifY=; b=h+OxBGyajEnjQ6
	g1yFYc3fkt+yB9476Q6vRkoJRXe4jAT1qKUi1M1+tQGV+E9l4ctKTqsHbhZfIcEm+EsYWZ6KZXhPz
	mmMGqM9iF7pGnRk4aL/hFPa9VmlDOCep6LD7MxLUkHIWjOdGzhHTPL9eAhbGk9inbcJ4y3zNBa4Yy
	Ice6oxwAWDtw/M0ZOwdSOJFQSEGIAt9aWIRTCd5JnP3PoOnzC4Sy6U8nF/wX11X8nJDOLSXx9mQFM
	1zIPbyBwfv5JLzm1KnQZKiDtlGDvdhxJrlvvYeNQBIYbOG3+Q4Iz7y1MXWYlGF+/ogbaKGIduZAXH
	0M0TCqIVNCbcSN/sAspQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf55T-0005H3-ID; Thu, 03 Jan 2019 15:39:11 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf55Q-0005GY-ES
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 15:39:09 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A78BA78;
 Thu,  3 Jan 2019 07:39:06 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88FB03F575;
 Thu,  3 Jan 2019 07:39:05 -0800 (PST)
Date: Thu, 3 Jan 2019 15:39:03 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: Re: [PATCH] arm64: smp: Fix compilation error
Message-ID: <20190103153902.GD45937@lakrids.cambridge.arm.com>
References: <1546047797-48275-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546047797-48275-1-git-send-email-zhangshaokun@hisilicon.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_073908_485970_6F8A83E1 
X-CRM114-Status: GOOD (  16.36  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 29, 2018 at 09:43:17AM +0800, Shaokun Zhang wrote:
> For arm64: updates for 4.21, there is a compilation error:
> arch/arm64/kernel/head.S: Assembler messages:
> arch/arm64/kernel/head.S:824: Error: missing ')'
> arch/arm64/kernel/head.S:824: Error: missing ')'
> arch/arm64/kernel/head.S:824: Error: missing ')'
> arch/arm64/kernel/head.S:824: Error: unexpected characters following instruction at operand 2 -- `mov x2,#(2)|(2U<<(8))'
> scripts/Makefile.build:391: recipe for target 'arch/arm64/kernel/head.o' failed
> make[1]: *** [arch/arm64/kernel/head.o] Error 1
> GCC version is gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609
> 
> Let's fix it using the UL() macro.
> 
> Fixes: 66f16a24512f ("arm64: smp: Rework early feature mismatched detection")
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  arch/arm64/include/asm/smp.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
> index 1895561839a9..99c9ed170072 100644
> --- a/arch/arm64/include/asm/smp.h
> +++ b/arch/arm64/include/asm/smp.h
> @@ -25,12 +25,12 @@
>  /* The cpu invoked ops->cpu_die, synchronise it with cpu_kill */
>  #define CPU_KILL_ME			(1)
>  /* The cpu couldn't die gracefully and is looping in the kernel */
> -#define CPU_STUCK_IN_KERNEL		(2)
> +#define CPU_STUCK_IN_KERNEL		UL(2)

I don't think we need this here.

If we want this for consistenty, it should be applied to all of the
CPU_* definitions, and should probably rethink CPU_MMU_OFF.

>  /* Fatal system error detected by secondary CPU, crash the system */
>  #define CPU_PANIC_KERNEL		(3)
>  
>  #define CPU_STUCK_REASON_52_BIT_VA	(1U << CPU_STUCK_REASON_SHIFT)
> -#define CPU_STUCK_REASON_NO_GRAN	(2U << CPU_STUCK_REASON_SHIFT)
> +#define CPU_STUCK_REASON_NO_GRAN	(UL(2) << CPU_STUCK_REASON_SHIFT)

We'll need this for CPU_STUCK_REASON_52_BIT_VA, too.

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
