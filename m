Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DE7C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 02:54:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 622F72177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 02:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uCjCghO4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="UDxyzjDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622F72177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=GTpTYKPi8W0Eds5zGcpGOnwRjH6cy4VcWdEqI4WFurg=; b=uCjCghO4/FjDAf
	8lefc0W5tgr3+z/FbYGWXDyZzKn38xsZHtdTgnVQz+qzFvJnSOk6niP6FBWVrERGT+/46PF6thIeq
	fKxs6AzDu+QvoboAiFB1RJkRy440yPt7J8E86o4iaNlfaddLEmm7da0+xuXzulGEEHJbJLsSzA2Hb
	aAvPYNWWMD5jyHAiCvoL0Ov2nkxoHZVWM2SKDmBZ2L9IeRdKXiNZlpctBtIAc6hrENOW40uMSl30o
	95gzEBTa26yRadd3zMcCNpdsGuo+5KIQBmIAav9UeIMBmGuwRQ2bp4k0ld5SuJKmIijBc1QX/X30e
	M0ahQdtAYPe7D1A1HZaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsImh-00059h-5L; Sat, 09 Feb 2019 02:54:27 +0000
Received: from mail-oln040092254013.outbound.protection.outlook.com
 ([40.92.254.13] helo=APC01-PU1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsIme-00059F-An
 for linux-arm-kernel@lists.infradead.org; Sat, 09 Feb 2019 02:54:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njMj3+4+vkfXLJKSvPza0BleiC+tBKMPb+df3lwKVrs=;
 b=UDxyzjDmpnS8PpEv90XXkS4Tc9wAbFD1Xm2+1JqNnh7wLkO2YO3FcWxDRHoPnPPAOzbo2OHM3hppZFJ0iNCyB/yG5arep7qwIcIZqh1gsdlg4orP7ZniipiQ+PPLoMVx1MhTOzhq4INok+pZd/X+DPzRmw8DVeA8iD5JbVIY30kWoWnJrFHARz7cPTFZNDrpYXwEJvO1o7//6hTTeCKsL5dkOcG64R/zQE6oxrcZY8zdBJquyHLzwGN84SOWyUD+7bxYBGe4LCo7zyvrHdTls8Hv/vExUgvE6v1TmSu8QRjnMYq4cxGl8iKCL5FfEuEo+RVBH+xgboUtNc7Je3esow==
Received: from SG2APC01FT051.eop-APC01.prod.protection.outlook.com
 (10.152.250.57) by SG2APC01HT083.eop-APC01.prod.protection.outlook.com
 (10.152.251.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Sat, 9 Feb
 2019 02:54:19 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com (10.152.250.56) by
 SG2APC01FT051.mail.protection.outlook.com (10.152.251.112) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.10 via Frontend Transport; Sat, 9 Feb 2019 02:54:19 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735]) by HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735%3]) with mapi id 15.20.1601.016; Sat, 9 Feb 2019
 02:54:19 +0000
From: Wen Yang <yellowriver2010@hotmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 3/4] media: s5p-cec: fix possible object reference leak
Thread-Topic: [PATCH 3/4] media: s5p-cec: fix possible object reference leak
Thread-Index: AQHUwCLAheaZAVEnFUOp1LtWme01Tg==
Date: Sat, 9 Feb 2019 02:54:18 +0000
Message-ID: <HK0PR02MB36340E1F3B235BEB13AAE491B26A0@HK0PR02MB3634.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR04CA0060.apcprd04.prod.outlook.com
 (2603:1096:202:14::28) To HK0PR02MB3634.apcprd02.prod.outlook.com
 (2603:1096:203:97::14)
