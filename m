Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0663AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:11:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8FCE20651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pYnAdUvO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V8nXUyp6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZImPGVKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8FCE20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Jc2Un5iaVvLk7S6HNWnTswwaUXK8N8LSFA6Djvbkemw=; b=pYnAdUvOEEr4+3
	gpOE4rZYiFe0q0/tvEzdHuII7l8lROWIUZp6w4GnXkSfAU8X2ND372XfXOjCe6P16KBlo5ZAwlVDo
	siWoLbiaEPRZTaSYJiNl+yDcman1j3cbVxDNLP0y+oBikCABlihu72ok7JzmURDzFCB3qwBHmsqCm
	0gWr1oi5wPV0lxEDSBUnCtHRZ9WOigNUTqbOUfAvn4FlkF/8AkCBst7DjUbNhG7+mKUvG3zIwwK1i
	uI60cTsmd2eK32P1KO8NqG03rszRqXaAN4xdkmohWmTIkc1DnNuVUfr3gX8iE+1r5HPzwkOxp6baM
	kEkokPQb6rIHGITOn1JQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjOUa-0002tS-8I; Tue, 15 Jan 2019 13:10:56 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjOUO-0002jq-8b; Tue, 15 Jan 2019 13:10:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WMJutvrRVqU2G+NfW0oaXPrSQ5NzlJs0ZhFbwpFfsdw=; b=V8nXUyp6LN/L5GEblF/OlEaOc6
 Bl8o4j93SzrSqdBLvwgnMt6Mr+UUJU+Gu3+AR79p1tx6Q3I+JlniYbDlH71q0Wr81oWo5Z8APW86j
 Nwy8lagwaC9X2Jp4xvzsWnKBotNFuLUm4Qdh8n6Qm2qHphHM/z/HQF86ki9ZSkaIjLy+Lb/5Cy0e4
 90khCDf8MWag2LI0WI/zzjmHAmj1nlvABlt70Dr94nzh2KQbhxK7PmAWLcGi63rh/2w8glgApPbgu
 uxb1ZvtHaqg0aJDitjQPTvaxqtXylEplg6cr5vkc2wah5avZ8qbEEWeiYf0d1xEgL7H2xFHTMWeN4
 tf9N8prw==;
Received: from mail-eopbgr130083.outbound.protection.outlook.com
 ([40.107.13.83] helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjNPk-0003L0-2m; Tue, 15 Jan 2019 12:01:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMJutvrRVqU2G+NfW0oaXPrSQ5NzlJs0ZhFbwpFfsdw=;
 b=ZImPGVKZSLy11hnPAQzbBJOSfPOv+lk9zF5Si3wJ8JF2TsKgV6Rnw7FMK2Sb+3Go2Yueg6Nrl/mrCkMrGi+cO+tVHkl28Jf/rZiiTp0sdDbKjGOvG4+Z5mq+zfBDCxLQfZ1uLo1vt5iFCsZPNCpKz96ffvY8sKpnqDxQJeNxhnw=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB4301.eurprd04.prod.outlook.com (52.134.31.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Tue, 15 Jan 2019 12:00:37 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb%4]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 12:00:37 +0000
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "bbrezillon@kernel.org" <bbrezillon@kernel.org>, "marek.vasut@gmail.com"
 <marek.vasut@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v8 5/5] MAINTAINERS: add maintainers for the NXP FlexSPI driver
Thread-Topic: [PATCH v8 5/5] MAINTAINERS: add maintainers for the NXP FlexSPI
 driver
