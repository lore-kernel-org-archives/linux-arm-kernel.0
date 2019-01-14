Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F8AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:48:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44C7020656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LQT52TCV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="0qc/2Dfm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C7020656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=wXVXbfAsi/sEaqiZGTpSzdmEJzAZcO6ffMQg3HzYXZU=; b=LQT52TCVAopXYU
	iW2IEUNCLOkpbTp1sIUN4dwcNpTdMPqxp18C3VOJiQ+AppeRJ8c+weF+SesOMheRYxRlDZcXxCyFD
	KfQcoEnaoweA4eGg3Uzu90yusYGtziwySGS60DjwJmCwQxkAY5E/bhIfklgGOMNF0g+xaNOL3KQ+D
	0JLuNGS+d1gH6TLxOUgDCVyegWbNxbJplDLYfHCucb1xtQZfNlbhs6f+O4zm4NlGamXe0vlbmrc+l
	vVvAfD9b0wEwcpgXoVpwD56g03LXndJaFf1gQkdBqdjKDY6T89+9TRk6iyHOrAMiciQxJ0AiQ+32Z
	PTAeY1YO0yD0RgMvXwXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giyqs-0004Sn-85; Mon, 14 Jan 2019 09:48:14 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giymG-0007RB-Rx
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 09:43:34 +0000
X-IronPort-AV: E=Sophos;i="5.56,477,1539673200"; d="scan'208";a="25286621"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 14 Jan 2019 02:43:26 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 14 Jan 2019 02:43:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuQmQiOq/4+HIB2vcq9qAnFjL/CD5iTLZO+zrjPbWSw=;
 b=0qc/2Dfmfu9FrtI7+GqJc4uat7t58X2t/74+wW1Fk9Wqk6NBolU4P8IdwGc/FkXKZDxpoQcL1XWYhBBrk3m/tmm8ZYxCWTP64k0CF79q1jrmU1vDWZFHBNE1u4TuAbBXK5Di1DvHo2SDOgHRCmexE5OIhxwfY/KwfM+dhVK3uXg=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1675.namprd11.prod.outlook.com (10.172.38.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Mon, 14 Jan 2019 09:43:23 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::4c19:f788:c2be:5e8f]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::4c19:f788:c2be:5e8f%4]) with mapi id 15.20.1516.019; Mon, 14 Jan 2019
 09:43:23 +0000
From: <Eugen.Hristev@microchip.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>, <airlied@linux.ie>, 
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <Nicolas.Ferre@microchip.com>
Subject: [PATCH v2 0/3] drm: Add panel support for PDA 91-00156-A0
Thread-Topic: [PATCH v2 0/3] drm: Add panel support for PDA 91-00156-A0
Thread-Index: AQHUq+2X+1DoMYM8T0+/MR1+K+zQaA==
Date: Mon, 14 Jan 2019 09:43:23 +0000
Message-ID: <1547458584-29548-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::30) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eugen.Hristev@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR11MB1675;
 6:2c/OY0kBQQaKsUIMLILyf+uuJaK3aYhDxvgEsU2ctXApAbRLQyf3PlZvSmRISrLG4I0F2BWBL2e9KPKYgKj2cKlrCfUTXQeDZXLTBaZYcCjkSsIkYN2X3OtQVEIEZK+P/fJB071i1CdpnJkfR5ifH0Bs5q9w6XdYJj8jl5Hae2znRIPFOU5cZ5txVHTbliZ11noTtEdjGUniKeROJ+IYLDMzcKmSvjclyFFHyXcomUzBT0HHzNKjJ0SVrN91ptrUfKvQYRunwye3UnHUloqLMtBU+swxuzpbIFPICzmy9Qse7pPK6MskwFTpGk/N2QDwOQvzh/7jN708vyeZIW4Vd6VkAcB2lEk2ZaWrTsI5vnGg3Q9Xqe8Z5rtQucoN1D0uRWzRKE3CJWdhrvu+9OdjBTdCPR7AvhKj+IORJkOVBfP3noULKCMkBQ9gt6OfR1qV2BQveTF420456BvBQrq9Bw==;
 5:1qrkO4sXg7B9hJD7GPPu7Axy6I9FFnvsQY+NNs3rrghWCkbWSmiVGO/UVHcb3cQjb2zvfYCCQMJi9S0l+RcQ3k+mzCYPqh7JW2EYLt10oSMehzXep1qaEWMrFxIgcfkrVwFxZXyKqlxSMTY0ANwsIKLyR6IGd+hP/ajQTbILiMZSrLsIYJ+OkrIsC+CTSkC0POfO9Kbd9neIA67IJ+M1dw==;
 7:0dunYZpQfUqP2Hr3nuve0yZjRnSs+1LrxbQpD0259hANwS30a+yRG6/eI1vUBPuJdp4GK14YRP0jiqyu++hT0qNC/G0mlXWe6PnMGKMG+n846GTp6BF04zoXx+We72aByhvYclLxRbK5cjJruK8KcQ==
