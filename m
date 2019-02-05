Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE97EC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:20:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65D052083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mqu0nqwB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="tGJP9Wba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D052083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=pJbt2Apt3DkAYcxJDciT5lkb51rFhFKfgBo/c1z48zc=; b=Mqu0nqwB9q95a7
	vmX03Z5culZeB9jETUgMFB2Lrt6Z7BwX2ssvqPIVNBhsvAo0DUYHlqgkvGGhU3E/0yo7jXI4kJAJ6
	VSDZ9seYPRNilIS4N5epMdloySBaspryyy+s2517LVnrQH8vnzBFGtXOppuJP4C1T2sRoiebQoeW6
	sIcyND1wqSb5vbWTRS1x/EdOz2lS/MzaCifS0KS6C0OocuhABcSSR4aYipwTVQ3hxsRRu7witjVsl
	5W/I7qZjByiPaYAfn3NKCv3BqUrmlzl2J5sTLZyOwUQRSKJJtMPU4P1lb3IZbjJxH6CFN+N7LyiQx
	yWSE2Pqp/WqYKKs65bbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqxqA-00054E-KU; Tue, 05 Feb 2019 10:20:30 +0000
Received: from mail-hk2apc01olkn0818.outbound.protection.outlook.com
 ([2a01:111:f400:febc::818]
 helo=APC01-HK2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqxpy-0004vU-Pz; Tue, 05 Feb 2019 10:20:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfj+jJayxxicgLmGKbp8S5bfkRNHMzZjrFwKqW9BCG8=;
 b=tGJP9WbaUlEU41epI3BtPtNIJvnpNVhkB62kv2BlmRcqeYkOCrHI5X0pjekJWFYK6KG/kWOUf0XDYd1lqUPU2eYGVcbP7Mmz3h0qy+g51tl6ucESFTXfPwhf7XXYEY23y0lMZTGraLQT9PikRip80V63/ssIvvD4NjLsgVWUwRbrQEDKuLFnXzMox2RwLGusMYzvEPQwhd8DJksoofN2uErOx0zb+bbzUqDbKGKZ8NSKua9Ej0eEeCuTj1/uJQxAXWmVY4ZWE0G+acXaF4uTdFtA+3rjHyggB8C625ohLQkzgQ8X7CDe2zreQusCRVWv/WeXONXlwF9hPfy5fix6pg==
Received: from HK2APC01FT053.eop-APC01.prod.protection.outlook.com
 (10.152.248.59) by HK2APC01HT156.eop-APC01.prod.protection.outlook.com
 (10.152.248.255) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Tue, 5 Feb
 2019 10:05:46 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com (10.152.248.59) by
 HK2APC01FT053.mail.protection.outlook.com (10.152.249.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Tue, 5 Feb 2019 10:05:46 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735]) by HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735%3]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 10:05:46 +0000
From: wen yang <yellowriver2010@hotmail.com>
To: "xiaolei.li@mediatek.com" <xiaolei.li@mediatek.com>,
 "bbrezillon@kernel.org" <bbrezillon@kernel.org>, "miquel.raynal@bootlin.com"
 <miquel.raynal@bootlin.com>, "richard@nod.at" <richard@nod.at>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "computersforpeace@gmail.com"
 <computersforpeace@gmail.com>, "marek.vasut@gmail.com"
 <marek.vasut@gmail.com>
Subject: [PATCH] mtd: rawnand: mtk: fix object reference leaks in mtk_ecc_get
Thread-Topic: [PATCH] mtd: rawnand: mtk: fix object reference leaks in
 mtk_ecc_get
Thread-Index: AQHUvTpcgk0GGSTopEWAqFwy/qe0ng==
Date: Tue, 5 Feb 2019 10:05:46 +0000
Message-ID: <HK0PR02MB36345BDC344D1A6FE77B4576B26E0@HK0PR02MB3634.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:a03:74::40) To HK0PR02MB3634.apcprd02.prod.outlook.com
 (2603:1096:203:97::14)
x-incomingtopheadermarker: OriginalChecksum:885F2515CCC5ACF4577544D00C6ACB530656D87FB39CBED03E0496C3A69F267F;
 UpperCasedChecksum:163C92EFA9364B480C9327502F766FF0B7B2D26326D0F0095006614B71F08329;
 SizeAsReceived:9207; Count:63
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-tmn: [j6wsPK5VJVoYRyvH0IZTOxWwAKv+7F5H]
x-microsoft-original-message-id: <1549360963-32387-1-git-send-email-yellowriver2010@hotmail.com>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HK2APC01HT156;
 6:upoEE1Ykh6Ih2+Y4VdFqln30KkdBTiGYuX5td18IDIEnqUo3J8L6sCwSq60J60EhQBRTk1OswePlzp5X4hY+jcQNIURKYs2EaqFzRjx0eTIuQEQVeGvcdvrkE4hvvLvL3Ltzu8OtbpgyVIUjq+ZBJUOsiqZ5ag6CbYAvZF5zrPGY9s6XaoPqGF/0nSJUYGo03A3XnNZcPmsHHvkgo4k6diocOgvqoRm7X9cJHdPt7cP9lmuXgyucJGFMSYZInM4/UlDz4/BMmrJghfaRiMhnlXrFfYuqFaHzSqFBWf73VIQguMsfMmDSOAx7v0I/L0RepEkQdegBoG9UJJA8Tm+3CDmt38kCOthv6UTniN531wnUYFfQVTnof5WfY/qpbLRKmqm2JomSrZ92bH8BGlja0y1boTdwGwjErwbMwzu7knG0TfRnCITw4Lqj8l4Xk0HQVRsXtLB2Mn6+twpR/Ldq4g==;
 5:62vINVlDS8nuQaqyYF/+hp4E6S69QX1RtKCKe9ggKMrpwj8gmAkJ3v790B7VWv1ZoGXMnl1mz2t70lhs8Pukot9hmO/0n9OMp/dx/omH5WHlZo6ZeZFE1iKo+UJhBpzFevBGajVAnznjy9Hf1iZ+IcllSe8+t0X8DjKWUgOrDnesAYqjqtPNPFRSACdTgEBhU6dXWXD+jQlurmNn+F5RkQ==;
 7:f+vdR5zFj6atmR3e4hYaBsivft+gMeHvIIcxbP1MbNxroSq9E3MzRNwA8l+t7K52uR4HlqFNIoDS77FdD5phRcHb1RqRQADHk5T7fNznEOANRzdu9+CXnhPxEXnpWR2z1wMYLUrZ8HKlL9bcdL6yqQ==
