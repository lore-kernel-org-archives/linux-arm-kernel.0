Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E17C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:48:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64AC920882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uGkFlQGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64AC920882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wlMGb0bWIg2fUPF1RkAqc3VZ0LrmknlFOQf7tv4uNJk=; b=uGkFlQGagvbTng
	xHX/wzZmMvDjhiNTC1KkHZoF8Ej7wN/Cq7D5HUwl+wGDo8DVP8GmA0XFXymowXW7XF4HioojG4akh
	AB6MGXde0HMEfU0nQIVQ12vtITr0u8FH+26LyU62Q+BAWfG9uX3R+R5izxr8cCNVtm1sqNNzFp0B3
	RqSZ5I+bCWWrDJHOA1YUfk2ro3nQ6jMpa/Zrsf1YdUS7Pz077cdxSxTVVxkOVg8Cu+OixY9D5WLWG
	afJSp6Vn0tZPPiXW/kpFfOx/NpIcNw/MfG8nWLmkAXcFbeW7qTyM19Qj3/nW540DOPwwwv4z982ZW
	q+9g41zkkLQf7/WeF8GA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goZMu-0005oA-NZ; Tue, 29 Jan 2019 19:48:24 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goZMr-0005nf-2N
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 19:48:22 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED3CDA78;
 Tue, 29 Jan 2019 11:48:18 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAE573F557;
 Tue, 29 Jan 2019 11:48:17 -0800 (PST)
Subject: Re: BUG: sleeping function called from invalid context at
 kernel/locking/mutex.c:908
From: Valentin Schneider <valentin.schneider@arm.com>
To: John Stultz <john.stultz@linaro.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <CALAqxLX0P6P4xnv=HgQsP-Cv4dkGJhkkMRn7jy-sbzZKUa1z4w@mail.gmail.com>
 <747e7740-b5d3-3ed1-17ed-21401cef1711@arm.com>
Message-ID: <a02d81b6-03d1-7b50-e254-14d826839c74@arm.com>
Date: Tue, 29 Jan 2019 19:48:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <747e7740-b5d3-3ed1-17ed-21401cef1711@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_114821_128624_08BED429 
X-CRM114-Status: GOOD (  17.29  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, Suzuki.Poulose@arm.com,
 Will Deacon <Will.Deacon@arm.com>, ard.biesheuvel@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 28/01/2019 16:54, Valentin Schneider wrote:
> Hi John,
> 
> Sorry I had missed that thread, Marc brought it up to me
> 
> On 24/01/2019 05:36, John Stultz wrote:
>> Trying to boot hikey960 with v5.0-rc3 (and Valentin's 2 recent lockdep
>> fixes), with lock debugging enabled, I'm seeing the BUG below.
>>
>> Wanted to see if anyone else had seen this or had ideas at what was going on.
>>
>> thanks
>> -john
>>
>> [    0.183376] Detected VIPT I-cache on CPU4
>> [    0.183388] CPU features: SANITY CHECK: Unexpected variation in
>> SYS_ID_AA64MMFR0_EL1. Boot CPU: 0x00000000001122, CPU4:
>> 0x00000000101122
>> [    0.183399] CPU features: Unsupported CPU feature variation detected.
>> [    0.183417] BUG: sleeping function called from invalid context at
>> kernel/locking/mutex.c:908
>> [    0.183421] in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/4
>> [    0.183451] no locks held by swapper/4/0.
>> [    0.183454] irq event stamp: 0
>> [    0.183459] hardirqs last  enabled at (0): [<0000000000000000>]
>>       (null)
>> [    0.183474] hardirqs last disabled at (0): [<ffffff80100f2af0>]
>> copy_process.isra.3.part.4+0x450/0x17b0
>> [    0.183479] softirqs last  enabled at (0): [<ffffff80100f2af0>]
>> copy_process.isra.3.part.4+0x450/0x17b0
>> [    0.183483] softirqs last disabled at (0): [<0000000000000000>]
>>       (null)
>> [    0.183485] Preemption disabled at:
>> [    0.183493] [<ffffff801009b680>] secondary_start_kernel+0xc0/0x1f8
>> [    0.183501] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G S
>>   5.0.0-rc3-00002-g4daf5b1 #372
>> [    0.183504] Hardware name: HiKey960 (DT)
>> [    0.183508] Call trace:
>> [    0.183515]  dump_backtrace+0x0/0x150
>> [    0.183518]  show_stack+0x24/0x30
>> [    0.183526]  dump_stack+0xa0/0xd4
>> [    0.183532]  ___might_sleep+0x1e4/0x240
>> [    0.183535]  __might_sleep+0x58/0x90
>> [    0.183540]  __mutex_lock+0x64/0x890
>> [    0.183543]  mutex_lock_nested+0x3c/0x50
>> [    0.183549]  static_key_enable_cpuslocked+0x64/0xd8
>> [    0.183556]  arch_timer_check_ool_workaround+0x208/0x260
>> [    0.183559]  arch_timer_starting_cpu+0xfc/0x2f8
>> [    0.183563]  cpuhp_invoke_callback+0xd8/0xce0
>> [    0.183567]  notify_cpu_starting+0x84/0xa0
>> [    0.183570]  secondary_start_kernel+0xec/0x1f8
>> [    0.183601] arch_timer: Enabling local workaround for ARM erratum 858921
>> [    0.183618] arch_timer: CPU4: Trapping CNTVCT access
>> [    0.183625] CPU4: Booted secondary processor 0x0000000100 [0x410fd091]
>>
> 
> Urgh, I was going to say I don't get that warning with the lockdep patches,
> but I just realized you actually get a different warning because you have
> DEBUG_ATOMIC_SLEEP. I'll see if I can make sense of this one, it reminds me
> of [1] although we already have the _cpuslocked variant.
>

So that one is different. DEBUG_ATOMIC_SLEEP doesn't like that we try
to enable the 'arch_timer_read_ool_enabled' static branch in whatever
context arch_timer_enable_workaround() is.

It only happens once when bringing up the first A73, because after that
the static key is already enabled. It goes something like this:

- secondary_start_kernel()
  - preempt_disable()
  - notify_cpu_starting()
    - [...] // cpuhp machinery leads us to the arch timer
    - arch_timer_starting_cpu()
      - __arch_timer_setup()
        - arch_timer_check_ool_workaround()
          - arch_timer_enable_workaround()
            - static_branch_enable_cpuslocked()

It complains because we've had that preempt_disable() further up and
interrupts are being masked.

Thing is, we bring up secondary CPUs one at a time, so AFAICT we shouldn't
have any contention on jump_label_lock() and will probably never sleep.
I **think** we could move the preempt_disable() down to right before
unmasking the interrupts, but might_sleep() would still complain about
interrupts being masked.

I'm fairly sure we can't change that so early, but then I don't know what
to do with the warning (can we document/suppress it in some way?).

Thoughts?

[...]

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
