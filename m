Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643B3C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 03:52:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D69A2070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 03:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JMCUY2pG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="mL/+QJPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D69A2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=fiMZNXsT1pdz5WbZpkVVLnPKmcGWHuNdKO/pOPubAZc=; b=JMCUY2pGSGA5ig
	TqzTH90pYy9jcuR5q/LZY/qMcZ93l+0sFonUME8Hhmz6U1VCfkW96Jc5Pv3Nt9gXaT75QpFfSOYj5
	O1sswIHZnsEP6bJ9YJ73g7m53h6sHgj0bMyv2tNL6VCGLPn7ltFRyCW6dOesFxY3jGJO5xYTxZJF9
	+xobLfvrIBOj3GFkJH4MtEtjKiMtONz6q/POJdOkmI1j4U22I9UKgjDdd2ku8x7zgjgihIz/tcMhq
	KmReukbw+lmDuckuEuZQ5KSO02AQpktJGhfsGuNrsJIPjYITrZZD/Qp8g4HiReY2IP+S3QnphZegG
	q0j3Fe5CVOve0lGNUm8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gq8pj-0005UY-LW; Sun, 03 Feb 2019 03:52:39 +0000
Received: from mail-oln040092255028.outbound.protection.outlook.com
 ([40.92.255.28] helo=APC01-HK2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gq8pg-0005UC-6x
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 03:52:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5WY9yrwV97r2vv+oe7/ckTZY7afW3LsIO5r9s+RRi4=;
 b=mL/+QJPySgZgI99dTQRffNt2MxqnYbzJwIzSBNqH0LiMLQeAPn5cifUdq4YXGk5R+8EyKkFsju+mTTjKQOyBDEqHgHEaAWz6z6hlRCTM6YzIxtqJ4fFoLvRcWa2ZMHoBorf5Ruh3d50otJvcgstOwgZdXgBjqlkv9AhGDv0ytnCxnu7WLMnzakPsX+iGoAdB9HSd6Lu/fxAhPSZsYt2UuGF/pucW60GzBNVkvVH+PccHvw7F5Paltz/bigjPAa9yaqc2Xn6Y6IN3stNynGhW4NvQfdS/xqUTRnRXBfESR05khiL5MWWDuwgmfPgy4Ms7H3evI2qqe97AL2SQvxdhyw==
Received: from HK2APC01FT054.eop-APC01.prod.protection.outlook.com
 (10.152.248.58) by HK2APC01HT114.eop-APC01.prod.protection.outlook.com
 (10.152.248.252) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Sun, 3 Feb
 2019 03:52:28 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com (10.152.248.59) by
 HK2APC01FT054.mail.protection.outlook.com (10.152.249.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Sun, 3 Feb 2019 03:52:28 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735]) by HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735%3]) with mapi id 15.20.1580.019; Sun, 3 Feb 2019
 03:52:28 +0000
From: wen yang <yellowriver2010@hotmail.com>
To: "patrice.chotard@st.com" <patrice.chotard@st.com>, "balbi@kernel.org"
 <balbi@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: [PATCH] USB: dwc3: add missing of_node_put()
Thread-Topic: [PATCH] USB: dwc3: add missing of_node_put()
Thread-Index: AQHUu3PhlWt5p92k+kmajluToxxENA==
Date: Sun, 3 Feb 2019 03:52:28 +0000
Message-ID: <HK0PR02MB363451C20715075F224345CEB26C0@HK0PR02MB3634.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0013.apcprd03.prod.outlook.com
 (2603:1096:203:2e::25) To HK0PR02MB3634.apcprd02.prod.outlook.com
 (2603:1096:203:97::14)
x-incomingtopheadermarker: OriginalChecksum:4B0C4158F1F5572DE76D239EF237FE4BD5F8FC2A60CF99322327FAC834F8196A;
 UpperCasedChecksum:5A61A3FF347627ED93842AEF4D916034F6BDE0A119FDD70D0A93185A8A832723;
 SizeAsReceived:8753; Count:63
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-tmn: [dEl/RVCDbO9c0PADjphFWcjLNtbeOZv0]
x-microsoft-original-message-id: <1549165763-16818-1-git-send-email-yellowriver2010@hotmail.com>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HK2APC01HT114;
 6:k2zPKcU+rksmd6dzY8XTnnEAqemHzWr32VC1XafDPQhyr5DKm2zpoH5NAsF+q/D4SRELVYXPZRznm6xqI1H565vtfmC/XsDcth+K3njoXlaHiqEiBUtiwkJ5yUZyUgcabYPPYvuDIoiEpOc2HA0HodnliI1FlBemtSN4Cj01nGbnJAoQa22UcozRMIsyTSVz0wFqgNhRHlJ0oeuvntHhF8jIzHkY6FvRQuuTzLT2yMsqGzaJyUUw0Ru0mDSJmHLXX5uTi/3LUuN7qm0sqeQQmiDdCxBsXmJTqtbx61qCze3Ky9cGXvLa9lczXdDmDaImWng/9vTX01JIQKpBXgayMkbqV8cwJAMehGdRi2J0vumlAmRKs1uo7m/TUw6KSWXKmHvxx6jHIRxXXBv3myIfvlCHITswzgg57bj4dG5GjyhGy+0kyokYhjglnuREadWoHUcJ1XtoJldmhR2q1jbfRg==;
 5:kuinJR95i+gAZeVIfvaGROo5uyxw2DpX87uT0+VtdlszzjxQZbzUzrL+i/yy8t9/0NYiKkQJ3WWrhrpHa3ns+nQLi5cfGXUpw02LDsMSSiJpXm9PNn6QIeHWCiSOp9ZfGHnNZFN15ZacZYRjsxI6aR9AKfNaDHPheO0Hsh0UpQXpWKoEtYelpanB4DSk5z2o3+3DrkqUf04VLiS2LnsNDA==;
 7:p6xmLV2btUstxXkjWp16ejzfyuQVLG9WFfJ3Tixn7zAZKGJVWLAjA+IfKskh/blOo+7rRXM80WrjqndevWUvQa0EXfwWPbx2c909xnj5yIylU/kNILmFGeAEd3yp5Pc0t5NwYMCSRJfxRC24HZ0wYA==
