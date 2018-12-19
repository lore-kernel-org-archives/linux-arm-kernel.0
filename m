Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD92DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:54:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E26021873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TAOvPpYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E26021873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BfCRN/DbKOI9Xsyk3Ljp8oYrcofgD5LCJ9TV/PsKR2s=; b=TAOvPpYlrNGlHG
	sNU6J3KQ/Mpcbrs1m/16mO3MAts4AJzTTbIS54RtdiSULyhUBIIzSO/CZD6EWd9lWe13f3M2tlyYF
	aTH3BzPLb7OWrw5Gj5KtjnP3QFLfon68vJ4abH91loa5GjIKq17HyK3tTOs2uScRHeo+rAzLOgmXO
	BWVy+t48qBsHcUWEkO+eeOClu+s8M/xxtDszRNqtWc4iFSRhGurdSFEOlhiYAecQxqDYXmy8tl7mK
	vpfjNpByYham5saLFngLjMUF33KGzAm36R2OecZeiKvMxeIeZR9O50JBiAeMMVBhcBsLV27SDZkjz
	fa2SIlY5LOjKw0B2pvMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZYYs-0000ZM-4H; Wed, 19 Dec 2018 09:54:42 +0000
Received: from mail-ed1-f68.google.com ([209.85.208.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZYYo-0000Vp-1a
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 09:54:40 +0000
Received: by mail-ed1-f68.google.com with SMTP id g22so10370876edr.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 01:54:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zvkrGh8FmjuQsFl1/lfQSnJLqSABQFL8mxLLYAsA+rc=;
 b=Fb0vys72W2lL0qhXvYPUNx5DeMR75ZMR7NOvpdFC5jWW3NNpQh+ponvlQABqoGrGAy
 yJHYULtP8xOjtBIyYPVY0f/10Sho675lN/asINqdDJ6cBWCd6c2+NSnl0rWlQpy5qbNt
 VJo4KfWcE7Ln/vVq21x5xlQlyllqQeLC7V6E3UaX1yLiRP/aZZ+GXzXrOEddNI4oEolq
 43X8LGnMGZlIngtrExe7nhqQ5mAtbS31q1O0kRYnyAr5e4Bj74xw0mfZ3MAOT4KNkKhL
 xEKy8SmowKqxrm1TivY6rcPy/B6Q2GMGJk3e3GI6T+U//0gN2L6Qr0Ly+uxIRbVplscv
 Vk7w==
X-Gm-Message-State: AA+aEWaflip34Y5WqgEXtLAVvH61/8ax8Jcg6Oanp+GxiuR95q2y6Ckp
 7XH2hVo2phAOJaBeShvJ93IlRYzissc=
X-Google-Smtp-Source: AFSGD/UU03DWLWc1jtaRAQeCf/EaVNyA5nvBv0rKynSFkv+jNpZfUZZ21mLIFYOGvHBC+tiS79E95g==
X-Received: by 2002:a50:b881:: with SMTP id l1mr19433599ede.167.1545213266128; 
 Wed, 19 Dec 2018 01:54:26 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com.
 [209.85.221.46])
 by smtp.gmail.com with ESMTPSA id f4sm5073913edb.21.2018.12.19.01.54.25
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Dec 2018 01:54:25 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id s12so18383540wrt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 01:54:25 -0800 (PST)
X-Received: by 2002:adf:b608:: with SMTP id f8mr17166237wre.120.1545213265539; 
 Wed, 19 Dec 2018 01:54:25 -0800 (PST)
MIME-Version: 1.0
References: <20181217040449.31437-1-wens@csie.org>
 <ADDC30F6-9C86-4D59-A28E-A3007C9D478D@holtmann.org>
In-Reply-To: <ADDC30F6-9C86-4D59-A28E-A3007C9D478D@holtmann.org>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 19 Dec 2018 17:54:12 +0800
X-Gmail-Original-Message-ID: <CAGb2v643Wyt5NSygxf0aQzrAhOjYS+M_OC5L7RSCnk+aw_p9LA@mail.gmail.com>
Message-ID: <CAGb2v643Wyt5NSygxf0aQzrAhOjYS+M_OC5L7RSCnk+aw_p9LA@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] ARM: sunxi: Enable Broadcom-based Bluetooth
 controllers