x-incomingtopheadermarker: OriginalChecksum:0E319AC3CE90429C3DF70E6D0EE13D277E3A6DAE1B2B066B4D205BAB69AC6CDE;
 UpperCasedChecksum:6F27B652B68A5345DFE49D685C944B1F1708281AF67F102CC60D9307F592CB87;
 SizeAsReceived:8818; Count:63
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-tmn: [xykGqNlMTvDczQ4y44A0ZRQoYmyEE/bl]
x-microsoft-original-message-id: <1549680698-2318-1-git-send-email-yellowriver2010@hotmail.com>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; SG2APC01HT083;
 6:pHwoRSs5hgTW1qpitm3m58JarUyxdZLSILtsOi0uuivimxN0/qzHwaZ3rAiCsZztsgo8+yR+QDpZf/d5pw/jDxt7ZKqx1hIPOnRCz1dWFeevRd9WS8bxUME6RroYF49QtvS7jV5vcUAYveY+DbiHtLS3nHcfRLyYT+OhNMnJHS1kCNv2rolvFDa2VITTUo8ePKq5nbt5+ft602IKCfLqxXviWok16qan8K40KkFtOXE08dchLfqvljOKHUsdGCjZ6IFBmmr7UeR+2ZGoUGXl8Mz8AQYdIRpJVD8i3tubzXIhEDDn0XBHrIb4+YZ1lmtOOzWfHKZGIIf8iZ+bYiuombl8NL7W8t5kt4Z7T/qXsESRd2raQtzG1DtGsidVgV3CLrSbDFjqayfxyd9d/bL1nDrv9ft3eH5xWeBMqkbaVr6bA94TNkGYQt8cLtWADzL1FPCqbgcUsselW3lOOcN/bg==;
 5:ovJETkmYSLvQXtCyO/Xv1nKwyBQQgXff3Lt+ELq0kjXRzVjckAawNoACkarpbqxS6eBpIKU4mTpWThYnhbq7hG6MGMEwTmpIicCuHbefEUt5FzMU+W/qUYYrqEMO8qvfJDzyuNSd6HYIOqgFfFGdXOK6BHQk72/vlRjEQKJEZO/0LyBs5cLtPLCI7DzYToHZD1APDdRhVSglZHhy1LyiMA==;
 7:BusLt8gYHMj54FGL77iBcnr1PI81Vy39GDZYSV7bAWICzqkmOJKzdpAZ4YgwPdvTReE5YG5fFPM/NJned+MhyrU4VGP2dLsDzOIcSjGVA43CpRvb5JzqyehssqAv7O/AT3lIWXHQaD53U7WGIgPb8Q==
x-incomingheadercount: 63
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: NS9Gj58uCj19rEMMhXpgLo/RKcy6JAK4g+z2m02aM2lnJuVxGXaK8vbbCrG2D6wR0b24dPVw6ngvJCSXfq5BMo2gVeGTwjHMpAffMm0Bj7pK6aMRo1zoTB1t555CETLnkIOuTU+BZKKUQULnVMA9efoa3txgHlCP1wQdnmthXZIZKPVxat4Nbrb7W+V/KgFaJE3rDJ0K9JBqdD8D/85Gf6JGdDZ9yNGemfpdwNpESMTnbK9UwWuYZPFPR/H8PqRA1qGgIdrW4z5OPbOSgFtsWxi3oiZY0XDjJNmLPoFh9eYVUW25XEHPBbv+Hxrr1hlMhQBWjfrbKChsUV/bQy6tvOkFYN8A4wGy2do+bgK7KS0AGsTleEH+fhsFc/i1MHdl9jvfm52IcrZMsTet/crxlfiF9SrV66fN/PE0SOz4RtvYm577jIyXKly8mHhXGzZSiyyBv8TWrrgzRqZRcKxejHRpBFkKydN0trjeebHVk1hGyBGKbfdagNCdwK9aeT7a7BKduNGSfSkDO7ScsbUWFM8iDujlii9bX5aj3oJc+coYQqVKSv/G+PLCuBKU3VOpA+s1U9j6aSH6djKkUTH6E7UmajmNrh681wK035d8K3upy6PAZkGcMvnhTiGIV5iXCV1k6BBQxWObXg4mbdUaF+lTFVwqyPam/vB8d5W4wHDX50PGZ7pjZ1uBkwIl0Obio+2bjnkYC3PDQVYiYuBdKQ==
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
 SRVR:SG2APC01HT083; 
