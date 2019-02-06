Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A561C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:33:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED0A02184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="icraDIXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED0A02184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=9aU9VjzS9EAe1sDyAcxdv9Ud4lBbiVZmODJnnVs2XPY=; b=icraDIXUziWyb6
	mjQ1QYb/D29bsI3Zu1BRkiKcw/8QSk46jWi85deByTw3WALDoFZOG3ztbuAo2BbkK2aR6eG9oNXct
	u0SDX72uO/dOsgSVEieD7zpFJ9TT7G/zrrzHPLiStw3eW9bmWvhLZaDDdYaVt9trTwTP0jmGDQ/GK
	H4rEySyJRpUVnpxG8wkKCZ0dRVnYOBOHbUiylnWRzUbnd+OUXM/XwnVgPMMOMAudQtswroH6MTjzo
	RAlek+Xya2VeCbxg2jyKlkYANRkjiveyP9T8wS1mkaVxZdpY30p1oxPv4Y/Kba6HwzeD/mo/MbOSq
	Xlr9U69boFczw4oeaxDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grDxP-000318-KA; Wed, 06 Feb 2019 03:33:03 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grDxA-0002nr-52
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 03:32:49 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 8FC765FCDF; Wed,  6 Feb 2019 11:32:43 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/9] ARM: sun9i: a80: Enable GMAC
Date: Wed,  6 Feb 2019 11:32:30 +0800
Message-Id: <20190206033239.3619-1-wens@csie.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_193248_351832_FA02E406 
X-CRM114-Status: UNSURE (   9.72  )
X-CRM114-Notice: Please train this message.
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
Cc: devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi everyone,

On the Allwinner A80, the PIO pin controller includes configuration
registers to set the I/O voltage. These must match the actual voltage
provided externally. A mismatch results in signals not being passed
through.

With the new PIO pin-bank regulator supply support in place, we can
tack on support for setting up these registers.

This in turn allows us to enable the GMAC, which runs at a reduced
2.5V for RGMII, instead of the standard 3.0V or 3.3V.

Please have a look.


Regards
ChenYu


Chen-Yu Tsai (9):
  pinctrl: sunxi: Support I/O bias voltage setting on A80
  ARM: dts: sun9i: a80-optimus: Add node for AXP809's unused dc1sw
    regulator
  ARM: dts: sun9i: a80-optimus: Add GPIO pin-bank regulator supplies
  ARM: dts: sun9i: cubieboard4: Add GPIO pin-bank regulator supplies
  ARM: dts: sun9i: Add GMAC clock node
  ARM: dts: sun9i: Add A80 GMAC gigabit ethernet controller node
  ARM: dts: sun9i: Add A80 GMAC RGMII pinmux setting
  ARM: dts: sun9i: a80-optimus: Enable GMAC
  ARM: dts: sun9i: cubieboard4: Enable GMAC

 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 44 +++++++++++++-
 arch/arm/boot/dts/sun9i-a80-optimus.dts     | 44 +++++++++++++-
 arch/arm/boot/dts/sun9i-a80.dtsi            | 65 +++++++++++++++++++++
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c |  1 +
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c   |  1 +
 drivers/pinctrl/sunxi/pinctrl-sunxi.c       | 41 +++++++++++++
 drivers/pinctrl/sunxi/pinctrl-sunxi.h       | 12 ++++
 7 files changed, 202 insertions(+), 6 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
