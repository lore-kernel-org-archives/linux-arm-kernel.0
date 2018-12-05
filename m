Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F45C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:12:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87A152084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Py8a6McB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ctQX4J+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A152084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KBaCSCOpPlQQG9iY4/Es4mjFI2QWF39QJ6qtZi9bxM4=; b=Py8a6McBPfJgFGHGX1Xb4adD1
	FQCAVXCRihd809Pl2mWoQJuOAoi4s+iFrLUt3beXlrMSuM/dE8d/ie/OG9af86e5DEiexj8hRtU3N
	jT7v17IftUf8OIs2VuOYX2MNquJg7ewXhBLhHlDrX7VkUHG6s/d73XuNXY+bFmTq8+dr7pexCA4DE
	7Efcid4LNAyvc0tiutqAJ38FysnJ2yrsOzHZojOQn8R3F35WI0h80ShKID1PWwmKku/UItchQpnhe
	YmsQfz+PLq7XSJvCkZn8TEC5fpnf9mdh6utSJiSJs5xwCtiHK7FAEP/QkkCc+MQO77/AI4gYONv+/
	yN0AqMvdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUQPn-0007NA-Do; Wed, 05 Dec 2018 06:12:07 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUQPl-0007Lt-1a
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 06:12:06 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c076c290000>; Tue, 04 Dec 2018 22:11:53 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 04 Dec 2018 22:11:54 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 04 Dec 2018 22:11:54 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 5 Dec
 2018 06:11:52 +0000
Subject: Re: [PATCH 00/19] Tegra210 DFLL support
To: Thierry Reding <thierry.reding@gmail.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204151059.GA23827@ulmo>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <43c59781-3548-b643-3c5e-9d2dcab422f2@nvidia.com>
Date: Wed, 5 Dec 2018 14:11:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204151059.GA23827@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1543990313; bh=cI5viBqZsrU7zAbr6DtN9LDds4rlapK6lKPQaQLP3Iw=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=ctQX4J+4Lu2o3wEpmTVqvPRES8JSTcr1UOG0mV/wajtSiQuHvykaDnfs05HccUfu/
 Nfe7uvLwMJYcRO3OGI19oyHFdsSfx75kHitl8sbjH4IFsm2wSj9nibvzNgubtr8JoL
 /bZufxCJA6O64mkYIKf5f6DDs1hnZz2U/G+uTMnuuctAzg/gTiox8h4HtNz0adoVhp
 +vmby2zr3kh0vnqqm6DwXXS+bwQlL9mLHpr54sKQ/99x+X9t0wQud/fflWBg5PINwB
 3buGHEGIuBQH6qSekMxAwcrWDIUegkgYt7A4H3GMGh0usc7lnDJqCAu0owLLo7xgnF
 dB6VWqbuawb2A==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_221205_103459_8AFC3776 
