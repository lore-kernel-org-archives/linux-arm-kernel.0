Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD4CC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:47:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EE042175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EQQglBqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE042175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=HGw+tDxU4UeYfoNAEE8hfqBVM4HbnU9hv6UUBzFJk0c=; b=EQQglBqM5YzYoK
	IFX81vvuZJVfuCSmOIsrAC5nL9LHV6FmJthhalKmF9CNsRhdYz/dfNaawuAasNskgTyH/UdzWWvXI
	oC4SKUjIARHDhd92BtqTwfdy3nPrs4XIJ2IiNll8cT++JHXgBDSqeNdLQaqFgsHA2JtykOEHBmspN
	Pr5Q2rjRfYXCagmKXumwu4M5AQ9VWF/Jih384GLtuc0M05pU6UC0qmRFd0Bgu/f441LutuFgC1hOY
	+4c3+9moIPeUrRdmxyeD++IulEweu1P8paHpVs257zxyOGVtC0xR5V6/spSw+Gg2ko0PqqlPmHYJl
	nlO8fxSPZHRwVxv0f8+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grdSa-0006yX-1D; Thu, 07 Feb 2019 06:46:56 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grdRS-0005tA-2e
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 06:45:49 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 96D3D5FA80; Thu,  7 Feb 2019 14:45:39 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>
Subject: [RFT PATCH 0/9] ARM: sun8i: a83t: Enable USB OTG
Date: Thu,  7 Feb 2019 14:45:26 +0800
Message-Id: <20190207064535.9226-1-wens@csie.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_224546_400994_38312F66 
X-CRM114-Status: GOOD (  16.48  )
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
Cc: devicetree@vger.kernel.org, Quentin Schulz <quentin.schulz@bootlin.com>,
 linux-pm@vger.kernel.org, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi everyone,

This series enables USB OTG on the A83T boards. The AXP813/AXP818 PMICs
used with the A83T have the same behavior as the AXP221 and AXP223,
where if the N_VBUSEN pin is driven high, the VBUS sensing interrupts
stop working. In the past Hans made a polling workaround in the USB PHY
driver. In this series polling is added to the power supply driver.

The power supply driver work was started by Quentin, and shared with me
when I expressed interest in getting USB OTG to work some time ago.
Neither of us got around to finishing it, until now that is.

Patch 1 adds a new compatible string for the AXP813 VBUS power supply
part.

Patch 2 is a bit of cleanup work for the driver.

Patch 3 allows disabling VBUS input current limiting on the AXP20x /
AXP22x PMICs. While not strictly related to this series, I found it
easier to just send everything together. This patch depends on the
previous one.

Patch 4 adds the VBUS status polling feature. This is enabled on AXP221
and all later PMICs.

Patch 5 factors out code to read out the configured input current limit
for the AXP20x and AXP22x PMICs. As the AXP813 uses different values,
factoring out the code based on model will make the main function more
readable.

Patch 6 adds support for the AXP813 VBUS power supply. checkpatch.pl
reports a few warnings for this patch:

    WARNING: Possible switch case/default not preceded by break or
    fallthrough comment
    #100: FILE: drivers/power/supply/axp20x_usb_power.c:306:
    +       case 1500000:

    WARNING: Possible switch case/default not preceded by break or
    fallthrough comment
    #101: FILE: drivers/power/supply/axp20x_usb_power.c:307:
    +       case 2000000:

    WARNING: Possible switch case/default not preceded by break or
    fallthrough comment
    #102: FILE: drivers/power/supply/axp20x_usb_power.c:308:
    +       case 2500000:

However they seem to be a false positive. The preceding line of the
reported lines is a return statement, which is definitely not a
fallthrough.

Patch 7 adds an mfd cell for the newly supported VBUS power supply.

Patch 8 adds a device node for the VBUS power supply to the common
axp81x dtsi file.

Patch 9 enables USB OTG on the Cubietruck Plus and Bananapi M3.

Please have a look, and also test it on boards you have, and don't
limit it to just the A83T ones. As mentioned above, the polling feature
affects all boards that have an AXP221 or newer PMIC.

I haven't removed the polling workaround from the USB PHY driver yet.
That would be the next step after this series is merged, and preferrably
a release has passed.


Regards
ChenYu


Chen-Yu Tsai (5):
  dt-bindings: power: supply: axp20x_usb_power: add axp813 compatible
  power: supply: axp20x_usb_power: Fix typo in VBUS current limit macros
  power: supply: axp20x_usb_power: allow disabling input current
    limiting
  power: supply: axp20x_usb_power: use polling to detect vbus status
    change
  ARM: dts: sun8i: a83t: Enable USB OTG controller on some boards

Quentin Schulz (4):
  power: supply: axp20x_usb_power: add function to get max current
  power: supply: axp20x_usb_power: add support for AXP813
  mfd: axp20x: add USB power supply mfd cell to AXP813
  ARM: dtsi: axp81x: add USB power supply node

 .../power/supply/axp20x_usb_power.txt         |   1 +
 arch/arm/boot/dts/axp81x.dtsi                 |   4 +
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts  |  12 ++
 .../boot/dts/sun8i-a83t-cubietruck-plus.dts   |  12 ++
 drivers/mfd/axp20x.c                          |  11 ++
 drivers/power/supply/axp20x_usb_power.c       | 184 +++++++++++++++---
 6 files changed, 197 insertions(+), 27 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
