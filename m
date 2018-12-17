Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C33C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:06:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7AD2217FB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="todE/lpj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7AD2217FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=VlGX8guI3sUVaAK+u69bLYwhMJ3Ujk33HXfQ4zmQMWM=; b=todE/lpjAb2Jxx
	vOmCaRuq5KLP3DqLQQ+lPCnhv/6nLBhqGTdFYdb4akjCarG6bZFfMaqS/oNdITX3rshReOW7w5f0n
	KP4rUsFgNPQRR97GCnu8U+vr+PnnWrNJE2jB6h9uzHu4g7eWBj5/btV/caG2BddHR82jdTKiXHnL+
	Tysbo2+Mz4GMnjfeqmGN9KhZ35bsFgg6Gq5xKqjecBilslj0LhlsEomsmV2lF19wJyveyGTQOFJMv
	+EFi+zH5jIQC4b9dUT24+fI33zhFxxaa7TsfBjvJ1TYtJMtGshLz+0/BaRfBfs3pjYBhR+OhzGWZ9
	Owv7qHAktz00g8QRo8wA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYkAO-0000pN-GS; Mon, 17 Dec 2018 04:06:04 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYk9g-0007js-8H
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 04:05:27 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 3B1025FBF3; Mon, 17 Dec 2018 12:05:03 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v3 00/15] ARM: sunxi: Enable Broadcom-based Bluetooth
 controllers
Date: Mon, 17 Dec 2018 12:04:34 +0800
Message-Id: <20181217040449.31437-1-wens@csie.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_200521_581219_726C0BBB 
X-CRM114-Status: GOOD (  19.76  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 Loic Poulain <loic.poulain@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi everyone,

This is v3 of my Broadcom-based Bluetooth controllers on Allwinner SoC-
based SBCs series. v2 was sent on 11/15, with a follow up ping on 11/28.
No response from either Bluetooth maintainer. Would the maintainers
acknowledge or provide feedback so we can move forward? WiFi for the
Broadcom chips has been supported and enabled for many years. Bluetooth
on the other hand has required userspace trickery to get it working.
With serdev support, this now requires minimal interaction from
users to get working.


Changes since v2:

  - Collected tags from Ondrej for applicable patches

Changes since v1:

  - Collected tags
  - Re-organize dt binding clocks and clock-names properties
  - Simplify check for deferred probe when getting clocks
  - Add explanation of Cubietruck's clk_out_a pinmux setting placement
    to commit message.
  - Add missing "uart-has-rtscts" property to Cubietruck device tree

Original cover letter follows.


On many Allwinner SBCs / developer boards, there is a WiFi+BT combo
module from AMPAK. Inside is either one or two Broadcom chips, depending
on the model. This series enables the Bluetooth controllers for AMPAK
AP6210, AP6212, and AP6330 found on several boards. More will come later
as other SoCs require changes to some other parts. I did not cover the
SCO PCM connections from the controller to the SoC's I2S interface. It
seems no one is actually doing this, so I was not sure how to proceed.
Any suggestions?

I deliberately left out the netdev mailing list and Dave Miller, as the
only thing that is under net is the binding document. Maybe we should
move that out of Documentation/devicetree/bindings/net/ ?

Also, I'm not subscribed to the linux-bluetooth ML, so please CC me for
any discussions.

Patches 1 through 4 are device tree binding changes:

1 - Make the external clock name unambiguous, and add a second entry for
    the LPO clock.

2 - Add regulator supply properties for the VBAT and VDDIO power pins.

3 - Add a compatible string for BCM20702A1.

4 - Add a compatible string for BCM4330.

Patches 5 through 13 are changes to the driver, either improvements,
or updates to handle the updated device tree binding.

5 - Make the driver handle deferred probing for the external clock.

6 - Simplify clock error checking for subsequent clk API calls.

7 - Handle clock-names for the main external clock.

8 - Support a new external clock, the LPO.

9 - Support regulator supplies.

10 - Wait a small amount of time after toggling the GPIO for the device
     to settle.

11 - Add support for BCM20702A1, including its default address.

12 - Add BCM4330 compatible string to the driver.

13 - Handle default address for BCM43430A0.

14 - Enable Broadcom-based serdev Bluetooth for multiple Allwinner ARMv7
     boards.

15 - Enable Broadcom-based serdev Bluetooth for the Bananapi M64.

checkpatch reports an error for both patch 11 and patch 13:

    ERROR: space required after that close brace '}'

I followed the existing code's style. If this is undesirable, I can send
a follow-up patch fixing the entire code block.

The first 13 patches should go through the Bluetooth tree, while we, the
sunxi maintainers, will take the last 2.


Thanks
ChenYu

Chen-Yu Tsai (14):
  dt-bindings: net: broadcom-bluetooth: Fix external clock names
  dt-bindings: net: broadcom-bluetooth: Add VBAT and VDDIO supplies
  dt-bindings: net: broadcom-bluetooth: Add BCM20702A1 compatible string
  dt-bindings: net: broadcom-bluetooth: Add BCM4330 compatible string
  Bluetooth: hci_bcm: Handle deferred probing for the clock supply
  Bluetooth: hci_bcm: Simplify clk_get error handling
  Bluetooth: hci_bcm: Use "txco" and "extclk" to get clock reference
  Bluetooth: hci_bcm: Add support for LPO clock
  Bluetooth: hci_bcm: Add support for regulator supplies
  Bluetooth: hci_bcm: Wait for device to come out of reset after power
    on
  Bluetooth: hci_bcm: Add compatible string for BCM4330
  Bluetooth: btbcm: Add default address for BCM43430A0
  ARM: dts: sunxi: Enable Broadcom-based Bluetooth for multiple boards
  arm64: dts: allwinner: a64: bananapi-m64: Add Bluetooth device node

Maxime Ripard (1):
  Bluetooth: hci_bcm: Add BCM20702A1 variant

 .../bindings/net/broadcom-bluetooth.txt       |  11 +-
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts    |  25 ++++
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts  |  18 +++
 .../boot/dts/sun8i-a83t-cubietruck-plus.dts   |  18 +++
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts  |  14 +++
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts |  14 +++
 drivers/bluetooth/btbcm.c                     |  13 +-
 drivers/bluetooth/hci_bcm.c                   | 112 +++++++++++++++---
 8 files changed, 208 insertions(+), 17 deletions(-)

-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
