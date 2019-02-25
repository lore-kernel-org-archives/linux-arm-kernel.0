Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52EEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 03:32:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 927B32087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 03:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AGsM6RO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927B32087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=2HivrA0xHME02xsUjJpS+LFXlEriPY+HXqBANN1Etww=; b=AGsM6RO9/YmXGE
	Hv01zYjreEdjFKBH4cCZtzBFLFyx+4f+HW7Yp3VmsWFkK5pmReZRvrnrSMXWWQLWuLvpvfwfkG8+j
	v92oBOOWeVBk5k2iCUCSpLiGlz0dmqV1+JcfZFUH3YziqW7ViAy+GnajMPfhWYxFOKZ+bRQzv7NR6
	9WGBJ0hI8s2qKf5njJ2KALdBWX/Vr2gjGnntDQrYsG5+TK/sFS+bBGOhMORqa6dWdpFj0mk08czN/
	Ida84kJQbFCGc2yzaFIXe36tmMxhg7DlNdSkmjuVH2iuyYixy6mLGr0erKYdaIrY7K63r1WIJTrHW
	MbrpGtMepp4qGkDwErcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gy6zu-0008Kc-FY; Mon, 25 Feb 2019 03:32:06 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gy6zD-0007aj-8F
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 03:31:26 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 2A2FE5FCC3; Mon, 25 Feb 2019 11:31:16 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v2 0/9] ARM: sun8i: a83t: Enable USB OTG
Date: Mon, 25 Feb 2019 11:30:58 +0800
Message-Id: <20190225033107.17326-1-wens@csie.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_193123_548556_30EE85BE 
X-CRM114-Status: GOOD (  19.43  )
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

This is v2 of my A83T USB power supply / OTG series. Changes since v1:

  - Added Lee's ack for mfd patch
  - Make axp803_usb_power_supply_resources[] const

This series has since been tested. Both host mode and gadget mode work
well. However this SoC seems to have a glitch in hardware. After host
mode is used by plugging in a host mode cable, the hardware will not
revert back to gadget mode if a standard USB cable is plugged in. Host
mode continues to work however. This will likely have to be addressed
with some workaround in either the musb driver or our USB PHY driver.

The patches have no cross-tree dependencies, so each part can go through
their respective trees (power-supply / mfd / arm-soc).

I also have some follow-up patches to enable the USB power supply on
AXP803 / A64. It's the boiler-plate mfd cell and device node addition.

Original cover letter follows:

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