x-incomingheadercount: 63
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: 7MJMDUNTCtyrRYFWDI6RhBZbjdSntUejTzf/lYeAY0uoIgxkR4i4MwrU4Ag0BcbTKV5S9Wo2UN1qctTwdsFbgmiaLmh1ejY3dD+/oa5prfbPxHFm0BAO079/sHqK/KUpiH5J9Y0/Mkk4vwevxU7Vc8Ryq/bkT6ggqmGoCGqbEUJAV3OothjDbEphMAyuEGNVy0Wwmd5nzS4TC5Li2iBkxRKVFr3DmLGNe5ZsOVgAHklB9AfBAkA1g+xmHUhx+lmRH31HMEqm9P6pXe4dI01YLKvJ1C3ZzozXGRVC9OORs0yHiEw7pKE6BOwTsZooP+vHI0SSGDwTN4PE4mKmBWpdIPYj5sOcU7z3/TtSz1VawF1hJHi2FvxjyqZsQX8bH38WGufyJA/+0GKN56GWjQPxbIXQlrTA4AmKsssD6f7KY/42aGhLgK9ZEHmZdj2sZGYnUrteyOZQqqAXfvHchrbLu0W+K8W2HBATzcIA8mVsOdlJWwp9wNrT6GrClCEh+0uMqN6PBEGyjVpdbrvSdMd9M4BMDiumFUTes17BqBtTwhdnOrSPFxSuFK8AOJAcCGdqISFJNnhvZrzN0mf5/Ll8jtm8FOAf69Tbk4mWwud4wSWA3TelvDalbB7qVIwTABDkHgWY8SKgrWp30tGMpvkIv3PtDNjiS+YXD5i/DRV6VQo6EF1IgyYI5iCT3q7EDU8GYibgYeYMAvlYyZ4S+7wkcz9QZl1IXpUqsCILP/RhsS3t6Oxv5IsTJA==
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
 SRVR:HK2APC01HT156; 
x-ms-traffictypediagnostic: HK2APC01HT156:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:HK2APC01HT156; BCL:0; PCL:0; RULEID:; SRVR:HK2APC01HT156; 
x-microsoft-antispam-message-info: V8Z2eOIsKHRUA/Uz46+TYSIBjYLb5HKclp1cLuXd/owaiEi2bdEr08aSIRkjV1j9
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-Network-Message-Id: 69afa0ad-2c1d-4d02-c921-08d68b517ecd
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 10:05:39.7293 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT156
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_022018_902576_CE88CC38 
X-CRM114-Status: GOOD (  14.74  )
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
Cc: wen yang <yellowriver2010@hotmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

of_find_device_by_node() takes a reference to the struct device
when it finds a match via get_device, there is no need to call
get_device() twice.
We also should make sure to drop the reference to the device
taken by of_find_device_by_node() on driver unbind.

Fixes: 1d6b1e464950 ("mtd: mediatek: driver for MTK Smart Device")
Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
Suggested-by: Boris Brezillon <bbrezillon@kernel.org>
Cc: Xiaolei Li <xiaolei.li@mediatek.com>
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/mtd/nand/raw/mtk_ecc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/mtk_ecc.c b/drivers/mtd/nand/raw/mtk_ecc.c
index 6432bd7..25bdc15 100644
--- a/drivers/mtd/nand/raw/mtk_ecc.c
+++ b/drivers/mtd/nand/raw/mtk_ecc.c
@@ -265,17 +265,25 @@ static struct mtk_ecc *mtk_ecc_get(struct device_node *np)
 {
 	struct platform_device *pdev;
 	struct mtk_ecc *ecc;
+	int ret;
 
 	pdev = of_find_device_by_node(np);
-	if (!pdev || !platform_get_drvdata(pdev))
+	if (!pdev)
 		return ERR_PTR(-EPROBE_DEFER);
+	if (!platform_get_drvdata(pdev)) {
+		ret = -EPROBE_DEFER;
+		goto err_put_device;
+	}
 
-	get_device(&pdev->dev);
 	ecc = platform_get_drvdata(pdev);
 	clk_prepare_enable(ecc->clk);
 	mtk_ecc_hw_init(ecc);
 
 	return ecc;
+
+err_put_device:
+	put_device(&pdev->dev);
+	return ERR_PTR(ret);
 }
 
 struct mtk_ecc *of_mtk_ecc_get(struct device_node *of_node)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