Thread-Index: AQHUrMntyt8t2ONyEEG1Za+L0xz/Xw==
Date: Tue, 15 Jan 2019 12:00:37 +0000
Message-ID: <1547553487-9936-6-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1547553487-9936-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1547553487-9936-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0096.apcprd06.prod.outlook.com
 (2603:1096:3:14::22) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB4301;
 6:zcFQ/19p3w27u2o4hC5SICz0wtnGHGPRj3Ik3tToqcpPRkKH9F08p2m/LB1XRnPXwFMbH2cjJE7LMz1i2km69C5978SdQYUIVwR8LEcTa6GgnFcCFlB6kFWiqFFUelWjdbJRWj6nvdTSs9OW8fh61j0IuS6pISUzq4cKKgMp0VwrMv/3JToGFiaxTTLqLuizkYegs1BnEiDqj8cPDEzWb3x0XUVz9ym6baxqUmibvoorcLyd7IIR6ZiEzl48ylTEfOKFV44rWLXqejC9siZwJv1TlUMo7o3LVm95mM9yaw7D/CvbiIgrECuTB7ob0KIjT1U4SMgmimYPKu68wfR4eHapBbfRoPI7vQZA7AXrobrnUAgr+oe0/Vd/VOJ6dLratt1U6T307t7RV6l7ELj+etZILCLQLWvnzP868DzB2bVk+Nf41BwPqTYwMbpbfsbbjFjMfPsfNBkDN5ZbDVaj3g==;
 5:LTnEatdKp/UeGVA2STc+1PSz1+iFcagY+pLL7jjXqt4fDUHODOKCLfb3swPFF50ed8loNToBEJp3ooZ7pZMSFhPA+na3SDNCifQwik1/ayWimvZxiyUmwsrejZl2auPU/11GypdxVRwr2/w7SVetzKmEfC3CAXjKixFoE5CTUaotRe9yzYzMI8GwzAMUGw+kgKAhosT+BvC7LX9BIOSAWA==;
 7:aCvSNRsm3Z3foSVpslgfxMDMdOHvmQytWUepRMmDdBjwJ/qH2RBbigiy5M7s6SOARrxML2ER6kK+HJbl7hyPkH1rn3H4fQ+pa7hXkqaxoh6VKS+LSYbVz2iruMvEiAOBi6FEvsLowElJUuzqGLwk8Q==
x-ms-office365-filtering-correlation-id: 31cf3676-7443-4f6b-8d37-08d67ae10fc9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4301; 
x-ms-traffictypediagnostic: VI1PR04MB4301:
x-microsoft-antispam-prvs: <VI1PR04MB4301915063D8A38DFBB7515499810@VI1PR04MB4301.eurprd04.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(136003)(396003)(366004)(39860400002)(189003)(199004)(26005)(102836004)(6512007)(25786009)(4326008)(105586002)(2201001)(86362001)(478600001)(186003)(52116002)(6436002)(53936002)(476003)(14454004)(4744005)(106356001)(50226002)(8676002)(81156014)(81166006)(8936002)(7736002)(305945005)(486006)(316002)(68736007)(36756003)(7416002)(110136005)(54906003)(3846002)(6116002)(97736004)(78486014)(2906002)(6486002)(256004)(14444005)(446003)(6506007)(386003)(11346002)(39060400002)(2616005)(2501003)(5660300001)(55236004)(76176011)(66066001)(71200400001)(71190400001)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4301;
 H:VI1PR04MB5726.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wx+gb2gHW6x6p41yTmKPBNa9pDglUBcuA/U65ir70XzW+7SgM5vl9auEiZabBTj+FRyydBMnGyZ/PAsURODBU/8qZOOaDc+u1Viv4bwwBdmZZQ38FPgkrK3+5uc7ahrrD+xOGMaxPj+h8r1H6hP+ha/BGcWEZpJUUndJ80V9DCFu8Hvf7tSrgQeRL9HOmI1dejPA7D65s8Z1DHTVGCOizP0QGkh9PIpAZen8uReKF5Es5egstVKkMHayJy38wWiMKpSG3h+9zVFCMYN12xzvosjp0Y+schrv2Y4fA3+iTLrUEZ/Ui+GatwpYkEgakVxL43yXWr2ymh4XKB6WQNN4rXMHZSNEVMwdnxPk7N+VLw6tKnNQ9A9FkDvINRMNQyptfgw6W+HubcrM+DjAxs+f79LpppaJ6/cyufeA3Uo+oqo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31cf3676-7443-4f6b-8d37-08d67ae10fc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 12:00:32.2475 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4301
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_070152_137446_1762C850 
X-CRM114-Status: GOOD (  10.39  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "robh@kernel.org" <robh@kernel.org>,
 Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add maintainers for the NXP FlexSPI driver

Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v8:
- Update entry for NXP FlexSPI maintainers name
Changes for v7:
- None
Changes for v6:
- None
Changes for v5:
- Add maintainers for binding file
Changes for v4:
- None
Changes for v3:
- None
Changes for v2:
- None

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8b6c0d454d7e..5e7ec7cda3bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10927,6 +10927,14 @@ F:	lib/objagg.c
 F:	lib/test_objagg.c
 F:	include/linux/objagg.h
 
+NXP FSPI DRIVER
+R:	Yogesh Gaur <yogeshgaur.83@gmail.com>
+M:	Ashish Kumar <ashish.kumar@nxp.com>
+L:	linux-spi@vger.kernel.org
+S:	Maintained
+F:	drivers/spi/spi-nxp-fspi.c
+F:	Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
+
 OBJTOOL
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
 M:	Peter Zijlstra <peterz@infradead.org>
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
