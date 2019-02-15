Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B998C10F02
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:10:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A61E21A80
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oDQlXL+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A61E21A80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=E17WW5UOYTJXAEnTmFF4PBiNSANXTOnPB5wQUN8gL9E=; b=oDQlXL+qUHGWffi+4RQcmaSke5
	PuUONOyAhe8f+VHWsOeKDfKL+Og3+Cep8SnKxxZNWjX+M+zdPz0I764H6w03FZCxVhqB8QvWjg72+
	k5Kiwwj5J34IrY3KTHe4T/DblNMA+XTP19pGDwZr95XtDxBH/m0pp8PLGxk5Px4XvNrlkI9MEVZSW
	53O45V44X8yXTNGi0YFj7C0loetNyD1jVjm43wTJU+HnOJoqOfmHsBCwkehpEk9P+u/uaFwdqR1rp
	eNk6R9rjGGratlgDVoCmcWSCc5EoOJlkB+Cj/c3/xeXcqXMrUJY8jv+u/Kiae0WeP4PvJu9ad3XUz
	P7+V03HQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guaRp-0005m3-IS; Fri, 15 Feb 2019 10:10:21 +0000
Received: from inva021.nxp.com ([92.121.34.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guaRm-0005lA-Bg
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 10:10:19 +0000
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 158A12001FE;
 Fri, 15 Feb 2019 11:10:17 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 08AA32000E9;
 Fri, 15 Feb 2019 11:10:17 +0100 (CET)
Received: from fsr-ub1664-016.ea.freescale.net
 (fsr-ub1664-016.ea.freescale.net [10.171.71.216])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 8A5D4205EC;
 Fri, 15 Feb 2019 11:10:16 +0100 (CET)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
 "David S . Miller" <davem@davemloft.net>
Subject: [PATCH net-next v2 2/3] arm64: dts: fsl: ls1028a-rdb: Add ENETC
 external eth ports for the LS1028A RDB board
Date: Fri, 15 Feb 2019 12:10:13 +0200
Message-Id: <1550225414-12125-3-git-send-email-claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550225414-12125-1-git-send-email-claudiu.manoil@nxp.com>
References: <1550225414-12125-1-git-send-email-claudiu.manoil@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_021018_545017_24E096F8 
X-CRM114-Status: UNSURE (   7.64  )
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
