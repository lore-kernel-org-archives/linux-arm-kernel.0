Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A72C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:27:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99BAB20880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OIplUT8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99BAB20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UiqD9jFOgaBDnODI6ajGu917tNDG/CRKINk9sqe9Yr8=; b=OIplUT8MbZF3vtXUawinzZKEu
	nH+pRSNs757suV+Il3ItfN26JFbePH1eFmGQXyadSHNZKd4DtZI8dbWYFvPRXvA7zNwONPJYzBk59
	SxbAKq6sXVgkHC5zvX1yQzanSdz8s9WkOxShZTCp7lf+ofMSKcdbwVtNdzgGsp6jomR2tApVjA8PX
	c19J1jz4Xgnt7LEVFKy256llkuhMOaxctILmtDbJ6mf0qbf+PYX3Lp2683jeBrzp8eoXhoyFQE9Na
	kXoCaB/jgND/qlVGNxuzZ2lGe3MoUm9A+h/RsnTprBwuFcWBXDGqGVYnxZ1CZZBW70743tBumzFNh
	u3m4dARyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXP9V-00048C-1n; Thu, 13 Dec 2018 11:27:37 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXP9Q-00047b-RV
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 11:27:34 +0000
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 1BC68922CDEAC;
 Thu, 13 Dec 2018 19:27:18 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Thu, 13 Dec 2018
 19:27:12 +0800
Subject: Re: arm64 board boot pauses on linux-next (resend)
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Robin Murphy
 <robin.murphy@arm.com>, <linux-arm-kernel@lists.infradead.org>
References: <95b1b28c-da6d-fa1f-4b39-ed3c37c4bb9e@huawei.com>
 <8e1e38dd-70b0-a0ec-0687-581cc773b600@arm.com>
 <644bb3fa-20e5-9958-e3aa-67eb711289ce@huawei.com>
 <4f82e9c4-acfb-d36e-5a54-876fd0e22d69@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <eac9866b-3cb4-f7af-dc21-7f685bd3aa96@huawei.com>
Date: Thu, 13 Dec 2018 11:27:09 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <4f82e9c4-acfb-d36e-5a54-876fd0e22d69@arm.com>
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_032733_057106_4B12F1CC 
X-CRM114-Status: GOOD (  19.10  )
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
Cc: Linuxarm <linuxarm@huawei.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/12/2018 19:16, Suzuki K Poulose wrote:
> Hi
>
> On 12/12/2018 06:07 PM, John Garry wrote:
>> On 12/12/2018 17:17, Robin Murphy wrote:
>>> [ +Suzuki ]
>>>
>>> Hi John,
>>>
>>
>> Hi Robin,
>>
>>> On 12/12/2018 16:48, John Garry wrote:
>>>> Hi all,
>>>>
>>>> I am finding our arm64 D05 board particularly slow to boot from
>>>> linux-next, specifically a 30+ second pause when setting up CPU
>>>> features.
>>>
>>> That does look like it's almost certainly spending the mystery time in
>>> setup_cpu_features() itself.
>>
>> Seems to be "Kernel page table isolation (KPTI)" feature which we hang
>> on, but I would not say that's conclusive.
>>
>
> I think I have an idea what could be happening. The cpu_enable()
> for KPTI, waits for all the secondary CPUs to enter a busy loop,
> before installing the non-global mapping. So, with the changes in
> -next, we batch the cpu_enabl() callbacks, which implies, the seconary
> CPUs end up in the "cpu_enable()" for KPTI at different times.
>
> Could you check if the following hack makes it any better ?
>

Hi,

Unfortunately it does not help:
[    5.502243] CPU63: Booted secondary processor 0x0000070303 [0x410fd082]
[    5.502329] smp: Brought up 4 nodes, 64 CPUs
[    7.442722] SMP: Total of 64 processors activated.
[    7.447567] CPU features: detected: GIC system register CPU interface
[    7.454098] CPU features: detected: 32-bit EL0 Support
[    7.459291] CPU features: detected: CRC32 instructions
[   40.236781] CPU: All CPU(s) started at EL2
[   40.241062] alternatives: patching kernel code
[   40.263213] devtmpfs: initialized
[   40.267140] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 7645041785100000 ns
[   40.277147] futex hash table entries: 16384 (order: 8, 1048576 bytes)
[   40.284424] pinctrl core: initialized pinctrl subsystem
[   40.290081] SMBIOS 3.0.0 present.

BTW, If you guys know the reason for this delay and it is not going to 
be an issue, then that's fine. I just wanted to raise awareness.

Cheers,
John

> ---8>---
>
> hack: Reorder KPTI to the top
>
>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/cpucaps.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/cpucaps.h
> b/arch/arm64/include/asm/cpucaps.h
> index a89f587..1363e09 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -18,7 +18,7 @@
>  #ifndef __ASM_CPUCAPS_H
>  #define __ASM_CPUCAPS_H
>
> -#define ARM64_WORKAROUND_CLEAN_CACHE        0
> +#define ARM64_UNMAP_KERNEL_AT_EL0        0
>  #define ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE    1
>  #define ARM64_WORKAROUND_845719            2
>  #define ARM64_HAS_SYSREG_GIC_CPUIF        3
> @@ -41,7 +41,7 @@
>  #define ARM64_WORKAROUND_CAVIUM_30115        20
>  #define ARM64_HAS_DCPOP                21
>  #define ARM64_SVE                22
> -#define ARM64_UNMAP_KERNEL_AT_EL0        23
> +#define ARM64_WORKAROUND_CLEAN_CACHE        23
>  #define ARM64_HARDEN_BRANCH_PREDICTOR        24
>  #define ARM64_HAS_RAS_EXTN            25
>  #define ARM64_WORKAROUND_843419            26



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
