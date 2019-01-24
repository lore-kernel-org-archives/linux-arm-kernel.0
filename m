Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0B1C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:12:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0A6721872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DkNyCt8w";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YKM0mw9w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A6721872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Tp8+f2DCVTlhbDjuXq+BVuREIFvdQDqT4JdGgBDrUKo=; b=DkNyCt8w8fI95y
	k+73ePXK748KhBGf/OC1ix9SMh0bMn4D4Ys1ZMeTUO/e6miXLw9Jhjlh0y/JjkTeUhC1YJM1faxRe
	TnklQrCk6a6rdVW4gPtM1AGZt/+mhnbahr76zLoMeEQXZA4tbUz6U3KZhCgs2YqquiW0UOOIjqTGn
	Ti4ax2v8gls3PnMPqMmGjqb7bjjAm3DqYngT3XN4hq5OQ6AIuqm/RSRcffAwBNwE4Kgst1dGWaSVo
	9siUxzRW74KwJACL8HBJh6mjjeiVkEo9CUzIbgPpIgirxGAwT2UVfH7mYy1E/mmPaLaW1fA9mvPAQ
	cRf9fcWZVo23bBE9Jvfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gma7C-0007V7-Rp; Thu, 24 Jan 2019 08:11:58 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gma6L-0006dH-TB
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 08:11:10 +0000
Received: by mail-it1-x141.google.com with SMTP id a6so3118136itl.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 00:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q8P8qMF3dQYKOlf8NolgDv1yJ5Ia0DCXBzgEZf2JcMY=;
 b=YKM0mw9w8OZCnY4KRB965JDXuu+3V+xOXST3D9/ihvSXLnoRAABIQ0n2kKF6dT0rvs
 EBNPwu1rqGWy+9JbLUbdDbMtkGZhwEL6wbR35iRto5VARg0bbxobL7haLMWe3Jka9qXf
 qxjGctdWwGQHfv2kIGCjNfP8EX4Y22AruiDj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q8P8qMF3dQYKOlf8NolgDv1yJ5Ia0DCXBzgEZf2JcMY=;
 b=Pj2ztZiQyNBD2956nGnJCV1xanfGhqiQL81TU+kJmGQLVvJNRBQ0H4DB0JVoYo6GR4
 MYG+5UgEwvaBd7xXWa+Coz6eYcLxaM9zzuz5lmAxVDP/5WpFhGX77+VJhwz0EuS7betW
 ym+1rP2IovzQf72W76Ox+xUcWdfewqFbknFCamD4ohOXcN7Aj6GN4LKwn5JXOnxDoEWf
 oJuTNS8lREqO/8cN/9l2hyNd7USRJfXulZQEN0TDQZriF3wYbfx+rcIkPgaaVdFGt1lo
 xluHwRGKTlrGRFEJDpAY9NwX+DnQW35j6RqfTkIdT5aoz6I1hqJCCNScoAfYeRsbXSWo
 fJ8Q==
X-Gm-Message-State: AJcUukcwprLNefXcc+KWm6amd+llGqMBa6qWwjtABfW9AUBM7tf+/NWe
 QKndc6CtkJ8+J4j5GcPVYvjjjZme/LuMQhQ136upCw==
X-Google-Smtp-Source: ALg8bN7JuCfiGbfYSuw18cX8OnY6dC91F0vsp2shiow8uOGMohL2+w0Qcho6vLtFEb3FRQRUZ9yj7IED2zaUCJ0X/gU=
X-Received: by 2002:a24:edc4:: with SMTP id r187mr922342ith.158.1548317464624; 
 Thu, 24 Jan 2019 00:11:04 -0800 (PST)
MIME-Version: 1.0
References: <CALAqxLX0P6P4xnv=HgQsP-Cv4dkGJhkkMRn7jy-sbzZKUa1z4w@mail.gmail.com>
In-Reply-To: <CALAqxLX0P6P4xnv=HgQsP-Cv4dkGJhkkMRn7jy-sbzZKUa1z4w@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 24 Jan 2019 09:10:53 +0100
Message-ID: <CAKv+Gu_OrO1Spx949j9LOUONJZvsnr_XsNxE1QkERTcFxdG0bA@mail.gmail.com>
Subject: Re: BUG: sleeping function called from invalid context at
 kernel/locking/mutex.c:908
