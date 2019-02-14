Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B504CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:25:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83F73222D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MhgaDqsn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F73222D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nY9NNFqKtbXmWv0fvqKadMJqiLVmCVCVJvbruoadOss=; b=MhgaDqsnkGw2Kr
	IHXJmNrPSqmyqcrmKY7FtHOvuWTjJ6pc7mQtZ+YjS6cC+MpYbrWzpS00ckz8hA47kG/GiTyxfcqeo
	EzTZRDxdHNEHgowbUR22Due5hwZU8JJwVkoqf9C+shEdlLK2UgoJrAghXfvj8LyJ0NLukAvwrAmn6
	daWUKmC8K1ijxmUvFSpV8LL8HRRoa5kcOVBkev8dLIePPgvSHfMPz838vGTLjOtaeqpxT6Jm+3t+Q
	Jco/ovhPoYd+DRG1CiPQv7e5LTAZgTosE61nxavkwXxU36Pc5bDhQYVohUJpHBExLxBh+eihdFFly
	Bwp+U9jnXJ9SvC53xLtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu6i7-0007aS-3c; Thu, 14 Feb 2019 02:25:11 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu6i2-0006PT-Ub; Thu, 14 Feb 2019 02:25:08 +0000
X-UUID: 0032f20d2e76433e86c2cc507dc1d712-20190213
X-UUID: 0032f20d2e76433e86c2cc507dc1d712-20190213
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <yunfei.dong@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 238405810; Wed, 13 Feb 2019 18:25:00 -0800
Received: from mtkmbs08n2.mediatek.inc (172.21.101.56) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 13 Feb 2019 18:24:58 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 14 Feb 2019 10:24:56 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 14 Feb 2019 10:24:55 +0800
From: Yunfei Dong <yunfei.dong@mediatek.com>
To: Hans Verkuil <hverkuil@xs4all.nl>, Tiffany Lin <tiffany.lin@mediatek.com>, 
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>, Rob Herring
 <robh+dt@kernel.org>
Subject: [RESEND PATCH v4,
 2/3] arm64: dts: Using standard CCF interface to set vcodec clk
Date: Thu, 14 Feb 2019 10:24:52 +0800
Message-ID: <1550111093-7057-2-git-send-email-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1550111093-7057-1-git-send-email-yunfei.dong@mediatek.com>
References: <1550111093-7057-1-git-send-email-yunfei.dong@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 505ED9FBFA238E16F710D7103E13967DF4CCD8A4E801243108565D5607A8E1F02000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_182506_997794_D091010C 
X-CRM114-Status: UNSURE (   7.36  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Yunfei Dong <yunfei.dong@mediatek.com>, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Qianqian Yan <qianqian.yan@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Using standard CCF interface to set vdec/venc parent clk
and clk rate.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Signed-off-by: Qianqian Yan <qianqian.yan@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 412ffd4..126d11e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -1305,6 +1305,15 @@
 				      "vencpll",
 				      "venc_lt_sel",
 				      "vdec_bus_clk_src";
+			assigned-clocks = <&topckgen CLK_TOP_VENC_LT_SEL>,
+					  <&topckgen CLK_TOP_CCI400_SEL>,
+					  <&topckgen CLK_TOP_VDEC_SEL>,
+					  <&apmixedsys CLK_APMIXED_VCODECPLL>,
+					  <&apmixedsys CLK_APMIXED_VENCPLL>;
+			assigned-clock-parents = <&topckgen CLK_TOP_VCODECPLL_370P5>,
+						 <&topckgen CLK_TOP_UNIVPLL_D2>,
+						 <&topckgen CLK_TOP_VCODECPLL>;
+			assigned-clock-rates = <0>, <0>, <0>, <1482000000>, <800000000>;
 		};
 
 		larb1: larb@16010000 {
@@ -1370,6 +1379,10 @@
 				      "venc_sel",
 				      "venc_lt_sel_src",
 				      "venc_lt_sel";
+			assigned-clocks = <&topckgen CLK_TOP_VENC_SEL>,
+					  <&topckgen CLK_TOP_VENC_LT_SEL>;
+			assigned-clock-parents = <&topckgen CLK_TOP_VENCPLL_D2>,
+						 <&topckgen CLK_TOP_UNIVPLL1_D2>;
 		};
 
 		vencltsys: clock-controller@19000000 {
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
