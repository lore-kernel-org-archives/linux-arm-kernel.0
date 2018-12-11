Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26131C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:34:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E59852082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="enQVCblI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59852082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oLuW6EoLx1nuHVCFUEvkn1xWDJ3aFZ/2N+bEz8Bjc6Q=; b=enQVCblIMnKqwF
	nNiHkyvQwMTln6O3mfZSL5FS6zzn1WL9GzTc9msdSfRg/MqKBQL8eCpj0UUGMg2mKJFCt5oOygWPh
	RE3Jm8CfInSxsHjA4JMP9UyKKmqXUdxTump2h2dJ7LDj/eL+cLl8OIH7Y+bxT54r6zxZKFj2fk6zg
	0QMIHxE3p7UXbhTucQxGEZs7z5XEn92SraRr27pnFEVBvxob+GtwMDaIPl9HQHh7G6+nspkTxGxjF
	Z/U2ThLH3mLDCxZA+zSPA09uz0z51+9YFRDtzQDzddfCuC4kblHaoycxhp+fh3wJWFZHPKdYl7IOF
	EbVqtqRicmOWCzg9j64w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWgJG-0006h2-Ba; Tue, 11 Dec 2018 11:34:42 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWgJC-0006gi-ED
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 11:34:40 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76F03EBD;
 Tue, 11 Dec 2018 03:34:25 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 419C73F6A8;
 Tue, 11 Dec 2018 03:34:24 -0800 (PST)
Subject: Re: arm64: kdump broken on a large CPU system
To: Marc Zyngier <marc.zyngier@arm.com>, Qian Cai <cai@lca.pw>
References: <113776f1-5633-e397-96eb-c533ea79671d@lca.pw>
 <29f74c6d-dd21-dcee-6c62-914f018c4e4e@arm.com>
From: James Morse <james.morse@arm.com>
Message-ID: <7f467952-342b-71e2-c553-ff53ecc1812e@arm.com>
Date: Tue, 11 Dec 2018 11:34:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <29f74c6d-dd21-dcee-6c62-914f018c4e4e@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_033438_488033_23348A37 
X-CRM114-Status: GOOD (  22.54  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, "AKASHI,
 Takahiro" <takahiro.akashi@linaro.org>, Will Deacon <will.deacon@arm.com>,
 linux-arm-kernel@lists.infradead.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Qian, Marc,

On 11/12/2018 10:09, Marc Zyngier wrote:
> On 10/12/2018 22:30, Qian Cai wrote:
>> On this HPE Apollo 70 arm64 server with 256 CPUs, triggering a crash dump just
>> hung (4.20-rc6 as well as 4.18). It was confirmed that the executing went as far
>> as entering __cpu_soft_restart(),
> 
> You can forget about 4.18 altogether, it will never correctly kexec.
> I've used 4.20 + kexec on a TX2 system though, and although it takes
> absolutely ages, it reliably works.

>> __crash_kexec
>>   machine_kexec
>>     cpu_soft_restart
>>       restart
>>         __cpu_soft_restart
>>
>> The earlycon was enabled but had no output from the 2nd kernel, so it was pretty
>> much stuck in all those assembly code in arm64/kernel/head.S or the early part
>> of start_kernel() before earlycon was initialized.
> 
> Could it instead be in the purgatory code provided by userspace?

Yes, this could be anything between entering __cpu_soft_restart(), purgatory and
the earlycon driver in the new kernel.


>> It turned out this has something to do with nr_cpus in the 1st kernel, although
>> the 2nd kernel always has nr_cpus=1 [1]. It was tested with both
>> crashkernel=512M or 768M.
> 
> James was saying something about a timeout, which may or may not be long
> enough.

This comes from arch/arm64/kernel/smp.c:crash_smp_send_stop()
It sends IPIs to all other CPUs, then waits one second before timing-out.
This may not be enough time for a system with hundreds of CPUs.

Increasing the timeout may help, but I don't understand why extra CPUs would
matter if we're getting as far as __cpu_soft_restart().


>> nr_cpus <= 96  GOOD (2nd kernel was up in 2-3 mins.)
>> nr_cpus=256    BAD  (2nd kernel was NOT up after 1 hour.)
>> nr_cpus=127    BAD  (2nd kernel was NOT up after 10 mins.)
>>
>> I did also test with and without CONFIG_ARM64_VHE (i.e., el2_switch) made no
>> difference.

>> [1] KDUMP_COMMANDLINE_APPEND="irqpoll nr_cpus=1 swiotlb=noforce reset_devices"

>> I am still figuring out a way to debug those assembly code to where it actually
>> hung, 

There were some earlier patches to purgatory to let it write the console, but
this didn't scale as purgatory isn't an operating-system. (Reducing purgatory to
be as simple as possible is better, with kexec_file_load() we don't use it all.)

If kexec-tools still has a 'ARM64_DEBUG_PORT' you may be able to get it to write
to your uart. (no idea which uarts it supports, or how it tells pl011 and 8250
apart).

Some threads to pull on:
https://patchwork.kernel.org/patch/6121951/
https://patchwork.kernel.org/patch/9238475/
(search for 'TX as the first port?' in the last one)


>> but the server was hooked up with a conserver that was not able to
>> generate any sysrq and I have no shell access to the conserver, so seems a bit
>> difficult to use kgdb or kdb in this case.

More recent kexec tools has a 'lite' or 'no-checks' option that tells it not to
bother checksumming the kdump kernel. This is what takes a long time as its done
without the MMU+caches enabled.
It shouldn't be possible for the old-kernel to corrupt it, as its not mapped
unless its being loaded (or save/restored by hibernate). I'm not sure how the
crash-regs get written to the elfcore header though...


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
