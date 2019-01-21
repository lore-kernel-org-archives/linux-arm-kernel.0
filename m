Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D13C7113B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:20:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 439E72084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m/IuBtMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439E72084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:Subject:From:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ax4fkpNwtL8Kp+2QsJDDBU/2S+sGMfnrSeyJHNYv54M=; b=m/IuBtMjwXLb2E
	ACFDduA+gnuwfFVqUc+iJ9VGoBid6m3WNSkJIvBH/Di4EqCv80C3n5lUAUdMp7W//rpZ/QWhHA6PR
	dt9xJakL4+R9vK16EKzuK6wVT27V6dVEntt5Zd2cxn3Bqor3JkO/B9FyUYHyaN8Ufqhc0oC0IRx0g
	gISx/3gdQbRzQAWIHEHt1zjdt4bYVXZqq8Saks6hleAlilMColsNUcHzEYzpI/VRnuEQKFg8iBj4/
	anbuRd8S05SJqphwO11UZRRe9sWiT6WmlwIDAzr4aIFyo8UGTHQ9JpDKJwSwNY2UYOf/Df5Vbvdi+
	0YkUicjObEbbjm6EC//Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glYYp-0002mH-4O; Mon, 21 Jan 2019 12:20:15 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glYYl-0002LV-7V
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 12:20:12 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B5EA80D;
 Mon, 21 Jan 2019 04:20:10 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 531CE3F614;
 Mon, 21 Jan 2019 04:20:09 -0800 (PST)
From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v2 4/4] arm64: kprobes: Use
 arch_populate_kprobe_blacklist()
To: Masami Hiramatsu <mhiramat@kernel.org>
References: <154753341900.31541.8135985235882849464.stgit@devbox>
 <154753353370.31541.14485875717131836689.stgit@devbox>
Message-ID: <7f840cc8-4e62-e1d7-9035-4361204fc134@arm.com>
Date: Mon, 21 Jan 2019 12:20:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <154753353370.31541.14485875717131836689.stgit@devbox>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_042011_307459_92521E15 
X-CRM114-Status: GOOD (  18.87  )
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

Hello,

On 15/01/2019 06:25, Masami Hiramatsu wrote:
> Use arch_populate_kprobe_blacklist() instead of
> arch_within_kprobe_blacklist() so that we can see the full
> blacklisted symbols under the debugfs.
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index b9e9758b6534..6c066c34c8a4 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -465,26 +465,30 @@ kprobe_breakpoint_handler(struct pt_regs *regs, unsigned int esr)
>  	return DBG_HOOK_HANDLED;
>  }
>  
> -bool arch_within_kprobe_blacklist(unsigned long addr)
> +int __init arch_populate_kprobe_blacklist(void)
>  {
> -	if ((addr >= (unsigned long)__kprobes_text_start &&
> -	    addr < (unsigned long)__kprobes_text_end) ||
> -	    (addr >= (unsigned long)__entry_text_start &&
> -	    addr < (unsigned long)__entry_text_end) ||
> -	    (addr >= (unsigned long)__idmap_text_start &&
> -	    addr < (unsigned long)__idmap_text_end) ||

> -	    in_exception_text(addr))

You added this one in the previous patch, but it disappears here.


> -		return true;
> -
> -	if (!is_kernel_in_hyp_mode()) {
> -		if ((addr >= (unsigned long)__hyp_text_start &&
> -		    addr < (unsigned long)__hyp_text_end) ||
> -		    (addr >= (unsigned long)__hyp_idmap_text_start &&
> -		    addr < (unsigned long)__hyp_idmap_text_end))
> -			return true;
> -	}
> -
> -	return false;
> +	int ret;


> +	ret = kprobe_add_area_blacklist((unsigned long)__kprobes_text_start,
> +					(unsigned long)__kprobes_text_end);
> +	if (ret)
> +		return ret;

Now that we have arch_populate_kprobe_blacklist(), does the arch-code need to
blacklist the kprobes section itself?

The weak arch_within_kprobe_blacklist() will test it at kprobe-load time, and
populate_kprobe_blacklist() adds it to the list before it calls
arch_populate_kprobe_blacklist().

Won't this result in duplicate entries?


> +	ret = kprobe_add_area_blacklist((unsigned long)__entry_text_start,
> +					(unsigned long)__entry_text_end);
> +	if (ret)
> +		return ret;

> +	ret = kprobe_add_area_blacklist((unsigned long)__idmap_text_start,
> +					(unsigned long)__idmap_text_end);

> +	if (ret || is_kernel_in_hyp_mode())
> +		return ret;


Hmmm, I think we have a bug here today.

This is saying we can kprobe KVM when we have VHE, because all of KVMs code runs
at the same exception-level as the kernel. Which is true...
But KVM switches VBAR_EL1, so if we run over one of kprobes BRK instructions,
we're going to hyp-panic, because KVM doesn't handle synchronous exceptions from
EL2.

The __hyp_text also contains the guest entry/exit code, which we mustn't probe,
even on VHE.

I think we should always blacklist the __hyp_text, and KVM should mark its
vhe-only functions with __kprobes. I'll post patches for this.


Thanks,

James


> +	ret = kprobe_add_area_blacklist((unsigned long)__hyp_text_start,
> +					(unsigned long)__hyp_text_end);
> +	if (ret)
> +		return ret;
> +	ret = kprobe_add_area_blacklist((unsigned long)__hyp_idmap_text_start,
> +					(unsigned long)__hyp_idmap_text_end);
> +	return ret;
>  }
>  
>  void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
