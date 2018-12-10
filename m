Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F1DC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:48:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DABC2081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NShQVtPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DABC2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=nWhhVQ0lXJoFX/5sJGjkrNYej6kAz0ePakxeaoQTSsg=; b=NShQVtPduTFfTNLop7OWkvEsQm
	SHfv5wzUxKgjPrrYD2zEDcS96rDaiWntF3QERD7g4ZPwKsBdiw1q4CrZfQRIn9NJvZPmRDWx+6Yq9
	WJj+syWuj1qta5rWEnNc+i7mHq06p1IN4FnX7RN06zBE00wCcFz5fstNiwtRagocmLcygUbZz3ScF
	eND3ErXYXjMp75cPCfntmdPjwG8P6TPYl8qYm58kbMzZzW63wmEe3X2oxZnP0hnvM+Ij+mVAGoNJN
	NLRjmUn1Y8Qtz4WL0uRd8VoupclbJRjwyY4nbW7W2kShb3HQSDX+dQRwZ4OszdlOKd1Arz+ctWDtG
	CvNiO7ZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWGIy-0004Vn-Ff; Mon, 10 Dec 2018 07:48:40 +0000
Received: from mail-pg1-f180.google.com ([209.85.215.180])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWGII-0003j6-PJ
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 07:48:05 +0000
Received: by mail-pg1-f180.google.com with SMTP id s198so4584618pgs.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 23:47:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=pqa9EMb5oRdGEeQJtPA2oU5T4HdPLUuV8gtDcIbT474=;
 b=qix5pBKmwOZjQjRYo01p1ubBzqYfQpgZV/Z2Ma/4ZH/zp8LmUh/0GVF4uA4+7qsArf
 w6S15/6ADSbpIdn3Mw36+okvPiVPhTEpDVKQEJyAz6WmJXPkOSZqXGKtFXpK+/+uogxk
 V7WmuzSBByttVQU3iakT1jdK6paxuXk+ABngkK6i2UMcV60j0RHKwVvfz/vbMT8Rnhuc
 nkURxycweSyGqyfYePMxKVTDFz94QeCTfXHpXfrhl04hwT6eXwB1hgSu7Y/rhXVDVMro
 txKPsLTRvVB/LODuWkbh34SYUWnBRV4Jf0cDzxyK3ECb27DGERT3Jk9KdLlnUXvIf3WG
 IIkQ==
X-Gm-Message-State: AA+aEWYK6D/ILmdQ1zZacQPhCxW2vweBspgqIkZfeWSWRnKnlDL9Mjx5
 aX8RnN/ze+5oUNVgD2p6Uzc2coLVuN/vgw==
X-Google-Smtp-Source: AFSGD/Ub99fzJ0WgHTXFbnoCzl09a/a5COzug6yPH98jp1uXsrunBj6deQHYIf48elNbWX9R8sDWrA==
X-Received: by 2002:a62:7504:: with SMTP id q4mr11237229pfc.180.1544428067562; 
 Sun, 09 Dec 2018 23:47:47 -0800 (PST)
Received: from localhost.localdomain (61-216-91-114.HINET-IP.hinet.net.
 [61.216.91.114])
 by smtp.gmail.com with ESMTPSA id c13sm14363809pfo.121.2018.12.09.23.47.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 09 Dec 2018 23:47:46 -0800 (PST)
