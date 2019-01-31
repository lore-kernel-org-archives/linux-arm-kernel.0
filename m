Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25B6C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:17:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B72620863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qCFTO2ZA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y8v4wvtn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nMq2anH2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B72620863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=K55ptR0k16tXnETYKL7Z4rp2Tz19rsM062sVfuE1Tq0=; b=qCFTO2ZAkGXlkY
	ZUsGqHN0zRd01/2J30BpiZ0kQv8r35BJNC6diYOZIsXX29o/HNPWhS3uiAlO58Lt9TCrmI/FUMRL+
	diauK476JMwJRQkCJNzcrRSZekKVbZM0zPZSb8otn6nyOdmoWONCgBkDKkkdH5rl/6cgMCVrrGIJC
	X+R7ZkdF9VvIQF8B4FvWrn8tw9QmsEvwStr8H5s/PvErxNTaaZ0DW8Qm5UqOJ/zf91aXY0filRGjh
	eumu5Y9zsLMYPkNHXq2sx8IIAa1cCjq0w6Knatj+JVvocY3qscQa5mXPY7YBes7WA6OwrO4eZ4nLi
	uFRqUk74bYTFdm2i2FrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpE5I-0001pF-3Z; Thu, 31 Jan 2019 15:16:57 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpE4n-0001D5-Ni
 for linux-arm-kernel@bombadil.infradead.org; Thu, 31 Jan 2019 15:16:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=n5jOxHVta1izLjs7AYrhBRKKdLh/vUgQeyG+4eUDAMs=; b=Y8v4wvtnRBiGlBDPRgZXLRQ0Qk
 Ta90Et0DsoOMEYBLTEp4TtNNOTpktHLO6mqBT73JQw2/kn+ecMblmPiefUNz41hwuAvEodxBCcYmW
 dRcHtBgXBtDAu0/qaCCJXijXx586SSGfEow9+dk5toDJyMy4WOAr+DsjomsbyRURra6GdBliQVfFD
 3DPZfFnEqXowgzNjEYW/sVIFzwjG0jMVETf7m4gKDzFASOT1gu0azshOT2PxCGPnMWtiQuWCl0BnK
 M0DxiwKldnevRrkmMIh1zbrEhwUlji33FYcoVlr3rk+JsKZoRIEG7bF0XKXfXsxf2r8hKqLD8Liwz
 cfos03Fg==;
