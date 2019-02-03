Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51790C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 05:41:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E66B2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 05:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CrSi39fI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="MPRXyUV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E66B2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=DmSQzZAgq2JOac/J4k+qThEItFeHR1eo4hy81UP7OMg=; b=CrSi39fIrwaBLT
	it3/TeSarmkaCFaB97Kdg3aOCjCb9vzILZA992pmWwZ5gC+9wxOtwz7b2pwq2T9bKeOxnOyeaZr6W
	lVXfriKI9eJzMTPeUBF2UOjXQlhyDF2KNbAJADaL6v5KPuX0E4jCdVTF0bvh+kl1XaQpMlCVqQvSw
	d5gdSC8xF8rBlVjtyYMEPLWo+4Qr6Ujtns12NoH0MJL14BltSLxZ5SqrIjfTIpFWBv6qSiXnF3kKi
	B67nGALdQdFc7rY6jbaSDaukh3vOz5rMjLp5NM8QEhlgMfIRvMY4UDp3Gmr65r+vswdMyCMqFzTKS
	O3nAuCTUGRlQ6rTSLhyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqAX7-0003vz-Ob; Sun, 03 Feb 2019 05:41:33 +0000
Received: from mail-oln040092255075.outbound.protection.outlook.com
 ([40.92.255.75] helo=APC01-HK2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqAX5-0003va-0f; Sun, 03 Feb 2019 05:41:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=At2cY9lCMfKnMwboHUEVK8QXiutkhaUte/pT8vvS8vc=;
 b=MPRXyUV7PwR/gK/jcGGmLXJp7RYYDcHE02U9FttbjoWHa/mkO/jM80KGnbT31HHvPH1NWvlCC9JqQbA0RvySmKNhjWFBxygfqnHmX2+am5hzMJ+LhF5jCxL6S6WeamZqutRz8cCHVaPMAhPjGKEM8814t96zeFvEIYC7qtjU5lRCZ8hoCUtUvAM2TvvqrLQzbyzcqEl5HD4nr/6mn6Z5rLmqggrN85+8zc/b6Tz2s5fbNjzAAuwsHpKVF9C8IckFEmV0V+TWcXIykmLmxlJC+0HkB7Ja2MsIdOmXp0W2s3/iEu42j5G9l46iChJVnWVu47m9o7u0Nl9uOocu4EHTjw==
Received: from PU1APC01FT052.eop-APC01.prod.protection.outlook.com
 (10.152.252.51) by PU1APC01HT008.eop-APC01.prod.protection.outlook.com
 (10.152.252.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Sun, 3 Feb
 2019 05:41:25 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com (10.152.252.52) by
 PU1APC01FT052.mail.protection.outlook.com (10.152.253.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.10 via Frontend Transport; Sun, 3 Feb 2019 05:41:25 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735]) by HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735%3]) with mapi id 15.20.1580.019; Sun, 3 Feb 2019
 05:41:25 +0000
From: wen yang <yellowriver2010@hotmail.com>
To: "khilman@baylibre.com" <khilman@baylibre.com>
Subject: [RESEND PATCH] soc: amlogic: add missing of_node_put()
Thread-Topic: [RESEND PATCH] soc: amlogic: add missing of_node_put()
Thread-Index: AQHUu4MadwEf7ebhMUW9TPdpzWWDrw==
Date: Sun, 3 Feb 2019 05:41:25 +0000
Message-ID: <HK0PR02MB3634BF379E6F17F7FC82906BB26C0@HK0PR02MB3634.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::20) To HK0PR02MB3634.apcprd02.prod.outlook.com
 (2603:1096:203:97::14)