From: Shawn Guo <shawnguo@kernel.org>
To: arm@kernel.org
Subject: [GIT PULL 3/7] i.MX device tree update for 4.21
Date: Mon, 10 Dec 2018 15:46:34 +0800
Message-Id: <20181210074638.27873-3-shawnguo@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181210074638.27873-1-shawnguo@kernel.org>
References: <20181210074638.27873-1-shawnguo@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_234759_495918_EB6FE1C8 
X-CRM114-Status: GOOD (  17.60  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-imx@nxp.com, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.21

for you to fetch changes up to 79da07dec740a42c70963ebacbd2bf8866af9e20:

  ARM: dts: imx51-zii-rdu1: Do not specify "power-gpio" for hpa1 (2018-12-10 10:03:19 +0800)

----------------------------------------------------------------
i.MX device tree update for 4.21:
 - New boards support: emtrion emCON-MX6, imx6ul-pico-pi, imx7d-sdb-reva
   and vf610 based Liebherr's BK4 device, ZII SCU4 AIB board.
 - Add flexcan support for i.MX6UL SoC, turn on stop mode wakeup feature
   for flexcan, and enable devices on a few i.MX6 NXP boards.
 - Enable AUO G101EVN010 lcd panel and Goodix touch support for
   imx6ul-ccimx6ulsbcpro board.
 - Enable sensors support for imx6qdl-sabresd board: egalax touch, light,
   magnetometer and accelerometer sensor.
 - Switch more boards to use SPDX identifier.
 - Fix memory node duplication in i.MX device tree sources.
 - Correct GIC PPI interrupts mask for i.MX6UL and i.MX7 SoCs.
 - Drop 'snps,dw-pcie' compatible from LS1021A PCIe device to avoid
   incorrect device matching.
 - Add the gpu nodes for the adreno 200 GPU on iMX51 and iMX53, which
   are now supported by the freedreno driver.
 - Add DCP device support for i.MX6ULL, which requires explicit clock
   enabling.
 - Add '#thermal-sensor-cells' for thermal device and '#cooling-cells'
   for cooling devices.
 - Add missing clock information for EPIT on i.MX25 SoC.
 - Add PWM and qdma devices for LS1021A SoC.
 - Update cooling maps of LS1021A SoC to include all devices affected by
   individual trip points.
 - Random device addition and cleanup on various boards.

----------------------------------------------------------------
Aisheng Dong (7):
      ARM: dts: imx6sx-sdb: add flexcan support
      ARM: dts: imx6sx-sabreauto: add flexcan support
      ARM: dts: imx6qdl-sabreauto: add flexcan support
      ARM: dts: imx6sx: Add flexcan stop mode wakeup support
      ARM: dts: imx6qdl: Add flexcan stop mode wakeup support
      ARM: dts: imx6ul: Add flexcan stop mode wakeup support
      ARM: dts: imx7s: Add flexcan stop mode wakeup support

Alex Gonzalez (4):
      ARM: dts: imx6ul: ccimx6ulsom: Add support for wireless SOM variant
      ARM: dts: imx6ul: ccimx6ulsom: Fix indentation on iomuxc nodes
      ARM: dts: ccimx6ulsbcpro: Enable AUO G101EVN010 lcdif panel
      ARM: dts: ccimx6ulsbcpro: Add support for Goodix touch controller

Andrey Smirnov (1):
      ARM: dts: imx51-zii-rdu1: Do not specify "power-gpio" for hpa1

Anson Huang (11):
      ARM: dts: imx6: add mmdc ipg clock
      ARM: dts: imx6sll: remove unused property in gpc node
      ARM: dts: imx6sl: vddpu is NOT an always-on regulator
      ARM: dts: imx6sx: specify proper clock for nodes with dummy clock
      ARM: dts: imx7d-sdb: add rev-a board support
      ARM: dts: imx6sll-evk: add debug LED support
      ARM: dts: imx6sll-evk: use WDOG_B pin reset
      ARM: dts: imx6qdl-sabresd: add egalax touch screen support on i2c2 bus
      ARM: dts: imx6qdl-sabresd: add light sensor support
      ARM: dts: imx6qdl-sabresd: add magnetometer sensor support
      ARM: dts: imx6qdl-sabresd: add accelerometer sensor support

Dong Aisheng (1):
      ARM: dts: imx6ul: add flexcan support

Fabio Estevam (34):
      ARM: dts: vf610: Add ZII SCU4 AIB board
      ARM: dts: imx51: Fix memory node duplication
      ARM: dts: imx53: Fix memory node duplication
      ARM: dts: imx6sx: Complete the PXP support
      ARM: dts: imx31: Fix memory node duplication
      ARM: dts: imx35: Fix memory node duplication
      ARM: dts: imx7: Fix memory node duplication
      ARM: dts: imx6ul-ccimx6ulsom: Add memory node to board dts
      ARM: dts: imx6ul: Fix memory node duplication
      ARM: dts: imx6sx: Fix memory node duplication
      ARM: dts: imx6sl: Fix memory node duplication
      ARM: dts: imx50: Fix memory node duplication
      ARM: dts: imx6qdl-wandboard: Switch to SPDX identifier
      ARM: dts: imx6: Switch NXP board dts to SPDX identifier
      ARM: dts: imx23: Fix memory node duplication
      ARM: dts: imx28: Fix memory node duplication
      ARM: dts: imx1: Fix memory node duplication
      ARM: dts: imx27: Fix memory node duplication
      ARM: dts: imx25: Fix memory node duplication
      ARM: dts: imx50: Switch to SPDX identifier
      ARM: dts: imx53: Switch to SPDX identifier
      ARM: dts: imx6ul: Correct mask for GIC PPI interrupts
      ARM: dts: imx7: Correct mask for GIC PPI interrupts
      ARM: dts: vf: Fix memory node duplication
      ARM: dts: imx6ul-pico-hobbit: Switch to SPDX identifier
      ARM: dts: imx6ul-pico-hobbit: Move SoM related part to imx6ul-pico.dtsi
      ARM: dts: imx6ul-pico-hobbit: Make the child led nodes standard
      ARM: dts: imx6ul-pico-hobbit: Extend peripherals support
      ARM: dts: imx6ul-pico: Add the imx6ul-pico-pi variant
      ARM: dts: vf610-zii-scu4-aib: Add HI8435 support
      ARM: dts: imx53-voipac-dmm-668: Fix memory node duplication
      ARM: dts: imx6dl-mamoj: Add a memory node
      ARM: dts: imx6qdl-sabresd: Move regulators outside of "simple-bus"
      ARM: dts: imx6qdl-sabresd: Use GPIO_ACTIVE_HIGH for regulators

Frieder Schrempf (1):
      ARM: dts: imx: Add dummy PHYs for HSIC-only USB controllers

Hou Zhiqiang (3):
      dt-bindings: pci: layerscape-pci: add compatible strings "fsl,ls1043a-pcie"
      dt-bindings: pci: layerscape-pci: removed compatible string "snps,dw-pcie"
      ARM: dts: ls1021a: removed compatible string "snps,dw-pcie"

Ian Ray (1):
      ARM: dts: imx6q-bx50v3: user-space watchdog GPIO configuration

Jan Tuerk (3):
      ARM: dts: imx: Add an cpu0 label for imx6dl devices
      dt-bindings: arm: Document emtrion emCON-MX6 bindings
      ARM: dts: Add support for emtrion emCON-MX6 series

Joakim Zhang (1):
      ARM: dts: imx6qdl-sabreauto: Remove reg property from fixed regulator

Jonathan Marek (1):
      ARM: dts: imx5: add gpu nodes

Leonard Crestez (3):
      ARM: dts: imx6ull: Add dcp node
      ARM: dts: imx6qdl-sabreauto: Enable pcie
      ARM: dts: imx6ul: Remove extra space between node name and brace

Lucas Stach (2):
      ARM: dts: imx6: RDU2: fix eGalax touchscreen node
      ARM: dts: imx6: add thermal sensor and cooling cells

Lukasz Majewski (1):
      ARM: dts: Add support for Liebherr's BK4 device (vf610 based)

Marco Franchi (1):
      ARM: dts: imx6qdl: Fix memory node duplication

Markus Kueffner (1):
      ARM: dts: imx6qdl-udoo: Add Pincfgs for UART4

Martin Kaiser (1):
      ARM: dts: i.MX25: add the clocks for the EPIT blocks

Patrick Havelange (1):
      ARM: dts: ls1021a: add nodes for PWMs

Peng Ma (1):
      ARM: dts: ls1021a: add qdma device tree nodes

Shyam Saini (1):
      ARM: dts: imx6qdl-icore: Add missing stdout-path property

Viresh Kumar (1):
      ARM: dts: ls1021a: Add all CPUs in cooling maps

Xiaowei Bao (1):
      ARM: dts: ls1021a: Add the status property disable PCIe

 Documentation/devicetree/bindings/arm/emtrion.txt  |  12 +
 .../devicetree/bindings/pci/layerscape-pci.txt     |   7 +-
 arch/arm/boot/dts/Makefile                         |   6 +
 arch/arm/boot/dts/imx1-ads.dts                     |   1 +
 arch/arm/boot/dts/imx1-apf9328.dts                 |   1 +
 arch/arm/boot/dts/imx1.dtsi                        |   2 -
 arch/arm/boot/dts/imx23-evk.dts                    |   1 +
 arch/arm/boot/dts/imx23-olinuxino.dts              |   1 +
 arch/arm/boot/dts/imx23-sansa.dts                  |   1 +
 arch/arm/boot/dts/imx23-stmp378x_devb.dts          |   1 +
 arch/arm/boot/dts/imx23-xfi3.dts                   |   1 +
 arch/arm/boot/dts/imx23.dtsi                       |   2 -
 arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi       |   1 +
 arch/arm/boot/dts/imx25-karo-tx25.dts              |   1 +
 arch/arm/boot/dts/imx25-pdk.dts                    |   1 +
 arch/arm/boot/dts/imx25.dtsi                       |   6 +-
 arch/arm/boot/dts/imx27-apf27.dts                  |   1 +
 arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi       |   1 +
 arch/arm/boot/dts/imx27-pdk.dts                    |   1 +
 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi  |   1 +
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi    |   1 +
 arch/arm/boot/dts/imx27.dtsi                       |   2 -
 arch/arm/boot/dts/imx28-apf28.dts                  |   1 +
 arch/arm/boot/dts/imx28-apx4devkit.dts             |   1 +
 arch/arm/boot/dts/imx28-cfa10036.dts               |   1 +
 arch/arm/boot/dts/imx28-duckbill-2-485.dts         |   1 +
 arch/arm/boot/dts/imx28-duckbill-2-enocean.dts     |   1 +
 arch/arm/boot/dts/imx28-duckbill-2-spi.dts         |   1 +
 arch/arm/boot/dts/imx28-duckbill-2.dts             |   1 +
 arch/arm/boot/dts/imx28-duckbill.dts               |   1 +
 arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts       |   1 +
 arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts       |   1 +
 arch/arm/boot/dts/imx28-evk.dts                    |   1 +
 arch/arm/boot/dts/imx28-m28.dtsi                   |   1 +
 arch/arm/boot/dts/imx28-m28cu3.dts                 |   1 +
 arch/arm/boot/dts/imx28-m28evk.dts                 |   1 +
 arch/arm/boot/dts/imx28-sps1.dts                   |   1 +
 arch/arm/boot/dts/imx28-ts4600.dts                 |   1 +
 arch/arm/boot/dts/imx28-tx28.dts                   |   1 +
 arch/arm/boot/dts/imx28.dtsi                       |   2 -
 arch/arm/boot/dts/imx31-bug.dts                    |   1 +
 arch/arm/boot/dts/imx31-lite.dts                   |   1 +
 arch/arm/boot/dts/imx31.dtsi                       |   2 -
 arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi       |   1 +
 arch/arm/boot/dts/imx35-pdk.dts                    |   1 +
 arch/arm/boot/dts/imx35.dtsi                       |   2 -
 arch/arm/boot/dts/imx50-evk.dts                    |   1 +
 arch/arm/boot/dts/imx50.dtsi                       |  19 +-
 arch/arm/boot/dts/imx51-apf51.dts                  |   1 +
 arch/arm/boot/dts/imx51-babbage.dts                |   1 +
 arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi  |   1 +
 arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi       |   1 +
 arch/arm/boot/dts/imx51-ts4800.dts                 |   1 +
 arch/arm/boot/dts/imx51-zii-rdu1.dts               |  18 +-
 arch/arm/boot/dts/imx51-zii-scu2-mezz.dts          |   1 +
 arch/arm/boot/dts/imx51-zii-scu3-esb.dts           |   1 +
 arch/arm/boot/dts/imx51.dtsi                       |  12 +-
 arch/arm/boot/dts/imx53-ard.dts                    |   1 +
 arch/arm/boot/dts/imx53-cx9020.dts                 |   1 +
 arch/arm/boot/dts/imx53-m53.dtsi                   |   1 +
 arch/arm/boot/dts/imx53-qsb-common.dtsi            |   1 +
 arch/arm/boot/dts/imx53-smd.dts                    |   1 +
 arch/arm/boot/dts/imx53-tqma53.dtsi                |   1 +
 arch/arm/boot/dts/imx53-tx53.dtsi                  |   1 +
 arch/arm/boot/dts/imx53-usbarmory.dts              |   1 +
 arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi        |   8 +-
 arch/arm/boot/dts/imx53.dtsi                       |  27 +-
 arch/arm/boot/dts/imx6dl-apf6dev.dts               |   1 +
 arch/arm/boot/dts/imx6dl-aristainetos2_4.dts       |   1 +
 arch/arm/boot/dts/imx6dl-aristainetos2_7.dts       |   1 +
 arch/arm/boot/dts/imx6dl-aristainetos_4.dts        |   1 +
 arch/arm/boot/dts/imx6dl-aristainetos_7.dts        |   1 +
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts       |   1 +
 arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dts         |   1 +
 arch/arm/boot/dts/imx6dl-emcon-avari.dts           |  14 +
 arch/arm/boot/dts/imx6dl-mamoj.dts                 |   6 +
 arch/arm/boot/dts/imx6dl-phytec-pfla02.dtsi        |   1 +
 arch/arm/boot/dts/imx6dl-rex-basic.dts             |   1 +
 arch/arm/boot/dts/imx6dl-riotboard.dts             |   1 +
 arch/arm/boot/dts/imx6dl-ts4900.dts                |   1 +
 arch/arm/boot/dts/imx6dl-ts7970.dts                |   1 +
 arch/arm/boot/dts/imx6dl-wandboard-revb1.dts       |   1 +
 arch/arm/boot/dts/imx6dl-wandboard-revd1.dts       |   1 +
 arch/arm/boot/dts/imx6dl-wandboard.dts             |   1 +
 arch/arm/boot/dts/imx6dl.dtsi                      |   2 +-
 arch/arm/boot/dts/imx6q-apf6dev.dts                |   1 +
 arch/arm/boot/dts/imx6q-arm2.dts                   |   1 +
 arch/arm/boot/dts/imx6q-b450v3.dts                 |   7 -
 arch/arm/boot/dts/imx6q-b650v3.dts                 |   7 -
 arch/arm/boot/dts/imx6q-b850v3.dts                 |  16 +
 arch/arm/boot/dts/imx6q-ba16.dtsi                  |   1 +
 arch/arm/boot/dts/imx6q-bx50v3.dtsi                |  14 -
 arch/arm/boot/dts/imx6q-cm-fx6.dts                 |   1 +
 arch/arm/boot/dts/imx6q-dfi-fs700-m60.dts          |   1 +
 arch/arm/boot/dts/imx6q-dhcom-som.dtsi             |   1 +
 arch/arm/boot/dts/imx6q-display5.dtsi              |   1 +
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts            |   1 +
 arch/arm/boot/dts/imx6q-emcon-avari.dts            |  14 +
 arch/arm/boot/dts/imx6q-evi.dts                    |   1 +
 arch/arm/boot/dts/imx6q-gk802.dts                  |   1 +
 arch/arm/boot/dts/imx6q-gw5400-a.dts               |   1 +
 arch/arm/boot/dts/imx6q-h100.dts                   |   1 +
 arch/arm/boot/dts/imx6q-kp-tpc.dts                 |   1 +
 arch/arm/boot/dts/imx6q-marsboard.dts              |   1 +
 arch/arm/boot/dts/imx6q-mccmon6.dts                |   1 +
 arch/arm/boot/dts/imx6q-novena.dts                 |   1 +
 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi         |   1 +
 arch/arm/boot/dts/imx6q-pistachio.dts              |   1 +
 arch/arm/boot/dts/imx6q-rex-pro.dts                |   1 +
 arch/arm/boot/dts/imx6q-sbc6x.dts                  |   1 +
 arch/arm/boot/dts/imx6q-tbs2910.dts                |   1 +
 arch/arm/boot/dts/imx6q-ts4900.dts                 |   1 +
 arch/arm/boot/dts/imx6q-ts7970.dts                 |   1 +
 arch/arm/boot/dts/imx6q-wandboard-revb1.dts        |   1 +
 arch/arm/boot/dts/imx6q-wandboard-revd1.dts        |   1 +
 arch/arm/boot/dts/imx6q-wandboard.dts              |   1 +
 arch/arm/boot/dts/imx6q-zii-rdu2.dts               |   1 +
 arch/arm/boot/dts/imx6q.dtsi                       |   1 +
 arch/arm/boot/dts/imx6qdl-apalis.dtsi              |   1 +
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi             |   1 +
 arch/arm/boot/dts/imx6qdl-emcon-avari.dtsi         | 177 +++++
 arch/arm/boot/dts/imx6qdl-emcon.dtsi               | 833 ++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi              |   1 +
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              |   1 +
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              |   1 +
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              |   1 +
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi              |   1 +
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi              |   1 +
 arch/arm/boot/dts/imx6qdl-gw553x.dtsi              |   1 +
 arch/arm/boot/dts/imx6qdl-gw560x.dtsi              |   1 +
 arch/arm/boot/dts/imx6qdl-gw5903.dtsi              |   1 +
 arch/arm/boot/dts/imx6qdl-gw5904.dtsi              |   1 +
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi        |   1 +
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi       |   1 +
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi           |   1 +
 arch/arm/boot/dts/imx6qdl-icore.dtsi               |   5 +
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi           |   1 +
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi       |   1 +
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi      |   1 +
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |   1 +
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi       |   1 +
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           | 105 ++-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           |   1 +
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             | 162 ++--
 arch/arm/boot/dts/imx6qdl-tx6.dtsi                 |   1 +
 arch/arm/boot/dts/imx6qdl-udoo.dtsi                |  14 +
 arch/arm/boot/dts/imx6qdl-var-dart.dtsi            |   1 +
 arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi     |  15 +-
 arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi     |  15 +-
 arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi     |  15 +-
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi            |   5 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |  22 +-
 arch/arm/boot/dts/imx6qp-wandboard-revd1.dts       |   1 +
 arch/arm/boot/dts/imx6qp-zii-rdu2.dts              |   1 +
 arch/arm/boot/dts/imx6sl-evk.dts                   |   1 +
 arch/arm/boot/dts/imx6sl-warp.dts                  |   1 +
 arch/arm/boot/dts/imx6sl.dtsi                      |  11 +-
 arch/arm/boot/dts/imx6sll-evk.dts                  |  31 +
 arch/arm/boot/dts/imx6sll.dtsi                     |   2 +-
 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts           |   1 +
 arch/arm/boot/dts/imx6sx-sabreauto.dts             |  58 ++
 arch/arm/boot/dts/imx6sx-sdb-reva.dts              |  22 +-
 arch/arm/boot/dts/imx6sx-sdb-sai.dts               |  43 +-
 arch/arm/boot/dts/imx6sx-sdb.dts                   |  15 +-
 arch/arm/boot/dts/imx6sx-sdb.dtsi                  |  53 +-
 arch/arm/boot/dts/imx6sx-softing-vining-2000.dts   |   1 +
 arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts        |   1 +
 arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts     |   1 +
 arch/arm/boot/dts/imx6sx-udoo-neo-full.dts         |   1 +
 arch/arm/boot/dts/imx6sx.dtsi                      |  25 +-
 arch/arm/boot/dts/imx6ul-14x14-evk.dtsi            |  64 +-
 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts        |  37 +
 arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi          |  77 +-
 arch/arm/boot/dts/imx6ul-geam.dts                  |   1 +
 arch/arm/boot/dts/imx6ul-isiot.dtsi                |   1 +
 arch/arm/boot/dts/imx6ul-litesom.dtsi              |   1 +
 arch/arm/boot/dts/imx6ul-opos6ul.dtsi              |   1 +
 arch/arm/boot/dts/imx6ul-pico-hobbit.dts           | 534 +------------
 arch/arm/boot/dts/imx6ul-pico-pi.dts               |  97 +++
 arch/arm/boot/dts/imx6ul-pico.dtsi                 | 461 +++++++++++
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi                |   1 +
 arch/arm/boot/dts/imx6ul.dtsi                      |  17 +-
 arch/arm/boot/dts/imx6ull-14x14-evk.dts            |  43 +-
 arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi     |   1 +
 arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi        |   1 +
 arch/arm/boot/dts/imx6ull.dtsi                     |  10 +
 arch/arm/boot/dts/imx6ulz-14x14-evk.dts            |   2 +
 arch/arm/boot/dts/imx6ulz.dtsi                     |   2 -
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts            |   3 +-
 arch/arm/boot/dts/imx7d-colibri-emmc.dtsi          |   1 +
 arch/arm/boot/dts/imx7d-colibri.dtsi               |   1 +
 arch/arm/boot/dts/imx7d-nitrogen7.dts              |   1 +
 arch/arm/boot/dts/imx7d-pico.dtsi                  |   1 +
 arch/arm/boot/dts/imx7d-sdb-reva.dts               |  40 +
 arch/arm/boot/dts/imx7d-sdb.dts                    |  29 +-
 arch/arm/boot/dts/imx7d.dtsi                       |  21 +
 arch/arm/boot/dts/imx7s-colibri.dtsi               |   1 +
 arch/arm/boot/dts/imx7s-warp.dts                   |   1 +
 arch/arm/boot/dts/imx7s.dtsi                       |  14 +-
 arch/arm/boot/dts/ls1021a.dtsi                     | 124 ++-
 arch/arm/boot/dts/vf500-colibri.dtsi               |   1 +
 arch/arm/boot/dts/vf500.dtsi                       |   1 -
 arch/arm/boot/dts/vf610-bk4.dts                    | 502 ++++++++++++
 arch/arm/boot/dts/vf610-colibri.dtsi               |   1 +
 arch/arm/boot/dts/vf610-cosmic.dts                 |   1 +
 arch/arm/boot/dts/vf610-twr.dts                    |   1 +
 arch/arm/boot/dts/vf610-zii-cfu1.dts               |   1 +
 arch/arm/boot/dts/vf610-zii-dev.dtsi               |   1 +
 arch/arm/boot/dts/vf610-zii-scu4-aib.dts           | 851 +++++++++++++++++++++
 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts          |   1 +
 arch/arm/boot/dts/vf610m4-colibri.dts              |   1 +
 arch/arm/boot/dts/vf610m4.dtsi                     |   1 -
 212 files changed, 4076 insertions(+), 837 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/emtrion.txt
 create mode 100644 arch/arm/boot/dts/imx6dl-emcon-avari.dts
 create mode 100644 arch/arm/boot/dts/imx6q-emcon-avari.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-emcon-avari.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-emcon.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-pico-pi.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-pico.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-sdb-reva.dts
 create mode 100644 arch/arm/boot/dts/vf610-bk4.dts
 create mode 100644 arch/arm/boot/dts/vf610-zii-scu4-aib.dts

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
