Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36451C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:22:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 041602081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hexm8+yN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="dwrRTRqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 041602081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3/R9jpY5Vwwcgqie3N7onCJNPexVyTFFPASeKt3On4g=; b=Hexm8+yNu8UsyX
	0hF27wL8xpNntw4g+fSKW8LOxZSHsK6Oc3spze9CAprfLS+68yvhaiiVBcYwfpiBqSAbH3zq5CP0P
	DPy+75RSgbWLxJkgflGR/djeLOzH1GGgPg31FhQ6iR1czdSXOJRj6E8fA19SjguXXJgWYBeA000j+
	JbWdy2nxTsTnqQtrcFpWubgzaQ7LTeRMd2M/MqxcWN6J8gl1jHV6D4XYqMJpLy8Wl3SiNIEJnIfg6
	0U/vUqE9jb6XZWVSIX8RGATgN6VQb0VKVLX1eakX6bx6MOHEE7A15swSQ5VHr+rdUoZf5Ipi/7Wxf
	c/DHpfm3uDF9Ayk1DqzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqbON-0006iM-QN; Mon, 04 Feb 2019 10:22:19 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqbC9-00068K-Oy; Mon, 04 Feb 2019 10:09:52 +0000
X-IronPort-AV: E=Sophos;i="5.56,559,1539673200"; d="scan'208";a="26269131"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 04 Feb 2019 03:09:39 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 4 Feb 2019 03:09:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONzljGUKpxSEzjquSeX0Xc1OQzIQlDcNjKqAIPOusBI=;
 b=dwrRTRqfDTXpvOMuaRs1hcGIMWeTKMtsIRJjTVtLwFw0deEaKESRXBxoh9InkRUosqCvfMHwJwr1oWVx8fiVT/rw1WW7Zdrd0G9EQX1fdKQFUlm0Decp+Fo0jag6WfmiHo+V/CH8UhOTQnV9MyGsQ/DwyjdtQUOflGzPUGP7UNI=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1553.namprd11.prod.outlook.com (10.172.23.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Mon, 4 Feb 2019 10:09:35 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 10:09:35 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
 <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
Subject: [PATCH v4 05/13] spi: atmel-quadspi: remove unnecessary cast
Thread-Topic: [PATCH v4 05/13] spi: atmel-quadspi: remove unnecessary cast
Thread-Index: AQHUvHG7FrZsuRI6JkGSi50b6kZeGw==
Date: Mon, 4 Feb 2019 10:09:35 +0000
Message-ID: <20190204100910.26701-6-tudor.ambarus@microchip.com>
References: <20190204100910.26701-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190204100910.26701-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0270.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::43) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1553;
 6:6DU13k39C2gdorANswtXWwDb2JlePpPw34FI1Udnwly0HL5xlrJAZeeWGuyoFO9oni+X1l5ac+UZmxhlEGqsv+MU9mOzXbtQCVmk07woGJmg+HuJPIdHu7oxHF1M8ZyGmKcwEauryI1faiGY/liugOHKe/ML8/4E9rnYDxcBTKUtI+QFw3uFYqhrlTmSpcs+E3jVN/lEwOVc3RS7fvjWx+9OriwD/hotb4AO3G5J5fipcXrGXWg+XeRpZKfaPoIOcNXwrdP0KUuzu9D0c7d884D8d0VpqitNr8llm7pD6MtAaOU6434rzuTm7s1Oj9ba5/beqBEZzkIq6Qi0Ws/szURCXuwDZqb//tC1KWTZso6zls+t9gUOeofpQsXWXd6PZIVElgWxrB7F/VWlZd9DLUajTjVuND07F8Uv1q9dkGd1UKndZCXpuHW3rc3JlRVV9JDfrBlQbD1DC4vFNdzIqw==;
 5:Nt4NuklSRIvUpNrjFBasA3m4gglTVt+pVcl04xqpLzSXq5O72UJHIV/lTT0snkjcm89NahcweUtehjisex4bR4Cy9pLSw/99wGremA5MRKSMZo/BFl1/esKJtfi4IeZrT3/WhpIZnFfVbktfFWNggUPKNeca6+/K63g1j/dcmmuSw/bcpOq5JdQ3/4bmORSt6+xeheXBtYGkbN0FDZE5Mg==;
 7:qagK4kiJuvn/QYa8R+deNBqgNFwRrYdbUvZ7YpXwHyWDIwBgU9RoJhM80mZrTOQgofmNcm+prleuYoq4At0eGRzcnatJwmzbfGWRGVkeVrKa0AgL3DbS8VJ5i3G+h58uovGuIsEzwaKrF66LG4OvUw==
x-ms-office365-filtering-correlation-id: ac730272-e9e0-4f61-4895-08d68a88dd3f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1553; 
x-ms-traffictypediagnostic: BN6PR11MB1553:
x-microsoft-antispam-prvs: <BN6PR11MB15533BE642F46FB6FD792D7EF06D0@BN6PR11MB1553.namprd11.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39850400004)(136003)(366004)(396003)(346002)(376002)(189003)(199004)(8676002)(81166006)(81156014)(316002)(76176011)(8936002)(4744005)(110136005)(305945005)(186003)(54906003)(66066001)(7736002)(446003)(3846002)(6116002)(6436002)(68736007)(86362001)(478600001)(102836004)(1076003)(36756003)(105586002)(26005)(106356001)(99286004)(72206003)(50226002)(6512007)(2501003)(14454004)(11346002)(476003)(486006)(256004)(14444005)(7416002)(25786009)(4326008)(53936002)(39060400002)(107886003)(2906002)(6486002)(2616005)(52116002)(97736004)(71200400001)(386003)(71190400001)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1553;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LfguKdxVrQJkzHbDVJjKQkyIn0w/zHuL22XcD0+zlbwP+fZDKsArnHUNC7dE4G9FEjpsq4gVgBCLqD5qbPOptgnnHiuoJa6W8aqetFYTrFInt+mpcaUFIUzwzf3wj59suJE62hIjKo26oeWZV5D+0jr8Y8mCKUfyOKcg+3W/GAjDFFX7atvZeo22yHeUMOw4zB6az2Mg3UIFMoHSNXMAuOGeigUDA6P8boJJvu8p/UGlEkjQH0UzOOax2EwVbYEHws5KWHSS5fQZ/4UnDJ6DRc3x60Uwmjac+svPKygCDOQZLB83pneB8mJbD91B8FU5wXnmXU/oC5HI8BP34UrmWIfXHyhV1auZbwiiK9B9gTQPyjf7MkgHvDqCaXfvmQpaRG/A+S4VwE18mifqak5KCSSvbzHQJp2I5fDsNTxdT7o=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ac730272-e9e0-4f61-4895-08d68a88dd3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 10:09:32.7821 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1553
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_020942_461453_3A1E94DA 
X-CRM114-Status: UNSURE (   8.71  )
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
Cc: devicetree@vger.kernel.org, Tudor.Ambarus@microchip.com,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The cast is done implicitly.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
v4: no change
v3: no change
v2: collect R-b

 drivers/spi/atmel-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index be1d1ba7898c..be7f87fd5ac7 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -389,7 +389,7 @@ static int atmel_qspi_init(struct atmel_qspi *aq)
 
 static irqreturn_t atmel_qspi_interrupt(int irq, void *dev_id)
 {
-	struct atmel_qspi *aq = (struct atmel_qspi *)dev_id;
+	struct atmel_qspi *aq = dev_id;
 	u32 status, mask, pending;
 
 	status = readl_relaxed(aq->regs + QSPI_SR);
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
