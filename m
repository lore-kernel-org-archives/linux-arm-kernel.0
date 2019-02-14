Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A2AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:51:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4343021928
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EIYzmcK1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="EEvymeBS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4343021928
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q0plDpcCdVWkPBSFDUZMXBirEWnDVRssOBzJTeqrw1Q=; b=EIYzmcK1O7rjvM
	KsLmgofl1B9GC7Cop8F/MLaC+U9XRfjsz3fSrMKrrzc3vXPc8FkYaOJnhRfxI87A5QJ5EABcMgGmX
	yE5fkm9P/kFDopIdlsjFmLT4pl+OJLA5NroTkVFgmgyYyLuBavAvnRnS8a0D5KZxhEVpNH6rR5Mzr
	VMKBiZzvo8Dl7Wue7zFIMNpqDxqUM8igbq9NDuQwWP0tAcz42v0HTLUsZG0q3x/lMuFtuXUeQwE2M
	RWVG1zAbCTshf4P7a93TaQg4C2CVKiMR/ENgHWy5rvl8+J2U9ZblBI/VP3R9BX3bX6RGwnppjuWSg
	lusp3QBIxwtb737IuaPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guKE5-0002FA-Vl; Thu, 14 Feb 2019 16:51:05 +0000
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guKE2-0002Ei-SE
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 16:51:04 +0000
Received: by mail-qk1-x741.google.com with SMTP id p15so3972947qkl.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 08:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/gm51Onr9LKQ8Z1hMHalMImelwz3/5P0dNUDGKc/lm4=;
 b=EEvymeBSITM42sZzQbx8NHYnvc5Qszqonn8wuSeQdprToGsT8rmjxothHYxlGjXMN6
 O6xe2clgAubvztRxF2UxxJOAVb01EuQ47Us3QskmLSGfqazPMcKM+VOhsX6yGTpfnq8+
 vP2zRhuJmDI8GLgwQ6HiwVpC57p7JfdCno2zVZMlO1doNcfhE6u3J5mOqJH8R0AYOsDb
 KG3Ok8pIhNGm6cRZWGDS03tkEWddIkLWuIEclCwL7GqD8113IxQ7nyYXTYdTRLmudZAf
 ZzniWuNjf9c5lCseJROCeMjFxAMiS1988Fy8RclReOWTp1fiMUXAfY1dIhXcze9Pky6e
 MZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/gm51Onr9LKQ8Z1hMHalMImelwz3/5P0dNUDGKc/lm4=;
 b=LS6Pa78jm8HNu8ms/cCI57znUYdogDT0LjX0b7UiAi60px3w9BWzZtZ1ctHnWpFhNA
 wyxgQq19DYIrmSW+iEDkaZE7vopc9pFxLrZewbGKVuvZ29jFe0GSIL0zA1hiQIWgUhVA
 SZrMjg36TOOPxnfOw7BFFeGiu4w9ovGDgZPAu7v4KPq36pRIFecgncKjIMMMOQFUFzof
 hYILt/mHMzS/TX2Xgn2vRxDcm/CyhLaoHll+wGv32IXVXAwRp3gf4mRe2eV5RkUqmlpl
 mOcHk6HqgzKF+7Qt/jMePi6DXvxFk/G2y37mBTmA1BC0k8qcBxwyCuLIMPn4j2FYFSeG
 sAhA==
X-Gm-Message-State: AHQUAuaZyVv3l9pwTY22sNqMkTyyw38JalYoH+zmYvIuHpLWhQkaU8Vu
 2QUVPvURMzILmFD8wQafeRmam26Sk3A=
X-Google-Smtp-Source: AHgI3Ia5jfbcAd6yW7ki1qRS5hLQnTyscdesKUR94YjcHamlD9ZZdkuZByGWPbVMHSoMIzdwk3t+9Q==
X-Received: by 2002:a37:a42:: with SMTP id 63mr3574440qkk.269.1550163061329;
 Thu, 14 Feb 2019 08:51:01 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id p15sm1880592qta.81.2019.02.14.08.51.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 08:51:00 -0800 (PST)
Subject: Re: livelock with KASAN_SW_TAGS
To: Will Deacon <will.deacon@arm.com>
References: <7ec14ad5-8d64-b842-a819-9d57cc8495e2@lca.pw>
 <20190214163536.GB1825@fuggles.cambridge.arm.com>
From: Qian Cai <cai@lca.pw>
Message-ID: <50ef4f07-af09-5498-2bca-26ced76d9736@lca.pw>
Date: Thu, 14 Feb 2019 11:50:59 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190214163536.GB1825@fuggles.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_085102_973433_08C9F125 
X-CRM114-Status: GOOD (  17.42  )
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
Cc: Andrey Konovalov <andreyknvl@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 kasan-dev <kasan-dev@googlegroups.com>, aryabinin@virtuozzo.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 2/14/19 11:35 AM, Will Deacon wrote:
> Hi Qian Cai,
> 
> On Wed, Feb 13, 2019 at 10:32:11PM -0500, Qian Cai wrote:
>> Running LTP msgstress03 [1] triggers endless soft lockups below after a few
>> minutes on a ThunderX2 server. It works fine with KASAN_GENERIC and finish the
>> test in roughly 11 minutes.
> 
> I've not been able to reproduce this failure under KVM, however the test
> only takes around 18s to complete on the host and the guest, so it feels
> like something is amiss here. Please could you share more information about
> how you're triggering this problem? For example:
> 
>   - Kernel version and .config

Latest mainline at 1f947a7a01 ("Merge branch 'akpm' (patches from Andrew)") plus
a few KASAN_SW_TAGS patches in order to boot.

https://marc.info/?l=linux-mm&m=155006632110129&w=2 (all 5)
https://marc.info/?l=linux-mm&m=154968731424637&w=2
https://marc.info/?l=linux-mm&m=155010395725051&w=2

https://git.sr.ht/~cai/linux-debug/tree/master/config

>   - Clang version

clang-7.0.1

>   - LTP version and command-line

latest git at db57ddc1497e

/opt/ltp/testcases/bin/msgstress03

>   - Machine configuration (CPUs, memory, etc)

https://git.sr.ht/~cai/linux-debug/tree/master/dmesg

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

# free -m
              total        used        free      shared  buff/cache   available
Mem:          84871        8347       75942          55         581       69699
Swap:          4095           0        4095

> 
>> # ./scripts/faddr2line vmlinux _raw_spin_unlock_irqrestore+0x44/0xac
>> _raw_spin_unlock_irqrestore+0x44/0xac:
>> arch_local_irq_restore at arch/arm64/include/asm/irqflags.h:88
>> (inlined by) __raw_spin_unlock_irqrestore at include/linux/spinlock_api_smp.h:160
>> (inlined by) _raw_spin_unlock_irqrestore at kernel/locking/spinlock.c:184
>>
>> This code:
>>
>> 	asm volatile(
>> 		"msr	daif, %0
>> 	:
>> 	: "r" (flags)
>> 	: "memory");
> 
> This is just the instruction when we unmask interrupts, so that's when the
> soft watchdog fires. I suspect the real issue is that we're spending lots
> of time in:
> 
>> [  545.772027]  free_debug_processing+0x308/0x410
> 
> with irqs disabled. Does the machine eventually come back to life?
>

Never.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
