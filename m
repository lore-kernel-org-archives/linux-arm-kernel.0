Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191B1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 04:52:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3B65217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 04:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AyU0dQLx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RPeHTcHs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B65217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MyQRZ2CZBad4YLY7eNhpfZW5IyYV3DSGcGl2wIS5sck=; b=AyU0dQLxqJ8Aqc
	CUnU+kPRckpBKNjNiwjMzDpzN+pNzudEgYNo91Vim2Sxh38g+LidABOzeuSaEwycwY609K0pgmFO1
	psxlN9KV8r7IOe1QxQqsdN5KfxhTQPr2v47anGKRRJ7O6JpceRrvhhyu0Wc7QPkQMJJJYwrhGREFH
	A4dFGcBhDed8PhA7y7zbWcLFP5ogBj+PmAlAbz1q+vV8Zf89DY6l4MvmXq/Fww01wSgOdpPy0QCuv
	javxfFtJ+/OT4RtT954cn0Pvyk66gywJMxYgNfN8B2vCtHs9ruIRdSozFFdvBx/kINzytzcmWVo3S
	JfgKT9z7XK5nqbOOvPsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ7Mt-0002Bw-RT; Tue, 18 Dec 2018 04:52:31 +0000
Received: from mail-eopbgr30052.outbound.protection.outlook.com ([40.107.3.52]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ7Me-0001ir-Iq
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 04:52:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSTxVdFN8jNNoZwjLntdH1NCBk+1kOik+5k1gDbnaQs=;
 b=RPeHTcHs6Xq6EV4hv1Uwmk9zVEYds6QbfEbRHW+oY54qBht/Y70NPCxSOcLofeSD9UFt8kjnYdYPSWJ89/RrF2nOuuIwm1qLlkfH+Kydl+R4mLl5hq2qbdy2G3Tk6hx+QCAak4H5AM4+QbCGjLGjABIhvenf6avjfVpsOOAwpBU=
Received: from VI1PR04MB4480.eurprd04.prod.outlook.com (20.177.53.224) by
 VI1PR04MB4112.eurprd04.prod.outlook.com (52.133.14.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Tue, 18 Dec 2018 04:52:02 +0000
Received: from VI1PR04MB4480.eurprd04.prod.outlook.com
 ([fe80::9564:6e18:8e79:eff0]) by VI1PR04MB4480.eurprd04.prod.outlook.com
 ([fe80::9564:6e18:8e79:eff0%5]) with mapi id 15.20.1425.023; Tue, 18 Dec 2018
 04:52:02 +0000
From: Nipun Gupta <nipun.gupta@nxp.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>, 
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] arm64: dts: ls1088: add missing dma-coherent property in
 fsl-mc
Thread-Topic: [PATCH 2/2] arm64: dts: ls1088: add missing dma-coherent
 property in fsl-mc
Thread-Index: AQHUlo1q50lxxRhkykSM8Ikgp155Xg==
Date: Tue, 18 Dec 2018 04:52:02 +0000
Message-ID: <1545109016-1779-2-git-send-email-nipun.gupta@nxp.com>
References: <1545109016-1779-1-git-send-email-nipun.gupta@nxp.com>
In-Reply-To: <1545109016-1779-1-git-send-email-nipun.gupta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::11) To VI1PR04MB4480.eurprd04.prod.outlook.com
 (2603:10a6:803:67::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB4112;
 6:66Mylc6FIoBrtVjE1F05E4BKAdCHArgugf1mEkvKUsiKyDQH546OZy6SYqS2PifpkzuUzMoWVuD9mo4nfv25QiWKdsKOf9vuxe8bzTtI96GHlqCcR6kvigTpMDXIWaM5doB40Vq86TdXOOc6Mt6/iy2Ki+Xe3MPPJQkEr2BBDzZJJu1fjH6LGIvYwxpREcY6W7XKziON2fReK8jsrOznsBpekeRdDny1l1nlu+n+16weJ9Q/Yzs0qH9mZ6pIQVQmFJEumSVu8IkuCKwKMHuufiqNFEn2GADYIJ4ClswluGQ5Zp6tl40T0CM6k7LD9ESUmNW8Vq1RCO7LRS0N2/4AIC7QgRQ8QPOyqLdyOv5+i2MFZWtdt7b2KHZVUbNzp2CrtKxOihfyCLpjmAa/FYdvrukTb0oMeq3sQiuCJKnGqA+oYL+WHu+8THCAxWySOZIDHseIECVeuFhBSp3VFe2kcw==;
 5:6z5dsocmBLE4wMUoRqOV/MI1kq7E5Mf4gRW2wqSkSxNZE5fpNwFOaC22wleLo/86nkuIipBYjFNEOiBnHlKBRbjlvVtpXct3owdJMoYo7ibV+20kre3wIvWh8ojtFxjQDMfZh/mMupnohNbADahaPA+wPzBr+gY44tx298XLsbU=;
 7:MfuShbZPkvp3sQTkDW+DmKR2sv0UdiA6ubbQY2vVK3fU6e6epY4DJA67iObq3w1WL3u16J3pb+afTa9FhRu/ywnVFXNPmEfPfnMNT/6t/t//BLCDo4dRE2LKAOHfk/yWZFYMY5DBX+KtF5qa09uyjg==
x-ms-office365-filtering-correlation-id: 5c2016c4-de58-4284-f7b0-08d664a48d10
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4112; 
x-ms-traffictypediagnostic: VI1PR04MB4112:
x-microsoft-antispam-prvs: <VI1PR04MB4112673175B8A8E1AF5673F5E6BD0@VI1PR04MB4112.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB4112; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB4112; 
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(366004)(199004)(189003)(6512007)(256004)(6486002)(14454004)(6116002)(3846002)(26005)(78486014)(2906002)(186003)(2201001)(71200400001)(71190400001)(6436002)(66066001)(575784001)(97736004)(86362001)(8936002)(81166006)(8676002)(81156014)(478600001)(36756003)(76176011)(5660300001)(102836004)(99286004)(55236004)(6506007)(68736007)(4326008)(2501003)(52116002)(386003)(305945005)(44832011)(486006)(446003)(11346002)(476003)(53936002)(2616005)(7736002)(25786009)(105586002)(110136005)(316002)(106356001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4112;
 H:VI1PR04MB4480.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pXo9CIbSpAzYX4QPCPlMAK0GN8CREAUBwHMAhnQAqgqCBimtbFeNasPdanhJ35CcD/YA0NU+YM1N5DywJAXp/xczTYC7BNWFvAZVpej6cZ9VVi7o+e7Xng5LJfvDtCFWzP0421kgx5YdNyfQKDVV9Vg4+8h5LRopLJuShRWb2jKXe+5FKn5Z/8rxxAPE9GSgIZYIhBompEqFktPagzjsCizZeNu1YvF7Wv7gB+ta3CmxDboCn8xY3gTeJLoSRxrnE4uEIY3P934wK4gWQxBVrTP/Vn4mIpGOr0CarbxZ69VR8NJMZ+SQN+ezwNnWnuUQ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2016c4-de58-4284-f7b0-08d664a48d10
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 04:52:02.7069 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4112
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_205216_621639_7294765F 
X-CRM114-Status: GOOD (  12.11  )
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
Cc: Nipun Gupta <nipun.gupta@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index dec0c2d..b8e31a1 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -577,6 +577,7 @@
 			      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
 			msi-parent = <&its>;
 			iommu-map = <0 &smmu 0 0>;	/* This is fixed-up by u-boot */
+			dma-coherent;
 			#address-cells = <3>;
 			#size-cells = <1>;
 
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
