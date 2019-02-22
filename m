Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0ECC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:04:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B98F2070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A/kgzUEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B98F2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=6yUzfAYXYylqpUQksIOvUlD/n4uvrjQREiKikw5x938=; b=A/kgzUEU5Lh1Zr3aQ32prFZuyl
	VJe34BsqqVjDoJguv7+gEllFNkU92SuNS/ER4FVHCDjFR5FkGtKrTtB8YxuwJ9Fd6P/ss9E7ptwXb
	p2+c0PUqOKTSSJ0KxpKLEfqVyZlp12Tv+C2688bKmjxwwipriYLePGJWnp9A3bJRx3RYQ6DYWnRFo
	lIhl32xn2xTX+eDh4AI74Bn4Bsb491ZI8FJgRxxljz/RtYL67anV5gQLEoE6w1++DT83mqnSFNkWd
	epql9/MxpcKcGHotIiyQ3P/X8y3mY3ynnuyCy1QNS+YiWc+ZBuJxOBHPDe5sPv12HJQzOKxrbfInD
	ONryIcQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxCNJ-0005SI-JK; Fri, 22 Feb 2019 15:04:29 +0000
Received: from inva021.nxp.com ([92.121.34.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxCNF-0005PG-KF
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 15:04:27 +0000
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C446A20003C;
 Fri, 22 Feb 2019 16:04:21 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B6B01200036;
 Fri, 22 Feb 2019 16:04:21 +0100 (CET)
Received: from fsr-ub1664-016.ea.freescale.net
 (fsr-ub1664-016.ea.freescale.net [10.171.71.216])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 523AB2062B;
 Fri, 22 Feb 2019 16:04:21 +0100 (CET)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
 "David S . Miller" <davem@davemloft.net>
Subject: [PATCH net-next v3 2/4] arm64: dts: fsl: ls1028a-rdb: Add ENETC
 external eth ports for the LS1028A RDB board
Date: Fri, 22 Feb 2019 17:04:17 +0200
Message-Id: <1550847859-17346-3-git-send-email-claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550847859-17346-1-git-send-email-claudiu.manoil@nxp.com>
References: <1550847859-17346-1-git-send-email-claudiu.manoil@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_070425_965063_5C7CF240 
X-CRM114-Status: UNSURE (   7.43  )
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
Cc: devicetree@vger.kernel.org, alexandru.marginean@nxp.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The LS1028A RDB board features an Atheros PHY connected over
SGMII to the ENETC PF0 (or Port0).  ENETC Port1 (PF1) has no
external connection on this board, so it can be disabled for now.

Signed-off-by: Alex Marginean <alexandru.marginean@nxp.com>
Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v2 - added a mdio node as parent for the phy node
v3 - none

 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index fdeb417..f86b054 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -71,3 +71,20 @@
 &duart1 {
 	status = "okay";
 };
+
+&enetc_port0 {
+	phy-handle = <&sgmii_phy0>;
+	phy-connection-type = "sgmii";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		sgmii_phy0: ethernet-phy@2 {
+			reg = <0x2>;
+		};
+	};
+};
+
+&enetc_port1 {
+	status = "disabled";
+};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