x-ms-office365-filtering-correlation-id: a168731e-9888-40b7-ad06-08d67a04b9b6
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:DM5PR11MB1675; 
x-ms-traffictypediagnostic: DM5PR11MB1675:
x-microsoft-antispam-prvs: <DM5PR11MB16750CFC2F4EBC6CBB4E5970E8800@DM5PR11MB1675.namprd11.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(346002)(376002)(39860400002)(136003)(189003)(199004)(6436002)(316002)(2616005)(19273905006)(186003)(6306002)(54906003)(6512007)(476003)(6486002)(110136005)(2501003)(99286004)(71200400001)(71190400001)(6636002)(6506007)(386003)(102836004)(107886003)(26005)(68736007)(478600001)(72206003)(966005)(86362001)(66066001)(8676002)(39060400002)(106356001)(36756003)(25786009)(486006)(105586002)(3846002)(2906002)(14454004)(4326008)(53936002)(52116002)(81166006)(2201001)(8936002)(5660300001)(6116002)(7736002)(97736004)(81156014)(256004)(305945005)(562404015)(563064011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR11MB1675;
 H:DM5PR11MB1242.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7Qy82qP/g5Y35vUtquqDiwvmyjRmk8gagDO0IPEOgknsDhNILUSYXp8rJA5FPyz4SYpZ9yBpfa8HNdQYePZVdKc889KYzbtcVH+VZPt2bS2Heb7dA7iv5eFbOAEog3wskpAesyHlnkLMvhsSGjGZeIU4BeRfeMfN+E44/DyRsXca+ZkRHjtfiIZt0xNzVQMVJIf6Wlll4x+CkpXiSqti5wWD7ndSLmIdsZC/mzBJk7ZvOptTwHxSdvDZL0aMk+m9Ht6nvj0QNyNGHIjJnOuYDIhpeq+sUimXcLr4BnxOCP4thcV/PRd0JEIC6aiRfoKm2CdlKL0aQ1B9nHLwa4tOo3DSkw1EOAq8NE3kKJPaIXua17gCX4JFhT9pAJZNOJNM4+NwSvkF7/4VYjuKOOLo9syqZQFmHDxjhxSrtex91RY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a168731e-9888-40b7-ad06-08d67a04b9b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 09:43:23.6843 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1675
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_014329_885414_7C5A70A5 
X-CRM114-Status: UNSURE (   9.84  )
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
Cc: Eugen.Hristev@microchip.com, Cristian.Birsan@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Eugen Hristev <eugen.hristev@microchip.com>

Hello,

This patch series adds support for PDA (Precision Design Associates, Inc.)
vendor, and for the PDA 91-00156-A0 simple panel, together with the bindings.

The series is on top of http://anongit.freedesktop.org/git/drm/drm.git drm-next
branch.

Changes in v2:
- According to Rob Herring's review, added backlight and supply binding
to the .../devicetree/bindings/display/panel/pda,91-00156-a0.txt to comply with
the simple-panel bindings

Cristian Birsan (1):
  dt-bindings: drm/panel: simple: add support for PDA 91-00156-A0

Eugen Hristev (2):
  dt-bindings: add vendor prefix for PDA Precision Design Associates,
    Inc.
  drm/panel: simple: add support for PDA 91-00156-A0 panel

 .../bindings/display/panel/pda,91-00156-a0.txt     | 14 +++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 drivers/gpu/drm/panel/panel-simple.c               | 27 ++++++++++++++++++++++
 3 files changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.txt

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
