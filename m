Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A4AC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:31:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1750621855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XGzexYW/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="neKyxjoB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1750621855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=triplefau.lt
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=EGjpe7NoP3ncmey5wvn5SGUKBFo0RcsrpMo4bboBYKE=; b=XGzexYW/245f2g
	CouYwLgu1Tku91HPFmT94ZRkeDYLcyAxy8ZMaCwFKwKxPwpqgH6hNlB/qHlbvBs3H4nZbiTYyl/US
	pM7Z91p6RxVY7OF9DdebLW0vPP26ro+EQpflfanslhfilXJMnFkp3Q0uo0N2vqXEPGhT3bKcH0mAe
	tAfUIEM0eOx4L7MhXOD8qxpoksxBGR04Ux7+IgV3Xzw0wlWaO7pjhFe+VawkGK0wNBUKPO3W6QGVm
	AqWrZ+FgSoWnGZoIGwHPHGF/Fye9zspV9gceMzdNGNDzyMNAtWw5/Dzi3YoEMKnFXwcLSWdLYPYkM
	zvCfbWjieMZfXaWQtZQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmOEx-0006G5-La; Wed, 23 Jan 2019 19:31:11 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmOEu-0006Fb-Up
 for linux-arm-kernel@bombadil.infradead.org; Wed, 23 Jan 2019 19:31:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xm3LIsp1Rc+PdSfoLt6efwhwAxxedTYbxsbzuQBlX3E=; b=neKyxjoB07/ANKP3MvlqVVsy3w
 TybTtcpRI/PtMsKe8ZyLjRJ1HABlbDvbuhAeFS/W3CXrrj+pzHt5/u9uAOpN32hw+NQc2AQgPI4Wi
 GHiQPZ3saikgKTwu0ekgq8VpB2333r09HiQ9l1sesf+3UNPhFMsMap7UimtOR7zYujNPdVacakEXX
 L+y2/9zTnzDM/315PHk8REoa6ugWsJaRp3x7Uv8EB4FPqyGA2raeeOFgcZIZ4Azq2NZ+oEwoCHMHk
 5BSL3tUFozfbzZugIRiNZ/ShYV4mbHNHP2AZm/lEj+tHHJbCMFekISsKQ3aithXj2GCJOT3l7mvUW
 MIvidirg==;
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmOEq-0007k1-An
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 19:31:05 +0000
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
 (Authenticated sender: repk@triplefau.lt)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id DDC011BF20E;
 Wed, 23 Jan 2019 19:30:28 +0000 (UTC)
From: Remi Pommarel <repk@triplefau.lt>
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] arm64: dts: armada-3720-espressobin: Configure RGMII and SMI
 pins
Date: Wed, 23 Jan 2019 20:39:46 +0100
Message-Id: <20190123193946.13594-1-repk@triplefau.lt>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_143104_483508_4057A3D1 
X-CRM114-Status: GOOD (  10.18  )
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
Cc: devicetree@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In order to be able to communicate with the 88e6341 switch some pins
have to be repurposed as RGMII and SMI pins.

This fixes ethernet support on system booted via a bootloader that
has not already configured those pins (e.g. mainline u-boot, or vendor
u-boot compiled without ethernet support).

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
This should be applied along with pinctrl fixes from
https://lkml.org/lkml/2018/12/21/507 which have been merged in next branch of
linux-pinctrl tree.
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts | 2 ++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi            | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
index 846003bb480c..b60897edc885 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
@@ -196,6 +196,8 @@
 };
 
 &eth0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_pins>, <&smi_pins>;
 	phy-mode = "rgmii-id";
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index e05594ea15fb..f61538910901 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -271,6 +271,11 @@
 					function = "mii";
 				};
 
+				smi_pins: smi-pins {
+					groups = "smi";
+					function = "smi";
+				};
+
 				sdio_pins: sdio-pins {
 					groups = "sdio_sb";
 					function = "sdio";
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
