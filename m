Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F46C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:22:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1778F20656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XTo1+xcv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="gcw3od40"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1778F20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=0SiLd95NKD80ar8FeMvuNjaomEbNqqByvJPqWJSL4k8=; b=XTo1+xcv5iq9+e
	WAgvQOWLaBGj25yftfq1iBsfp/VB2xPuEtDUd06ILQ9cEq1MzwVXWebj3GH7OLiMd6wdUILXXt83z
	bXlxG7pTqiSPzAR/Bqbxft619TF5ggIJWOw+28Wkw5QHEoHL1pQbciXzNIdoA9dq5f+H55VzBux7v
	w0WnwAE6NPZsZAjRYxe8ybO10AVUkCbP6h6IIlu4XFR6hcqvl5Ytj8YaRWSPj0GXnOMG8zkoAH7HQ
	JHexVX4D/UIGQ4JL9up3Jcly3fCel0e4+jjltVHITyV3VIiOzeApGYwUrE1BrXO68v23JZQdFuEXe
	OiAsuLSbZk7BF5oaxgyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjPcA-0004qf-Nm; Tue, 15 Jan 2019 14:22:50 +0000
Received: from mail-eopbgr70070.outbound.protection.outlook.com ([40.107.7.70]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjPc8-0004qA-50
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 14:22:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqTK9CZt5vE55mF13xiWPY10b15hHFtVEI0eZtqoeWE=;
 b=gcw3od40+dwS7SnBQ/sHGzJ3E7gYLooYCfQCkmLzY+goUOa5pF8l4hXw6x7RwVzzisFEhTZXFQa8OUL0WajJQWId8Jevu0VfR5RZJVmvvtgFAtHfw5L67rEvRHhL1bTip2ttkp6CixI72cY5aDk/ib8H/ZGC46aQIMt6VlEJKvI=
Received: from DB7PR04MB4810.eurprd04.prod.outlook.com (20.176.233.96) by
 DB7PR04MB5515.eurprd04.prod.outlook.com (20.178.106.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.25; Tue, 15 Jan 2019 14:22:44 +0000
Received: from DB7PR04MB4810.eurprd04.prod.outlook.com
 ([fe80::951:9643:746c:47d7]) by DB7PR04MB4810.eurprd04.prod.outlook.com
 ([fe80::951:9643:746c:47d7%4]) with mapi id 15.20.1537.018; Tue, 15 Jan 2019
 14:22:44 +0000
From: =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH shawn/for-next v4 1/2] dt-bindings: arm: Add Y Soft IOTA
 Draco, Hydra and Ursa boards
Thread-Topic: [PATCH shawn/for-next v4 1/2] dt-bindings: arm: Add Y Soft IOTA
 Draco, Hydra and Ursa boards
Thread-Index: AQHUrN3I7Hdzk9Xbj0aq6qDYR1Zdxg==
Date: Tue, 15 Jan 2019 14:22:44 +0000
Message-ID: <1547562139-64730-1-git-send-email-michal.vokac@ysoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0045.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:8e::22) To DB7PR04MB4810.eurprd04.prod.outlook.com
 (2603:10a6:10:15::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.1.4
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB7PR04MB5515;
 6:oo9s++3UkQ4tTAQEH3mMLPNEdR8BsFcJLyECLFYMnRl8MLNjdT3dPIDdnoonR80ACzgv5H7+kbdwXjixe3L87ZHDAt6Euv9p+2IX0AjS/nizKOuamg6Zvlrxh1g6AeLTCvaTnWYraUbNZ9US8lZ+TTeHZDYvcUxLgXBAAxenZ//ospK3VKq9P0o9NTdvrV85I2z1SSSo/SLt9WQMySQUj+yZ437Y6Ngb+H32wODWF25eS7JF/JiIbCtJVhAOyxUmf8xMaqiDCHvoxAHZtCINnnm4w/2I0ABV6AqYoAjSx/vrOH+KMMLZdUCiE6Xx8swcoAaW+cqk45otw08TCXdAEPIshox1ccbRX9M0lbPx4k904gXYd0sGoBvnxS82mVquitB6WQfYXeL2g1k0cOlH8XnViy4yHUTK2YUfAsxHjz+HYSG/JoHTo/P0HFwKLOYDeHx8ZcLByXzAbOqroChZYw==;
 5:uZYGrLPZhlM+Lk+EK3hKHI/nccOmRTE98j8W0RfWA9lUSjNGL0mNO2R1F4vKwes1oWR8BnuTcI73ifddkEp9I4tzvp7R01KBfFnJw+qUGQ2uc00JFmzWsdrDzz0EOGkgy/CEEw4O0wve2K3O4BwycYpr+MHF5qbj/MkSwNK2V0mzwflfq7uVb6DCK23nyTnT5nJDAtydRujTwGDbgeQTxQ==;
 7:lpzgoA4s9FLVhnh7blU6Rzcv35U/tE3fVbAtk1mwIlKLZZDCkianWw2+WmC2zPHbdfsP6QwvUsp6e8o7VkQACH33hg5p1Pvb1sSNXWW00s1X9eStfnZnLSBfXelsARYLJKBcnuWz0tnW0MbPrc5/Dg==
x-ms-office365-filtering-correlation-id: 159cb702-e785-4ed0-c911-08d67af4ea78
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DB7PR04MB5515; 
x-ms-traffictypediagnostic: DB7PR04MB5515:
x-microsoft-antispam-prvs: <DB7PR04MB5515A5D0F702C5F0E1058E379E810@DB7PR04MB5515.eurprd04.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(136003)(346002)(396003)(39850400004)(366004)(189003)(199004)(71190400001)(71200400001)(6436002)(7736002)(305945005)(476003)(2616005)(6512007)(6486002)(5660300001)(316002)(54906003)(102836004)(6506007)(386003)(186003)(26005)(52116002)(99286004)(81166006)(81156014)(8936002)(36756003)(8676002)(68736007)(6916009)(19627235002)(50226002)(256004)(106356001)(105586002)(86362001)(2906002)(85182001)(53936002)(66066001)(6116002)(72206003)(4326008)(3846002)(486006)(25786009)(14454004)(4744005)(478600001)(97736004)(107886003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR04MB5515;
 H:DB7PR04MB4810.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: osubsntHLjl50B2A0H15NA8HZSOxy8oIJZGo2V1kYrm380sPiLQZ+krmaVikrxiA4fCVOOmhatQKg/Q8vzUBTe4O6S28QzSpJo6/wojhFBT6C+s+P+6oEiErKxxRqaeDItjn1aGp9tlvQMwunqRNkj3aF+nMkEGYpbAzTPi9zp6Vx3TlB9RmIJUWOsVZn7mTgV6SfNGOVunPg8fDel07m+kkP5M3M9HtQN11JzjBUZRY7gTFuJOhOmrex27NvQTMVdj8h3Z2CpYuhnHme/ypKxv8SAmOPSHeY5/2RdW0yR4GuqG8yJHV19MSdtR8HquBBE5wPxBd8dT2YSzdnW8JhINmuZ9seloIwXriZOQqknFQJE5gYrqH6yUFykyDb0fBJX+hR+PkCz8OqiGaj+QU81lJZBXyUxkHk+INxDbO7zo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <81378A1F400DB24585AA96296B7D9D59@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 159cb702-e785-4ed0-c911-08d67af4ea78
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 14:22:43.9714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5515
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_062248_402427_9E2126BA 
X-CRM114-Status: GOOD (  10.54  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>,
 Andrew Lunn <andrew@lunn.ch>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhlc2UgYXJlIGkuTVg2RHVhbExpdGUvU29sbyBiYXNlZCBzaW5nbGUgYm9hcmQgY29tcHV0ZXJz
IHVzZWQNCmluIHZhcmlvdXMgWSBTb2Z0IHByb2R1Y3RzLg0KDQpDYzogQW5kcmV3IEx1bm4gPGFu
ZHJld0BsdW5uLmNoPg0KU2lnbmVkLW9mZi1ieTogTWljaGFsIFZva8OhxI0gPG1pY2hhbC52b2th
Y0B5c29mdC5jb20+DQotLS0NCkNoYW5nZXMgc2luY2UgdjI6DQogLSBOZXcgcGF0Y2gNCg0KIERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNsLnlhbWwgfCAzICsrKw0KIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNsLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1sDQppbmRleCBhNGQ2MjVkLi5iMzkwOGEwIDEwMDY0
NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0K
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0KQEAg
LTk0LDYgKzk0LDkgQEAgcHJvcGVydGllczoNCiAgICAgICAgICAgICAgIC0gZnNsLGlteDZkbC1z
YWJyZXNkICAgICAgICAjIGkuTVg2IER1YWxMaXRlIFNBQlJFIFNtYXJ0IERldmljZSBCb2FyZA0K
ICAgICAgICAgICAgICAgLSB0ZWNobm9sb2dpYyxpbXg2ZGwtdHM0OTAwDQogICAgICAgICAgICAg
ICAtIHRlY2hub2xvZ2ljLGlteDZkbC10czc5NzANCisgICAgICAgICAgICAgIC0geXNvZnQsaW14
NmRsLXlhcHA0LWRyYWNvICAjIGkuTVg2IER1YWxMaXRlIFkgU29mdCBJT1RBIERyYWNvIGJvYXJk
DQorICAgICAgICAgICAgICAtIHlzb2Z0LGlteDZkbC15YXBwNC1oeWRyYSAgIyBpLk1YNiBEdWFs
TGl0ZSBZIFNvZnQgSU9UQSBIeWRyYSBib2FyZA0KKyAgICAgICAgICAgICAgLSB5c29mdCxpbXg2
ZGwteWFwcDQtdXJzYSAgICMgaS5NWDYgU29sbyBZIFNvZnQgSU9UQSBVcnNhIGJvYXJkDQogICAg
ICAgICAgIC0gY29uc3Q6IGZzbCxpbXg2ZGwNCiANCiAgICAgICAtIGRlc2NyaXB0aW9uOiBpLk1Y
NlNMIGJhc2VkIEJvYXJkcw0KLS0gDQoyLjEuNA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
