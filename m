Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60684C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:59:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B8872082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="huM/8VVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8872082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=o9r+NsymzOuxlj6hDHWy+dAiDlxFu53xP3n6i5kLye0=; b=huM/8VVQewY6DM
	qm2/YuX5Vv16LlHcMgEoreVpPzHiRHK6JHJsVWmCN4prpkkLpQOF/Rl8ucaGwcRaj+uvM6ei9c9Vg
	vu8dTD5pRQD9QxZ44Mkrf7d0aR4ljvpaq1cnQG+LZ/QQhtnKFx6dySXdMjal36Y5AFtMV9wwpycUb
	vFGdiQHfmdJ0lug/oWaZ5/kHm6926KJwDmds7LMYH1AhnYd7pZqN9+W6XDH0/8NkhBUYZRKNMULjX
	y8nZIMgL0RXEztgQlEorkYOQ8jjiniqHIgsFAyAqsG7KgXvyZnsUK2+nyxagX/VGglah/tZxWhSvB
	weiVZbOI2iiMrQW2G9YQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSdhh-0000Uz-72; Fri, 30 Nov 2018 07:59:13 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSdhd-0000S3-7M
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 07:59:10 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 3AE2D5FB8C; Fri, 30 Nov 2018 15:58:55 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 0/6] media: sun6i: Separate H3 compatible from A31
Date: Fri, 30 Nov 2018 15:58:43 +0800
Message-Id: <20181130075849.16941-1-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_235909_528095_003CE2C1 
X-CRM114-Status: GOOD (  10.51  )
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
Cc: devicetree@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The CSI (camera sensor interface) controller found on the H3 (and H5)
is a reduced version of the one found on the A31. It only has 1 channel,
instead of 4 channels supporting time-multiplexed BT.656 on the A31.
Since the H3 is a reduced version, it cannot "fallback" to a compatible
that implements more features than it supports.

This series separates support for the H3 variant from the A31 variant.

Patches 1 ~ 3 separate H3 CSI from A31 CSI in the bindings, driver, and
device tree, respectively.

Patch 4 adds a pinmux setting for the MCLK (master clock). Some camera
sensors use the master clock from the SoC instead of a standalone
crystal.

Patches 5 and 6 are examples of using a camera sensor with an SBC.
Since the modules are detachable, these changes should not be merged.
They should be implemented as overlays instead.

Please have a look.

In addition, I found that the first frame captured seems to always be
incomplete, with either parts cropped, out of position, or missing
color components.

Regards
ChenYu


Chen-Yu Tsai (6):
  media: dt-bindings: media: sun6i: Separate H3 compatible from A31
  media: sun6i: Add H3 compatible
  ARM: dts: sunxi: h3/h5: Drop A31 fallback compatible for CSI
    controller
  ARM: dts: sunxi: h3-h5: Add pinmux setting for CSI MCLK on PE1
  [DO NOT MERGE] ARM: dts: sunxi: bananapi-m2p: Add HDF5640 camera
    module
  [DO NOT MERGE] ARM: dts: sunxi: libretech-all-h3-cc: Add HDF5640
    camera module

 .../devicetree/bindings/media/sun6i-csi.txt   |  2 +-
 arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi | 87 +++++++++++++++++++
 arch/arm/boot/dts/sunxi-h3-h5.dtsi            |  8 +-
 .../boot/dts/sunxi-libretech-all-h3-cc.dtsi   | 81 +++++++++++++++++
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      |  1 +
 5 files changed, 176 insertions(+), 3 deletions(-)

-- 
2.20.0.rc1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
