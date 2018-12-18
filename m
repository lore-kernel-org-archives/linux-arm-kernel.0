Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB36C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:50:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73388218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZY3uyMgs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73388218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/9Xd3hqsSUrTsYM9//O7FP7UKUzcalSYgnrdEg2SqfM=; b=ZY3uyMgsRVt9WT
	kH0Q+LDHtFuEYVZaTmk0Ediq4aXvn+IBHzQRtLDfZaKUrfTlEx3Qk2eVYw+Isd8SObGE2cR9Fql2E
	dDm+tIYIPr+M0Lazef+l/r5IvQCR6rt+N4RMzteQoiLoVG8IKsEXK7XYPSl4u4K1npmTdU2z+znaR
	gemXA5JWQcvNpyTbX+Bow2NxMj0proh+pTALxs/7+gFKrGj5++CMTKh50HqIyNzaKBd+m8vaAtZHu
	539u/a5JjtetTLvO3i4LrKyKHD9s/CoYoZ0YOCDH4T0DB76mAjpd2D7otjK7oL9D+OWoCzhoRb8pa
	qjC+LArwsVcbAROPqZdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZP8E-0007Wc-3z; Tue, 18 Dec 2018 23:50:34 +0000
Received: from coyote.holtmann.net ([212.227.132.17] helo=mail.holtmann.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZP89-0007Up-GG
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 23:50:32 +0000
Received: from marcel-macpro.fritz.box (p4FF9F1DE.dip0.t-ipconnect.de
 [79.249.241.222])
 by mail.holtmann.org (Postfix) with ESMTPSA id 003B4CEE81;
 Wed, 19 Dec 2018 00:57:52 +0100 (CET)
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v3 00/15] ARM: sunxi: Enable Broadcom-based Bluetooth
 controllers
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181217040449.31437-1-wens@csie.org>
Date: Wed, 19 Dec 2018 00:50:13 +0100
Message-Id: <ADDC30F6-9C86-4D59-A28E-A3007C9D478D@holtmann.org>
References: <20181217040449.31437-1-wens@csie.org>
To: Chen-Yu Tsai <wens@csie.org>
X-Mailer: Apple Mail (2.3445.102.3)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_155029_697074_B98AA479 
X-CRM114-Status: GOOD (  26.47  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Loic Poulain <loic.poulain@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Chen-Yu,

> This is v3 of my Broadcom-based Bluetooth controllers on Allwinner SoC-
> based SBCs series. v2 was sent on 11/15, with a follow up ping on 11/28.
> No response from either Bluetooth maintainer. Would the maintainers
> acknowledge or provide feedback so we can move forward? WiFi for the
> Broadcom chips has been supported and enabled for many years. Bluetooth
> on the other hand has required userspace trickery to get it working.
> With serdev support, this now requires minimal interaction from
> users to get working.
> 
> 
> Changes since v2:
> 
>  - Collected tags from Ondrej for applicable patches
> 
> Changes since v1:
> 
>  - Collected tags
>  - Re-organize dt binding clocks and clock-names properties
>  - Simplify check for deferred probe when getting clocks
>  - Add explanation of Cubietruck's clk_out_a pinmux setting placement
>    to commit message.
>  - Add missing "uart-has-rtscts" property to Cubietruck device tree
> 
> Original cover letter follows.
> 
> 
> On many Allwinner SBCs / developer boards, there is a WiFi+BT combo
> module from AMPAK. Inside is either one or two Broadcom chips, depending
> on the model. This series enables the Bluetooth controllers for AMPAK
> AP6210, AP6212, and AP6330 found on several boards. More will come later
> as other SoCs require changes to some other parts. I did not cover the
> SCO PCM connections from the controller to the SoC's I2S interface. It
> seems no one is actually doing this, so I was not sure how to proceed.
> Any suggestions?
> 
> I deliberately left out the netdev mailing list and Dave Miller, as the
> only thing that is under net is the binding document. Maybe we should
> move that out of Documentation/devicetree/bindings/net/ ?
> 
> Also, I'm not subscribed to the linux-bluetooth ML, so please CC me for
> any discussions.
> 
> Patches 1 through 4 are device tree binding changes:
> 
> 1 - Make the external clock name unambiguous, and add a second entry for
>    the LPO clock.
> 
> 2 - Add regulator supply properties for the VBAT and VDDIO power pins.
> 
> 3 - Add a compatible string for BCM20702A1.
> 
> 4 - Add a compatible string for BCM4330.
> 
> Patches 5 through 13 are changes to the driver, either improvements,
> or updates to handle the updated device tree binding.
> 
> 5 - Make the driver handle deferred probing for the external clock.
> 
> 6 - Simplify clock error checking for subsequent clk API calls.
> 
> 7 - Handle clock-names for the main external clock.
> 
> 8 - Support a new external clock, the LPO.
> 
> 9 - Support regulator supplies.
> 
> 10 - Wait a small amount of time after toggling the GPIO for the device
>     to settle.
> 
> 11 - Add support for BCM20702A1, including its default address.
> 
> 12 - Add BCM4330 compatible string to the driver.
> 
> 13 - Handle default address for BCM43430A0.
> 
> 14 - Enable Broadcom-based serdev Bluetooth for multiple Allwinner ARMv7
>     boards.
> 
> 15 - Enable Broadcom-based serdev Bluetooth for the Bananapi M64.
> 
> checkpatch reports an error for both patch 11 and patch 13:
> 
>    ERROR: space required after that close brace '}'
> 
> I followed the existing code's style. If this is undesirable, I can send
> a follow-up patch fixing the entire code block.
> 
> The first 13 patches should go through the Bluetooth tree, while we, the
> sunxi maintainers, will take the last 2.
> 
> 
> Thanks
> ChenYu
> 
> Chen-Yu Tsai (14):
>  dt-bindings: net: broadcom-bluetooth: Fix external clock names
>  dt-bindings: net: broadcom-bluetooth: Add VBAT and VDDIO supplies
>  dt-bindings: net: broadcom-bluetooth: Add BCM20702A1 compatible string
>  dt-bindings: net: broadcom-bluetooth: Add BCM4330 compatible string
>  Bluetooth: hci_bcm: Handle deferred probing for the clock supply
>  Bluetooth: hci_bcm: Simplify clk_get error handling
>  Bluetooth: hci_bcm: Use "txco" and "extclk" to get clock reference
>  Bluetooth: hci_bcm: Add support for LPO clock
>  Bluetooth: hci_bcm: Add support for regulator supplies
>  Bluetooth: hci_bcm: Wait for device to come out of reset after power
>    on
>  Bluetooth: hci_bcm: Add compatible string for BCM4330
>  Bluetooth: btbcm: Add default address for BCM43430A0
>  ARM: dts: sunxi: Enable Broadcom-based Bluetooth for multiple boards
>  arm64: dts: allwinner: a64: bananapi-m64: Add Bluetooth device node
> 
> Maxime Ripard (1):
>  Bluetooth: hci_bcm: Add BCM20702A1 variant
> 
> .../bindings/net/broadcom-bluetooth.txt       |  11 +-
> arch/arm/boot/dts/sun7i-a20-cubietruck.dts    |  25 ++++
> arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts  |  18 +++
> .../boot/dts/sun8i-a83t-cubietruck-plus.dts   |  18 +++
> arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts  |  14 +++
> .../dts/allwinner/sun50i-a64-bananapi-m64.dts |  14 +++
> drivers/bluetooth/btbcm.c                     |  13 +-
> drivers/bluetooth/hci_bcm.c                   | 112 +++++++++++++++---
> 8 files changed, 208 insertions(+), 17 deletions(-)

patches 1-13 have been applied to bluetooth-next tree.

Regards

Marcel


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
