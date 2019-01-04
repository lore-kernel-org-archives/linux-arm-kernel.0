Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98006C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:07:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F05920449
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uSgr1DAh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Ubzrh0rI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F05920449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Yb/+YN2CU5JQ2TpK/toteWjflpfU5O18rg21wOYvpAM=; b=uSgr1DAhKROujt
	JqJvGGsb6RZjvix5/ITtNZ64bXjwsgJJohMXDwSu/EcaThdUNP2C0yQUQmaW5//O6NjdkiZSgEvji
	HFO76dKa8NPYBWNXerUj35VapWTIr/qMFvqG2wNIFnlvXS94Y8yhG7ezgju0LFEvp1yERJzdXbXMo
	sk43DZI17e9jIagIz9j6aAA2d83MH8xZLTwLUi9Tf/1YFWJJFD2C06rko1maapdc13NL1dbjgTKhB
	NiUmhpjicYM6wK5dtf2omqBbJwRD9X7iTot458xje5YBplL1KGpu4UIziHxQGLA0nPFYa/6HbLoC2
	tnpsIdTzBxnZwF/QS2Og==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfFpr-00064W-5L; Fri, 04 Jan 2019 03:07:47 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfFpH-0005Yb-Ch
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 03:07:14 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c2ecdcf0000>; Thu, 03 Jan 2019 19:06:55 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 03 Jan 2019 19:07:09 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 03 Jan 2019 19:07:09 -0800
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 4 Jan
 2019 03:07:09 +0000
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 4 Jan
 2019 03:07:09 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Fri, 4 Jan 2019 03:07:09 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c2ecddb0001>; Thu, 03 Jan 2019 19:07:08 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver
 <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH V4 00/20] Tegra210 DFLL support
Date: Fri, 4 Jan 2019 11:06:42 +0800
Message-ID: <20190104030702.8684-1-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1546571215; bh=PfzdiscJQ3Mm0CsBpXzKESM5yHoy9IKIDBPfTnnzKVQ=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
 Content-Type;
 b=Ubzrh0rIdRTIsil+j6vJziXu8q/2pQ8lsyBKvUA655XOnzRCcH2sNaXnZZqyXjtdq
 D+f/gumeuZ8X/5R3YF9Fu/iG4Xg9AOrU6CLUVdDMUgi/yA13ycISV7zutR0dk8c2xC
 xAwsBjOQYWhgZCbKRifC5ojSE90Xh4UE3Lrv9QqvtrGcvigI0v1XtKjaIs2eVBkAf+
 Gk7RGy8H4jpmO0l0UaR1r0nnhB3LEoLR91fU88ZVQ1XpHI0MSe0PY81smvO9BiAGQO
 3gskdXK07WC/RHYfMUfJnceuNDQfTcfxlBIlUv+lKV6wz2cWbRcNgRj+686mg61lMS
 mMzempPKFw0Vg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_190711_737581_5E8C55DA 
X-CRM114-Status: GOOD (  14.25  )
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
Cc: linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This series introduces support for the DFLL as a CPU clock source
on Tegra210. As Jetson TX1 uses a PWM controlled regulator IC which
is driven directly by the DFLLs PWM output, we also introduce support
for PWM regulators next to I2C controlled regulators. The DFLL output
frequency is directly controlled by the regulator voltage. The registers
for controlling the PWM are part of the DFLL IP block, so there's no
separate linux regulator object involved because the regulator IC only
supplies the rail powering the CPUs. It doesn't have any other controls.

The patch 1~4 are the patches of DT bindings update for DFLL clock and
Tegra124 cpufreq, which add PWM and Tegra210 support for DFLL clock and
remove deprecate properties for Tegra124 cpufreq bindings.

The patch 5~10 are the patches for DFLL clock driver update for PWM-mode
DFLL support.

The patch 11~13 are the Tegra124 cpufreq driver update to make it
work with Tegra210.

