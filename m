Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C08C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:49:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6046F21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cF8+AwKm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nJ/UAZaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6046F21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j8JvxOa7aNREFy3QkatDnVDofTSAB1VkowHHwh0bH2A=; b=cF8+AwKmRsy8fN
	dmPrZmXErmLNxF9UkN8/Yrsqfcob6toOoM20FtzG3e6Av3ry2++bvtrFh19VxBZx9MIzywobhdqR7
	JM2tSPAr8cW62rY8Gqsx5X8nYHrvE6ftHdjtRYjCADRTritUc6sxwT3ym8d43vmehyZLAoEsYlGKy
	ncn8Wl4iqWlnwbmuCXwehJGN3Uh0Hal5oaKO50zYmnZb6Wndv2GAtZN26PsRYHS+aZwfv0dMlH0NH
	QBbsd0zuc7kJFcLyZFoVMltfj4mvoN55+MIQRW/vKb6cn40KzR1yWYKRYZPG8p2kPq8290LSGWoug
	z4UDGC4DlPnonD2zULHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpYFt-0008O5-5c; Fri, 01 Feb 2019 12:49:13 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpYFp-0008Nk-6e
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 12:49:10 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c54401b0000>; Fri, 01 Feb 2019 04:48:27 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 01 Feb 2019 04:49:08 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 01 Feb 2019 04:49:08 -0800
Received: from [10.26.11.142] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 12:49:06 +0000
Subject: Re: [PATCH V5 0/7] Add CPUidle support for Tegra210
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner
 <tglx@linutronix.de>
References: <20190201033621.16814-1-josephl@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <1e8434d3-99aa-5d5f-3f2a-15f87f03e2e4@nvidia.com>
Date: Fri, 1 Feb 2019 12:49:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190201033621.16814-1-josephl@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1549025307; bh=J9MKiGDgbt3DZ3Yoyv/WrVTRWtDRMwHTEqeTt4Vsw20=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=nJ/UAZaWW0O52dQs/eSI8g0TG6iOwl4TiU1WJdTkjbqrxI4VF6bV4ipR70THfhgWz
 JmyexHewwG34L8kh+gG6mAh2iKAs9ZBc+sTRPUKMYZSBuLV3Pp71AsZdFuuE+cXCq6
 vlRpzBDLi3IunT5J6GrF0De0TnCU7v+pCd8gwxyYgIknrvYcZtMftk08AgkAe9OfTn
 7jybRPV62EAue6lk8RElWlT1fP3yPLQyQ4pZskMjeNMjwO2a+rbDXkV1bTQAAdeOxF
 Ef4vMxEobbg89fdvusC6n08I7SKvLA7d95H9YSuo65kB2ry4A2DNYN5RtcBZyxF1r+
 aiFpt25w1I8Uw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_044909_317696_F2314268 
X-CRM114-Status: GOOD (  17.15  )
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
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 01/02/2019 03:36, Joseph Lo wrote:
> This patch series adds CPUidle support for Tegra210, which supports
> power-down state (C7) for CPU cores. And due to arch timer cannot work
> across CPU core power-down and power on reset signal event. We introduce
> Tegra210 timer driver to work as clock event device. So it can be the
> wake-up source of CPU cores when they idled in the power-down state.
> 
> Fixed in V5:
>  * Just resend this whole series again with timer and Tegra maintainers
>    included
> 
> Fixed in V4:
>  * merge timer-tegra210.c into timer-tegra20.c
>  * add a new patch to select TEGRA_TIMER by default for Tegra210
> 
> Fixed in V3:
>  * use timer-of API for Tegra210 timer driver
> 
> Fixed in V2:
>  * list all the timer IRQs in the binding doc and dts file
>  * add error clean-up code in timer driver
>  * add entry-latency-us and exit-latency-us properties for idle-states
>    DT node
> 
> Joseph Lo (7):
>   dt-bindings: timer: add Tegra210 timer
>   clocksource: tegra: add Tegra210 timer support
>   soc/tegra: default select TEGRA_TIMER for Tegra210
>   arm64: dts: tegra210: fix timer node
>   arm64: dts: tegra210: add CPU idle states properties
>   arm64: dts: tegra210-p2180: Enable CPU idle support
>   arm64: dts: tegra210-smaug: Enable CPU idle support
> 
>  .../bindings/timer/nvidia,tegra210-timer.txt  |  36 ++
>  .../arm64/boot/dts/nvidia/tegra210-p2180.dtsi |   6 +
>  arch/arm64/boot/dts/nvidia/tegra210-smaug.dts |   7 +
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  33 +-
>  drivers/clocksource/Kconfig                   |   2 +-
>  drivers/clocksource/timer-tegra20.c           | 369 +++++++++++++-----
>  drivers/soc/tegra/Kconfig                     |   1 +
>  include/linux/cpuhotplug.h                    |   1 +
>  8 files changed, 352 insertions(+), 103 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt

Series looks good to me. Just a minor comment on patch 2/7 but otherwise
for the series ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
