Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611F9C64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:56:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F15020834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tmrvQmt6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F15020834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ipkOZEFBL6lxScm0OwRMVHhZEUym4tcPZRRTfZt9fHQ=; b=tmrvQmt6MpzwXa
	vK0siet45dz+Dek4PHeGRd6GlAj83cqzV2xwq9dq+2zKh6xncKin/BGKe9ucZ5CrzIDk0eshNslwj
	hf4OP4/gdwq+Rb/47FgPAk8fAQ9FoUfcFnDkY6le4lp5Xvpewc3Vr2EYVJ4ymddv89ZXbgQarqR7c
	FnBP1nszufmOfbgk3pmBgcDxssif8PVXOSN3Vytof1X0e++NIbou8XSM+8blcalBxY1r7TeGhH/Zs
	xCOi0USlF3tl01iIpsi2qAPi19e3XSe9nRPYIToPs8Ax2NPLKCAuaaQpFD6CJiGmG2/AeKx5mfIMZ
	sJRgeZfhzaFVY1VxdOTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSn1O-0003Fk-Rg; Fri, 30 Nov 2018 17:56:10 +0000
Received: from mail.bugwerft.de ([46.23.86.59])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSn1K-0003E9-AE
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 17:56:07 +0000
Received: from localhost.localdomain (pD95EF9A6.dip0.t-ipconnect.de
 [217.94.249.166])
 by mail.bugwerft.de (Postfix) with ESMTPSA id 3758B2C4586;
 Fri, 30 Nov 2018 17:55:38 +0000 (UTC)
From: Daniel Mack <daniel@zonque.org>
To: robert.jarzmik@free.fr,
	haojian.zhuang@gmail.com
Subject: [PATCH 0/7] ARM: dts: fixes and additions for pxa platform
Date: Fri, 30 Nov 2018 18:55:36 +0100
Message-Id: <20181130175543.32628-1-daniel@zonque.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_095606_493406_5CA6F780 
X-CRM114-Status: UNSURE (   7.78  )
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
Cc: devicetree@vger.kernel.org, robh+dt@kernel.org,
 Daniel Mack <daniel@zonque.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This series carries a number of smaller fixes for the PXA SoC dts
include files. The last patch is a revised version of the Raumfeld
audio devices DTS.

Daniel Mack (7):
  ARM: dts: pxa2xx: drop #address-cells and #size-cells from /cpus
  ARM: dts: pxa3xx: drop #address-cells and #size-cells from pinctrl
    node
  ARM: dts: pxa2xx: fix hwuart memory range
  ARM: dts: pxa: merge &pxa3xx_ohci with &usb0
  ARM: dts: pxa3xx: order timer and gcu nodes under /pxabus
  ARM: dts: pxa3xx: clean up pxa3xx clock controller node name
  ARM: dts: pxa3xx: Add Raumfeld DTS files

 arch/arm/boot/dts/Makefile                    |   7 +
 arch/arm/boot/dts/pxa2xx.dtsi                 |   7 +-
 arch/arm/boot/dts/pxa300-raumfeld-common.dtsi | 405 ++++++++++++++++++
 .../boot/dts/pxa300-raumfeld-connector.dts    |  73 ++++
 .../boot/dts/pxa300-raumfeld-controller.dts   | 266 ++++++++++++
 .../boot/dts/pxa300-raumfeld-speaker-l.dts    |  11 +
 .../boot/dts/pxa300-raumfeld-speaker-m.dts    |  11 +
 .../boot/dts/pxa300-raumfeld-speaker-one.dts  | 137 ++++++
 .../boot/dts/pxa300-raumfeld-speaker-s.dts    |  11 +
 .../dts/pxa300-raumfeld-tuneable-clock.dtsi   |  85 ++++
 arch/arm/boot/dts/pxa3xx.dtsi                 |  44 +-
 11 files changed, 1026 insertions(+), 31 deletions(-)
 create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-common.dtsi
 create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-connector.dts
 create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-controller.dts
 create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-speaker-l.dts
 create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-speaker-m.dts
 create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-speaker-one.dts
 create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-speaker-s.dts
 create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-tuneable-clock.dtsi

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
