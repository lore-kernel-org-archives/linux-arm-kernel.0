Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5DEC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:17:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A89A21726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WgE0q+/j";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kl2572Js"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A89A21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=rNbni8a/Kr/aXAJ+MhYnQ7RgWZqcALKqhueRvxNNNqI=; b=WgE0q+/jYygA84
	MRqBGEyJteURD5rDJ+LG0eY7myaQPPa6v791GdmAh8Aq/Ks3AItmbaAPjLxzBpSJoEV4rycyM7OQP
	wa6QKnwhvHHqHfnQhmnswGrGNTk3xhndwQV8OJmNzYJkYJrbhWDrn5oyzMdhnoxbvOfAzymdzx6eI
	MIHnVioGvhgqtvIGptBuNgKRwkxjL0vS91r+Es8LGKTtjCLX6XskmPxpOEUDTfeK/bGQc6NeJBXdB
	F/ypW/ICFvsSzq8aRppxHmBtpZ1WAVU3aChu7FbI0Nbm5Qp2JhuIq0A4HrhH22p73d1/oc1NRBFUL
	OpGXjxIRozsWsZuGbrKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpbV0-0007J6-C4; Fri, 01 Feb 2019 16:17:02 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpbUx-0007Hl-MV
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 16:17:01 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c5470de0001>; Fri, 01 Feb 2019 08:16:30 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Fri, 01 Feb 2019 08:16:59 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Fri, 01 Feb 2019 08:16:59 -0800
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 16:16:58 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 16:16:58 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 16:16:58 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw01.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c5470f90000>; Fri, 01 Feb 2019 08:16:58 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Thomas
 Gleixner" <tglx@linutronix.de>
Subject: [PATCH V6 0/7] Add CPUidle support for Tegra210
Date: Sat, 2 Feb 2019 00:16:47 +0800
Message-ID: <20190201161654.18315-1-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1549037790; bh=uJscNHq2iMjdct3rzEKX6s6cmP5B4dRbAdT8oBFTQU4=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
 Content-Type;
 b=kl2572JsMkd0Ei4k6F/qkG5kTxnpO4no0j0AXoC1WnRCshrBzw4zej5kZLm+OShUF
 iSql6XWw9suXECeMGwl6/m0I2wRJ08S1RKI55MjUHTZUDC5OJBNbLy5aDScYfupEl6
 WphU494Zy97cz7+PokHQ5QI8aLIgXGEZeEj7UmWvnS9o2/6kgvfMLpefwHBS31+nrL
 5UwSSwvwYldoTlliUpXX/AP+wqmzezpDSdLzesO3VOkII14F7y7v65NuDJQ/DRySVr
 Op9ddm+AYk1ihNSpwbbaFsyzo4/ocdtg3asZDdhae++6Uu3mTUFQYOwrvTyYF6gGpZ
 9sAFHv5s6D/rQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_081659_743120_D3F15383 
X-CRM114-Status: GOOD (  11.13  )
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
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch series adds CPUidle support for Tegra210, which supports
power-down state (C7) for CPU cores. And due to arch timer cannot work
across CPU core power-down and power on reset signal event. We introduce
Tegra210 timer driver to work as clock event device. So it can be the
wake-up source of CPU cores when they idled in the power-down state.

Fix in V6:
 * refine the timer defines in the timer driver (PATCH 2)
 * add ack tags from Jon Hunter.

Fixed in V5:
 * Just resend this whole series again with timer and Tegra maintainers
   included

Fixed in V4:
 * merge timer-tegra210.c into timer-tegra20.c
 * add a new patch to select TEGRA_TIMER by default for Tegra210

Fixed in V3:
 * use timer-of API for Tegra210 timer driver

Fixed in V2:
 * list all the timer IRQs in the binding doc and dts file
 * add error clean-up code in timer driver
 * add entry-latency-us and exit-latency-us properties for idle-states
   DT node

Joseph Lo (7):
  dt-bindings: timer: add Tegra210 timer
  clocksource: tegra: add Tegra210 timer support
  soc/tegra: default select TEGRA_TIMER for Tegra210
  arm64: dts: tegra210: fix timer node
  arm64: dts: tegra210: add CPU idle states properties
  arm64: dts: tegra210-p2180: Enable CPU idle support
  arm64: dts: tegra210-smaug: Enable CPU idle support

 .../bindings/timer/nvidia,tegra210-timer.txt  |  36 ++
 .../arm64/boot/dts/nvidia/tegra210-p2180.dtsi |   6 +
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts |   7 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  33 +-
 drivers/clocksource/Kconfig                   |   2 +-
 drivers/clocksource/timer-tegra20.c           | 371 +++++++++++++-----
 drivers/soc/tegra/Kconfig                     |   1 +
 include/linux/cpuhotplug.h                    |   1 +
 8 files changed, 350 insertions(+), 107 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
