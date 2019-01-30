Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF9EC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:39:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4794218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="doseXXGO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XXUr+6vs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4794218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=KJBg2ezPNvfZmKzOxD5yU8uTjP1pm+NH2M+CPMOMvAM=; b=doseXXGOvVYjwU
	P0ca2c7wEvFehTy8tUvw9eb3Km0Nj21tMGcOLHjiUv8ZQ5pYDLwhUn3jZyX1lvgcSYcPzQonmXIWG
	vnDCpA3y6oFsPZM/b24mPXrwtuOLd3344G25EQLvFpFCzCDyT3NeN4Zw+zDL48BfoGzni5h5LA3Qa
	YpVAZfTA4S6lPQH8GdBQCV6Jzbq7QF26uQNb/YX7EXmS2nb0xjQ7Kvs/G0eZd0TFWBN8t8bdykdRq
	/BC4stFujA9hBbIwrpjBiSvLRr5DXSki2wrZeKdT/pe7P/kRsiiODAHR1IJH2P1SdPQUpcRDV2x8m
	Z9RAcCYCKg+K0Osq3gIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gowdy-0000gV-CR; Wed, 30 Jan 2019 20:39:34 +0000
Received: from mail-bn3nam04olkn080f.outbound.protection.outlook.com
 ([2a01:111:f400:fe4e::80f]
 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gowdT-0008UG-W1; Wed, 30 Jan 2019 20:39:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gOk3zNOvlHgqXnstcDKeOC3vXTjWjVqC6lcez3yaMY=;
 b=XXUr+6vsVLWyxIH8p/NEfxcmYO3LmRSIK48NleZcp1AFs2YHJQU94uMw63HCf74Qt+G6sTD2pk/7mnwHfEp0d+NM7m9O89pavvc8dywpP0wb9rYfxv+79agU/p+EE2j12iY9bRXHPmFwe+gpozQXO6J8yq60lTmeF+h9i27yBeV6+kLikhxYZVnkqys2//kDQh1/ArpvvWgHFcCUkQ8TxwgxRHpO0a0FIchoJTFeKhzifisHqgazlnQo70AwPDosV4b/POnIjxyldsqHTJUwgK/Cg4L26iDwJii+t+iHmA9Ce/65quctYdZpW3zOJ71GpTkLJin4NO6d0fGMD4bCvg==
Received: from BN3NAM04FT039.eop-NAM04.prod.protection.outlook.com
 (10.152.92.54) by BN3NAM04HT114.eop-NAM04.prod.protection.outlook.com
 (10.152.92.252) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Wed, 30 Jan
 2019 20:39:00 +0000
Received: from RO1P15201MB2012.LAMP152.PROD.OUTLOOK.COM (10.152.92.55) by
 BN3NAM04FT039.mail.protection.outlook.com (10.152.93.3) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Wed, 30 Jan 2019 20:39:00 +0000
Received: from RO1P15201MB2012.LAMP152.PROD.OUTLOOK.COM
 ([fe80::914e:44b0:65a2:a915]) by RO1P15201MB2012.LAMP152.PROD.OUTLOOK.COM
 ([fe80::914e:44b0:65a2:a915%7]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 20:39:00 +0000
From: Carlos Henrique Lima Melara <charlesmelara@outlook.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: [PATCH v3] staging: mt7621-eth/ethtool.c: Correction of SPDX license
 identifier
Thread-Topic: [PATCH v3] staging: mt7621-eth/ethtool.c: Correction of SPDX
 license identifier
Thread-Index: AQHUuNvUS3CRMoaS/0quBShw+IuWww==
Date: Wed, 30 Jan 2019 20:39:00 +0000
Message-ID: <RO1P15201MB20122B62C6B87E3B1E3AFF0AA8900@RO1P15201MB2012.LAMP152.PROD.OUTLOOK.COM>
Accept-Language: pt-BR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CP2PR80CA0077.lamprd80.prod.outlook.com
 (2603:10d6:102:14::15) To RO1P15201MB2012.LAMP152.PROD.OUTLOOK.COM
 (2603:10d6:4:1d::10)
x-incomingtopheadermarker: OriginalChecksum:66DC319BC93C443BF17917B208E56C78BF49E14A481BD8421DA3A60307088061;
 UpperCasedChecksum:A946ED48047C0E4FA0C1EAC178F78071087B6753EC1391065B486861C6655EFF;
 SizeAsReceived:8799; Count:62
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [PuMdYe6QIjWAYsPIgO7ovGuZkVlmjD21bGrkEzebXMGuK9v7hTwvq7rXcTy+NeaW]
x-microsoft-original-message-id: <20190130203857.GA26547@debian-E470>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN3NAM04HT114;
 6:beEfoCa8oU/Uzdn7VlZ9qChW6krJs8BokDoBARtuCkTY88TgAyzy4TovJVbmQGLyDtvi7s/P58IZXJkq+RHGfzcmfskSgchgkimxDJYviyIIcXtt2s9j4IJVkrpKyCZaghbN7CErK0aqhoLxE9JNGznmwDnNFrtZwgdZdFdCog5brU8UL3Fk23dhhT2UKPfB4R92/hWxLNutAxO6evyoewbn63+3c6AwkXhIQ31D20upXn3VI+UphAyWbeF2tcS183ublS2NMDmD0L6yT97U+qpDGaA5XanDGRucHCn76q1b+rBS6sz598PZbewYE8iu1fyUnkkmdZlmE8iR5M2Nsn/EUmEMd5G23Db9VjLAibC/T6D5IXBayhVXmUHRbQbTFVWjHIFlqf383Y+HIa2LVJ8yQg+BoQvMjRnlrDvC20DQSyTUcp8Cin6pBSnURHT9Xnf+j/hqFd8W4u44yPlojg==;
 5:ZFyEpyVWIFDIY+5JopoH98MIpuro8edI8S2Dc3POEe8r05deBriCh8HKTBhGgWiV1PlqtzYMqWAfKLWf+aBgMEvoZ/2WxbNn5T3Yo6XvCVHcR7d9ZSbam2016TcPkMWDgSagnbQU8h3KQgsphlxR+qb7yvMfLwRQdrQh2jcAGSchLV3LdYbnXW9Eztnu5POv4cy7wCUtL2O0TJWLvqyxFQ==;
 7:pQ51XZwFG0DIOx38v8zNW2VukfJyb8VNUZVn8onxGTIJoxpdL8OzyxB9GU377e08PeSHhWzmvyWSZQl8WQNH771RY3BPtHmEhvXx+2fkSG9rYZ0saoM5mH7mNRNJ5PGl6nBINNjdT4v92TFu0KaWBA==
x-incomingheadercount: 62
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(9118020)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
 SRVR:BN3NAM04HT114; 
x-ms-traffictypediagnostic: BN3NAM04HT114:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:BN3NAM04HT114; BCL:0; PCL:0; RULEID:; SRVR:BN3NAM04HT114; 
x-microsoft-antispam-message-info: 0tsbOakgpL341riPCXRNk8G4YLbSdcl8TcNLcnRA+rssQ5vhgAhLbWv3W7MqIDtS
Content-ID: <7AEBFA925B201946BBA045C216239E77@LAMP152.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 24fd1209-d934-423e-a578-ee886993c07f
X-MS-Exchange-CrossTenant-Network-Message-Id: 111dcb9d-4dab-45c7-5d57-08d686f2f6b1
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 24fd1209-d934-423e-a578-ee886993c07f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 20:38:59.1734 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3NAM04HT114
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_123904_743280_5A923E25 
X-CRM114-Status: GOOD (  10.98  )
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
Cc: "neil@brown.name" <neil@brown.name>,
 "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch fixes the checkpatch.p1 warning:

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
+/*

It includes the SPDX expression for GPL-2.0 according to the text license
in the top of the C file.

Signed-off-by: Carlos Henrique Lima Melara <charlesmelara@outlook.com>
---
Changes since v2:
 - Corrects patch changelog
 - Removes changes in the copyrigth comment

Changes since v1:
 - Corrects the alingment of patch description
 - Cc to public mailing lists
---
 drivers/staging/mt7621-eth/ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/mt7621-eth/ethtool.c b/drivers/staging/mt7621-eth/ethtool.c
index 40a7d47be913..8c4228e2c987 100644
--- a/drivers/staging/mt7621-eth/ethtool.c
+++ b/drivers/staging/mt7621-eth/ethtool.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
  *   the Free Software Foundation; version 2 of the License
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