X-CRM114-Status: GOOD (  19.28  )
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
Cc: linux-tegra@vger.kernel.org, Peter De Schrijver <pdeschrijver@nvidia.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jonathan Hunter <jonathanh@nvidia.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 12/4/18 11:10 PM, Thierry Reding wrote:
> On Tue, Dec 04, 2018 at 05:25:29PM +0800, Joseph Lo wrote:
>> This series introduces support for the DFLL as a CPU clock source
>> on Tegra210. As Jetson TX1 uses a PWM controlled regulator IC which
>> is driven directly by the DFLLs PWM output, we also introduce support
>> for PWM regulators next to I2C controlled regulators. The DFLL output
>> frequency is directly controlled by the regulator voltage. The registers
>> for controlling the PWM are part of the DFLL IP block, so there's no
>> separate linux regulator object involved because the regulator IC only
>> supplies the rail powering the CPUs. It doesn't have any other controls.
>>
>> The patch 1~4 are the patches of DT bindings update for DFLL clock and
>> Tegra124 cpufreq, which add PWM and Tegra210 support for DFLL clock and
>> remove deprecate properties for Tegra124 cpufreq bindings.
>>
>> The patch 5~10 are the patches for DFLL clock driver update for PWM-mode
>> DFLL support.
>>
>> The patch 11 and 12 are the Tegra124 cpufreq driver update to make it
>> work with Tegra210.
>>
>> The patch 13~18 are the devicetree files update for Tegra210 SoC and
>> platforms. Two platforms are updated here for different DFLL mode usage.
>> The Tegra210-p2371-2180 (a.k.a. Jetson Tx1) uses DFLL-PWM and the
>> Tegra210-smaug (a.k.a. Pixel C) uses DFLL-I2C. So two different modes
>> are verified with this series.
>>
>> The patch 19 is the patch for enabling the CPU regulator for Smaug
>> board.
>>
>> Joseph Lo (16):
>>    dt-bindings: clock: tegra124-dfll: add Tegra210 support
>>    dt-bindings: cpufreq: tegra124: remove vdd-cpu-supply from required
>>      properties
>>    dt-bindings: cpufreq: tegra124: remove cpu_lp clock from required
>>      properties
>>    clk: tegra: dfll: CVB calculation alignment with the regulator
>>    clk: tegra: dfll: support PWM regulator control
>>    clk: tegra: dfll: round down voltages based on alignment
>>    clk: tegra: dfll: add CVB tables for Tegra210
>>    cpufreq: tegra124: do not handle the CPU rail
>>    cpufreq: tegra124: extend to support Tegra210
>>    arm64: dts: tegra210: add DFLL clock
>>    arm64: dts: tegra210: add CPU clocks
>>    arm64: dts: tegra210-p2597: add pinmux for PWM-based DFLL support
>>    arm64: dts: tegra210-p2371-2180: enable DFLL clock
>>    arm64: dts: tegra210-smaug: add CPU power rail regulator
>>    arm64: dts: tegra210-smaug: enable DFLL clock
>>    arm64: defconfig: Enable MAX8973 regulator
>>
>> Peter De Schrijver (3):
>>    dt-bindings: clock: tegra124-dfll: Update DFLL binding for PWM
>>      regulator
>>    clk: tegra: dfll: registration for multiple SoCs
>>    clk: tegra: dfll: build clk-dfll.c for Tegra124 and Tegra210
>>
>>   .../bindings/clock/nvidia,tegra124-dfll.txt   |  77 ++-
>>   .../cpufreq/nvidia,tegra124-cpufreq.txt       |   6 +-
>>   .../boot/dts/nvidia/tegra210-p2371-2180.dts   |  20 +
>>   .../arm64/boot/dts/nvidia/tegra210-p2597.dtsi |  14 +
>>   arch/arm64/boot/dts/nvidia/tegra210-smaug.dts |  31 +
>>   arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  25 +
>>   arch/arm64/configs/defconfig                  |   1 +
>>   drivers/clk/tegra/Kconfig                     |   5 +
>>   drivers/clk/tegra/Makefile                    |   2 +-
>>   drivers/clk/tegra/clk-dfll.c                  | 455 ++++++++++++---
>>   drivers/clk/tegra/clk-dfll.h                  |   6 +-
>>   drivers/clk/tegra/clk-tegra124-dfll-fcpu.c    | 536 +++++++++++++++++-
>>   drivers/clk/tegra/cvb.c                       |  12 +-
>>   drivers/clk/tegra/cvb.h                       |   7 +-
>>   drivers/cpufreq/Kconfig.arm                   |   2 +-
>>   drivers/cpufreq/tegra124-cpufreq.c            |  29 +-
>>   16 files changed, 1095 insertions(+), 133 deletions(-)
> 
> Hi Joseph,
> 
> can you highlight the build and runtime dependencies between the various
> patches? For example, can I pick up all the arch/arm64 patches into the
> Tegra tree without breaking anything?
> 

Hi Thierry,

The patches for DFLL clock and dts have build dependency, which means we 
need to follow the patch sequence to apply these patches (They can be 
applied separately.). The runtime dependency depends on two sub-series, 
"DFLL clock + cpufreq" patches and the dts series. We can just apply the 
changes for "arch/arm64" but the functionality needs to wait for another 
sub-series.

Thanks,
Joseph

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
