Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3D0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:07:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F136C20815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PBsc76/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F136C20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hRFKU58XFPnb6PDlFzbE0xi5PAppTPddAIuJJFD2mhY=; b=PBsc76/oYZaJax
	ibidDkJphD+soDN8/8s42sTUBDbCfNApcF0vjleWs9VmnzTiJeXtjM1P5XNziTNwCuEvkhbVnStrU
	zHJzGMa6sv1Xr6tqybR2sGjVHiT91bfYUgqcCmcXqPVzJucHff3PmcQk72bDazUGiPwbwRuBmnRIl
	OP9tFSjbsoa64R6IxPEezye8xjneEe4fHkSaOQoUBwWZgBke7xKEcfqIWq9JAiPQmv5+p9+7w0VqG
	1aJk+W0XoV73Tzp307SzPZWeGcri8PzGq1bwFsmQ0VZKqbXZSlzK+VbWNyrgvZqWFNPPauzJaPA4L
	BfgqxeFEHmw201oO6NBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf6Sv-00066G-Ch; Thu, 03 Jan 2019 17:07:29 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf6Ss-00065r-4t
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 17:07:27 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75E8515AD;
 Thu,  3 Jan 2019 09:07:25 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3159F3F5D4;
 Thu,  3 Jan 2019 09:07:24 -0800 (PST)
Subject: Re: [PATCH 2/3] arm64: kprobes: Remove unneeded RODATA check
To: Masami Hiramatsu <mhiramat@kernel.org>
References: <154502881646.30629.9938335052821665530.stgit@devbox>
 <154502887509.30629.17754148993239954461.stgit@devbox>
From: James Morse <james.morse@arm.com>
Message-ID: <3bebf737-fe6b-33c8-e535-5d155591b303@arm.com>
Date: Thu, 3 Jan 2019 17:07:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <154502887509.30629.17754148993239954461.stgit@devbox>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_090726_193655_B9EC186D 
X-CRM114-Status: GOOD (  14.97  )
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
Cc: Pratyush Anand <panand@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "David A . Long" <dave.long@linaro.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi!

On 17/12/2018 06:41, Masami Hiramatsu wrote:
> Remove unneeded RODATA check from arch_prepare_kprobe().
> 
> Since check_kprobe_address_safe() already ensured that
> the probe address is in kernel text, we don't need to
> check whether the address in RODATA or not. That must
> be always false.

So it does!

Reviewed-by: James Morse <james.morse@arm.com>


Thanks

James

> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index b2d4b7428ebc..1dae500d0a81 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -91,8 +91,6 @@ static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
>  int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  {
>  	unsigned long probe_addr = (unsigned long)p->addr;
> -	extern char __start_rodata[];
> -	extern char __end_rodata[];
>  
>  	if (probe_addr & 0x3)
>  		return -EINVAL;
> @@ -106,10 +104,6 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  	if (search_exception_tables(probe_addr))
>  		return -EINVAL;
>  
> -	if (probe_addr >= (unsigned long) __start_rodata &&
> -	    probe_addr <= (unsigned long) __end_rodata)
> -		return -EINVAL;
> -
>  	/* decode instruction */
>  	switch (arm_kprobe_decode_insn(p->addr, &p->ainsn)) {
>  	case INSN_REJECTED:	/* insn not supported */
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
