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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98858C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 05:23:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60A7120844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 05:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uotMT1l3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="quPeJLPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A7120844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=1QHWbDAvFpsGFXK5qDNJuzNdf7eHTWPRMH0H5YInkng=; b=uotMT1l3ZKodAx
	ga2cd2S3g8YWIGHb+fIuuUSyraL8VfefFLUMFTQlMgbdWQP3th4DBnDtHZ688arC92Xn6gsTWS0qS
	yg2BaIhWHUl8lIR52sGeKzwPosNoIagryN9jRx6/cwaaU7/oylv+9EL+zFIKstflbCJYdMYpej7lb
	rrE8INEgwQbpDyB8ABsbPQPIFH+oWQUOPxKHc9sCt1/4MmXyCaBiYF/Hx4lqUAfz3H3JQo2iKWck0
	9ikKF8/NtRKpu5zZv+P3RHkk2EwWKEy2tcMUkQJymrOlxm/TdE/fcEYQezaJAhWvbHU2Mbr5r8eD2
	x+qPIbaNqvCz3OpXTdBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqtCR-0001Gx-G7; Tue, 05 Feb 2019 05:23:11 +0000
Received: from mail-oln040092253096.outbound.protection.outlook.com
 ([40.92.253.96] helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqtCO-0001GX-Ma; Tue, 05 Feb 2019 05:23:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/0SecrgG7bJTOUndLj5gXDn9/I1P3lQ52op1Qehtco=;
 b=quPeJLPYjym8q2+vCQ94NmPb/O1yChjr91QFzYA2zIsvlTnbRocLKp4zdDfjXVHbxba2TOYMJprzmvXCDPK+Kh5XBe8M84VZHyBiWQC+QP/hGXZ3QsiPR+ID7goCNmAaalzhmv3qvNGaCTPXHzaREuv2zqFL3bX/ia2gFO76Xw0/w0z64UkA8v/zTtsGnd7E/43xAVgSdNU4iNm0Q8rA3y5M8nJa9SjMMjN4p/Bn7JF/ywzhWjzrpy6mOvev3Sc3kqPWufPJd4Oywt6/59wh0vNH25PaEMaJrnb02HCKLZzwFTZN/dzTKT0T+fYOdtY5A7Gp47jVy1iSzPWKNRqcwg==
Received: from HK2APC01FT035.eop-APC01.prod.protection.outlook.com
 (10.152.248.57) by HK2APC01HT231.eop-APC01.prod.protection.outlook.com
 (10.152.249.141) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Tue, 5 Feb
 2019 05:07:26 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com (10.152.248.51) by
 HK2APC01FT035.mail.protection.outlook.com (10.152.248.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.10 via Frontend Transport; Tue, 5 Feb 2019 05:07:26 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735]) by HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735%3]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 05:07:26 +0000
From: wen yang <yellowriver2010@hotmail.com>
To: "khilman@baylibre.com" <khilman@baylibre.com>
Subject: [PATCH v2] soc: amlogic: add missing of_node_put()
Thread-Topic: [PATCH v2] soc: amlogic: add missing of_node_put()
Thread-Index: AQHUvRCvjjN3BrhOkEe6Gj3fb1uuHw==
Date: Tue, 5 Feb 2019 05:07:26 +0000
Message-ID: <HK0PR02MB36342F50214F874F9C4BB968B26E0@HK0PR02MB3634.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0080.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::21) To HK0PR02MB3634.apcprd02.prod.outlook.com
 (2603:1096:203:97::14)
