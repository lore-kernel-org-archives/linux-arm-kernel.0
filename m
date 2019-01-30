Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE768C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:48:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E85320882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O26vzRiZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="G5MRlcH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E85320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=cUU/FwDuRaHitukWSlHDuCmjHLyADzAplBoVTCg2v3E=; b=O26vzRiZ32kM7b
	R0B5uLK2O3di/2SGaM2f0jc1q6043THbhkPOIQpKoMV6xch3z0YD7hRSJi0fbmWmRsqv+646qikEl
	rFh+FQXk0YpJf2oMpXPc6SAbueXX9f0prs/kcUz6eZ+Vp7ALQq9pyvxDJNrQWhfvYM2qoeBHRcTp0
	J3rjtMo/UxneVzGf8w3xrfqKoXht1afvbqzkTaaeHt0VGqctnOiC3Y2i3eA1q1XPjIKO8TUQ87Uo/
	GHFmS0IZOXAaJ32GacU5HCB6hkdbfSu+HmmShhhcd4OVVlLuRB8zPGFX9Sa1GzpsctqZvLH4vtDOm
	/MtV54tqpuPnGvzrvJ6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gorAK-00074z-Q3; Wed, 30 Jan 2019 14:48:36 +0000
Received: from mail-oln040092007068.outbound.protection.outlook.com
 ([40.92.7.68] helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gorAG-000743-FV; Wed, 30 Jan 2019 14:48:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/MWLtHM49SCXu0jnmXUEufqLudwOh8YBXeOFDCX7Aw=;
 b=G5MRlcH1pD1BEh2t+T2I0XwJNZAXe1dzy3pK//yK2lqwUj2xUfqbJjFUv86fO6Gt6uwV1R+WpbuSPqUw6K/tRCFFNtewG3yHDTviNp5mQIEMCvNLSw8AHSj8w/X3ioU8ckOldexvXiX/YZIbF68HkJOq5SlQkDZ5gIYpCsinvSPGbF+Kx0rnpibfaWy550/dPVyQKVssriprC8QC0jAXgnUfZ0/AmZ5Cc8kT5vgjcduyW9bJFq4QcTUQVWrhz8+h3ZozqQ/sQLY/ixF43PacbPizQN9G4xTvM1/RiOsqWjBlSJTb/UAZjdRFWGgKJCU5V01q4KjQ7UiVhEXnpdinMA==
Received: from BY2NAM03FT033.eop-NAM03.prod.protection.outlook.com
 (10.152.84.58) by BY2NAM03HT080.eop-NAM03.prod.protection.outlook.com
 (10.152.85.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Wed, 30 Jan
 2019 14:48:28 +0000
Received: from SC1P15201MB2014.LAMP152.PROD.OUTLOOK.COM (10.152.84.51) by
 BY2NAM03FT033.mail.protection.outlook.com (10.152.84.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Wed, 30 Jan 2019 14:48:27 +0000
Received: from SC1P15201MB2014.LAMP152.PROD.OUTLOOK.COM
 ([fe80::802b:a8e6:e6a4:f853]) by SC1P15201MB2014.LAMP152.PROD.OUTLOOK.COM
 ([fe80::802b:a8e6:e6a4:f853%6]) with mapi id 15.20.1558.025; Wed, 30 Jan 2019
 14:48:27 +0000
From: Carlos Henrique Lima Melara <charlesmelara@outlook.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: [PATCH v2] staging: mt7621-eth/ethtool.c: Correction of SPDX license
 identifier
Thread-Topic: [PATCH v2] staging: mt7621-eth/ethtool.c: Correction of SPDX
 license identifier
Thread-Index: AQHUuKrcmbJ1/Slp9Uu1hNB7UlhL0w==
Date: Wed, 30 Jan 2019 14:48:27 +0000
Message-ID: <SC1P15201MB2014C3E0CAB4DA9ADF330797A8900@SC1P15201MB2014.LAMP152.PROD.OUTLOOK.COM>
Accept-Language: pt-BR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CP2P15201CA0030.LAMP152.PROD.OUTLOOK.COM
 (2603:10d6:102:1c::16) To SC1P15201MB2014.LAMP152.PROD.OUTLOOK.COM
 (2603:10d6:4:5e::8)
x-incomingtopheadermarker: OriginalChecksum:C53338023F6448F255D00B6416641CA61A9DDA9DF78EDE8179A5D979888140BC;
 UpperCasedChecksum:9F1A64A8EB4DB1B94F6F979EA2FA752FA64AD96EF0429622FF705A629CD9335F;
 SizeAsReceived:8870; Count:62
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [nvePZXS2Lu3rwsIqoFTXqETHnZ1VVAb3oODa2DDexvj2mNX46TUcTLBxlN1u8X6S]
x-microsoft-original-message-id: <20190130144824.GA6118@debian-E470>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BY2NAM03HT080;
 6:YvESKpV7NNSAHLMGC6n89oPTe5a9A4ROvbGM/kW9NwCg3gqsVGYiePhJJABc9YnDYIaINCZLelgN3H1MfUdJ03W8secAkN68U6xaDhT1SXIubblLiXpYKZ6YfnUbkbwCjQe9mTRaTwZ1mVesxAFltpyn7tA9DyO9o9i94xYX5PKczrhCorBaffOA2GucVcQCfiWOY6jqeGZRhzx6tWJQWlOsjPCzoi8zZpnPjzQV2qetjQOaZt0B9CvSUhLFo8iPF5YMwMunxbExA+DjwiZcVgIyM3nO8mPCN5Wam2Hn5iVSYViB9uciRQ5Ulm+Y8b2LEm4r3e/ELI3zMmUn8APoH33qd8Dx8urmeX+lJ/eTO14sfl2v4Y5lu7MsbVRiZndBD2BTCsR64SIQmVCxF6lF+LvvDgREICQgYvdMUsjIZF9QIESLZZCROG954WJQZRQaUrjG099z8CEZwlZbwWj6XA==;
 5:L9WXGCqDv3yVcql/9Xbb6BCO5SxyJfO3FKNDz1KL/NHXltjfV3tXJep9j6M3H4znHJCPfjrWuqI3UA45NYmxxS/9ylJOwOt304+OiNOcYyFE9XFjmFQkXP+LSXYCWAXWS4P0P0ctG6qOIfrpD27nJFRD7Zu+gz1MGUtcAxcDP2E8waNn9I/XbLWN6WZ/1Di+ZMb/ZyTz2EvOgIga7DaAww==;
 7:KjBfgvtjHQFOwxCeLUXQhs5X2WnjLxJOX4d1wkqSSW+gvJ+Hi6mnykF3Zgm8dKRF6j5/pZC3EsfA336rtqU5R0lkCQuxkkEfByetztFucw0Y6jzYJnVuJvXqa9dS6YixfWtZOlryCZNq3VL+kUcoPg==
x-incomingheadercount: 62
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(20181119070)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(9118020)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
 SRVR:BY2NAM03HT080; 
x-ms-traffictypediagnostic: BY2NAM03HT080:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:BY2NAM03HT080; BCL:0; PCL:0; RULEID:; SRVR:BY2NAM03HT080; 
x-microsoft-antispam-message-info: MT++PZGogHDeZsWQm+JNYaWg3sy96XfK2gNNSqass86R6ciKSTtSoYj1mxAl1w0+
Content-ID: <59C8DD6DA53B784592C380241639F548@LAMP152.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 24fd1209-d934-423e-a578-ee886993c07f
X-MS-Exchange-CrossTenant-Network-Message-Id: 640c3cad-3516-4a87-a6f4-08d686c1fe5e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 24fd1209-d934-423e-a578-ee886993c07f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 14:48:26.9867 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2NAM03HT080
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_064832_610958_2728B5D4 
X-CRM114-Status: GOOD (  10.95  )
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

	This patch fix the checkpatch.p1 warning:

	WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
	+/*

	It includes the SPDX expression for GPL-2.0 and corrects the comment format to suit the kernel's coding style.

Signed-off-by: Carlos (Charles) Henrique Lima Melara <charlesmelara@outlook.com>
---
 drivers/staging/mt7621-eth/ethtool.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/mt7621-eth/ethtool.c b/drivers/staging/mt7621-eth/ethtool.c
index 40a7d47be913..49d417de64c8 100644
--- a/drivers/staging/mt7621-eth/ethtool.c
+++ b/drivers/staging/mt7621-eth/ethtool.c
@@ -1,15 +1,17 @@
-/*   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; version 2 of the License
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  *
- *   Copyright (C) 2009-2016 John Crispin <blogic@openwrt.org>
- *   Copyright (C) 2009-2016 Felix Fietkau <nbd@openwrt.org>
- *   Copyright (C) 2013-2016 Michael Lee <igvtee@gmail.com>
+ * Copyright (C) 2009-2016 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2009-2016 Felix Fietkau <nbd@openwrt.org>
+ * Copyright (C) 2013-2016 Michael Lee <igvtee@gmail.com>
  */
 
 #include "mtk_eth_soc.h"
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
