Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1EEC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 05:37:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 818A421773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 05:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dde8NHRk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="EzNTl8J/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818A421773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=BhXQbmhaCLKgZC3JD/0gAihy4wnsTyCBoK0NXD1/tSA=; b=Dde8NHRktFcdoO
	sEzpP6o3Ny3Cp+fFwXzTfpSeYTal51wJ1yBUbvrbP+fxj5m84ZscdIRYXVDsrLnEqRBPOHY/k9drZ
	FcCIn5ai5+nakBevFHEYNd0BH0+I9MQRkytQpgl+TECUPO7M491cLRn7afYzXB56CwlYnmjYB6GQ5
	A1yjFcTgnANU+dLRQBcfwx9lzZnelHd0I6J4KLsAmobGdGs189gtaRuclM42ZHutgYU+UZ+xW+CUi
	6m1WIFFw/cefw3X67aDqNkyPIHe09Ge0g8yLfp2RLPctNan6W4KT7hHlBYVeLzQ+0voW4d7sHM2P5
	AY+DxB2X882WiweMMsIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqASo-0002GK-B3; Sun, 03 Feb 2019 05:37:06 +0000
Received: from mail-oln040092254026.outbound.protection.outlook.com
 ([40.92.254.26] helo=APC01-PU1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqASk-0002Fy-FT; Sun, 03 Feb 2019 05:37:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZqVZbj0SEKj6UgcjhrsNS98VRIx4dPUpP79Nah3Pro=;
 b=EzNTl8J/wlnkFufVNQQYtyCiAFk+cYdOqBJTzA3jMPCiVTGI528XRmuVrXv+XjZgkgwuJRUnvJScmUy0dES4WrK7YAiCsS/+EfLCMpSB/YaU8SfGDa+64VZ1qBKwc+JHhW/+Rna/X4C3pj/EEobe2Y8SWpa0hlR25fUKmfNiIspqVQxTI86eZng+t3cGXoqWrWuOVPPtKmeDdDb+qcPjVswdmle+4uKo/kit921H/eXYvZ6wUnGh3lx5LhXoA+gY1ZrLuuAvGXtcWQ384ybw9Rx0Riz0tvBXx5/3JxDzuZ1l8BxA3boBt603Qm8aL7s68mLC3U/5k3qeI+f2k+gdRA==
Received: from PU1APC01FT052.eop-APC01.prod.protection.outlook.com
 (10.152.252.56) by PU1APC01HT197.eop-APC01.prod.protection.outlook.com
 (10.152.253.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1580.10; Sun, 3 Feb
 2019 05:36:57 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com (10.152.252.52) by
 PU1APC01FT052.mail.protection.outlook.com (10.152.253.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.10 via Frontend Transport; Sun, 3 Feb 2019 05:36:56 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735]) by HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735%3]) with mapi id 15.20.1580.019; Sun, 3 Feb 2019
 05:36:56 +0000
From: wen yang <yellowriver2010@hotmail.com>
To: "khilman@baylibre.com" <khilman@baylibre.com>
Subject: [PATCH] soc: amlogic: add missing of_node_put()
Thread-Topic: [PATCH] soc: amlogic: add missing of_node_put()
Thread-Index: AQHUu4J5Yp1eBC0MTkqqCRtUmrbz0Q==
Date: Sun, 3 Feb 2019 05:36:56 +0000
Message-ID: <HK0PR02MB3634702E1ABA268C57E70BFDB26C0@HK0PR02MB3634.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2P15301CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::26) To HK0PR02MB3634.apcprd02.prod.outlook.com
 (2603:1096:203:97::14)
x-incomingtopheadermarker: OriginalChecksum:5FCD8FF340D0DF9885E9810110C8BBB32B0790E603B588B95FEDAA0F5C573ABC;
 UpperCasedChecksum:38C40C03BF34C453574BA0C16DCA7C347988D9D35EB2348897415F165CB1E972;
 SizeAsReceived:8640; Count:63
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-tmn: [jK9iFNbZsK8sHSca7gcaRUm44JiPUSOX]
x-microsoft-original-message-id: <1549172041-6388-1-git-send-email-yellowriver2010@hotmail.com>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; PU1APC01HT197;
 6:fg7qfgXsC/PDjtjTK7gumqgSID2NV+3g+woMCyaq/9zU/1U99pn3t2gi6oB7XGP6Rv3AZDQ9+N5Stszf1ZpXFX8Slsvs/Owh+S7ZK3xN/f4IjntO6gDxiYZP8FFtMCvcJ920iUg6Xqblw1PzN9xJrWLxe5gpOqGf2MtRGkRoKP1VGrd9noHND4rdzak+LKGFvfPk5Tj6QcNHRXNHFdbvSnv+7eFqvJ5gbA4SVw374K3F7F+UNreqlxC//ToVFKiJGwrswJrlzg2Mbfx8vy/xmTGzCBilJI6juClHFkDhbvIgIYWuhmKG5VxBdNkbjoQMZ4Q8qZcS8PiSWOQlZmdkgn79+JW2sxVQJQkhE5HUvTAINP8+Arftkmn1XND3wOaB0UeBktHK0Bw3PSkFAqVhemQdJcUWbxuunvz4VubqOqKD4ddIH0pWtQZI2wpM17XwSnElCHO1XUjDTEBSuQh4CA==;
 5:1d90kyMWSUVc+Pr8qeDs70Wmq9buv6+U5+kIj3tUpW8C6nrMxFBKZgzzKdmXDipoEBfhsinJ7ibyGwWq+mq3d192YmNJIbb8NBBgq2L70M7XJULM4QcXjFYainZaLM11nWmtnQu5gKQaGziLCDrH5GJoMBC5V6SiAcJsUZK1DGRebrErOXSS2emdD2NE0qLbrZsiQSOzzENgAv8Jx1/+sw==;
 7:u5ulHIQd6Dxtl2X2cItPKtw6n0pLArOad5gaN98IUfRivdPSfJz1sHIAbowjctpRdSWt2FEgk3L0wmsLesdzKLpYJauZQR5q8QdkmMGNSvZ+EeKGUwsl+C0pr0kQmUE7XkWTCFCpWHofU+Vge1/XUw==
