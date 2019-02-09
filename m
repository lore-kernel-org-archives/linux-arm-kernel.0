Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C7DC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 02:52:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D89121916
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 02:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UeU2r19H";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="GwhwP3Yi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D89121916
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=yb5vjRZQ2auZSWGLWi7WosNLB79tsxkCbDZz0dZNLPA=; b=UeU2r19HrdY5NR
	4aj0lbdQGHaR6FwNmPXPhvbAPl6RVg5kmYE5drEQgDHe/bn4hTTQirHMSiGeII/IyRFhkmtw+ClG2
	aOcXgzOJKuEqOMTxZVd2K4MBFI8M9HnFj1ry8CZL4DNy8AmlRd2rQqUcN/RybmkgIDbxXVtvusxBd
	dHbdWv9+6swndGzo0IW5b5WeT27TM89J/Kxz9iUZVxwF9n7iwlADT4J2LCFC4nAeO2SGLmmRyVtFu
	ewZQLgKvqOlTYlevC4GCo60bGpA/h/f2kiYQVi9F6+W/7HP2dN4rOxqjKi6jpbZAof4q260ssKiWN
	NoWMk6m63jK+6kG2ZERA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsIka-0004nD-28; Sat, 09 Feb 2019 02:52:16 +0000
Received: from mail-oln040092255026.outbound.protection.outlook.com
 ([40.92.255.26] helo=APC01-HK2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsIkV-0004ls-C4; Sat, 09 Feb 2019 02:52:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkYPKcJXSNV36M+TOkvj0p+jhJsuYVGhEBHdKS7HWLc=;
 b=GwhwP3Yiro9L9NT8u/NiGrul0toLrQJYh/axBljrDTnJhbh4v3nP5nX+DD/ZDN0OjPZUrpkdAzHnXqOaqKWmL6BdvTx0Q+L7BYg4h6ZvclHAOATRcx+08zNNe5W6RWz4w7d1NKgaBxsDQIMFl7YtXO7Tdg1rf9Z3RpH2umkZb1QbuYkv6S7ryDkAV1CPvwUCUEpECDR1Y6WHwmFPju4llulpFOK6tL15eG+8E1SauXzuKiPTMZGueG35HcPErSPjw/MpFd1MrcjJdaKxWICd0EGbuhkkyK2xew4QuoPg14gL759W27kFYNwdhX1JRbr8Az9z0xhqoAjzb0Q/Xaxiqw==
Received: from SG2APC01FT051.eop-APC01.prod.protection.outlook.com
 (10.152.250.57) by SG2APC01HT175.eop-APC01.prod.protection.outlook.com
 (10.152.251.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Sat, 9 Feb
 2019 02:52:02 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com (10.152.250.56) by
 SG2APC01FT051.mail.protection.outlook.com (10.152.251.112) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.10 via Frontend Transport; Sat, 9 Feb 2019 02:52:02 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735]) by HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735%3]) with mapi id 15.20.1601.016; Sat, 9 Feb 2019
 02:52:02 +0000
From: Wen Yang <yellowriver2010@hotmail.com>
To: Neil Armstrong <narmstrong@baylibre.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 2/4] media: platform: meson-ao-cec: fix possible object
 reference leak
Thread-Topic: [PATCH 2/4] media: platform: meson-ao-cec: fix possible object
 reference leak
Thread-Index: AQHUwCJvxZvFf6UY1k6kMsXzgBxkTw==
Date: Sat, 9 Feb 2019 02:52:02 +0000
Message-ID: <HK0PR02MB3634925866F426F86DD213BDB26A0@HK0PR02MB3634.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0033.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::46) To HK0PR02MB3634.apcprd02.prod.outlook.com
 (2603:1096:203:97::14)
x-incomingtopheadermarker: OriginalChecksum:B34AEEF1FAC00EFDE8B1D5D1B2550EC1B0F3C95A873FE5104656D67A516BDD44;
 UpperCasedChecksum:7CE32C20B148BF43004E6DC0E0D656639E9D2CD60D4B6F3AE67040577F5A334C;
 SizeAsReceived:8950; Count:63
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-tmn: [XmIl+GlvmtsVQopvQxsdE98IJ0CdEoYJ]
x-microsoft-original-message-id: <1549680552-2238-1-git-send-email-yellowriver2010@hotmail.com>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; SG2APC01HT175;
 6:uEViugwXX4Jh5nq1FdwLpCy4byUQdQ9oPe/5sWvHzTd/EuFHaj5yAPkOiYgu6GRx44ub1Wn9Tb69cl9HgSaWVVoWyFbZeujR2lRPHwZSvNG4u1/TRl+05HP3uOXxatDZXfkKMeNPJtVbbOsFi7XQdgSPrf0kDs10SrRqP5eSjDPenIw4eDPePkpSCV/i77lw0AxKVWz707lV+64+VJCBlUsAfawxzUsUbfe3PqBr6xBzcKWG69tSIW8EoxBYKMpEj91qzbahpBqO5SLn49gZ3wHVsjPGECWQcTGy2S9/M+WiZ6P6GinL6AG0V7huqYintvJX8qP+0eFt4Zl8SwrF5h0h5ssChuknpSpTyzhJKR3FNqf+W1Q44GsjtR07SOy5wzGpIuW/syuvGQYGskt7pYGhP6WeIUUtUcnLJQGdjxg7BdEwuXXWTKWcc/ql4bRdHJ6wHJXIWKrCZqO5Wy4jig==;
 5:dKV88CCgFEm0dFkgjkjHlSDSY04QxaMGEDemd2NjMXFJoYKVsiUn1FokTzzJJYdBQ12ABSWRa0OefSEIV4bQpgc5GV/FUkry+nQg/SooKUxvnXoxBAEYOnQWJvymICaR7aAycKrXpDJt8Zck2d0OBnjukzODqNffloys0vDJsGKEPmHuxa+/4fyaZquJ3eDd+8HEynkRY3axbSUrmLBG4A==;
 7:KbQ7UIbZG8Sdq8lJHlUJV8OBXmk4v06PYt8mg6+sEE4cJvIYLQuaY7TZnhCqNlptonRnqX7H9HLCFJg4qOs97fa1cE9ZPgbeUKbY5TUXOKVExeRL23TTo0LVpEDjgb5SJ5TlNUMg8j/4R7myW72I7A==
