Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B3FC282D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:42:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57C5721473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fDFuP0Zp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C5721473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=JsU++BNT+Clq5Xpt4zVZKAa2yI8Ba01Fc0Ep/wMkb3c=; b=fDFuP0ZpNJtbIy
	9A8h95FXDFvbmtf0+vRmEiH/n63eSJ18g3xWm6/3YVtLl86jj1/0daBOpxqiXUQ9O9bQXsQrDJ6GO
	njdC4ZCcpR0HUUJWv8Bj15Fm/BeJvPocPvorFNVpLdiIhjvkf/G9sckpWS4QGEbrd8SqXICexgZZW
	dmak7ccdmdrecDCNU5El6OSumCw6uyqt8nS9yBbCyH9E/2N/8n+QOEALM6jCrPs/SWmQ0Rvqo3qkU
	PRUAOXzrqRc7zEPIuJyAMtqBxYhPRu+q/y47EPhji/GvuX7t6eeqIye7/ky0Mi4V1Fg8a7E8pkQ11
	FhOcv4rrjRd6C1/u+/kA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1golS3-0002Ef-8o; Wed, 30 Jan 2019 08:42:31 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1golRw-0002Cn-It
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 08:42:26 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id B51445FBD8; Wed, 30 Jan 2019 16:42:17 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 00/10] arm64: dts: allwinner: h5: Enable CPU DVFS (cpufreq)
Date: Wed, 30 Jan 2019 16:41:53 +0800
Message-Id: <20190130084203.25053-1-wens@csie.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_004224_818804_46A8298A 
X-CRM114-Status: GOOD (  11.92  )
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
Cc: devicetree@vger.kernel.org, Sergey Matyukevich <geomatsi@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 linux-kernel@vger.kernel.org, Emmanuel Vadot <manu@freebsd.org>,
 linux-sunxi@googlegroups.com, Jagan Teki <jagan@amarulasolutions.com>,
 Hauke Mehrtens <hauke@hauke-m.de>, linux-arm-kernel@lists.infradead.org,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi everyone,

This series enables DVFS for the CPU cores (aka cpufreq) on the
Allwinner H5 SoC. The OPP table was taken from Armbian, with minor
tweaks to the maximum voltage to account for slightly increased voltage
on some of the boards.

This has been tested on the Bananapi M2+ v1.2 and Libre Computer
ALL-H3-CC H5 ver..  I do not have the remaining boards so I've CC-ed
people who did the original submission or have modified the board
specifically later on.

Patch 1 fixes the voltages specified for the GPIO-controlled regulator
on the Bananapi M2+ v1.2. The voltages are slightly higher than what
was originally written.

Patch 2 adds a fixed regulator for the CPU on the original Bananapi M2+.
This is for the retail version, not the engineering samples that had an
even higher voltage setting.

Patch 3 hooks up the CPU regulator supply for H5 boards that already
define the regulator, but were missing the property to tie it to the
CPUs.

Patch 4 ~ 8 adds the CPU regulator for boards that don't have it
defined. This is based on each vendor's schematics. I need people
to test each of these specifically and the whole series.

Patch 9 ties the CPU clock to the CPU cores.

Patch 10 adds the OPP table, based on the one from Armbian.

Please have a look and please help test this.


Regards
ChenYu


Chen-Yu Tsai (10):
  ARM: dts: sunxi: bananapi-m2-plus-v1.2: Fix CPU supply voltages
  ARM: dts: bananapi-m2-plus: Add CPU supply regulator
  arm64: dts: allwinner: h5: Hook up cpu regulator supplies
  arm64: dts: allwinner: h5: nanopi-neo2: Add CPU regulator supply
  arm64: dts: allwinner: h5: orange-pi-zero-plus: Add CPU regulator
    supply
  arm64: dts: allwinner: h5: orange-pi-zero-plus2: Add CPU regulator
    supply
  arm64: dts: allwinner: h5: orange-pi-pc2: Add CPU regulator supply
  arm64: dts: allwinner: h5: orange-pi-prime: Add CPU regulator supply
  arm64: dts: allwinner: h5: Add clock to CPU cores
  arm64: dts: allwinner: h5: Add CPU Operating Performance Points table

 .../boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi | 30 +++-----
 arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi | 14 ++++
 .../sun50i-h5-emlid-neutis-n5-devboard.dts    |  4 +
 .../allwinner/sun50i-h5-nanopi-neo-plus2.dts  |  4 +
 .../dts/allwinner/sun50i-h5-nanopi-neo2.dts   | 20 +++++
 .../dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 28 +++++++
 .../allwinner/sun50i-h5-orangepi-prime.dts    | 28 +++++++
 .../sun50i-h5-orangepi-zero-plus.dts          | 20 +++++
 .../sun50i-h5-orangepi-zero-plus2.dts         | 20 +++++
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  | 75 +++++++++++++++++++
 10 files changed, 224 insertions(+), 19 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