x-incomingheadercount: 63
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: mBRmoEB1kyIUYo47VCffFdKtv5fcRcaCpUYkfU4DO/egScvCvIOzBLo9iALJP5PAI3lCC1NRyJr2eJIkJen0deoDCWq2xkR6Ust/l/kmGNZeuvKPazmSslPE0Gb9q1UnS8OaSjRE9hJZdqVvOI9xZNAygVvi0rYgxBcOaJnOuZmCrFpjSX41IMujdFP81sDtiAYBrhQsiF/4spYqFi7gWsDA/4YkJ0KO3v3OywZzWwDIHRYdsPeJbplPovljeq4H3wR007vZw9u8i4ljUvogYwJ3r6IDXtuYxO3Oco00MlcrMVixFmX0RypGtRKlll5MvXlHy81vlXiC1PYr56rhXI0goe1JxbA3eVZCvsOVrZOLuwOSGIy0pvMWkTPT8RDB4zAJjr9m9/INMg0EQ3EgI2A4IofXBoFkZ65JORBrIBND/HY4G11yU+mWkwJCdW9ut4tBKE1ysAMWIAsmfWFvpRJM8h53+ZEb0XztVWVf1VnuZiUzmOQ570pohDIJ9UzFG9+peuMgqYHDyEAp+IBhE4lU4vM1msWn2kJgE/KfYPL3SBABhj5qxQWd3FTG2VshT52B5b2X2qebZWulP7y9B0ZazJJJ8lGzMfP2nr6eBntuzCSopD31TUXMnCgw/Hl7p1KrwpODgToRP9SnpeNlw71T+Pkv6XuPB43CPese5LSSMRGVZs3rXC9XXJbLvrfru1Xz1Wxb5ZVvM4Dd/3aiyXT7bkjnli4SRmA8EmpJVhEJOdcfOXJveV9L4aiCN4U3/qfAtA1MRtI=
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
 SRVR:PU1APC01HT197; 
x-ms-traffictypediagnostic: PU1APC01HT197:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:PU1APC01HT197; BCL:0; PCL:0; RULEID:; SRVR:PU1APC01HT197; 
x-microsoft-antispam-message-info: YAlyTbfowIWHLRsUzQM/X6krXthm68q00k4dacWE8wqGjgYEKkeQ9xrQnilP8AVe
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-Network-Message-Id: 344cd704-89f2-425a-3436-08d689999bbf
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2019 05:36:55.2272 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT197
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_213702_613134_C1632F52 
X-CRM114-Status: UNSURE (   9.38  )
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
Cc: "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 wen yang <yellowriver2010@hotmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The call to of_find_node_by_name returns a node pointer with refcount
incremented thus it must be explicitly decremented here after the last
usage.

Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/soc/amlogic/meson-canvas.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/amlogic/meson-canvas.c b/drivers/soc/amlogic/meson-canvas.c
index fce33ca..87a6c6e 100644
--- a/drivers/soc/amlogic/meson-canvas.c
+++ b/drivers/soc/amlogic/meson-canvas.c
@@ -57,9 +57,12 @@ struct meson_canvas *meson_canvas_get(struct device *dev)
 		return ERR_PTR(-ENODEV);
 
 	canvas_pdev = of_find_device_by_node(canvas_node);
-	if (!canvas_pdev)
+	if (!canvas_pdev) {
+		of_node_put(canvas_node);
 		return ERR_PTR(-EPROBE_DEFER);
+	}
 
+	of_node_put(canvas_node);
 	return dev_get_drvdata(&canvas_pdev->dev);
 }
 EXPORT_SYMBOL_GPL(meson_canvas_get);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
