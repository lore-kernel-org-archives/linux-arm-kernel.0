Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE44C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:03:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 770CE206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aaNAjhza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770CE206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=51uoLhXohyjeVnPFzyuBtMSELyRubr8V/jOeOLc2QgY=; b=aaNAjhza0Tg/Y/
	WkbVqPzbGNVMpFSvciG1of+PdLvbu1aosiaXEX+xvu4LutdAOg26Ppxb1XJ/Eb/oczqwNkLXuKS5U
	FdkfBBA7oR7SnhrcJexrjrwYJK6UU0ZE6lnbp9GgAOKvDdG+ZPI7k5kVSrI6BSH5qO+3KEi9rWlMw
	szSXQcTV45h0BZZX3Bp+Q0t9HKIhlaTj8AuZQFgXTCrfvxWmE6NruCpwkpqPTu5dhPfwzuUpBzdnc
	BiJkcr06FxbEqG7FIhd3sLV7zc2vXEyTQjnKp779OqiK4Zcjx8VY0R6wp34GdZnHRrhUrl8qcXHHN
	oDkoJKTinWCz8Mfim8vQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghFNr-0001YH-LG; Wed, 09 Jan 2019 15:03:07 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghFNo-0001WU-J0
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 15:03:06 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 468DA5FCC8; Wed,  9 Jan 2019 23:03:00 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 0/5] ARM: dts: sunxi: Enable Broadcom-based Bluetooth w/ serdev
Date: Wed,  9 Jan 2019 23:02:52 +0800
Message-Id: <20190109150257.12602-1-wens@csie.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_070304_754639_1C272990 
X-CRM114-Status: UNSURE (   8.90  )
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
Cc: devicetree@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi everyone,

This is the second batch of patches enabling Bluetooth for Broadcom
(AMPAK) modules using the new serdev bindings.

The patches are self-explanatory, so I won't go into the details here.

This pretty much covers all the boards I have that have AMPAK modules.
The only ones missing are the A80-based boards, which I haven't gotten
working yet.

Chen-Yu Tsai (5):
  ARM: dts: sun8i: r40: Add pinmux settings for UART3 on PG pingroup
  ARM: dts: sun8i: r40: Add pinmux setting for CLK_OUT_A
  ARM: dts: sun8i: r40: bananapi-m2-ultra: Fix WiFi regulator
    definitions
  ARM: dts: sun8i: r40: bananapi-m2-ultra: Add Bluetooth device node
  ARM: dts: sunxi: bananapi-m2-plus: Add Bluetooth device node

 .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  | 41 +++++++++++++++++++
 arch/arm/boot/dts/sun8i-r40.dtsi              | 15 +++++++
 arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi | 16 +++++++-
 3 files changed, 71 insertions(+), 1 deletion(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
