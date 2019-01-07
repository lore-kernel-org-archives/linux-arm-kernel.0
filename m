Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5428C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:31:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 734102085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NXNoyrvt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SOz1HgfR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734102085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5OEtoyMBcHZLlQ1CGjBQr/NU1MpZZ+rQDaMk5TVUrmM=; b=NXNoyrvtnN6Mci
	Yz7u/uNPrHYl1ccfY5ag815D50ciXDpXw80IkW3Aebv1UYC2187v2jNWdblhXYsLk46aT2mBgRURe
	BE+TX9GsKGUTv8LNIh8noitzO2dY3eGAKK083jJYZCBRu6Mb4JIPifNwuy0NmRj+ttvHK4n/SFmK2
	geKO8xdhwYwoRoPl4z6x3FJss36Hv4vyozLNpnl784kKz2CNilmcDSS3xbRTgGqrRnF4RplNqSh9j
	hp+2EbyQPt0dkho7Jy80mElDitE1L9j4fJEsGfZQwYLfYnsvbyPhSZrKmq3yhRed3wSQ3JTDygXcT
	EWngN2zUSG28dsWY6AoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggack-0000cE-Dn; Mon, 07 Jan 2019 19:31:46 +0000
Received: from mail-eopbgr10076.outbound.protection.outlook.com ([40.107.1.76]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggacX-0000QA-VZ
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 19:31:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gR70ss4UCrz5jHnN+kp/qLUBnogGnoD3wRlkcDAI+c=;
 b=SOz1HgfRYrqchpfgDYMsh+ObgGfmI96R2Qze3h0zi9kl2aYXFeWetCPTxWvTOTd0WvnobV4FcUkWNXsRwI+oL3ZhEPYxqJxCh6F5rQkis08U5K+VITnlPEU0dwz247ecezAULIbtWmyNMmJicRgucOdVF9I3swXW95wTgYYm6Ss=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB5311.eurprd04.prod.outlook.com (20.177.52.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Mon, 7 Jan 2019 19:31:27 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::7d6d:ce34:3439:c184]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::7d6d:ce34:3439:c184%5]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 19:31:27 +0000
From: Leonard Crestez <leonard.crestez@nxp.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>, Rob Herring
 <robh+dt@kernel.org>, Olof Johansson <olof@lixom.net>, Shawn Guo
 <shawnguo@kernel.org>
