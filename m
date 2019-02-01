Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF07C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:36:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F0420815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J3NkYl89";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="E2Gk+EcB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F0420815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=69cj+MZk0iZSZu+tBltxF6L7VBPYTX3sUe90VY1ndLo=; b=J3NkYl89OJwCLj
	9WfHol6WcM7702ZVOssmQTppx6NSDJEOSxiv9KFd2Oz80JFK33RPi1WqHW3ofDK8yTL3FOQEQ7mSz
	0xU8JWqZe95jRuQkHco4sFDm9BLWonvOKBf0M7aSokGbSDJR6CQmG4Eic5WZTTcJ7uYIYf98rpNJu
	WauSUAuOzkL4iyviwYWTgn8GnRibmA9ltRgggIeSejsPjMO2n8KzCLRNJo5XKaEoYKevk4rdATc9C
	1bJO6zYNAKIaHeIBZIUbCR9YRYFBt1VFRbyVICtj/O5l8rq4sIoQysI/EQOvjvnyVXasyU7vb92Cc
	Z6PcQpspAfMoT4dZWYcQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpPd0-0004Qf-OC; Fri, 01 Feb 2019 03:36:30 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpPcx-0004QM-G5
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 03:36:28 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c53bebc0000>; Thu, 31 Jan 2019 19:36:29 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 31 Jan 2019 19:36:27 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 31 Jan 2019 19:36:27 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 03:36:26 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Fri, 1 Feb 2019 03:36:27 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c53beb90000>; Thu, 31 Jan 2019 19:36:26 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas
 Gleixner <tglx@linutronix.de>
Subject: [PATCH V5 0/7] Add CPUidle support for Tegra210
Date: Fri, 1 Feb 2019 11:36:14 +0800
Message-ID: <20190201033621.16814-1-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548992189; bh=sRsq/hOUknDMaVRYrhOE2ejUlz+TDwQQerbOP2UQDi8=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
 Content-Type;
 b=E2Gk+EcBnVfadaQZ76TcZdukb6qVqvTrnWhO4bpJqwnAtF82YXGTH/WLwqikOs/gN
 Mv8zzNvmO1trgEXZfN+eH+20y2787hrWuckmocQ7JtMMnrpiIJKbb7W/xIhRPtLSn5
 HaQBL7hGHcsOgVOElkEtVgzInL8JoE7Ejemx5wijulYh7U3CViJ8/GppXM7u5QGacs
 BHD3miJaON/Vtk4wsw7WZ/SGqugjVyL1PNRSUH1mhhwzoA4KN80uQKfmpOTqM2roin
 OzxBEpNl+ksiVppV0QvbFhf/1LcTzo4bPWLHs9mMIem+ZqWL28D7/wj/U+6NsPuB8C
 ebFmnk2A6Z7Kg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_193627_551255_FB378E4D 
X-CRM114-Status: GOOD (  10.62  )
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
 drivers/clocksource/timer-tegra20.c           | 369 +++++++++++++-----
 drivers/soc/tegra/Kconfig                     |   1 +
 include/linux/cpuhotplug.h                    |   1 +
 8 files changed, 352 insertions(+), 103 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
