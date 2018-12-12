Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1B6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 04:40:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1DBE20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 04:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R/EuA8+e";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="RnodPA0R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1DBE20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4OksINlb/k46QHpeWJ+xSpF1pB7nfwV4IZV7dgRw9QI=; b=R/EuA8+eaykzbw
	spJHYUV3OFe9DnSQSu3uuYLwyF36BWZnCAbgD2vtYaAeUP5WbYOBPNRIwHZE5iDisl3eco7hu0PFJ
	5AaeUSJY8sgTVRms8nRk+meI/1Bnb0LWcvBODqPbKSHE1lGObbcJZGH9JUB7/gbzDS3UY+5mJNYD+
	HxL6rMWRtvjaEbi/eWaHHvE3ZyweAYHasL7+jCyb7sFOhsGklz4sgdJCN/xDO9WDKuv2Zgp/eEiSf
	vfAl+mb12cFDh6TZ0rj3bb9QVe/cabhRZfXemywCLagvfoiwC/K7iyETndemAMuTgtROXpcgroI0c
	iXCSdG5GMDDWhY5DTgRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWwJa-00036C-Mj; Wed, 12 Dec 2018 04:40:06 +0000
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWwJU-0002hu-Tp
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 04:40:02 +0000
Received: by mail-qt1-x844.google.com with SMTP id z16so19163439qtq.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 20:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=subject:to:references:cc:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=If+bJ9rRO5lfOkSzkb1zpo4CnDIDkL/onzsW7KN4jxM=;
 b=RnodPA0RmvS/FPrHfI6jJAkwG0eR6GHQgMQ6QzhZJvfX8imPtP61fQ671IN5WDOfgq
 q/EZpYFGRSTRvpPB3jcuxH8L+xwkcI4i5vOaDynWEQ4eac1Yi/WKxGJn1uO/BukIVqhv
 A1DhmP6pBH+6PElYJZm7Iqrn//s+jlq1PD0c6ECxBCLnTF+Hwlad5PTdkuuLWw7Who/3
 If3ZFtYUAxqc/gKqpQp4IrLdR+zn8hBFkgbGKyWIaZdWgDydZ79/DFDWLkhmfE0+vF0P
 2U9/2BgEYWUzA9cMYuQZqOBdj80i48AdhkloH65sVGFOaEmF0Csa0IFyKMciH4tH4S2+
 NwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=If+bJ9rRO5lfOkSzkb1zpo4CnDIDkL/onzsW7KN4jxM=;
 b=OEkX5e8YgSopAqrTh04XumWNdxNEQNj2QQt09t9a5J5K7uSnYug15/LNNPpmBXgNR+
 zahYjXj4Wao21/yuALr6bQl48oaV3s846gY14kAck4wCxftaDYUx5pEG0/8H0MMjekv8
 0nP4VHd7pkq0cJ/HZoQJi+Vv3V2iLpXI71RsMHx3EKl0vSQtgUwWGk2kJZbSJAHQTuY4
 KBfU3chmtN2UB5StyuZnuPMIVkKzyYQoc1NxhLSARY94SeK8BBP03svjYz/VBwubZtFZ
 iM2D9RrMOBHwLe4Dbtc9iBDWpQN2uXNzJFY9y6fgtwtLcgg6RCyjns7i4Adn8qHy5PTh
 /sZA==
X-Gm-Message-State: AA+aEWY6vLGMV3iO0QC4DQ6/R2eZ1+ArX2WOg7AlWQ+mg5VEgqYSqIZE
 FQTMiHuvRjBldmebRT+WdU/rYg==
X-Google-Smtp-Source: AFSGD/UUVgnrQhZVjnKAAvHFXAKp2YJUCbcXvPM02058/G7Z4SL1nUMIz5xKjzCAHS4gZwKNOgg1ug==
X-Received: by 2002:a0c:e091:: with SMTP id l17mr17819831qvk.144.1544589589513; 
 Tue, 11 Dec 2018 20:39:49 -0800 (PST)
Received: from ovpn-121-90.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id r67sm12875324qkr.28.2018.12.11.20.39.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Dec 2018 20:39:49 -0800 (PST)
Subject: Re: arm64: kdump broken on a large CPU system
To: "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
 James Morse <james.morse@arm.com>, Marc Zyngier <marc.zyngier@arm.com>