To: John Stultz <john.stultz@linaro.org>,
 "Suzuki K. Poulose" <Suzuki.Poulose@arm.com>, 
 Marc Zyngier <marc.zyngier@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_001106_666270_CB3F0544 
X-CRM114-Status: GOOD (  10.59  )
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
 Will Deacon <Will.Deacon@arm.com>,
 Valentin Schneider <Valentin.Schneider@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 24 Jan 2019 at 06:36, John Stultz <john.stultz@linaro.org> wrote:
>
> Trying to boot hikey960 with v5.0-rc3 (and Valentin's 2 recent lockdep
> fixes), with lock debugging enabled, I'm seeing the BUG below.
>
> Wanted to see if anyone else had seen this or had ideas at what was going on.
>
> thanks
> -john
>
> [    0.183376] Detected VIPT I-cache on CPU4
> [    0.183388] CPU features: SANITY CHECK: Unexpected variation in
> SYS_ID_AA64MMFR0_EL1. Boot CPU: 0x00000000001122, CPU4:
> 0x00000000101122
> [    0.183399] CPU features: Unsupported CPU feature variation detected.

This means that some CPUs support 16k pages and some don't. This is
hardly relevant if you are running with 4k pages, but as Suzuki
pointed out (IIRC), it could be relevant for KVM, since you cannot
migrate a VM using 16k pages from one CPU to the other.

Suzuki, has there been any progress since this last came up?

The output below is from a separate issue, where it seems that we are
enabling a static key from atomic context, which apparently isn't
supported.

Marc might know more about this.


> [    0.183417] BUG: sleeping function called from invalid context at
> kernel/locking/mutex.c:908
> [    0.183421] in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/4
> [    0.183451] no locks held by swapper/4/0.
> [    0.183454] irq event stamp: 0
> [    0.183459] hardirqs last  enabled at (0): [<0000000000000000>]
>       (null)
> [    0.183474] hardirqs last disabled at (0): [<ffffff80100f2af0>]
> copy_process.isra.3.part.4+0x450/0x17b0
> [    0.183479] softirqs last  enabled at (0): [<ffffff80100f2af0>]
> copy_process.isra.3.part.4+0x450/0x17b0
> [    0.183483] softirqs last disabled at (0): [<0000000000000000>]
>       (null)
> [    0.183485] Preemption disabled at:
> [    0.183493] [<ffffff801009b680>] secondary_start_kernel+0xc0/0x1f8
> [    0.183501] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G S
>   5.0.0-rc3-00002-g4daf5b1 #372
> [    0.183504] Hardware name: HiKey960 (DT)
> [    0.183508] Call trace:
> [    0.183515]  dump_backtrace+0x0/0x150
> [    0.183518]  show_stack+0x24/0x30
> [    0.183526]  dump_stack+0xa0/0xd4
> [    0.183532]  ___might_sleep+0x1e4/0x240
> [    0.183535]  __might_sleep+0x58/0x90
> [    0.183540]  __mutex_lock+0x64/0x890
> [    0.183543]  mutex_lock_nested+0x3c/0x50
> [    0.183549]  static_key_enable_cpuslocked+0x64/0xd8
> [    0.183556]  arch_timer_check_ool_workaround+0x208/0x260
> [    0.183559]  arch_timer_starting_cpu+0xfc/0x2f8
> [    0.183563]  cpuhp_invoke_callback+0xd8/0xce0
> [    0.183567]  notify_cpu_starting+0x84/0xa0
> [    0.183570]  secondary_start_kernel+0xec/0x1f8
> [    0.183601] arch_timer: Enabling local workaround for ARM erratum 858921
> [    0.183618] arch_timer: CPU4: Trapping CNTVCT access
> [    0.183625] CPU4: Booted secondary processor 0x0000000100 [0x410fd091]
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
