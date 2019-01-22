Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE495C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:47:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E27121721
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iX6YRq8a";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0b5Xqe3T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E27121721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hjrZFABlTmJihQuNA6B6wykbW8VV+fdOWDfJQ6ShECA=; b=iX6YRq8aejNSEA
	HzdxRLngiwy2PZTZRN0BygiO7+U4p705Lrwc/akduMvx4d1Q0w9Yj4HosgsO6ivcp6uTBgjjQemPY
	gdGzKAPYg32LnXUCi1FDdpln5j8IK/c4hBciDwOECEF9BEX1Yo09QAa7D1kXXEHAKsXAPDOH/igu1
	DFmFBMlhhbRMSxSYX0kLN5/YYDy2YYlRwjCN71rcaP1q4Et8IVllBwx+u5G/ej4Gkaz89xk9PMOa4
	jWP3jBFQMY0WtZatJ3Hm6exAq4Knhqn6+jzMvuY3r7fsXIPyD5/KV6Hfzgn/F1tnkbGimeOnKhJVo
	E3X1Pf+XNn6AxDMBur4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glm6T-0004xb-TK; Tue, 22 Jan 2019 02:47:53 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glm6Q-0004xH-3k
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 02:47:51 +0000
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0EEFD20861;
 Tue, 22 Jan 2019 02:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548125269;
 bh=0+dru2PZah2CeHqOKw3td1hrYG/V7+iKoWfKzZ8MAAg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=0b5Xqe3TaPH9xr08PlislelhYtw/Bz0kX9VRNNdy7jN+z2T20lRCCbRWclrEvLYzV
 8Xr/Pv7MHlRIoBVy1uAYk1+rV8lkUY3YTIYrnasub4JG2v2U8Ibb2ewRX0WFREdoM+
 /HsslByufrqInDoELXUm/EDJdHrMKioTAiwS5xLg=
Date: Tue, 22 Jan 2019 11:47:46 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH 2/4] arm64: kprobe: Always blacklist the KVM
 world-switch code
Message-Id: <20190122114746.437af5a57eb9bcf706916cf3@kernel.org>
In-Reply-To: <20190121170404.142966-3-james.morse@arm.com>
References: <20190121170404.142966-1-james.morse@arm.com>
 <20190121170404.142966-3-james.morse@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_184750_177238_7D318EBB 
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 21 Jan 2019 17:04:02 +0000
James Morse <james.morse@arm.com> wrote:

> On systems with VHE the kernel and KVM's world-switch code run at the
> same exception level. Code that is only used on a VHE system does not
> need to be annotated as __hyp_text as it can reside anywhere in the
>  kernel text.
> 
> __hyp_text was also used to prevent kprobes from patching breakpoint
> instructions into this region, as this code runs at a different
> exception level. While this is no longer true with VHE, KVM still
> switches VBAR_EL1, meaning a kprobe's breakpoint executed in the
> world-switch code will cause a hyp-panic.
> 
> Move the __hyp_text check in the kprobes blacklist so it applies on
> VHE systems too, to cover the common code and guest enter/exit
> assembly.
> 

Looks good to me!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> Signed-off-by: James Morse <james.morse@arm.com>
> Fixes: 888b3c8720e0 ("arm64: Treat all entry code as non-kprobe-able")
> ---
>  arch/arm64/kernel/probes/kprobes.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index 2a5b338b2542..f17afb99890c 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -478,13 +478,13 @@ bool arch_within_kprobe_blacklist(unsigned long addr)
>  	    addr < (unsigned long)__entry_text_end) ||
>  	    (addr >= (unsigned long)__idmap_text_start &&
>  	    addr < (unsigned long)__idmap_text_end) ||
> +	    (addr >= (unsigned long)__hyp_text_start &&
> +	    addr < (unsigned long)__hyp_text_end) ||
>  	    !!search_exception_tables(addr))
>  		return true;
>  
>  	if (!is_kernel_in_hyp_mode()) {
> -		if ((addr >= (unsigned long)__hyp_text_start &&
> -		    addr < (unsigned long)__hyp_text_end) ||
> -		    (addr >= (unsigned long)__hyp_idmap_text_start &&
> +		if ((addr >= (unsigned long)__hyp_idmap_text_start &&
>  		    addr < (unsigned long)__hyp_idmap_text_end))
>  			return true;
>  	}
> -- 
> 2.20.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
