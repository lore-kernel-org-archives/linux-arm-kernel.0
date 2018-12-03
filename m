Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572C7C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:42:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05CF720851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p9T232t1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W/vB2amz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05CF720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CM8XiihXqihVY4gfzErI4DU4cU+ZYo0WNz1BFQlX5Ls=; b=p9T232t1s2Jz5H
	NZ5tH8odSNwkw3E2ptoGmyNbN+5ZSJyVySA8T5f2m40XKeorKbHgAVdGpM6k6osH4GvvTGKl5NtWL
	AoVsra4BTBSy2sytQd0hvVR7df/+szK7lzTul2lOBuZAlow59fSXTw1Wh9jkPFZSHuSF5ZggVMQaI
	iybCZV1jkwDipIfClXu6DGQ8Hbcn8B2hZ2hO7+wkCFG6GNpigvNVk3AL44+oRs84OBniNQP90GnQt
	0FesDDvdQnFeZz4U+7f6wYOYCZujktriZIzuGx3VJcIJwK8MM3IqMx4il/Kr+BFZ1nf+ohO1EaeSX
	WsZjYxpg53+cGg1XXipA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTjnz-0008Is-Ho; Mon, 03 Dec 2018 08:42:15 +0000
Received: from mail-eopbgr140043.outbound.protection.outlook.com
 ([40.107.14.43] helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTjlk-0004hk-Qy; Mon, 03 Dec 2018 08:40:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTcTKNAGT+ckD6PO5lLSse/nX/ZfHtEVm2DrqUcW5KE=;
 b=W/vB2amz4BAF/bgrhZzPjpSAMXnhZvlAYzjX7YeCl4eZfHlfaibDG8dmrLrHMao+UYDtCX0b9qN9S12lfAUztnaIepcWe0TYeigmE1VCHq5f1O0F0soyRFcwmpFiZklDocOg10tGc9wXJXoIrfGuK6paiDMdLVBn7i2GLAg/ch4=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB1470.eurprd04.prod.outlook.com (10.163.166.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Mon, 3 Dec 2018 08:39:37 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%4]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 08:39:37 +0000
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "marek.vasut@gmail.com"
 <marek.vasut@gmail.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v5 6/7] spi: nxp-fspi: add octal mode flag bit for octal
 support
Thread-Topic: [PATCH v5 6/7] spi: nxp-fspi: add octal mode flag bit for octal
 support
Thread-Index: AQHUiuO59OgZ8ZoaJkiQyASI9cR2GQ==
Date: Mon, 3 Dec 2018 08:39:37 +0000
Message-ID: <1543826226-30898-7-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR04CA0143.apcprd04.prod.outlook.com
 (2603:1096:3:16::27) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB1470;
 6:avnGBBtZX31Mc1m2oKeXiAbawzCxX9eAsNwdnvJshH6Xqbnnqx5nWFKYOcld2mTQ1DLC73EZKVuxDbbP4vCUfGRyAlBD9RHqsMi9sJWDkEGZUBjwwxhM917V9X4NfrUMucp457A+1N97sMiO89effQClB33anRFaHfQTl8Fl17VfSCWIdiqE+vlJluEOHhvmSvy+0O1PJuT6z+VzOQxELvMFPFELMiDTy0Joxu6AppdZCsH9d+MRWRLQFVXEsoSSQePAG9ubCRTfNT08jXCzw80+0PCVKJt0Ts6bB85GBjPoQGsFyTLwQmVhKgXkef5FVd0FsR9gjovU88Zea8LS+Vif5b4VjdedQdq4A26Ew/NPNS+5c0n0137SEF2KuhNmTzLPQn9gcEEYmLFaE+1y+u0DBlSAA/SDbZcRQ8OzmQbZl1o5irrI1DZ/2utSjht+FJ+7WBUaEuWx5NeRrs995g==;
 5:ERt/7mgNcvY3eIqMMw1pDjMSjIM0cXtb6kUh9todqAVrk2rTJqnpP2eQsb+eyReLynQNyP1Be645tgdztL9s2nR+jDuI9lvHYmActv202KqK96zesVjJvhcQjB55CYAuzln+OcKcfmxf2MFEIFpOqNDxjCaz3b3mg3vY/0wYrVA=;
 7:IyxQJZqHq2t+nyNRC2GWZlkkjczaXsjlnyILU5aTLhFooD6NUKGex8jd3l0dK2qNMWbC+J7IY/JAJBw9tx/cxBhTw/RmetRqL7hcxuYQGf93nTHC8oidmJPHTaJu9Xn5I9p6aPmMHfBRRknDTHeF4g==
x-ms-office365-filtering-correlation-id: 855e028f-280c-473e-8085-08d658fadb7a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB1470; 
x-ms-traffictypediagnostic: VI1PR04MB1470:
x-microsoft-antispam-prvs: <VI1PR04MB1470C05FFA46BA24D681B89B99AE0@VI1PR04MB1470.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231455)(999002)(944501493)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB1470; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB1470; 
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(39860400002)(366004)(396003)(136003)(189003)(199004)(55236004)(2501003)(105586002)(76176011)(5660300001)(7736002)(54906003)(14454004)(6116002)(110136005)(386003)(6506007)(99286004)(2906002)(52116002)(7416002)(316002)(3846002)(305945005)(68736007)(25786009)(2201001)(478600001)(97736004)(86362001)(256004)(36756003)(66066001)(81156014)(81166006)(8676002)(78486014)(8936002)(6512007)(53936002)(6486002)(6436002)(476003)(446003)(106356001)(486006)(2616005)(186003)(11346002)(71200400001)(26005)(102836004)(4326008)(71190400001)(39060400002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB1470;
 H:VI1PR04MB5726.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wmqQcHurHgyMsXGCBhPspMcZvd1AKpkP1sHrje3OMw0TVkjcos719YiwWCErecTBrDGcIfn58Gi06JMnhNCtaJBUPC8u6vL2MwQJIwZfHO2eju1e2FK+Q7FX26TF778dDzF+bUphV9hZy3yD3m2wDBxzkNreoalGvcG/dhzcXoQnfJAocTIXoGDrgnv8Yx1DU22lHbE/gdqHYBOIGo4C65Ozm674fX2rb7HzsU3Dtxk3nvArOWkngfTvqnNDqbou+REmVx8fEM6F/D6UiUGkWVj7lZO5nSkUnmIfQzQrmKl2oocKvUHyLzD0m0gGEwPAiQ4cv+Vak4IGgDsWFmFH+Yt0rTxeN3eJ+cIq17nLFXo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 855e028f-280c-473e-8085-08d658fadb7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 08:39:37.0713 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1470
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_003957_222139_7437167F 
X-CRM114-Status: GOOD (  12.61  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "robh@kernel.org" <robh@kernel.org>,
 Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add octal mode flags for octal I/O data transfer support.
NXP FlexSPI controller supports 8 lines Rx/Tx data transfer.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v5:
- Modified string 'octo' with 'octal'.
Changes for v4:
- None
Changes for v3:
- Modified string 'octal' with 'octo'.
Changes for v2:
- None

 drivers/spi/spi-nxp-fspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index a35013b..b65f27c 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -995,8 +995,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	if (!ctlr)
 		return -ENOMEM;
 
-	ctlr->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD |
-			  SPI_TX_DUAL | SPI_TX_QUAD;
+	ctlr->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL |
+			  SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL;
 
 	f = spi_controller_get_devdata(ctlr);
 	f->dev = dev;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