Subject: [PATCH 1/3] kbuild: Add wilddt function
Thread-Topic: [PATCH 1/3] kbuild: Add wilddt function
Thread-Index: AQHUpr+US0fxTx6gT0CcdEs9j++Ijg==
Date: Mon, 7 Jan 2019 19:31:26 +0000
Message-ID: <7fe1bbe77ddec38678a60e75512dabdd7e97ab1c.1546888138.git.leonard.crestez@nxp.com>
References: <cover.1546888138.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1546888138.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: AM6PR0502CA0030.eurprd05.prod.outlook.com
 (2603:10a6:209:1::43) To VI1PR04MB5533.eurprd04.prod.outlook.com
 (2603:10a6:803:d2::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5311;
 6:SZs3S2a0pXSNwjdmTAjpumnI/IMIltL8Zsg/pviayA8M7u1O8VETnJueIWE808iuCLX8BrHZrFKb/v029b4cxaX6HFtEBRwPDntsV854boXPBBN9nvGzrUl6LP8fJTfJn4Hm7MsR0Y4MwvXTCCgAg0EExFN9ybqEhE9LPy53K4NoryRVmwqz9gMq1otTu8IuXtufl2f+0fyfJUTKZEjj+JE6yGqK5pY3zCzxVCHEM2P5/fJLTeIeqpTd/9MtADRKiHcHJAHBMYYCJsIgoT1Q+hAKkrW0lmI1dmJhvcKzQTrvJAAYJZxaEJWXmO+ybb2+pqdFkthb6JU/oMx/93RRgCPh74RQXrLRlJHkS21HJDQQEzjD8+Sy7TATgEW8H8OBrDZRKmYb0Kpont8voRe3JslH1XLhMNEXqbFvgg8zhinVnYpthRympg02b8noIGK+IO+/8/P5vEpYOAjPFlzT1A==;
 5:70vnNeLsQ6ybTZyaUk+tWXrO/NUPY0I3P7SgAg0erB+50lyfikmgYCle83xSzgZRINeQ9nEpjkj5FtgGIvM25R0KFNvY7+5jGp0x9bk/fGtuTMN7XveVwc3eT2dWDD2HbBayEw1powX4P9tmxhHMSXYQDz8v8J3n9Bg7u+tenfoJkL0Oj6Qiq3Vr6YKi69gRk6wQY1X0OQFcXpDwiPQpnA==;
 7:07iq9/UUX+32sy0B4FdncvF9qWs2Xcc+WVtFVpES8YD9EZMwZE87j6KPxwDNuhvH7nroVNqKZJJxS0eCduaXf+F7DQlrkNM/r4dAHS07COIL5pSNzHFj+OPM5KlEwtYyWfPBjRE6PpbkTV27JVVTJw==
x-ms-office365-filtering-correlation-id: 196e436c-17ce-4421-cef0-08d674d6b744
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5311; 
x-ms-traffictypediagnostic: VI1PR04MB5311:
x-microsoft-antispam-prvs: <VI1PR04MB531130DA30062013772CBC3DEE890@VI1PR04MB5311.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB5311; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB5311; 
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(39860400002)(396003)(376002)(366004)(346002)(199004)(189003)(11346002)(5660300001)(102836004)(256004)(7416002)(6436002)(97736004)(478600001)(446003)(25786009)(476003)(2616005)(14454004)(6116002)(3846002)(8936002)(486006)(66066001)(4326008)(44832011)(305945005)(6486002)(2906002)(7736002)(81166006)(81156014)(99286004)(106356001)(50226002)(186003)(53936002)(110136005)(316002)(54906003)(8676002)(105586002)(6506007)(386003)(86362001)(575784001)(52116002)(76176011)(118296001)(71200400001)(71190400001)(6512007)(68736007)(26005)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5311;
 H:VI1PR04MB5533.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nIlGkW1EHEeB9gX0GpPOa+6LffakAmfSXkiHqbUMIknF70RIAPiSLEfWy4X2qdclZH7B2jE/gFqV9Ybu9Q16ZALqK2A2V2pAiKMCgulPrmKMqTbA/6jx9Ygp0qSrbF4/03VN0doQkiyg0Qt4HjVFcvvOTDefPnOqplCrhlSTRUkpBNlQMonF1TbK/Jgddi3sQNDcMvoFDS1nwATt99/dfIQRIXTxKtdAywNofKj/kh6hOEOxHK+6yx5hRjXSl3QKXgrxLjQEyQzrP6BKd49rBATsEZQoPtSaVHCz5VuFzbjZ81u8l/AwyPDrNOLe+62e
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 196e436c-17ce-4421-cef0-08d674d6b744
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 19:31:25.5949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5311
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_113134_014218_37313D66 
X-CRM114-Status: GOOD (  11.40  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Aisheng Dong <aisheng.dong@nxp.com>,
 Michal Marek <michal.lkml@markovi.net>,
 "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Many SOCs have very simple naming conventions for all boards using a
certain chip and long dtb lists can be collapsed using wildcards.

Since this applied to many architectures add a wilddt function to
Kbuild.include. Example usage:

dtb-$CONFIG_SOC_ABC123 += $(call wilddt,abc123-*)

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 scripts/Kbuild.include | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 46bf1a073f5d..6b8c0cca07c1 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -197,10 +197,16 @@ clean := -f $(srctree)/scripts/Makefile.clean obj
 # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.headersinst obj=
 # Usage:
 # $(Q)$(MAKE) $(hdr-inst)=dir
 hdr-inst := -f $(srctree)/scripts/Makefile.headersinst obj
 
+###
+# Return list of .dtb for all .dts matching $1 in current directory
+#
+# Example usage: dtb-$CONFIG_SOC_ABC123 += $(call wilddt,abc123-*)
+wilddt = $(patsubst $(srctree)/$(src)/%.dts,%.dtb, $(wildcard $(srctree)/$(src)/$(1).dts))
+
 # Prefix -I with $(srctree) if it is not an absolute path.
 # skip if -I has no parameter
 addtree = $(if $(patsubst -I%,%,$(1)), \
 $(if $(filter-out -I/% -I./% -I../%,$(1)),$(patsubst -I%,-I$(srctree)/%,$(1)),$(1)),$(1))
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