Received: from mail-eopbgr10041.outbound.protection.outlook.com ([40.107.1.41]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpDpy-0008NK-Ex
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 15:01:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5jOxHVta1izLjs7AYrhBRKKdLh/vUgQeyG+4eUDAMs=;
 b=nMq2anH2OzzvNK7qyvdDJ0pwvqG0XkFaIfmAr2+XUQMJ/GHs7bMzlI3SMhJesj/UFMxJWhwBKgELscVC8PO27KEVFNn574M6x4DTwAuZkVaEGZKLXz/eROnxouiHnstqMdaqn9AHPqyFgLvFnR1TypQPfcJ+yze4dcU4cetbB4k=
Received: from VI1PR04MB5008.eurprd04.prod.outlook.com (20.177.49.225) by
 VI1PR04MB6270.eurprd04.prod.outlook.com (20.179.26.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Thu, 31 Jan 2019 15:01:01 +0000
Received: from VI1PR04MB5008.eurprd04.prod.outlook.com
 ([fe80::2d2c:455a:16e9:cd4f]) by VI1PR04MB5008.eurprd04.prod.outlook.com
 ([fe80::2d2c:455a:16e9:cd4f%2]) with mapi id 15.20.1558.025; Thu, 31 Jan 2019
 15:01:01 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Simon Horman <horms+renesas@verge.net.au>, Andy Gross
 <andy.gross@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Olof Johansson
 <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson
 <bjorn.andersson@linaro.org>, Jagan Teki <jagan@amarulasolutions.com>, Enric
 Balletbo i Serra <enric.balletbo@collabora.com>, Marc Gonzalez
 <marc.w.gonzalez@free.fr>
Subject: [PATCH] arm64: defconfig: Enable RTC_DRV_SNVS
Thread-Topic: [PATCH] arm64: defconfig: Enable RTC_DRV_SNVS
Thread-Index: AQHUuXXHy3//xeNmMkalVMdvXtbX0A==
Date: Thu, 31 Jan 2019 15:01:01 +0000
Message-ID: <1548946838-28648-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0502CA0036.eurprd05.prod.outlook.com
 (2603:10a6:209:1::49) To VI1PR04MB5008.eurprd04.prod.outlook.com
 (2603:10a6:803:57::33)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB6270;
 6:2/J5LB8jHpJ9FNSc4gT7a856kNMcRFxaxUx7+bavnh1P1+iwysl4C5HQwvW0U2rsHRL7TYTAHJ/rwCbbvgGdJRSqyVvquKToUWYvfZvt+D3n4In0Pn5R7/408Y1q67ez5LbczobUUTix6ja7zf5zzLVHEdsgHRMiagbnPSFLZc8qFc54PPI5BFDpNzpL1N/smPUKw+3bGt4mjeJe/CHg4en2mcPru+T8SDCiZn1gA2d4sE5iCGjnJqc5CTMxsPX5fTb+MWLI4GebqQzsFiO7VqWXSS6K5C9XCIoFTS1geAeJzFcJXt+08rQr9kZKA9oxkUcccVi7ChBd17EYYxHNgJ5PnoApVZoMDsYKZjmr0SnijiWdT6LrU5R62J6I5p+NWf857P1Sn7VUHjoWJGap/Avfp8X7BohuAyk7/fHUzeA3I0q1IMSfDIClEmyqfLnFJPp4b26OihOX71IjsaUTCQ==;
 5:LdPu/EK7a4bEOwj70wbflrmpMWUTggiNSI9wQTlKMIUfgaZidZzB9MdgpsghNWUM5nWas4E6tnbG/79Yxa+E0HW+9rKEKIhBQ4gVu9SiEII7AsRBn7jIkBO6TeAvq4a1MhJ0UmN8fePwqQDP084avocZYnDNAUoWtNx0n/bqow4/5vLn8B7CqXUzW/N0CPAGGB0NkSpjxpUJ4aP1EkucZQ==;
 7:Bkb1t1y3DEYpSFjK41ZsexT8Uj/JY8KfPw+w9xDX1po5lG4mDFQQORwGLbRLxfCMiOuH49PrJmYdICye3o4fmFmXsI+qeUIht+6KrcBrR3ynCIthh2RZp+PHSivXy0v9S1Qgt08AugSj3bV9FxBGww==
x-ms-office365-filtering-correlation-id: 087857fb-36a9-429d-0029-08d6878cea43
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB6270; 
x-ms-traffictypediagnostic: VI1PR04MB6270:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <VI1PR04MB6270332D4E1901A5FDE34A30F6910@VI1PR04MB6270.eurprd04.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(39860400002)(376002)(136003)(366004)(396003)(346002)(199004)(189003)(186003)(14454004)(6436002)(386003)(105586002)(2501003)(476003)(26005)(4744005)(106356001)(44832011)(68736007)(86362001)(71190400001)(102836004)(486006)(71200400001)(6512007)(53936002)(97736004)(256004)(2616005)(110136005)(6116002)(25786009)(7736002)(81156014)(316002)(3846002)(305945005)(6506007)(54906003)(50226002)(6486002)(81166006)(8936002)(66066001)(4326008)(2906002)(478600001)(99286004)(36756003)(7416002)(52116002)(8676002)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB6270;
 H:VI1PR04MB5008.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0AauHBJigN80+uERw0OgfAECfyutwTSNWJpsfKM7TTteZFcrG+qWT5UtvIaJESBm/5PLON3gh33vQIdvv4puh9UDzBwFyOpSLX5Ng6OxhRyz+YbdrLDgF5ZMcRusvLxB84lLlAf5CxEW5DV6U9WL5grhHizKxqKnZuTJ/aezaXhSOXf550z6WY109KagBW643o5ZrLEThaqcHw8fX003gr7tCX/gMr5ZnOeq8S9bSeVU+Kw+7x6nrt4mfIb9b7THoXct3UHzkch/D9DT6onSa80c4b6TqTFNHQmhgdBujw+ZgFltGTKxbPldMP+xOgEQIjSmo72Nhmw7+jNP6poqg5X15mtlUEBm4rcPzM6StX9cFEww4DFb6nskbYAuA2v3qb/rPCXo5JTMvl5DD5ybeczTFGj70aKn0zynqMSCCNE=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 087857fb-36a9-429d-0029-08d6878cea43
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 15:01:00.4778 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6270
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_150106_693152_93FD7363 
X-CRM114-Status: GOOD (  11.88  )
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
Cc: Abel Vesa <abel.vesa@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

i.MX8MQ needs it for RTC support.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6e5af25..5ac64c5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -603,6 +603,7 @@ CONFIG_RTC_DRV_PL031=y
 CONFIG_RTC_DRV_SUN6I=y
 CONFIG_RTC_DRV_ARMADA38X=y
 CONFIG_RTC_DRV_TEGRA=y
+CONFIG_RTC_DRV_SNVS=y
 CONFIG_RTC_DRV_IMX_SC=m
 CONFIG_RTC_DRV_XGENE=y
 CONFIG_DMADEVICES=y
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
