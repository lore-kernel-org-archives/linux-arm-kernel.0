Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407DCC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:50:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11CA521929
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Er8RHzYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11CA521929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=olimex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=XBJMU4EpF6hPkwCLOgLixq1jJFx+in6XcrpB5OT0wjE=; b=Er8
	RHzYf7BW8bX+Uw484Q7oAa5BB6TLFLTQuEVNLrWX3ggoRZ0pbTsRvDztAgV+9TiY+s/dI3k/w1KRE
	mZ7YSoV4jTIRiZ8g+P+Ns/LGNJJWmHQyu5qmZvduqyGjhPsLLWKsL8SFwAzwyTesfoaIsFndvJ5Ls
	UHDZRvppOAbN1JtJPQ4gq4Jx6IbXF9fX8NlMszE2AiwBVMsjZJqURlcnJk7ctxb6IX2Z5OgMs9qUr
	zsKiJL+jd/Hiad1Zeu5W0wFSpiN8n1QYvk1XjxnIdih8uXawCq0G/Ziwcj+Nmd3sgZQLGJXZqk1jr
	KKIJ+q/BV9rd3PjbQn2Cfv3oyJr1Hzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guc0w-000754-VF; Fri, 15 Feb 2019 11:50:43 +0000
Received: from olimex.com ([2001:470:0:1f2::b869:4820])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guc0t-000749-K4
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 11:50:40 +0000
Received: from localhost.localdomain ([195.238.85.143])
 by olimex.com with ESMTPSA
 (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD)
 (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
 for <linux-arm-kernel@lists.infradead.org>; Fri, 15 Feb 2019 03:50:36 -0800
From: Stefan Mavrodiev <stefan@olimex.com>
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>,
 Lee Jones <lee.jones@linaro.org>,
 linux-leds@vger.kernel.org (open list:LED SUBSYSTEM),
 devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS), 
 linux-kernel@vger.kernel.org (open list:X-POWERS MULTIFUNCTION PMIC DEVICE
 DRIVERS), 
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner sunXi SoC
 support)
Subject: [PATCH v2 0/8] leds: Add AXP20X CHGLED
Date: Fri, 15 Feb 2019 13:50:05 +0200
Message-Id: <20190215115013.11098-1-stefan@olimex.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_035039_654626_B93E83E1 
X-CRM114-Status: GOOD (  10.33  )
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
Cc: Stefan Mavrodiev <stefan@olimex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This series add support for CHGLED pin found on most of
X-Powers PMICs.

Changes for v2:
- use mutex when accessing hardware registers
- fixed LED naming style
- fixed some typos
- fix variable types when showing attributes
- remove useless private data
- fix binding documentation
- add device consumers

Stefan Mavrodiev (8):
  leds: Add support for AXP20X CHGLED
  mfd: axp20x: Add axp20x-led cell
  dt-bindings: leds: Add binding for axp20x-led device driver
  arm64: dts: allwinner: axp803: add charge led node
  arm64: dts: allwinner: Enable AXP803 CHGLED for Olimex boards
  arm: dts: axpxx: add charge led node
  ARM: dts: sun7i: Enable AXP209 CHGLED for Olimex boards
  ARM: dts: sun8i: a33: Enable AXP223 CHGLED for A33-OLinuXino

 .../devicetree/bindings/leds/leds-axp20x.txt  |  74 +++++
 arch/arm/boot/dts/axp209.dtsi                 |   5 +
 arch/arm/boot/dts/axp22x.dtsi                 |   5 +
 arch/arm/boot/dts/axp81x.dtsi                 |   5 +
 .../arm/boot/dts/sun7i-a20-olimex-som-evb.dts |   6 +
 .../boot/dts/sun7i-a20-olimex-som204-evb.dts  |   6 +
 .../boot/dts/sun7i-a20-olinuxino-lime2.dts    |   6 +
 .../boot/dts/sun7i-a20-olinuxino-micro.dts    |   6 +
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts     |   6 +
 arch/arm64/boot/dts/allwinner/axp803.dtsi     |   5 +
 .../dts/allwinner/sun50i-a64-olinuxino.dts    |   6 +
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts |   6 +
 drivers/leds/Kconfig                          |  10 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-axp20x.c                    | 291 ++++++++++++++++++
 drivers/mfd/axp20x.c                          |  24 +-
 16 files changed, 461 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-axp20x.txt
 create mode 100644 drivers/leds/leds-axp20x.c

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
