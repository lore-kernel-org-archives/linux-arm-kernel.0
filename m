Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3608FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:41:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1E1120821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="chk8jHj/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="f9ipNCe1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E1120821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PTdfGpsfQgauptL7UGS6i5N0uQt3C51JjwArQ4x0ceM=; b=chk8jHj/zPEzq+
	qXAEWUcUmvbKnn+Im4r01vYJiwD9v+jq7EG04QCRyfS0ekSQ5ANMvhQw9b5rhakvqyux7GZZFhjEd
	g0zc1FACoeeWGpz7OJIi0Inycc6BtxTFUtTlKvmx2hpFbFzwMxS5+3TfOEz1aKD20sPBJv0fh7h+2
	K7fwefw2S+vtWd/NPx3kzKBA3iCpqCKlOq1Fm6lfAOaMoiDsV7TvR29wa813Kq8OKSWMw2l7SlQ7L
	Xj4ENf+XoTdcfSEefQoL2XZRteTLp7Tya+GeNGw1T3mp4P0IJTY6u86Np4OiL7s2jmVQyGFurrTom
	RoSTFFEclmxSpVOIbQ9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWH8S-0001ZS-4i; Mon, 10 Dec 2018 08:41:52 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWH8A-0001Im-UJ
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 08:41:37 +0000
X-IronPort-AV: E=Sophos;i="5.56,337,1539673200"; d="scan'208";a="21317792"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 10 Dec 2018 01:41:22 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Mon, 10 Dec 2018 01:41:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6tDzFsXUsLGq8DM8wDFZGW8OGAxYUwvIsmScBtvY1k=;
 b=f9ipNCe140tZHuwFW2iMvvKbhTcD8OVWDvOqLmXTlucphgCG8qX2NTG13AFOgV1Jy69l0AL8wZhGvRC/qiKu3JhZlHzxoCM7Bv+Kr7Av1ESBXEt7L+5dUHfTTZ5XMIWaNR3G0nKMyjzgIcO8asfR1Jqq3YOaBaBoZ+3GXBWmkZc=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1971.namprd11.prod.outlook.com (10.175.100.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Mon, 10 Dec 2018 08:41:21 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae%2]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 08:41:21 +0000
From: <Tudor.Ambarus@microchip.com>
To: <wsa@the-dreams.de>
Subject: [PATCH v2 1/2] i2c: enable buses to save their clock frequency in
 adapter
Thread-Topic: [PATCH v2 1/2] i2c: enable buses to save their clock frequency
 in adapter
Thread-Index: AQHUkGQg12gMYeerukaGe7imI+F8FQ==
Date: Mon, 10 Dec 2018 08:41:21 +0000
Message-ID: <20181210084111.6938-2-tudor.ambarus@microchip.com>
References: <20181210084111.6938-1-tudor.ambarus@microchip.com>
In-Reply-To: <20181210084111.6938-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P190CA0036.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::49) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1971;
 6:sSca5ZRTzULv5an9KHvg6gbEmfqAp0jZxHH17tr/wDTC4IWuCpcR1tHvI9LfJjeXinK589KSD8oGhHbG44HP9spsk59Mqx0Olk4PkVoCoLUVgn8Wrt4Yn9bFLwTGY7qr7wnxNXSIFnFJfYTUCkND5iCC2dIH+xCM1pfboaspXQiRx7JQRv267RjwQdPlIAVX3zBXxfOmuF2Cqv7SJGxpeis6VXnb5waR3DREFBuCaGMTqSXAin853jhmWfUJdzqGxNdFtReXqsKSKIlMiVCkAnWhFUs78WcNcjpFrVmAEAsHNV8zcjTKSNfD0T6rKgLRhbpdZJZI9V8aVp0sz96eC7xfXYBS4FhA4MhcMijg4BSqJRkDL5nl9+izE8jQprWO6JsSBYmXpMTfT/vnYQSyBCeYXZ0UljRp/B1B2bkDNH2wIPIEcwf2mSpNn6Lb2rp2gz7wLo0fQQ+8AsbnAFpG/Q==;
 5:ZeFRW0tvwA8LqutSsbtwLtMNBFgQp+wLxR7i3Fo60YslofrzJSVnVtdgZyzOvxKSgd5Yn3/3/0uxvLYVVunmnKITiHtpCjAvwlAMcGNIcSutFX/L3jMrQlCJNqnzs5txKTsvGfaeW0HbC9SDIY1UvhSXCVsjCdN5Q0l2i/rhjGA=;
 7:+KkSB7GyYW8zBT+E+0IbQWFkB6pcRal1ENV1PqwqxiJ8C/eUaUmXe59cqaYBX9eBvWoDniW1hO4bIDUiFASiz7p1OTJMQw3Z2wzJS12XpGnYtpJtkuZBbm7pj5zv2bdRaTyBt5nuNzvsDZzt+RmJZg==