x-incomingheadercount: 63
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: 79Jo46q8hhA6wMGiks2f2Kn1jtsGnFIo+ZGzvLt9cauP32n19Vj1xnpaJjpSI2XtL15NjOxrsCvoBHm2nXBN+Y85g+is1qwl3YjxDtXmtSDA2VHex1/Vmddrne6ThlrO3qbH9LosIoDg1YchzbbsKPuRjOwRvlDRJsSSr6mLYxw58LTDEuuzSPYzIF6AgRJAEJRa98OKSpWwKwrN0nHSZobKi8Ta1ADFxGqzPAND9Q6JOh2NjO8HZcof5ASEJ2xkd/88InbUHFIRP2CXEDBjYqLtJbhYTBdwP3GqK55CpBGhusFFm+fIJyFSOpPyVvFvQqtkPGSvqU9pZp8WNHBo8V71zL4RPspH8yCs62EyEFoC5a/JFWnEbID2FoGu0jLRsui5mgtBH8TW7r08G1x/QNEsatFO8imW7SUgOy1+xDeVZTEoH8Etm220LycxODOR09HFkAE2BtxJ7S/QB4zUKBuhJYcSIt6qSizPUUXlfkm7sr2KQ7fm5gJcQcJD1Xd5QopVT7YBjK0QVv6PtSO//gqQfJh6wo1WxmBIhubtnfRk7aNIQE+zMtnG+nCiN2b8KU1O7N+mFX/pKi8ufefdaK4GlA1uEgY6IWZmCkqjDV6m3IxExsy1MW8jirbT8pcMu7BZ+u/AgUtknyUJUR6grwsjDaIuuWSt6dEfvQNy4Z6fJeNf9JDxIlortHfMl+vE
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
 SRVR:HK2APC01HT114; 
x-ms-traffictypediagnostic: HK2APC01HT114:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:HK2APC01HT114; BCL:0; PCL:0; RULEID:; SRVR:HK2APC01HT114; 
x-microsoft-antispam-message-info: a1lt9l8xFCYDGddQeVLa91D4jzwldswxr1CGYK0i7QggQxCG/AKX3WUapYM4ht2X
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e8b43e-dc38-40d6-2cb9-08d6898b03bc
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2019 03:52:26.7171 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT114
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_195236_348364_302648FE 
X-CRM114-Status: GOOD (  10.81  )
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
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The call to of_find_node_by_name returns a node pointer with refcount
incremented thus it must be explicitly decremented here after the last
usage.
The of_find_device_by_node() takes a reference to the underlying device
structure, we also should release that reference.
This patch fixes those 2 issues.

Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/usb/dwc3/dwc3-st.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
index 1608138..fdd90d2 100644
--- a/drivers/usb/dwc3/dwc3-st.c
+++ b/drivers/usb/dwc3/dwc3-st.c
@@ -262,17 +262,18 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	ret = of_platform_populate(node, NULL, NULL, dev);
 	if (ret) {
 		dev_err(dev, "failed to add dwc3 core\n");
-		goto undo_softreset;
+		goto put_node;
 	}
 
 	child_pdev = of_find_device_by_node(child);
 	if (!child_pdev) {
 		dev_err(dev, "failed to find dwc3 core device\n");
 		ret = -ENODEV;
-		goto undo_softreset;
+		goto put_node;
 	}
 
 	dwc3_data->dr_mode = usb_get_dr_mode(&child_pdev->dev);
+	put_device(&child_pdev->dev);
 
 	/*
 	 * Configure the USB port as device or host according to the static
@@ -283,15 +284,18 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	ret = st_dwc3_drd_init(dwc3_data);
 	if (ret) {
 		dev_err(dev, "drd initialisation failed\n");
-		goto undo_softreset;
+		goto put_node;
 	}
 
 	/* ST glue logic init */
 	st_dwc3_init(dwc3_data);
 
 	platform_set_drvdata(pdev, dwc3_data);
+	of_node_put(child);
 	return 0;
 
+put_node:
+	of_node_put(child);
 undo_softreset:
 	reset_control_assert(dwc3_data->rstc_rst);
 undo_powerdown:
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