x-incomingtopheadermarker: OriginalChecksum:8E6208383022AF9AC3B128025CF284821CE70724A01DFCD2F1A4EE0F3967906C;
 UpperCasedChecksum:6837BC6B4E50DBB667FF9D8ECF1F2E4E4B160B99A7F1EE3FFCAA025740384478;
 SizeAsReceived:8699; Count:63
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-tmn: [YIHrXstZKTN5B5JordXgAriWMfCRlrvW]
x-microsoft-original-message-id: <1549343066-7152-1-git-send-email-yellowriver2010@hotmail.com>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HK2APC01HT231;
 6:GwNxXBDSInb7iQYIv2Vc5efO379PNwN6lHoqbRAOfJnQzS8dC9WwNF3RrRu+YYyHBzkisnfZ1SK2PIczYU5ANrETKR7ywljnzuO/Q9PEa3RYQf4RyRcaafK70mh3jSwE9ZPdFgTYasFAkNN+4Dv6NMwwvC0OXtN9oDkX6DSVKMBTGErZyovqZZURxn3B1Tom3VDIa/mxvfo1MP1s0e5B3NiflFF9BenD0JZjgKZ8Z1MZE969FmjFEYgxVGNEvuUIZFUF2NeLZGlWnJYUKRN6AU5KNOpJyB8mS+FPn5ia3hFrayJgaUMCsVbWjLEXR86rK+VWLS4RUL09GXAVvcZPKgCbuHFszSyeOqB5iLlOxK5LN+2O3WDNYeOQUV1GrEigBAiF7h7ZMVo68egvorHpYA+O6+6u/kNbdsVkWv46iBvQnFEn9KZxcL/T0JpuC2WNzYCq1QYbDyyxCK0p0iGd0A==;
 5:fzevoL6WtoraHUXdmesWdEqH4LRJe3ZlX+D8cNPqJuh4SoFsCR+UyyIdYx0zY/9dMCc7l41cy6ubx4Cyu3Imh0aXnQ0rxLHukEup5FPr8RqHMPsaZ3IZpECvDeihGhmtmKPN2Da8K0M4KTuJzHRKwaTSHtw9GN9VSU30/AqwBFmcvuqAcFVuUEiMw+0UUWgC0+SgLkvpk4r8RRZIqZ1sFA==;
 7:OOhPjpdL5Rm5SjdDLx4UnSGNgwataAf9LP5i41zwh/ulX2+e63V1vqaEFo1gY7/8WmkzVg2jJM4EB/xc445hmz7N49JkcKaarzKc6pMO6kbQSgLBg6SSlMvNKGvavrjuiJpWcdRQWsTPsawktTalzQ==
x-incomingheadercount: 63
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: zswcL9HXbeXZrseF0BFKG9CzWWT0ZgiJ1Tx8T4uAcRSJ3Ye9LJcM7aYNhsCLAtjU6AvOoo4DmUD/Fz7thNUDcfN7lKIp3cXz+ERL6NcVNSEiwrN1IugoyFJ0xIKzWq7VCrVS8LvkpE8SapSMXjJvRrSzwa5uVh1tvVbT9F0k7Ke/bgpHuBcy5ZofOnXnC8POgYqHxgbkiBUMW7PmL+rTULJKd14/2lyRoQXeLqZzuy4+pUF9msfk7H47u1XSe59xYzjs4jhJyDJinZr+ahNFwySqgAr9hMSvlxwbCs6jSEyqb9fQQl5IvAlw3dI5vS1hH3+oCqB5z7zY0RTla8nNPOS6/qNo7y9B0d+hHp1WaogmJS3mhTzEr3VIRC0i7H+52ORDok1mQN30n55ts2qKByGfpF5HlaNGXcyz66x7Kt4uC41LWtgcUb1htp8v1v1sP6v3ONIUGCn0eFh8So3LAW7FUyuzsrNv6JUHN25Ku7ECFd6zok8aWVye/YFN/rp/UJBmlg8uSuMqvDDr/oabFyX2BDDWkqPsMdGg0AwHIL4oFlOUW2JmxYEQqY26b6Pcm3iDAJhrGY8h74bG9Xw8ltKPDgo4ymnaMgyJhlx6zcFgzbwmgIb+azRCC7ocqqiN6eswlhm8nJpeOTEerVC5KDbtmX4iFshvJzfFYepBnP1mZTyEciWyF5hRwGEthGKG9KD5Vxx+Xp7/4I0h3Xw5FK7xVcbtDBjC15sL5zza9OKB3ZN+2Oq8jSLp3Y/tU0Cy
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
 SRVR:HK2APC01HT231; 
x-ms-traffictypediagnostic: HK2APC01HT231:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:HK2APC01HT231; BCL:0; PCL:0; RULEID:; SRVR:HK2APC01HT231; 
x-microsoft-antispam-message-info: 41NGChGfpQGhVsu/hzoVPV/PKFhuLb6JVEiLWt8xvwHWhAJ5FEXpDpr7mjI0Kpbk
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-Network-Message-Id: e261086f-1302-4cca-02ba-08d68b27d19c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 05:07:22.7111 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT231
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_212308_806743_383D8991 
X-CRM114-Status: UNSURE (   9.53  )
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
 Neil Armstrong <narmstrong@baylibre.com>,
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

Fixes: d4983983 ("soc: amlogic: add meson-canvas driver")
Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com> 
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
