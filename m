Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C68C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:31:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E10482082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DWw+mBFo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="eG/BJTA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E10482082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:
	From:To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=jCfCie3fuQJJcnHx3jSczyq9/SbIy+dyXjfa91k0lwQ=; b=DWw+mBFoYeUZ77
	4brfXttCL65QutPyVxaDmuFWy6jKHgwdqjeKoSNFlgbq8FG7/Vl3pOW6h947EcBpUIhkI6Ld9KbkW
	HUsjEGnuuqF/G18HCcbDC9irf5NcUYdqkBhqWt88LcgdAks0tEbZf89aSX+0420GM96CUvdu9AYu8
	0zzl8RhJBlGqr+Jgl2NgscqxULCUbDaLZdf58A/NNdbgH8HmKfSU5uDZIx81wXaKAxObn8CdIItHt
	Jl1obFjtLd+nAp6w8DrBqKTEIXbnFiYNUet7/w19x6b4+4Z5RCSteRMKSwgGPGhz1ki9ZIV+F0MWT
	Qg4r1e+BZUU8Ibq1vnww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWU53-0007yK-Ok; Mon, 10 Dec 2018 22:31:13 +0000
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWU50-0007We-5C
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 22:31:11 +0000
Received: by mail-qt1-x843.google.com with SMTP id z16so14299477qtq.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 14:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=to:cc:from:subject:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=5iwI2MpgtO2jzEYZXapodUPP+xTVRw0wB39p6m+EMSA=;
 b=eG/BJTA0L2HBYC7t6HNKiah1A7IyM+DGerYz+BbK8xojs/BwaKEkM/V8G38uuf5dGS
 JdRJHYVjbwvMKKJbGQCEstddMyEcydVKYvBDMumXgk3gGVQbQY4Bn9PLPlpESiYx9gNF
 7DqaNa2VDmOmT2c/47/ZAWivpi0sR8spP76Soo0GBmYCp/njuhEF2L5HtkstIF1WDPLQ
 Fdvz0tS4fy7gFbVJ3XlsCcEglRPhKgzJi2yWXWSdrX6vkXI4eeTObQfPn0nMRzQTsFOM
 LIRPtHNw/ffsVQO5gOhqk761U3Q9+MJy2cTArBS2VCvbh9mttYeut0J5Mn5qilnlDYB8
 BfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=5iwI2MpgtO2jzEYZXapodUPP+xTVRw0wB39p6m+EMSA=;
 b=pBp3ciIk1LDH7AL6+gwMDSOT+fahHYqOQEkkcebxIJ+HHcpaqL2T8jGhjJKMFbYXCO
 dmp5ZRzmF8tEYkXGuuvvdtHD+bTeGnt/JzSD2ezvlQTvdGC6Q4j8wsJ1r0//Qyg0L/qH
 3JolEgFCWK41OLt8cEZK3Ux8YGKxiZHVhmL0JZo1ku5PxGpRMhcQK8lv2wspDSMgHeQ4
 W1LVHOHH3iPpmGYWp8Vu0v4lJ/4A+o/wqlbKCuONKY/eHX25j598kQX/P6IV1HwAhe4D
 FmNk68OVo8m/sfEhDpP0eh0p8Odly7CAZFEU3tKgLm8djGyv0DP4aMYzYs0E7UWeU/ri
 0K0g==
X-Gm-Message-State: AA+aEWbSG13FDAbD/BDVh2VV4lYuAFXrFPhO8Yvy5/D6fTz7j1GLPMEf
 vGZMgbdSQPrO5JeuqQrPwHXKidB80es=
X-Google-Smtp-Source: AFSGD/Upbyu/fhOFxfjY7StpZ8hieY5uaLCGcR/a4GDtGXmt4jIWIHXYwjSjchnEBCcugDNqYl2EhA==
X-Received: by 2002:a0c:ba24:: with SMTP id w36mr13173262qvf.60.1544481058725; 
 Mon, 10 Dec 2018 14:30:58 -0800 (PST)
Received: from ovpn-121-90.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id o190sm6602395qkd.53.2018.12.10.14.30.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 14:30:58 -0800 (PST)
To: Marc Zyngier <marc.zyngier@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
From: Qian Cai <cai@lca.pw>
Subject: arm64: kdump broken on a large CPU system
Message-ID: <113776f1-5633-e397-96eb-c533ea79671d@lca.pw>
Date: Mon, 10 Dec 2018 17:30:57 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_143110_248141_1B695F4C 
X-CRM114-Status: GOOD (  12.42  )
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
Cc: linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

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