x-incomingtopheadermarker: OriginalChecksum:FA6FDDE675ABF2F7FA824DF4D970CD7711D99921CC34D64E17DC8C76295E6EBB;
 UpperCasedChecksum:9F975FF06900F81F70D78D0AE4A7DA9649465E5DE30E4BC17ED54CF77B10722E;
 SizeAsReceived:8655; Count:63
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-tmn: [6W36GddR9ssEDqfNf9p1AJuJwrMnsbYM]
x-microsoft-original-message-id: <1549172315-6683-1-git-send-email-yellowriver2010@hotmail.com>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; PU1APC01HT008;
 6:za1cxJJueFgc3iVHxpBrpuSNJmIOLF0x4lPmruOEjUsLidyiCHjMn4SNU+2EuJlzH6rNBbo44XHbQIfKnnMxP28cHsWSXnWObJnLEakh1VIT3zbXqWEDxDDB2+ugKvUCCUtFytJVxLJPehnkdYkLZbW5s01cbZQ8d6L0M0IlaWaqVJ8zKTJNXYWxHFl1AgOu+mgFEmS245bkYgrV32nfL0bLk676u9wLvU07tpgVG6l1w5X3BWnckHYYUIVUcuowc7E9+pLRdJDKFaCCJ25Q2DeiIQRYRQDSuUEDykE700/w1oxULKb1QltTp6yHTvkeIc0UhGp+ytnbREcpYck1EwBsGXIiN65lb+PvtshuRFAMavmiSpzCI1q37UlFn3Y2Gl6g58GtbuPkn/kbHGwrnqzzJI9pH8NGgNWIUVK+WQbQExerFg+hQ1IncNYgnoflC4igcPooLxPbZJIJALi8Aw==;
 5:B52/kwUT7XxMGZ5K1Q1vCp2njs154h/OrXG0MvHesOTC5AOXAAzxd3BVNgSw7sI/j2iTxAD127QJl07G7wYKndjuTlG0FrDW+vtpYqkEsFk3vujbnSUp1WSegqlByHd+r6oLKqKWPPC7o+iwqdyiFBEoY2zd2wiXo2shWTAc8lx8rIEgQY20c5uW6UdkFQMmLNuWef6iH2oIhbJARZx6/w==;
 7:m/pusGS1/rc8sCdsghQbHCTRZfoKiSVgyPXmI1D+CE6P/WighupHv78TbyGe6CFY+B2OS/hsm0gIt+UEyx51y1qedv4IYgr43NtQWX/a9iICsoB+o/q0jwsBbSaNmYIzAjzBXbjBKCwp8dbsj6mZJg==
x-incomingheadercount: 63
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: S/btQ8cKWiQqoVwXX3ck2v8S52F+JOpJSR1zu4YvCnw1MHcmYyLS+dm4/7ucc9sHNX7OiS/0aBC27QDsSnfqS6nqxhqdRqBllFwoOSesPOpswMZPaZWvaRo9k/j6MVqyAaXdqXdd47VngMd4rjYoYLlqSjALqT5YCZOj9oS4Jk1IvTkoEOo3vRX403O1Kwj7xWrVZlM3OPFplWZh3GOTF2TRCBt9EOcCJ+2YsGbxWjbYZ7O1enZKC9Elq4s+X/+rxVb0+sGZNjiHronAfMIuI7jfgAEmJPhvAMPunCcx/A5WDxm1hdgqEud09oZodMnJGq8UHmdV/1/NC0bS5RxpkFeFBgULiG2CEPQY9txejP0tPqh8/FRee5Z2idb5hYdMA5JpRaQK6B7P5mUUc8o7IX5IsvmP7s42E+Uatd/Vao72H6hWXwam9Dob+Zw0PJGcplGC+gRlV39ilZ/ZZPhZa9Pd8KF/E+CP6gFOGhLWer/dJFyHBIOilS+fqEBR/+gyC8xaEC+C5Slg07S20tURTV2O/bjaVz7eACKp4HEem4LeZdCFwNiLvpBkru1VLt3P+R9za2IXWjQsq18EUqpZGqQZgwBr54A0Uz5Z3WuOBNxKdIWl4ZFjY6ovAzRKclE2crT4czSPM+jRgJXZG0/JRTZQwcAzE0wulQL8u2sIqHfwAOKTCL2VRTtwKRjjGGyCDyFVFjSw6mcYD9kHcRW+MTcbJQeitRj3wHjJPeBYwGckFaNkd2yGoXYFQn1KQ20O6nbNI6aLvYI=
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(20181119070)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
 SRVR:PU1APC01HT008; 
x-ms-traffictypediagnostic: PU1APC01HT008:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:PU1APC01HT008; BCL:0; PCL:0; RULEID:; SRVR:PU1APC01HT008; 
x-microsoft-antispam-message-info: bOXI2y5s2Wrrp7f1NBXFiYzpwUKrBx0hdqNK8qaQkUDpTkyk9bhaOL+CgSmfjbjz
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c2d972-c09c-4978-e7d1-08d6899a3c88
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2019 05:41:22.6639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT008
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_214131_076114_C72B6F88 
X-CRM114-Status: UNSURE (   8.63  )
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

The call to of_parse_phandle returns a node pointer with refcount
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
