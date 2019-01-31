Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7C0C4151A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:15:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE624218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FzuIclmY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="1wNuWmOf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE624218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=duBYPKZEeIMEodEUHC0Lg5qwhr8nIcOmzecRLZbwtVg=; b=FzuIclmY5Q8G/q
	UMgMDT7e8Co0z6ZoqtVgPV5w4zE76hE1nLrW2fOd1ANp2W75wMtx7NXsGJj+1jqCU4KDbhLPjnv/k
	ruFNTN1mqbapXzyesSwYhsVC5v+cwy8S7HwFWlhd8/q1RSY1pFAMuMZ2LWoDkza8z++i4rc3NrwYP
	64CZcC1u9niG7u58EhpNu2v5DvMZz1QpuXhm5OQkrQneGwNf1w1fWKem816vE/iMWq3CX1bJEL9nB
	PDus6hX7C0M17Y5OB25TeOoYl8XfdruV2TXbnNotbBN5Dx2IyegS6o1l67OtPPnOsfzpCQw1veEOV
	ldmyBa5cNYw5VDiN6wdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpF02-0002zv-5d; Thu, 31 Jan 2019 16:15:34 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpEzy-0002ys-6J; Thu, 31 Jan 2019 16:15:32 +0000
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; d="scan'208";a="23261553"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA;
 31 Jan 2019 09:15:27 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 09:15:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fe7RdTgelTscr8BGRznFJAPsc8DSTSeupFpv7obvyfg=;
 b=1wNuWmOf/u/YUirEJDNTkoYD44JDCWLO9S7Yq3g+W8XI7+RPRPDXPAIN5X+ZH0F6QVaVGmAxFThqQwEin7CsWrW6zWzWhoUfVT/19BYGuNupzxg1FdkrMhcslgqT67ZVoLvmcfdLipB7ILz7FFw4knD0M3klTL6jZuJpW5yYK+k=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1874.namprd11.prod.outlook.com (10.175.101.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Thu, 31 Jan 2019 16:15:25 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 16:15:25 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>
Subject: [PATCH v2 00/10] spi: atmel-quadspi: introduce sam9x60 qspi controller
Thread-Topic: [PATCH v2 00/10] spi: atmel-quadspi: introduce sam9x60 qspi
 controller
Thread-Index: AQHUuYAsoRWfA19y0k+PIqbEPZTkig==
Date: Thu, 31 Jan 2019 16:15:25 +0000
Message-ID: <20190131161515.21605-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR02CA0046.eurprd02.prod.outlook.com
 (2603:10a6:802:14::17) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1874;
 6:rFZFfIn7M/z0Z1xHMFAz5R7jUBIOaDqPZtp+KsyodoDJDSIM3prTX0YFSHCvTVElcNRKxTB8qnzXoXsQGOOYqjXBlsx587WieqrRhE9BjtuUDhHAgzyuoaELNdwgm5t8d74PquKW3MV+3caeeg190jeUkU5xp+hPdVmm6tw/kmnAcwg5CrgMuAoiIQZ2gxHFuJZP0kwwnqyT3TRTSIqpj97V5gW0XXmCYCdQv0zJs1Vn/1t3ua70w9L+tRQfcSW+BUwM/JhMYRij1TQE/yMVsW3i0TO+c0TuciRN3koOGjwAjSL/AlzFOQpNu7HwC2F7GDdljPua22PDP5+RQyvoFT32eLjmzP7MREJ0P1LJ7n+DdVoFhO1kiDJkp5DbpdAnvfS2a9v3fQu1wvB8sC5mrsiDoN0aR3mjwheOXRdBXMm4MlyjvI1eHhZURcBpJifFe0sShraoz/a/rO5vOM9kCA==;
 5:Ynwy1Gg5UgHMUEkitaBmeXAx7b+McMPQkoId1dUpEu2h6FAQdH+PAPJS5Z+7Mu2nGCS0anTH/f8QXEmOteqC+lT+ndEmAbIETBt8xqy5tRSIdoWsoUKQT6oZtw7tVq/73VMhIqZpPow1cRoEPkuC82BR3QZEFVvYS8m+lroc0ZQgl4vz3iXnJomoYC86qeEP9XakALsG8PZXaKYdk/BsFQ==;
 7:PfEpZo6tZLJBuzjUCObF/G/LdH80sdt6/4PsgM5pigQtdkFRUTiLOjgsxhgLiqoj5Db48kquIKOmNUsBYpMCcNUttOcej2xxCak2/HBJAvms41R0caej3y8ta31nOL1/XBrKB6dQ8nIXHX+ofRbIsw==
x-ms-office365-filtering-correlation-id: 85b4ef26-e83a-4d62-5307-08d687974ee6
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1874; 
x-ms-traffictypediagnostic: BN6PR11MB1874:
x-microsoft-antispam-prvs: <BN6PR11MB18743F10068DDF9B74451CF1F0910@BN6PR11MB1874.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(39860400002)(136003)(396003)(376002)(366004)(189003)(199004)(186003)(107886003)(26005)(4326008)(68736007)(97736004)(14444005)(72206003)(478600001)(256004)(106356001)(105586002)(36756003)(99286004)(54906003)(50226002)(8936002)(7416002)(6116002)(3846002)(7736002)(8676002)(81156014)(81166006)(71200400001)(71190400001)(52116002)(2906002)(1076003)(305945005)(2501003)(14454004)(102836004)(6436002)(66066001)(25786009)(476003)(486006)(2616005)(110136005)(316002)(86362001)(53936002)(6486002)(6506007)(386003)(6512007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1874;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 537jdphST5CvUVGciRZt09JduGoS4tVfXmmKVLmNp8XuGIlBNCXdA7602OHdt9iXVDCYX/Cmus1MmRrShztv7bD4R1JK97tzWghqDMpnz1NqwaB6R7zv9Qmo8mib35Ij9MKy8CkvZ3jp28pQsjJtXwkH26Z020KERDir+R1H4JqPrAkKhvFAgmUTpK2tOhxdG/85peYmCdqRch4txJvKtNdYd8NLC5znzizmWnrG+62JobkU+Vug9v0zhG5I7OPrsCauVJXSo+Z/xsqu1awpcpLERH/vLdhrn3zRTQ5JXNUy77PjGvlVNSQVHvywogJ/Z3srfUvQECQ0SqXWi3PbYwWWdzFdlY5b/qaGeZgzHPL4YiyEt4I772E0JpiP6evSYPlRsavanGnnLkoRgige+TouvxyRznfrJeQSD+80YSs=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b4ef26-e83a-4d62-5307-08d687974ee6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 16:15:22.9472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1874
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_081530_500835_1799EC98 
X-CRM114-Status: UNSURE (   5.30  )
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
Cc: devicetree@vger.kernel.org, Tudor.Ambarus@microchip.com,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Patches from 1 to 8 are minor fixes or cosmetics.
Patches 9 and 10 introduce the sam9x60 qspi controller.

sam9x60 qspi controller tested with sst26vf064b jedec,spi-nor flash.
Backward compatibility test done on sama5d2 qspi controller and
mx25l25635e jedec,spi-nor flash.

The patches are generated on top of for-next branch.

v2:
- cache MR value,
- drop iomem wrappers,
- make "pclk" clock-name mandatory even for sama5d2,
- rework clock handling,
- reorder setting of register values in set_cfg() calls,
- collect R-b tags.

Tudor Ambarus (10):
  spi: atmel-quadspi: cache MR value to avoid a write access
  spi: atmel-quadspi: order header files inclusion alphabetically
  spi: atmel-quadspi: drop wrappers for iomem accesses
  spi: atmel-quadspi: fix naming scheme
  spi: atmel-quadspi: remove unnecessary cast
  spi: atmel-quadspi: return appropriate error code
  spi: atmel-quadspi: switch to SPDX license identifiers
  dt-bindings: spi: atmel-quadspi: update example to new clock binding
  dt-bindings: spi: atmel-quadspi: QuadSPI driver for Microchip SAM9X60
  spi: atmel-quadspi: add support for sam9x60 qspi controller

 .../devicetree/bindings/spi/atmel-quadspi.txt      |  14 +-
 drivers/spi/atmel-quadspi.c                        | 374 +++++++++++++++------
 2 files changed, 281 insertions(+), 107 deletions(-)

-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