x-ms-office365-filtering-correlation-id: 117ba36d-2814-48b1-9ef0-08d65e7b4294
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1971; 
x-ms-traffictypediagnostic: BN6PR11MB1971:
x-microsoft-antispam-prvs: <BN6PR11MB197124CA3A38C2FAD1FE20B3F0A50@BN6PR11MB1971.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(3231472)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:BN6PR11MB1971; BCL:0; PCL:0; RULEID:; SRVR:BN6PR11MB1971; 
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(366004)(396003)(346002)(39860400002)(136003)(199004)(189003)(1076002)(4326008)(5640700003)(107886003)(14454004)(26005)(71200400001)(6512007)(25786009)(54906003)(6486002)(71190400001)(97736004)(81156014)(81166006)(36756003)(6116002)(386003)(3846002)(6506007)(102836004)(1730700003)(8676002)(8936002)(99286004)(5660300001)(53936002)(2501003)(2906002)(76176011)(52116002)(305945005)(446003)(316002)(11346002)(476003)(486006)(2616005)(106356001)(14444005)(2351001)(6436002)(186003)(256004)(105586002)(68736007)(478600001)(66066001)(86362001)(7736002)(72206003)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1971;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DVCpc3lJxAO66GOSN9IBeVv/HIEhy24dg/lee8Jj/Dfs7RkZOPX9hzugYBbRayrCWWdHw2fDmhAKhxrubjvf/rbbAENDyjYEncXIWAcLMdTEO2Vyva/AStX8XWpHJ3jvP44Hl5dzjuBC+ier1yDd6qFt7BEDaJI8gibAt0RePqCzU86+j06hp7zIhDqn96j6gQUsGCkwlo8rCZzVyzqkgeLQ+rxxp4fXEKyMgGJcXiaYVEqfvCTxVodgom6dZeESCkWPO3rVm5YA7/DPALd9VzhiDGAAK3EbaovMXq/yOf94gIspUhh6X/rwnRkGyo1C
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 117ba36d-2814-48b1-9ef0-08d65e7b4294
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 08:41:21.3330 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1971
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_004135_130225_BA9E7120 
X-CRM114-Status: GOOD (  12.83  )
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
Cc: alexandre.belloni@bootlin.com, Tudor.Ambarus@microchip.com,
 linux-kernel@vger.kernel.org, Ludovic.Desroches@microchip.com,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The clock-frequency property is not mandatory for the i2c buses. If it's
not present in the device tree, the buses __usually__ assume it's 100kHZ
(see altera, at91, axxia, etc.). Broadcom uses a 375kHZ default
clock-frequency, so the default clock frequency varies from bus to bus.

There are i2c clients that need to know the bus clock frequency in order to
compute their wake token (see atecc508a i2c client).

The clock-frequency value has to be propagated to the i2c clients, otherwise,
if they will not find the i2c bus clock frequency in the device tree, they
will have to make their own assumption of the clock frequency.

Spare the i2c clients of making wrong assumptions of the i2c bus clock
frequency and enable the buses to save their clock frequency in adapter.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
v2: fix typo in R-b tag

 include/linux/i2c.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 65b4eaed1d96..f238da204c49 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -677,6 +677,7 @@ struct i2c_adapter {
 	struct rt_mutex bus_lock;
 	struct rt_mutex mux_lock;
 
+	u32 bus_freq_hz;
 	int timeout;			/* in jiffies */
 	int retries;
 	struct device dev;		/* the adapter device */
-- 
2.9.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
