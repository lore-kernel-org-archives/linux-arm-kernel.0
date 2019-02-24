Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA107C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 20:10:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B620B20651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 20:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PjORwsx4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B620B20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kwiboo.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=0y7HXZ+TdZmr2lC+7LQyuEtA+hkJqpcI7xTPrCQ/EWQ=; b=PjORwsx4Oxk9fG
	xV4CfvWsUXl5iaVmDDyf7oaikYFSKp5oUUVQeldJk/4GP4RlHgOVowhjfZPieqEsH9rojvXdIdhak
	kuu2x6/GJtpNGoGFfovj9Ibyx4wxEyc0o6fP/AjvoaMd3WntZ8gcVxyOwW3glr3LT+sye+mi6Ya2k
	q2MO9JZSBN46+JR4EcJJGVyRUavJLw8DwecuY/cB+6oZyFMeDg1+0/8+8uAk/mscTMbTWehuDgayh
	CGjPU/0hFm1kSSgGrUxJl2MV/Hv5l/xY8HmCp6tIbXE6iianfFJ/McZOIGbyGg3cACN1HGlIVVPgx
	d5R9J/ndzhmj79l1gS8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gy06G-0008AO-W3; Sun, 24 Feb 2019 20:10:12 +0000
Received: from mail-oln040092068048.outbound.protection.outlook.com
 ([40.92.68.48] helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gy06D-00084U-Hv; Sun, 24 Feb 2019 20:10:10 +0000
Received: from HE1EUR02FT021.eop-EUR02.prod.protection.outlook.com
 (10.152.10.54) by HE1EUR02HT083.eop-EUR02.prod.protection.outlook.com
 (10.152.11.232) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Sun, 24 Feb
 2019 20:10:06 +0000
Received: from AM3PR03MB0966.eurprd03.prod.outlook.com (10.152.10.55) by
 HE1EUR02FT021.mail.protection.outlook.com (10.152.10.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Sun, 24 Feb 2019 20:10:06 +0000
Received: from AM3PR03MB0966.eurprd03.prod.outlook.com
 ([fe80::8011:1f4d:3804:e5f3]) by AM3PR03MB0966.eurprd03.prod.outlook.com
 ([fe80::8011:1f4d:3804:e5f3%10]) with mapi id 15.20.1643.019; Sun, 24 Feb
 2019 20:10:06 +0000
From: Jonas Karlman <jonas@kwiboo.se>
To: "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>
Subject: [PATCH] ARM: dts: rockchip: Enable HDMI CEC on rk3288-tinker-s
Thread-Topic: [PATCH] ARM: dts: rockchip: Enable HDMI CEC on rk3288-tinker-s
Thread-Index: AQHUzHzvJU+Wey4D206DLTd1OY5eQQ==
Date: Sun, 24 Feb 2019 20:10:06 +0000
Message-ID: <AM3PR03MB096695687A4BDD432428A977AC790@AM3PR03MB0966.eurprd03.prod.outlook.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0099.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::40) To AM3PR03MB0966.eurprd03.prod.outlook.com
 (2a01:111:e400:884c::23)
x-incomingtopheadermarker: OriginalChecksum:DF45CFA2DB92743F5C7E5AD08D39BB51D9D1ADA39CD8ADE41BFD400F7968AF1B;
 UpperCasedChecksum:831317F6FE4A78AFABB9D7F6F5BC619E12747762929F90A536B904AF3764E6F1;
 SizeAsReceived:8581; Count:62
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn: [VLWJ+WQVJrDV080W2HfAOQbvGWV6bNUD]
x-microsoft-original-message-id: <20190224200946.25414-1-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 62
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031324274)(2017031323274)(1601125500)(1603101475)(1701031045);
 SRVR:HE1EUR02HT083; 
x-ms-traffictypediagnostic: HE1EUR02HT083:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:HE1EUR02HT083; BCL:0; PCL:0; RULEID:; SRVR:HE1EUR02HT083; 
x-microsoft-antispam-message-info: xJVlkGBqpmwcrZyBIHktzBkx3iI/TQpItjQ7BohXquhy4X+L65XOAUonVYmuoxWI
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 54485d23-c432-40fe-8436-6091d627118c
X-MS-Exchange-CrossTenant-Network-Message-Id: d46cab32-06c7-4d71-70e7-08d69a941167
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 54485d23-c432-40fe-8436-6091d627118c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2019 20:10:05.4931 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1EUR02HT083
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_121009_599420_723C03E0 
X-CRM114-Status: UNSURE (   9.98  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Jonas Karlman <jonas@kwiboo.se>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch enables HDMI CEC on Tinker Board S

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/boot/dts/rk3288-tinker-s.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-tinker-s.dts b/arch/arm/boot/dts/rk3288-tinker-s.dts
index 37093922b482..590e3b06bbc4 100644
--- a/arch/arm/boot/dts/rk3288-tinker-s.dts
+++ b/arch/arm/boot/dts/rk3288-tinker-s.dts
@@ -24,3 +24,8 @@
 	mmc-ddr-1_8v;
 	status = "okay";
 };
+
+&hdmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmi_cec_c0>;
+};
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
