Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D612C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 21:51:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF3FD20842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 21:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J4mYIZaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3FD20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kwiboo.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bmPX82HB66fI9rIByOE4yCG64VqKk6S+6bXviEhAn/o=; b=J4mYIZaAI5OcvG
	ow5prpzdWITd9nQp0BYoGAHhCS+9ZXNgJOZ0PjMZP4E1npVkkLevWBFaoqq0LWOzmgpf35EK8DT8D
	OkUe9+N0wjmYQWgW33rB58NLQIPnpYzCA0+l1Wgvb3bHOYJ6z3jcXl72IdrJYiNcT/ed2TWxRgVJ6
	0bP9zpySI7xHRDXsvU9eeTLlk3IeqsDL0SkgLaHli+tF87oKzyhaF1E4eoka6iHpTKXuu9aqYH3H4
	81uzaFZudFo9qazVGZtk4h08Ltq5hS7HOzm0Rnr29w7w5sf1P4503BWuhrtLUq2NQry3aQJEboAV0
	2mP1nXN3POxbBUDJcQjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gy1gM-00059U-Qj; Sun, 24 Feb 2019 21:51:34 +0000
Received: from mail-db5eur03olkn0818.outbound.protection.outlook.com
 ([2a01:111:f400:fe0a::818]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gy1gE-00058I-Bh; Sun, 24 Feb 2019 21:51:28 +0000
Received: from VE1EUR03FT024.eop-EUR03.prod.protection.outlook.com
 (10.152.18.51) by VE1EUR03HT089.eop-EUR03.prod.protection.outlook.com
 (10.152.19.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.11; Sun, 24 Feb
 2019 21:51:22 +0000
Received: from AM3PR03MB0966.eurprd03.prod.outlook.com (10.152.18.57) by
 VE1EUR03FT024.mail.protection.outlook.com (10.152.18.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.11 via Frontend Transport; Sun, 24 Feb 2019 21:51:22 +0000
Received: from AM3PR03MB0966.eurprd03.prod.outlook.com
 ([fe80::8011:1f4d:3804:e5f3]) by AM3PR03MB0966.eurprd03.prod.outlook.com
 ([fe80::8011:1f4d:3804:e5f3%10]) with mapi id 15.20.1643.019; Sun, 24 Feb
 2019 21:51:22 +0000
From: Jonas Karlman <jonas@kwiboo.se>
To: "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>
Subject: [PATCH] ARM: dts: rockchip: fix rk3288 cpu opp node reference
Thread-Topic: [PATCH] ARM: dts: rockchip: fix rk3288 cpu opp node reference
Thread-Index: AQHUzIsUCHHVZIT5gUGqpB7tPDNEtQ==
Date: Sun, 24 Feb 2019 21:51:22 +0000
Message-ID: <AM3PR03MB0966C52CCF14FCEDE6615265AC790@AM3PR03MB0966.eurprd03.prod.outlook.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR05CA0032.eurprd05.prod.outlook.com
 (2603:10a6:20b:2e::45) To AM3PR03MB0966.eurprd03.prod.outlook.com
 (2a01:111:e400:884c::23)
x-incomingtopheadermarker: OriginalChecksum:F972A736F52C2FD2BAFEE8270221852B49197743C65E7198F8353B7E1F4ED03C;
 UpperCasedChecksum:A95496DB9B26ED8EACC4EBD055DEC8D2EFF0A59412C85641A10823AAF85BF2F9;
 SizeAsReceived:8597; Count:62
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn: [A3l8AM3xX4xbHoAhwb66n7xfNYIBNx57]
x-microsoft-original-message-id: <20190224215110.27049-1-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 62
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031324274)(2017031323274)(1601125500)(1603101475)(1701031045);
 SRVR:VE1EUR03HT089; 
x-ms-traffictypediagnostic: VE1EUR03HT089:
x-microsoft-antispam-message-info: 1WKWTie9iIDTAfZRdgTGJScraUIQoi4H/CDpIvH9o0fp2ROV+qbM1SERS+cnZStG
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ac99c053-86c0-4c44-cea6-08d69aa236cf
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2019 21:51:21.2029 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR03HT089
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_135126_497783_BC57B7CD 
X-CRM114-Status: GOOD (  12.26  )
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

The following error can be seen during boot:

  of: /cpus/cpu@501: Couldn't find opp node

Change cpu nodes to use operating-points-v2 in order to fix this.

Fixes: ce76de984649 ("ARM: dts: rockchip: convert rk3288 to operating-points-v2")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/boot/dts/rk3288.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index ca7d52daa8fb..09868dcee34b 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -70,7 +70,7 @@
 			compatible = "arm,cortex-a12";
 			reg = <0x501>;
 			resets = <&cru SRST_CORE1>;
-			operating-points = <&cpu_opp_table>;
+			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>; /* min followed by max */
 			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
@@ -80,7 +80,7 @@
 			compatible = "arm,cortex-a12";
 			reg = <0x502>;
 			resets = <&cru SRST_CORE2>;
-			operating-points = <&cpu_opp_table>;
+			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>; /* min followed by max */
 			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
@@ -90,7 +90,7 @@
 			compatible = "arm,cortex-a12";
 			reg = <0x503>;
 			resets = <&cru SRST_CORE3>;
-			operating-points = <&cpu_opp_table>;
+			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>; /* min followed by max */
 			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