The patch 14~19 are the devicetree files update for Tegra210 SoC and
platforms. Two platforms are updated here for different DFLL mode usage.
The Tegra210-p2371-2180 (a.k.a. Jetson Tx1) uses DFLL-PWM and the
Tegra210-smaug (a.k.a. Pixel C) uses DFLL-I2C. So two different modes
are verified with this series.

The patch 20 is the patch for enabling the CPU regulator for Smaug
board.

* Update in V4:
 - s/nvidia,pwm-period/nvidia,pwm-period-nanoseconds/ in patch 1 for
 DFLL DT bindings update.
 - remove parenthesis in Kconfig of DFLL driver
 - add more ack and RB tags

* Update in V3:
 - Squash patch 9 in previous series into patch 7 (ref. [0])
 - minor fixes in patch 6 for geting alignment data
 - more variable type fixes in patch 7
 - fix the error handling in patch 8
 - collect more ack tags

* Update in V2:
 - Add two patches that suggested from comments in V1. See patch 9 and
 14.
 - Update DT binding for DFLL-PWM mode in patch 1.
 - Update the code for how to get regulator data from DT or regulator
 API in patch 6.
 - Update to use lut_uv table for LUT lookup in patch 7. That makes the
 generic lut table to work with both I2C and PWM mode.
 - not allow Tegra124 cpufreq driver to be built as a module and remove
 the removal function in patch 12.

[0]: http://patchwork.ozlabs.org/project/linux-tegra/list/?series=81595

Joseph Lo (17):
  dt-bindings: clock: tegra124-dfll: add Tegra210 support
  dt-bindings: cpufreq: tegra124: remove vdd-cpu-supply from required
    properties
  dt-bindings: cpufreq: tegra124: remove cpu_lp clock from required
    properties
  clk: tegra: dfll: CVB calculation alignment with the regulator
  clk: tegra: dfll: support PWM regulator control
  clk: tegra: dfll: round down voltages based on alignment
  clk: tegra: dfll: add CVB tables for Tegra210
  cpufreq: tegra124: do not handle the CPU rail
  cpufreq: tegra124: extend to support Tegra210
  cpufreq: dt-platdev: add Tegra210 to blacklist
  arm64: dts: tegra210: add DFLL clock
  arm64: dts: tegra210: add CPU clocks
  arm64: dts: tegra210-p2597: add pinmux for PWM-based DFLL support
  arm64: dts: tegra210-p2371-2180: enable DFLL clock
  arm64: dts: tegra210-smaug: add CPU power rail regulator
  arm64: dts: tegra210-smaug: enable DFLL clock
  arm64: defconfig: Enable MAX8973 regulator

Peter De Schrijver (3):
  dt-bindings: clock: tegra124-dfll: Update DFLL binding for PWM
    regulator
  clk: tegra: dfll: registration for multiple SoCs
  clk: tegra: dfll: build clk-dfll.c for Tegra124 and Tegra210

 .../bindings/clock/nvidia,tegra124-dfll.txt   |  83 ++-
 .../cpufreq/nvidia,tegra124-cpufreq.txt       |   6 +-
 .../boot/dts/nvidia/tegra210-p2371-2180.dts   |  21 +
 .../arm64/boot/dts/nvidia/tegra210-p2597.dtsi |  14 +
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts |  31 ++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  25 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/tegra/Kconfig                     |   5 +
 drivers/clk/tegra/Makefile                    |   2 +-
 drivers/clk/tegra/clk-dfll.c                  | 459 +++++++++++++---
 drivers/clk/tegra/clk-dfll.h                  |   6 +-
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c    | 520 +++++++++++++++++-
 drivers/clk/tegra/cvb.c                       |  12 +-
 drivers/clk/tegra/cvb.h                       |   7 +-
 drivers/cpufreq/Kconfig.arm                   |   4 +-
 drivers/cpufreq/cpufreq-dt-platdev.c          |   1 +
 drivers/cpufreq/tegra124-cpufreq.c            |  44 +-
 17 files changed, 1093 insertions(+), 148 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