References: <113776f1-5633-e397-96eb-c533ea79671d@lca.pw>
 <29f74c6d-dd21-dcee-6c62-914f018c4e4e@arm.com>
 <7f467952-342b-71e2-c553-ff53ecc1812e@arm.com>
 <20181212025131.GL21466@linaro.org>
From: Qian Cai <cai@lca.pw>
Message-ID: <e4a3456b-6a75-4564-a49f-0532d0b35726@lca.pw>
Date: Tue, 11 Dec 2018 23:39:47 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181212025131.GL21466@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_204000_961136_8B33F2AA 
X-CRM114-Status: GOOD (  14.40  )
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
 Will Deacon <will.deacon@arm.com>, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

[+ kexec@lists.infradead.org]

The debugging progress so far...

Wait up to 5 minutes for other CPUs to stop in crash_smp_send_stop() made no
difference.

With "dev" branch of this tree [1], it is possible to print out messages from
purgatory when passing something like "--port=0x602B0000
--port-lsr=0x602B0000,0x80" to kexec. However, even enable_dcache() in
setup_arch() will hung like forever on this machine (working fine on another
arm64 server - Cortex-A72). After removed only enable_dcache() /
disable_dcache() from setup_arch() etc without removing printf() lines, it did
print out,

I'm in purgatory
purgatory: entry=0000000090080000
purgatory: dtb=0000000092d50000
purgatory: D-cache Enabled before SHA verification
purgatory: D-cache Disabled after SHA verification

So, it confirmed that it must hung somewhere in arm64/kernel/head.S (.stext) or
the early part of start_kernel() before earlycon was initialized.

Also confirmed that passing nr_cpus=64 in the first kernel would again make
everything work fine with this new kexec.

Since enable_dcache() would hung as well, I suspect this has something to do
with enabling MMU (i.e, .stext -> __primary_switch -> __enable_mmu) coupling
with some sort of per-CPU data where the number of CPUs matters.

Right now, I think I need to find a way to print directly to pl011 serial
console while debugging those assembly code like CONFIG_DEBUG_LL for arm64, so
it can be used to locate where exactly it hung. Otherwise, I am shooting in the
dark.

[1] https://github.com/pratyushanand/kexec-tools

=== original email ===

On this HPE Apollo 70 arm64 server with 256 CPUs, triggering a crash dump just
hung (4.20-rc6 as well as 4.18). It was confirmed that the executing went as far
as entering __cpu_soft_restart(),

__crash_kexec
  machine_kexec
    cpu_soft_restart
      restart
        __cpu_soft_restart

The earlycon was enabled but had no output from the 2nd kernel, so it was pretty
much stuck in all those assembly code in arm64/kernel/head.S or the early part
of start_kernel() before earlycon was initialized.

It turned out this has something to do with nr_cpus in the 1st kernel, although
the 2nd kernel always has nr_cpus=1 [1]. It was tested with both
crashkernel=512M or 768M.

nr_cpus <= 96  GOOD (2nd kernel was up in 2-3 mins.)
nr_cpus=256    BAD  (2nd kernel was NOT up after 1 hour.)
nr_cpus=127    BAD  (2nd kernel was NOT up after 10 mins.)

I did also test with and without CONFIG_ARM64_VHE (i.e., el2_switch) made no
difference.

[1] KDUMP_COMMANDLINE_APPEND="irqpoll nr_cpus=1 swiotlb=noforce reset_devices"

I am still figuring out a way to debug those assembly code to where it actually
hung, but the server was hooked up with a conserver that was not able to
generate any sysrq and I have no shell access to the conserver, so seems a bit
difficult to use kgdb or kdb in this case.

CPU information,

# lscpu
Architecture:        aarch64
Byte Order:          Little Endian
CPU(s):              256
On-line CPU(s) list: 0-255
Thread(s) per core:  4
Core(s) per socket:  32
Socket(s):           2
NUMA node(s):        2
Vendor ID:           Cavium
Model:               1
Model name:          ThunderX2 99xx
Stepping:            0x1
BogoMIPS:            400.00
L1d cache:           32K
L1i cache:           32K
L2 cache:            256K
L3 cache:            32768K
NUMA node0 CPU(s):   0-127
NUMA node1 CPU(s):   128-255
Flags:               fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics cpuid
asimdrdm

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
