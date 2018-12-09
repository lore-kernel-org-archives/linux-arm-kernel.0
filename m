Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C02C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:27:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 470BF20837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="COq9y4F/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dUKZszo9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470BF20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IblK0BFepOcJ0rMb+92Uw1Ia3FLZNRB+IoBILzovIBo=; b=COq9y4F/bRgJhH
	2D6XPFvFr/A+GxAJEXZIsftFD0umANepNPMaan3ouptB5lNsegyvT954DeJw5uS2PClObwiDxm40G
	xkhRkzWjALBiSUL0DyALdtRmLUG6jwtIrfq/ApZgtVZ8kxYpucNB3rjWjQkKHqzp09WqKPzc7ujQf
	7mvBt1O2BdmbBHtF/QHeKF5JLU72XgaYtu2vILzxWnfFb5MJfa9H6zJPQYNl6U/6NjPlFifSFIOca
	cl081A33mNCaZHB5lRtKbZI7fwYetfYf+PonsICQZLeSXERCxmdlLyJ50bnIfo7fOB4JHUfMHTw3e
	c22QS8QWV0ykIX5qyTNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gW030-0002Vr-Im; Sun, 09 Dec 2018 14:27:06 +0000
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gW02V-0001oS-LC
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 14:26:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnf1zQkMWNUYqRXqqcv4aF6W7b0nAWY7Of4XS97j5rI=;
 b=dUKZszo9Gwi35MYk3eugcF3pe0S7tlLNyy/2Cptq0R6BVmSpn0oZHr5LJc9C+1ibZjbRlUxf1wOA8y0yl9xtPhVX5gglxQC1vN6P248OaR77/vw0PBK8AsTb0f6ebViPRoh2aHFkL066S5UwFl0qZW4rk9lALRBF0R8OlBJXGN4=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3910.eurprd04.prod.outlook.com (52.133.29.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Sun, 9 Dec 2018 14:26:09 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d%4]) with mapi id 15.20.1404.025; Sun, 9 Dec 2018
 14:26:09 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Shawn Guo <shawnguo@kernel.org>, Rob
 Herring <robh@kernel.org>
Subject: [PATCH v5 4/6] MAINTAINERS: add i.MX8 DT path to i.MX architecture
Thread-Topic: [PATCH v5 4/6] MAINTAINERS: add i.MX8 DT path to i.MX
 architecture
Thread-Index: AQHUj8sg6oMVnX7IAEu+p0UQ2ghn8A==
Date: Sun, 9 Dec 2018 14:26:09 +0000
Message-ID: <1544365552-30270-5-git-send-email-abel.vesa@nxp.com>
References: <1544365552-30270-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1544365552-30270-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0004.eurprd07.prod.outlook.com
 (2603:10a6:203:51::14) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR0402MB3910;
 6:arpZoswgFsm/buNFbwmRQuR/SbHa5/lIlmXEhmPnljThK9PnZUEOshfney5ADewjT3jx1fRXMVyRZWXj55vcCzjp2t8iA9rTCstEUYb4A+hL1EuOibHKhflFaiZWA/4o+wFtwCU+Q+wA2fPmo6qn3jO3mkM2CKlsSlxc3WH2G+unVhucfOyTXMOTDK7jrjiLFt1KtJGh0+C83BskVHo7+DWJmaZ47FlwwsFfEQ2za4aJh5Xi+S0G520g3JR5WPD9rZu2ZC57x6gJDM/ZPNmA8MtZwUKcbGwt3oJkJPbzAi05qY5zT8uhFt/YvcE4dIQRCb5hKc1YbcwLTdDpe3Or99QoFoWdRpXDC3+aF587DkiLnD1KhLnQML5qJkT4Sm0zftJt6kq2Vl9I0RRCVVhK2X28PjjG80I8VgvLU3Vie8HX7G1saIf5w1OcEW8ijolTP+8L2TLylnEvG2R0lzNjWA==;
 5:ei5dTsl0Y1sxiKWdmitEY/PRiKCEqmiM+DdAc+U63WFj7o1fk9YdVx0t20J+6Pb3KiicA3KKxS5XkfQNzGUCDNzGiqUsV1/NNS99lPTQkJyz+Kqk1MpPNp4p+HLdL1+xjIokVUH6rNo8lDKQijTzW6FSL33WMpuizqGN4dS95XM=;
 7:b8Dqt9PdK0iChaMLCgj39B82sixaQ10MSAn2l2mCyK9aL3jgWhz1BL7WM5c90VbfEEHicFPqQeCBkxFyF7KWMDc83xut9NI+2NZnRZ0wwVM0YaQklRMcfM95sWp6JixKeYymR6llYCuh7ZqutLZNcg==
x-ms-office365-filtering-correlation-id: bcd85004-8724-4dd4-3056-08d65de24308
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR0402MB3910; 
x-ms-traffictypediagnostic: AM6PR0402MB3910:
x-microsoft-antispam-prvs: <AM6PR0402MB3910407C2777FE1B8109B408F6A40@AM6PR0402MB3910.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231455)(999002)(944501520)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:AM6PR0402MB3910; BCL:0; PCL:0; RULEID:; SRVR:AM6PR0402MB3910; 
x-forefront-prvs: 0881A7A935
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(376002)(396003)(39860400002)(136003)(346002)(189003)(199004)(26005)(446003)(5660300001)(25786009)(11346002)(71190400001)(2906002)(106356001)(105586002)(54906003)(3846002)(7736002)(44832011)(305945005)(2501003)(6116002)(476003)(486006)(2616005)(66066001)(97736004)(8676002)(4326008)(53936002)(99286004)(6436002)(81166006)(110136005)(6486002)(186003)(81156014)(68736007)(6512007)(386003)(6506007)(478600001)(86362001)(256004)(14454004)(36756003)(76176011)(71200400001)(102836004)(8936002)(52116002)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR0402MB3910;
 H:AM6PR0402MB3654.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NBHl6yIf8gIwc3zBLohlJ+qfBnxSePtNreJaeyD+IPDsjM5Rcm+oCKf166/YZZ1PHVkVzo2JC56Cd68nou3TmvCQe2HAfnuxfBITm2fxvQbYCL0XWSWWE7302W3qtprCDitayPKaIc3sVKtqsBEypqcrDl4BDrEZWvHdvaO/UArYTwJjbJCgcQXj1gM9Rst+pMI3zoEED+rE3a16NAs0IPjW42wB2ypoFszjQuSX6H+a8cWzFyGBp5TXuCNKYpLd8jyf2yWcWIwrJeF7fHqYEkyN4N9ZLwrwzWON7+2uE1PoRby0j/aUE0D1tEFrmuyL/sSWxNwOGPwilkNqe8mNTvGSm0kyOwqDtJM3yWa2JpI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd85004-8724-4dd4-3056-08d65de24308
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2018 14:26:09.1928 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3910
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_062635_801548_99A721CD 
X-CRM114-Status: GOOD (  11.60  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Abel Vesa <abel.vesa@nxp.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>,
 Abel Vesa <abelvesa@linux.com>, dl-linux-imx <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Lucas Stach <l.stach@pengutronix.de>

Shawn agreed to take patches for the i.MX8 parts through his tree.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3625a8d..b41ebff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1530,6 +1530,7 @@ F:	arch/arm/mach-imx/
 F:	arch/arm/mach-mxs/
 F:	arch/arm/boot/dts/imx*
 F:	arch/arm/configs/imx*_defconfig
+F:	arch/arm64/boot/dts/freescale/imx*
 F:	drivers/clk/imx/
 F:	drivers/firmware/imx/
 F:	drivers/soc/imx/
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
