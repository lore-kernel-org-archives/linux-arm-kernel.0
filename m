Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF4DC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:18:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE6852184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V9U7aotM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6852184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MRKj2wt/TnOXs6GgTO7obcWgMQ9WofqDKhpch5o/lrw=; b=V9U7aotM7CgazQ
	pEiiwuAlKuXldeV4JW6KseluVStJx0Bv6zQY0XAEcHQ6Gt/xQWjugICqTmPBy4QivVWt/VVrUpBK+
	0iKPNq9c3KlhNBSyKtPc9OwbDh/I9PFT9rgfhcBMPbw+xkfbJxs69EhrhwCNPjyB4RV15bEvPy7qv
	2uPBKb7yhP6fE0cm2UriY0WruXMphSeH6VQEPYGzUp/7lsllcDyTVZAVK9BvP9BU3J6bsbG2QMn+/
	7eV5Usv+2XOWB/RPBQ6tWZXAwED/whCDXOkOlJx3sWP5q1t1I6qJTl0THuciBaT+rtDieYjQGr/79
	MMug1N5GkR7h7FXagvFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gopl0-0003SI-Ss; Wed, 30 Jan 2019 13:18:22 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gopkm-0003AK-Co
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 13:18:14 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AB0AEBD;
 Wed, 30 Jan 2019 05:18:07 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 561B03F59C;
 Wed, 30 Jan 2019 05:18:06 -0800 (PST)
Date: Wed, 30 Jan 2019 13:18:03 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Kristina Martsenko <kristina.martsenko@arm.com>
Subject: Re: [PATCH v4] arm64: add ptrace regsets for ptrauth key management
Message-ID: <20190130131803.GD3567@e103592.cambridge.arm.com>
References: <20190130120244.25158-1-kristina.martsenko@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190130120244.25158-1-kristina.martsenko@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_051809_182163_DE09A10C 
X-CRM114-Status: GOOD (  21.04  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Amit Kachhap <amit.kachhap@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 12:02:44PM +0000, Kristina Martsenko wrote:
> Add two new ptrace regsets, which can be used to request and change the
> pointer authentication keys of a thread. NT_ARM_PACA_KEYS gives access
> to the instruction/data address keys, and NT_ARM_PACG_KEYS to the
> generic authentication key. The keys are also part of the core dump file
> of the process.
> 
> The regsets are only exposed if the kernel is compiled with
> CONFIG_CHECKPOINT_RESTORE=y, as the only intended use case is
> checkpointing and restoring processes that are using pointer
> authentication. (This can be changed later if there are other use
> cases.)
> 
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> ---
> 
> Changes in v4:
>  - remove unnecessary memset's
>  - add pac_key_to_user and pac_key_from_user helpers
>  - use 'const' in pac_{address,generic}_keys_{to,from}_user
>  - reverse argument order in pac_{address,generic}_keys_from_user
> 

[...]

> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 9dce33b0e260..a86413be5a2d 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -979,6 +979,131 @@ static int pac_mask_get(struct task_struct *target,
>  
>  	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, &uregs, 0, -1);
>  }
> +

Come to think of it, this ifdef

> +#ifdef CONFIG_CHECKPOINT_RESTORE
> +static __uint128_t pac_key_to_user(const struct ptrauth_key *key)
> +{

[...]

> +static void pac_address_keys_from_user(struct ptrauth_keys *keys,
> +				       const struct user_pac_address_keys *ukeys)
> +{
> +	keys->apia = pac_key_from_user(ukeys->apiakey);
> +	keys->apib = pac_key_from_user(ukeys->apibkey);
> +	keys->apda = pac_key_from_user(ukeys->apdakey);
> +	keys->apdb = pac_key_from_user(ukeys->apdbkey);
> +}

Could be moved here, or could be eliminated entirely if we either mark
these functions __maybe_unused, or unconditionally include the regsets[]
entries.  Similarly with the other existing ifdefs.

Anyway, if we bother to do that at all it's something for another day.

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
