Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2B4C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:15:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CEE8218A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V4z1sX+7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=asyring.de header.i=@asyring.de header.b="fuE2ZeES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CEE8218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=asyring.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=QZR3aNbInJb+a2PEePqoxb2c0LKLyHRgFUg1MxWPa+Q=; b=V4z1sX+7vW0982
	itCGOCaDpygJ4Jv5by4nerKHwZWUz1sYUT/13nGdhnrbvq8KL8xO8llpBqjDKcsORKYGUataGUbWz
	DOZGZ5tv0vaF3zPxpTtF275Gpf9txwYtOvK+wv6BY/wsLv7WvxqkLipmZ+kxKYVURwLjJZ5yxsAoZ
	8aCYDXxWzhczxX3ba77P5tZYdA0RjdCfRkRz8KNle9Dox+yHhlxlGRiKTDOkPEz+dpST/rgzYIxUG
	K3FTJDchdnTZHTR7bfSxvUhn7dD9cs/7CWFaCmtMSA4pHjxQJVpONHE8AtvWLAtwJiuxEwMFQfmrD
	ztL75mM3MSMlNAf6z5vQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtFAg-0000Jd-0b; Mon, 11 Feb 2019 17:15:06 +0000
Received: from asyring.homeip.net ([37.120.161.147]
 helo=vserver.asyring.homeip.net)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtFAb-0008Pp-Vw
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 17:15:03 +0000
Received: from localhost (localhost [127.0.0.1])
 by vserver.asyring.homeip.net (Postfix) with ESMTP id F0B905F8DF
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 18:14:46 +0100 (CET)
Authentication-Results: mail.asyring.de (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)" header.d=asyring.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asyring.de; h=
 content-transfer-encoding:mime-version:x-mailer:message-id:date
 :date:subject:subject:to:from:from; s=dkim; t=1549905286; x=
 1550769287; bh=PxHmdGBIIavfe+FujuZeHhqR0BLJB3Zd/OO54oJLHsM=; b=f
 uE2ZeESdwGiMZ82Twbmqx63FNzxpda5s92rfQyB+Oa6nRQpE5eBtaJ8ngauSiA3M
 4Ul5WQIp8DdwJgNYjcn+YG6dLwPPk0KLqnAXPhgfsqjY2r+qZa3zknlvhcofiUUa
 REfw15dbuOlTMQbt3l8ujTXVQn7F22GBo5i1W5cqCE=
X-Virus-Scanned: Debian amavisd-new at asyring.homeip.net
Received: from vserver.asyring.homeip.net ([127.0.0.1])
 by localhost (mail.asyring.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2mDxUW2lnP74 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 18:14:46 +0100 (CET)
Received: from Cubietruck.lan. (Cubietruck-Lan.lan [192.168.0.131])
 by vserver.asyring.homeip.net (Postfix) with ESMTPSA id 93F635F83B;
 Mon, 11 Feb 2019 18:14:39 +0100 (CET)
From: Alexander Syring <alex@asyring.de>
To: Russell King <linux@armlinux.org.uk>
Subject: [PATCH 1/2] arm64: dts: marvell: mcbin: Adding SPI-NOR Flash Config
Date: Mon, 11 Feb 2019 18:14:01 +0100
Message-Id: <20190211171401.434-1-alex@asyring.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_091502_199910_6BBF7AA1 
X-CRM114-Status: GOOD (  13.10  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Alexander Syring <alex@asyring.de>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

According to U-Boot dts file enabling the SPI-NOR flash for use in
Linux

Signed-off-by: Alexander Syring <alex@asyring.de>
---
 .../boot/dts/marvell/armada-8040-mcbin.dtsi   | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
index 329f8ceeebea..83994ff46e2d 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
@@ -333,11 +333,24 @@
 	status = "okay";
 
 	spi-flash@0 {
-		compatible = "st,w25q32";
-		spi-max-frequency = <50000000>;
-		reg = <0>;
-	};
-};
+		compatible = "st,w25q32", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <50000000>;
+
+		partitions {
+			compatible = "fixed-partitions";
+
+			partition@0 {
+				label = "U-Boot";
+				reg = <0 0x200000>;
+			};
+			partition@400000 {
+				label = "U-Boot Env";
+				reg = <0x200000 0xce0000>;
+			};
+		};
+	};
+};
 
 &cp1_usb3_0 {
 	/* CPS Lane 2 - CON7 */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
