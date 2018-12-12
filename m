Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4501C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:08:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 887622084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uQzA9LTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887622084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:Subject:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1ZtvG5PyjwLlSHxgJDefYJHRNRA2re622nVCnOmlOeY=; b=uQzA9LTu+Zi2Y9elJSDcy5yUC
	AsUSnM8PgjWom22TpyBVp1RMVSX2vugy4UxGMbxnDZ6lAiEsHwsYyPv16+dZL8rHK674V5QN9lzk1
	AuKAzM2f6XYSYvpulqcBUCT5Z6UV/zVupVt8XUAzmX2gWM0gcqK5mu3/s+f12ar4UmX/FiPQOED1Y
	lQeWy8fgZIcEtzJQMgeujPFpyIS7ufY2AX7X6op2jz2AcuwFMNDiB9SHFptA7JQ3l7cBisW0Ul35B
	jPjxaAEr1WZnhniQsDqqvWg1tKlsBPAl3TbGDEHRqVrfHQ9zcOZOWonGhk8rdY2LNs1oyoBvvDLI2
	LEXFf1iBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX8vW-0007Ky-AY; Wed, 12 Dec 2018 18:08:06 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX8vS-0007K5-SR
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 18:08:04 +0000
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 0099C3D5B0D06;
 Thu, 13 Dec 2018 02:07:42 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Thu, 13 Dec 2018
 02:07:33 +0800
From: John Garry <john.garry@huawei.com>
Subject: Re: arm64 board boot pauses on linux-next (resend)
To: Robin Murphy <robin.murphy@arm.com>, <linux-arm-kernel@lists.infradead.org>
References: <95b1b28c-da6d-fa1f-4b39-ed3c37c4bb9e@huawei.com>
 <8e1e38dd-70b0-a0ec-0687-581cc773b600@arm.com>
Message-ID: <644bb3fa-20e5-9958-e3aa-67eb711289ce@huawei.com>
Date: Wed, 12 Dec 2018 18:07:29 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <8e1e38dd-70b0-a0ec-0687-581cc773b600@arm.com>
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_100803_085015_8C0BC8FD 
X-CRM114-Status: GOOD (  12.99  )
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
Cc: Linuxarm <linuxarm@huawei.com>, Suzuki K Poulose <suzuki.poulose@arm.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/12/2018 17:17, Robin Murphy wrote:
> [ +Suzuki ]
>
> Hi John,
>

Hi Robin,

> On 12/12/2018 16:48, John Garry wrote:
>> Hi all,
>>
>> I am finding our arm64 D05 board particularly slow to boot from
>> linux-next, specifically a 30+ second pause when setting up CPU features.
>
> That does look like it's almost certainly spending the mystery time in
> setup_cpu_features() itself.

Seems to be "Kernel page table isolation (KPTI)" feature which we hang 
on, but I would not say that's conclusive.

>
>> I tried to bisect, but I am finding bisect holes (board does not boot
>> at all).
>
> I'd suggest focusing on the arm64 for-next/core branch, since we have
> some cpufeature rework queued there which was supposed to make it go
> quicker...

Tip of this branch doesn't exhibit the issue.

Cheers,
John

>
> Robin.
>
>>
>> Snippet good, like v4.20-rc6:
>> [    5.482756] smp: Brought up 4 nodes, 64 CPUs
>> [    7.423242] SMP: Total of 64 processors activated.
>> [    7.428087] CPU features: detected: GIC system register CPU interface
>> [    7.434620] CPU features: detected: 32-bit EL0 Support
>> [    7.439813] CPU features: detected: CRC32 instructions
>> [    7.530336] CPU: All CPU(s) started at EL2
>> [    7.534599] alternatives: patching kernel code
>> [    7.556042] devtmpfs: initialized
>> [    7.559982] clocksource: jiffies: mask: 0xffffffff max_cycles:
>> 0xffffffff, max_idle_ns: 7645041785100000 ns
>> [    7.569991] futex hash table entries: 16384 (order: 8, 1048576 bytes)
>> [    7.577262] pinctrl core: initialized pinctrl subsystem
>> [    7.582947] SMBIOS 3.0.0 present.
>> [    7.586293] DMI: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 IT17
>> Nemo 2.0 RC0 10/05/2018
>> [    7.594812] NET: Registered protocol family 16
>> [    7.600073] audit: initializing netlink subsys (disabled)
>> [    7.605593] audit: type=2000 audit(5.072:1): state=initialized
>> audit_enabled=0 res=1
>>
>>
>> Snippet next-20181211:
>> [    5.483420] GICv3: CPU63: found redistributor 70303 region
>> 63:0x000004006d4c0000
>> [    5.483438] GICv3: CPU63: using allocated LPI pending table
>> @0x0000001fb8dd0000
>> [    5.483578] arch_timer: CPU63: Trapping CNTVCT access
>> [    5.483582] CPU63: Booted secondary processor 0x0000070303
>> [0x410fd082]
>> [    5.483666] smp: Brought up 4 nodes, 64 CPUs
>> [    7.424162] SMP: Total of 64 processors activated.
>> [    7.429006] CPU features: detected: GIC system register CPU interface
>> [    7.435538] CPU features: detected: 32-bit EL0 Support
>> [    7.440731] CPU features: detected: CRC32 instructions
>> [   40.107984] CPU: All CPU(s) started at EL2
>> [   40.112264] alternatives: patching kernel code
>> [   40.134299] devtmpfs: initialized
>> [   40.138196] clocksource: jiffies: mask: 0xffffffff max_cycles:
>> 0xffffffff, max_idle_ns: 7645041785100000 ns
>> [   40.148209] futex hash table entries: 16384 (order: 8, 1048576 bytes)
>> [   40.155486] pinctrl core: initialized pinctrl subsystem
>> [   40.161109] SMBIOS 3.0.0 present.
>> [   40.164456] DMI: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 IT17
>> Nemo 2.0 RC0 10/05/2018
>> [   40.172985] NET: Registered protocol family 16
>> [   40.178236] audit: initializing netlink subsys (disabled)
>> [   40.183748] audit: type=2000 audit(5.072:1): state=initialized
>> audit_enabled=0 res=1
>>
>> Anyone else notice a similar issue?
>>
>> Our nextgen D06 board does not seem to have this issue.
>>
>> Thanks,
>> John
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> .
>



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
