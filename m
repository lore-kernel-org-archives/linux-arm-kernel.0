Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0A9C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:08:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7303214DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nSwC0v1X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7303214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jusst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=zTwzQ7Whgp9QjYa6NOHc1tdLsqO91fmDaFMoT1ZCXKI=; b=nSwC0v1X0Eim7M
	1AACqaAvP5ybpjB6Aw7yotmWP45aUV7ONEly+KU2U7huBMabPMji6WDUD49oTvexwlkXSsQNBNHYn
	81dPLqoKJbuo60fWxYwfSglHDmwAWUFbIbaqGUpanbF/NwWR8EhEnPaL3kDrwD3RAZDVj8evhjiFE
	XhJv0I+8S4Qwt+6H/1FRr/DdMquYjK6pRAoyspRacvNhaMmaV6eZuYJl4AzTIp7llLW4rdDaNFnzu
	FszmjJO3QFK2e3Amfo8s/SqVMAw49Vol9bmR1BCd3OguebTybflOq3saVcTHDjsVdT7fcNBNcFOd7
	q58lZegcQxnPNkKTHTRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU8Yb-0003gE-JA; Tue, 04 Dec 2018 11:08:01 +0000
Received: from jusst.de ([188.40.114.84] helo=web01.jusst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU8YX-0003PM-OZ
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 11:07:59 +0000
Received: from hans-ole-workstation.ms.jusst.de (i577BBB33.versanet.de
 [87.123.187.51]) (Authenticated sender: hohatzel@jusst.de)
 by web01.jusst.de (Postfix) with ESMTPSA id D88401B01A78;
 Tue,  4 Dec 2018 12:07:38 +0100 (CET)
From: Hans Ole Hatzel <hohatzel@jusst.de>
To: linux-arm-kernel@lists.infradead.org, ilya@compulab.co.il,
 devicetree@vger.kernel.org, linux-imx@nxp.com, fabio.estevam@nxp.com,
 shawnguo@kernel.org
Subject: [PATCH 0/4] imx7 sbc board support extensions
Date: Tue,  4 Dec 2018 12:07:37 +0100
Message-Id: <20181204110741.6943-1-hohatzel@jusst.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Authentication-Results: web01.jusst.de;
 auth=pass smtp.auth=hohatzel@jusst.de smtp.mailfrom=hohatzel@jusst.de
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_030757_995381_F653CB56 
X-CRM114-Status: UNSURE (   6.76  )
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
Cc: Hans Ole Hatzel <hohatzel@jusst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following patch series contains a number of extensions and fixes to
the board support for the imx7 sbc.

Hans Ole Hatzel (4):
  ARM: dts: imx7d: cl-som-imx7: fix pinctrl for i2c2
  ARM: dts: imx7d: cl-som-imx7: WiLink8 WLAN support
  ARM: dts: imx7d: sbc imx7: add uart2
  ARM: dts: imx7d: sbc imx7: add uart5

 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 100 +++++++++++++++++++++++-
 arch/arm/boot/dts/imx7d-sbc-imx7.dts    |   8 ++
 2 files changed, 106 insertions(+), 2 deletions(-)

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
