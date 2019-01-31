Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2237C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:05:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D06202087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PiQc8Fn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D06202087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JmDFRs9AFD9yZT/dGdEFH0dXuVX9LXwfKUSsWC6Nyp8=; b=PiQc8Fn8MCvgzp
	1JWMK2q/2Kd7o10eZrHk84zrvkmGjEvuQILjhu15MRGr+TtJN5t6qDpsNanS5KqWL7czNOhsDrRI7
	Wg1j591wnM/lGJHo7Q+8J7eaYO8004NlJlZSd3cnbIvnaqjZ/FqaQIxZsST1cOcKRTGnmpsq8Sa+p
	2X5Cbu/TyS2mHzz/+CkwuiEHk/aCDJ4yV1JKREU7IazYKU6El8yN+jbt7Y8k8/yfjbZwKpXgz7TFb
	OrLsTN/vNLb9NneqjfLLYFFKpnk2h6TAYtiLytAQ4mWpfB7KBG8vejIRnl/CYxr72iNmsaovbYOJ4
	FiEXMy6oStBr/V5vRnjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp7Lm-00084i-V9; Thu, 31 Jan 2019 08:05:30 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp7Ki-0006C2-QX
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 08:04:47 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A04980D;
 Thu, 31 Jan 2019 00:04:23 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E75F33F589;
 Thu, 31 Jan 2019 00:04:22 -0800 (PST)
Date: Thu, 31 Jan 2019 09:04:21 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v2 3/4] arm64: hyp-stub: Forbid kprobing of the hyp-stub
Message-ID: <20190131080421.GJ13482@e113682-lin.lund.arm.com>
References: <20190124163257.233929-1-james.morse@arm.com>
 <20190124163257.233929-4-james.morse@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190124163257.233929-4-james.morse@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_000425_645330_DD512D2F 
X-CRM114-Status: GOOD (  21.67  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 24, 2019 at 04:32:56PM +0000, James Morse wrote:
> The hyp-stub is loaded by the kernel's early startup code at EL2
> during boot, before KVM takes ownership later. The hyp-stub's
> text is part of the regular kernel text, meaning it can be kprobed.
> 
> A breakpoint in the hyp-stub causes the CPU to spin in el2_sync_invalid.
> 
> Add it to the __hyp_text.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Cc: stable@vger.kernel.org
> ---
> 
> This has been a problem since kprobes was merged, it should
> probably have been covered in 888b3c8720e0.
> 
> I'm not sure __hyp_text is the right place. Its not idmaped,
> and as it contains a set of vectors, adding it to the host/hyp
> idmap sections could grow them beyond a page... but it does
> run with the MMU off, so does need to be cleaned to PoC when
> anything wacky, like hibernate happens. With this patch,
> hibernate should clean the __hyp_text to PoC too.

How did this code get cleaned before?

Is there a problem you can identify with putting it in __hyp_text?
Seems to me we should just stick it there if it has no negative
side-effects and otherwise we have to make up a separate section with a
specialized meaning.


Thanks,

    Christoffer

> ---
>  arch/arm64/kernel/hyp-stub.S | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
> index e1261fbaa374..17f325ba831e 100644
> --- a/arch/arm64/kernel/hyp-stub.S
> +++ b/arch/arm64/kernel/hyp-stub.S
> @@ -28,6 +28,8 @@
>  #include <asm/virt.h>
>  
>  	.text
> +	.pushsection	.hyp.text, "ax"
> +
>  	.align 11
>  
>  ENTRY(__hyp_stub_vectors)
> -- 
> 2.20.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