To: Marcel Holtmann <marcel@holtmann.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_015438_079907_69F789AF 
X-CRM114-Status: GOOD (  33.03  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-bluetooth@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Loic Poulain <loic.poulain@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 19, 2018 at 7:50 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Chen-Yu,
>
> > This is v3 of my Broadcom-based Bluetooth controllers on Allwinner SoC-
> > based SBCs series. v2 was sent on 11/15, with a follow up ping on 11/28.
> > No response from either Bluetooth maintainer. Would the maintainers
> > acknowledge or provide feedback so we can move forward? WiFi for the
> > Broadcom chips has been supported and enabled for many years. Bluetooth
> > on the other hand has required userspace trickery to get it working.
> > With serdev support, this now requires minimal interaction from
> > users to get working.
> >
> >
> > Changes since v2:
> >
> >  - Collected tags from Ondrej for applicable patches
> >
> > Changes since v1:
> >
> >  - Collected tags
> >  - Re-organize dt binding clocks and clock-names properties
> >  - Simplify check for deferred probe when getting clocks
> >  - Add explanation of Cubietruck's clk_out_a pinmux setting placement
> >    to commit message.
> >  - Add missing "uart-has-rtscts" property to Cubietruck device tree
> >
> > Original cover letter follows.
> >
> >
> > On many Allwinner SBCs / developer boards, there is a WiFi+BT combo
> > module from AMPAK. Inside is either one or two Broadcom chips, depending
> > on the model. This series enables the Bluetooth controllers for AMPAK
> > AP6210, AP6212, and AP6330 found on several boards. More will come later
> > as other SoCs require changes to some other parts. I did not cover the
> > SCO PCM connections from the controller to the SoC's I2S interface. It
> > seems no one is actually doing this, so I was not sure how to proceed.
> > Any suggestions?
> >
> > I deliberately left out the netdev mailing list and Dave Miller, as the
> > only thing that is under net is the binding document. Maybe we should
> > move that out of Documentation/devicetree/bindings/net/ ?
> >
> > Also, I'm not subscribed to the linux-bluetooth ML, so please CC me for
> > any discussions.
> >
> > Patches 1 through 4 are device tree binding changes:
> >
> > 1 - Make the external clock name unambiguous, and add a second entry for
> >    the LPO clock.
> >
> > 2 - Add regulator supply properties for the VBAT and VDDIO power pins.
> >
> > 3 - Add a compatible string for BCM20702A1.
> >
> > 4 - Add a compatible string for BCM4330.
> >
> > Patches 5 through 13 are changes to the driver, either improvements,
> > or updates to handle the updated device tree binding.
> >
> > 5 - Make the driver handle deferred probing for the external clock.
> >
> > 6 - Simplify clock error checking for subsequent clk API calls.
> >
> > 7 - Handle clock-names for the main external clock.
> >
> > 8 - Support a new external clock, the LPO.
> >
> > 9 - Support regulator supplies.
> >
> > 10 - Wait a small amount of time after toggling the GPIO for the device
> >     to settle.
> >
> > 11 - Add support for BCM20702A1, including its default address.
> >
> > 12 - Add BCM4330 compatible string to the driver.
> >
> > 13 - Handle default address for BCM43430A0.
> >
> > 14 - Enable Broadcom-based serdev Bluetooth for multiple Allwinner ARMv7
> >     boards.
> >
> > 15 - Enable Broadcom-based serdev Bluetooth for the Bananapi M64.
> >
> > checkpatch reports an error for both patch 11 and patch 13:
> >
> >    ERROR: space required after that close brace '}'
> >
> > I followed the existing code's style. If this is undesirable, I can send
> > a follow-up patch fixing the entire code block.
> >
> > The first 13 patches should go through the Bluetooth tree, while we, the
> > sunxi maintainers, will take the last 2.
> >
> >
> > Thanks
> > ChenYu
> >
> > Chen-Yu Tsai (14):
> >  dt-bindings: net: broadcom-bluetooth: Fix external clock names
> >  dt-bindings: net: broadcom-bluetooth: Add VBAT and VDDIO supplies
> >  dt-bindings: net: broadcom-bluetooth: Add BCM20702A1 compatible string
> >  dt-bindings: net: broadcom-bluetooth: Add BCM4330 compatible string
> >  Bluetooth: hci_bcm: Handle deferred probing for the clock supply
> >  Bluetooth: hci_bcm: Simplify clk_get error handling
> >  Bluetooth: hci_bcm: Use "txco" and "extclk" to get clock reference
> >  Bluetooth: hci_bcm: Add support for LPO clock
> >  Bluetooth: hci_bcm: Add support for regulator supplies
> >  Bluetooth: hci_bcm: Wait for device to come out of reset after power
> >    on
> >  Bluetooth: hci_bcm: Add compatible string for BCM4330
> >  Bluetooth: btbcm: Add default address for BCM43430A0
> >  ARM: dts: sunxi: Enable Broadcom-based Bluetooth for multiple boards
> >  arm64: dts: allwinner: a64: bananapi-m64: Add Bluetooth device node
> >
> > Maxime Ripard (1):
> >  Bluetooth: hci_bcm: Add BCM20702A1 variant
> >
> > .../bindings/net/broadcom-bluetooth.txt       |  11 +-
> > arch/arm/boot/dts/sun7i-a20-cubietruck.dts    |  25 ++++
> > arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts  |  18 +++
> > .../boot/dts/sun8i-a83t-cubietruck-plus.dts   |  18 +++
> > arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts  |  14 +++
> > .../dts/allwinner/sun50i-a64-bananapi-m64.dts |  14 +++
> > drivers/bluetooth/btbcm.c                     |  13 +-
> > drivers/bluetooth/hci_bcm.c                   | 112 +++++++++++++++---
> > 8 files changed, 208 insertions(+), 17 deletions(-)
>
> patches 1-13 have been applied to bluetooth-next tree.

Thanks. Queued up the last two for a late pull request round.

ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
