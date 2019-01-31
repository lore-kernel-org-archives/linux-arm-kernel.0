Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C76C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:09:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20B6E2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BsF50kAB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B6E2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m34eKa8IAVgKCtgflKImDXAj//M8NmQyridcxNaqFbQ=; b=BsF50kAByAkHTy
	eSmyRshWs4N5Ai3bCsetDGqo6SAnaWIY6gRl0BbOmmWGX/pZjztSNgG7TaOIYtrHlbekSOwKWqHKt
	BsY4tXe7Pz/HN9dRjaQE8At/x4+tYFJAYf3ELMbtkapuGopmnNO/cZ+6MCljj7lOxPYVAMu6xSVui
	b2Q5zUvma7PZIGNRGVSnQq07w3WRPq3MMnwO0N805mKExQNjIxgjIfSM3SH0jg7NlnK1zPTJkjlSN
	85CIBbafnYXRyukIvxJXSAKvDQNmTIyICN5Ah/6H/PUJNwTserLBdHYHwPfo//Y77HqVzEozlBxKz
	zKInnxNzk+alAdojtF2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp7PQ-0000qV-3g; Thu, 31 Jan 2019 08:09:16 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp7P2-0000aP-Bm
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 08:08:54 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91FC515AD;
 Thu, 31 Jan 2019 00:08:51 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 031783F589;
 Thu, 31 Jan 2019 00:08:50 -0800 (PST)
Date: Thu, 31 Jan 2019 09:08:49 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v2 2/4] arm64: kprobe: Always blacklist the KVM
 world-switch code
Message-ID: <20190131080849.GL13482@e113682-lin.lund.arm.com>
References: <20190124163257.233929-1-james.morse@arm.com>
 <20190124163257.233929-3-james.morse@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190124163257.233929-3-james.morse@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_000852_404699_06091143 
X-CRM114-Status: GOOD (  21.81  )
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

On Thu, Jan 24, 2019 at 04:32:55PM +0000, James Morse wrote:
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
> Fixes: 888b3c8720e0 ("arm64: Treat all entry code as non-kprobe-able")
> Signed-off-by: James Morse <james.morse@arm.com>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>

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

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