x-ms-traffictypediagnostic: SG2APC01HT083:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:SG2APC01HT083; BCL:0; PCL:0; RULEID:; SRVR:SG2APC01HT083; 
x-microsoft-antispam-message-info: mCeZssTfOBPVU85Auf7cOyVrbDWsA5BKbkiLdDATPDlmLH3eaNmOGTXNypab2PNq
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd38a63-95df-45cf-d151-08d68e39e2af
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2019 02:54:18.1933 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT083
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_185424_377894_F6C75477 
X-CRM114-Status: GOOD (  13.66  )
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
Cc: Wen Yang <yellowriver2010@hotmail.com>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The call to of_parse_phandle() returns a node pointer with refcount
incremented thus it must be explicitly decremented here after the last
usage.
The of_find_device_by_node() takes a reference to the underlying device
structure, we also should release that reference.
This patch fixes those two issues.

Fixes: a93d429b51fb ("[media] s5p-cec: add cec-notifier support, move out of staging")
Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
---
 drivers/media/platform/s5p-cec/s5p_cec.c | 38 ++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/s5p-cec/s5p_cec.c b/drivers/media/platform/s5p-cec/s5p_cec.c
index 8837e26..4af47ce 100644
--- a/drivers/media/platform/s5p-cec/s5p_cec.c
+++ b/drivers/media/platform/s5p-cec/s5p_cec.c
@@ -192,47 +192,64 @@ static int s5p_cec_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 	hdmi_dev = of_find_device_by_node(np);
-	if (hdmi_dev == NULL)
+	if (hdmi_dev == NULL) {
+		of_node_put(np);
 		return -EPROBE_DEFER;
+	}
 
+	of_node_put(np);
 	cec = devm_kzalloc(&pdev->dev, sizeof(*cec), GFP_KERNEL);
-	if (!cec)
+	if (!cec) {
+		put_device(&hdmi_dev->dev);
 		return -ENOMEM;
+	}
 
 	cec->dev = dev;
 
 	cec->irq = platform_get_irq(pdev, 0);
-	if (cec->irq < 0)
+	if (cec->irq < 0) {
+		put_device(&hdmi_dev->dev);
 		return cec->irq;
+	}
 
 	ret = devm_request_threaded_irq(dev, cec->irq, s5p_cec_irq_handler,
 		s5p_cec_irq_handler_thread, 0, pdev->name, cec);
-	if (ret)
+	if (ret) {
+		put_device(&hdmi_dev->dev);
 		return ret;
+	}
 
 	cec->clk = devm_clk_get(dev, "hdmicec");
-	if (IS_ERR(cec->clk))
+	if (IS_ERR(cec->clk)) {
+		put_device(&hdmi_dev->dev);
 		return PTR_ERR(cec->clk);
+	}
 
 	cec->pmu = syscon_regmap_lookup_by_phandle(dev->of_node,
 						 "samsung,syscon-phandle");
-	if (IS_ERR(cec->pmu))
+	if (IS_ERR(cec->pmu)) {
+		put_device(&hdmi_dev->dev);
 		return -EPROBE_DEFER;
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	cec->reg = devm_ioremap_resource(dev, res);
-	if (IS_ERR(cec->reg))
+	if (IS_ERR(cec->reg)) {
+		put_device(&hdmi_dev->dev);
 		return PTR_ERR(cec->reg);
+	}
 
 	cec->notifier = cec_notifier_get(&hdmi_dev->dev);
-	if (cec->notifier == NULL)
+	if (cec->notifier == NULL) {
+		put_device(&hdmi_dev->dev);
 		return -ENOMEM;
+	}
 
 	cec->adap = cec_allocate_adapter(&s5p_cec_adap_ops, cec, CEC_NAME,
 		CEC_CAP_DEFAULTS | (needs_hpd ? CEC_CAP_NEEDS_HPD : 0), 1);
 	ret = PTR_ERR_OR_ZERO(cec->adap);
 	if (ret)
-		return ret;
+		goto err_put_notifier;
 
 	ret = cec_register_adapter(cec->adap, &pdev->dev);
 	if (ret)
@@ -248,6 +265,9 @@ static int s5p_cec_probe(struct platform_device *pdev)
 
 err_delete_adapter:
 	cec_delete_adapter(cec->adap);
+err_put_notifier:
+	cec_notifier_put(cec->notifier);
+	dev_err(&pdev->dev, "CEC controller registration failed\n");
 	return ret;
 }
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