x-incomingheadercount: 63
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: qY7UPrLqMbadjCbi5XwWKq4E/AV3DyG9FrVU6pGTwa7P4NRFUq0/kHoWv3Ojuix+Dtwb+LFIiL+5bTxHYCCTgDSHI9VMKHAOzvjOgt2e6GCO+s9iU7/pHRJoLqJkwtzmYMIFthOdJZ5Xfvk8cxlu5pF0Yu3j1wHL2Rdh9si0VH/VhLZwHX1HB955Q/wg2CjyEUNl+1b35/U/tT+4BjB/2BSi1g35V3yof8jqBIGxBCYszefEc60pv5L6P4jr+Xsw5o9WKuOaN2ydJ5B/9jvNLgyK9IrF2Q7otIuL17KxdHJA8Ibjtu77xGxA+x0QnOHQR3A50H1NWA76j+R7LB0k6K97v/hrE9eaiRXNXkLiqszGUg9I28Himi6D0MNZxD8KvABItTAMcMT9L0fuiiCOEfJBzawvUdEoRKb5WyZnLGy/yz9ZuNIOzxVHNE14USNzuBZGctEGgmuAGh/KZ0sXU9BZXJDWtJ/5e7x/eSYrekuxDR0ClBHH1ASE5au8/3wcnCpuzXSB/GhT44hgeYUSke2OACSd+2kyTRDDNcEGGCE5RFQ5w88+SGjzmyKS+nvx/1fqcwnD6gxLpnUCXkcPcwKuzU+99Kz59WLTJo+NgyWYiKHBC+1F7/qolFffohwQOXqsQCPPNmDE9sw5ycPsAiHABwyMW3c5bB97FJOpsdRXHlsIvP3KpA8/aJXxyL2bl47wsC1YPyxBdpSGyKknOA==
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
 SRVR:SG2APC01HT175; 
x-ms-traffictypediagnostic: SG2APC01HT175:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:SG2APC01HT175; BCL:0; PCL:0; RULEID:; SRVR:SG2APC01HT175; 
x-microsoft-antispam-message-info: vL32sL6vy3kpbvCyvCGRS6fZ/btU8adirytLfGKrI+px+pIgVBLbgoeHFHBrAreP
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-Network-Message-Id: f01e48c2-6f3a-48e5-76f5-08d68e399140
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2019 02:51:58.1471 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT175
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_185211_505766_0A500FF2 
X-CRM114-Status: GOOD (  10.87  )
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-media@lists.freedesktop.org" <linux-media@lists.freedesktop.org>,
 "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
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

Fixes: 7ec2c0f72cb1 ("media: platform: Add Amlogic Meson AO CEC Controller driver")
Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
---
 drivers/media/platform/meson/ao-cec.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/meson/ao-cec.c b/drivers/media/platform/meson/ao-cec.c
index cd4be38..8ba8b46 100644
--- a/drivers/media/platform/meson/ao-cec.c
+++ b/drivers/media/platform/meson/ao-cec.c
@@ -613,18 +613,25 @@ static int meson_ao_cec_probe(struct platform_device *pdev)
 	}
 
 	hdmi_dev = of_find_device_by_node(np);
-	if (hdmi_dev == NULL)
+	if (hdmi_dev == NULL) {
+		of_node_put(np);
 		return -EPROBE_DEFER;
+	}
 
+	of_node_put(np);
 	ao_cec = devm_kzalloc(&pdev->dev, sizeof(*ao_cec), GFP_KERNEL);
-	if (!ao_cec)
+	if (!ao_cec) {
+		put_device(&hdmi_dev->dev);
 		return -ENOMEM;
+	}
 
 	spin_lock_init(&ao_cec->cec_reg_lock);
 
 	ao_cec->notify = cec_notifier_get(&hdmi_dev->dev);
-	if (!ao_cec->notify)
+	if (!ao_cec->notify) {
+		put_device(&hdmi_dev->dev);
 		return -ENOMEM;
+	}
 
 	ao_cec->adap = cec_allocate_adapter(&meson_ao_cec_ops, ao_cec,
 					    "meson_ao_cec",
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
