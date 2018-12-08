Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C00C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 14:55:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A1832081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 14:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jf9ZDt0p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="e4Svp81u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1832081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=wMNnf41OAjIyyYMtJFVkdJ/M1qXtDbgwiI9yJGIqULY=; b=Jf9ZDt0paRrpaV
	hWRV9w3lsMtEJkm7QLBN1Q3KY9lEgV0Qbd9THN41cbPmFGjvm6Juh3G37UhoU7LiG6vCv7AKnKCyP
	nHvkLGxTf4bxjuRFbNBw8QmwUkIJjlH50WIReJNKcjhfi4biAFNrM4/vVKgO/S5Bfi7+UwZEWAPQc
	d2sEd8rFM03N6ZwpHSsHDmmqwQe1qejvzD5LgJf2RDJrYYFLFaMvQOzI5TSdUg+ufJV3T5H4h6Yrm
	1zVP98IWeKOgkbVejs9fdDo3GtAqPYHYfhaSm3fA0TkzyCv0mTNWjV7WVPyNSpdKLro30kP3w6Ouz
	m30rWivbVlvxIG6vmGhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVe0h-00043o-G8; Sat, 08 Dec 2018 14:55:15 +0000
Received: from mail-eopbgr10112.outbound.protection.outlook.com
 ([40.107.1.112] helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVe0d-0002jy-UG
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 14:55:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5+3OwvH4c9qfHz0mn+Ag0OX/mt6uvccLCupKTaIHDI=;
 b=e4Svp81uMC6LT1sy8Cr3D4u/9X64e/ZZT+HdrmHeXtXrggl6t9mrAn/PhSCjzYOBfd5ckIY8uhEfGN2EvUVf3rHWqwlhJLRIzRJgiRBvv3G1gc+qtb7bq74XTmzx91HHvRQ9F1uF5a+KAK4dZ6RsD8Z90wjIqkUs8iOSDy/3xAw=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2029.eurprd05.prod.outlook.com (10.167.195.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Sat, 8 Dec 2018 14:54:46 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::f0bb:aa66:e721:ecac]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::f0bb:aa66:e721:ecac%11]) with mapi id 15.20.1404.023; Sat, 8 Dec 2018
 14:54:46 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "jonathanh@nvidia.com" <jonathanh@nvidia.com>, "mperttunen@nvidia.com"
 <mperttunen@nvidia.com>, "bskeggs@redhat.com" <bskeggs@redhat.com>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
 <linux-tegra@vger.kernel.org>
Subject: TK1: DRM, Nouveau and VIC
Thread-Topic: TK1: DRM, Nouveau and VIC
Thread-Index: AQHUjwX1/WKFepsP1EqwZtC4knNc+g==
Date: Sat, 8 Dec 2018 14:54:45 +0000
Message-ID: <0c2db0d1c102a4f5a441f8e5a90f6793f329ada7.camel@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [188.155.129.42]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0501MB2029;
 6:raIDkOLwdaL3C6EgqQohT6ajCTgm78qU5tzhU3t/42OpTVIfeV0Oiutr+uMuD1Fgyct2cPCxn3Nb5T2QpJG1lYT3KwSd5jZxnvkxVImWZDfQ110q4xxWAkrxVCSwhLqMUKWgtdGtPrgMrFru83Y5mmngZw90j94TbcmzZcy6cdXY0qeseo3e4c91pO8fWakgymhIkYSoM+6NaI3FfmSymUUhQgiV7izxZfXvjfJ5W9fuyv/HirX2/577a9PoXWRHDcHbd1pyCKUt7VhRuzFLUALen11uZlwt41Yuo9uI5L2FKIZ1NO8tEYCrsSpTJ/ZD6ZMByZwSnIjIr9nHNOYiAZe43k6ZrEC2OqcJq8M5/uWvL+jttetN8HHh4/7fNCeJ7cT8UGPxj9f71gghKXtkpNQ/QcPEygvrNEBxOnmE9OPQ8oXNKSIg4NEkFH6ZeTcs3OlGKhVn17LahzDKcckJwQ==;
 5:WfGbX+3HkDd1+JRA1K8gB9+JXPqFU3v5ScCBZwA5Zkgq9ZdRlOukYmg0HY0ip0jSeLFTzpfIKcI2Lv5whTZVJM0w1VFpfB0LEa7TOxbcgVpSW7q4cWK1UxK/2dTvgHgkRnLjdSdm+SEh9iWp+0QmQ6gzTbKDfC6OUEXjFYjaFUA=;
 7:L9K28dAUqXKFSMNvMxazLWpgseNYZwLxfJMJ2MN/JJWbWZV27Qb6qRoXEA7bN9HEgkz/Nh+tk6LnK8oMwSLhWfoOuEc2bCCVhHfyLjqQN3Ogq1vldo1c9p1U7eniexR9E+Di5VTvBGdhdmZJULmScA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 35864323-4f52-42c8-a0d9-08d65d1d1838
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0501MB2029; 
x-ms-traffictypediagnostic: VI1PR0501MB2029:
x-microsoft-antispam-prvs: <VI1PR0501MB20292590E78AB874FC7E26F0FBAB0@VI1PR0501MB2029.eurprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(10201501046)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(2016111802025)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR0501MB2029; BCL:0; PCL:0; RULEID:; SRVR:VI1PR0501MB2029; 
x-forefront-prvs: 0880FB6EC1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(39840400004)(346002)(396003)(366004)(136003)(189003)(199004)(66066001)(105586002)(106356001)(102836004)(81156014)(81166006)(8936002)(8676002)(110136005)(97736004)(14454004)(7736002)(305945005)(5660300001)(68736007)(256004)(5024004)(71200400001)(71190400001)(14444005)(6506007)(36756003)(476003)(6436002)(39060400002)(2616005)(6486002)(6116002)(186003)(486006)(3846002)(508600001)(45080400002)(118296001)(2906002)(25786009)(99286004)(316002)(6512007)(2501003)(575784001)(86362001)(26005)(2201001)(53936002)(44832011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR0501MB2029;
 H:VI1PR0501MB2590.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4sbOX5ntIsppwgOw3oiR2cshSMsaJSkfsGQFmXqaRYT4XhlWijpnVF+dRDBJBpEt6KDRmSMw8KUILRa5xHHTbXD0RRV0zLyJivKCshm3Y4lxskTZKJuaSod+nnePci4zsjLU7le2BQpliMNjhbcbvvqwRK/uhEIF1z18w0CT+5OR4MttzcoIKBX4zs9wXXYJBuMhs496pJYNLvDvS4BghBahg2mUT2X/Xf10USHTlk/exl6ezT5pb13oR5MCHoijnT/4YTq46pZVT0i4t1zeAFEevgfgSzeZPi6O9DgLQcGPDq1eke8ZdbUi2nbtjkDimywilCeDHJTB595pug7KDUxXHl/Le0FFwgxd7vm14+4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <A04F9F665FB2D844A027DBD74AEDCA0E@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35864323-4f52-42c8-a0d9-08d65d1d1838
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2018 14:54:45.9521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_065512_321914_F7F36706 
X-CRM114-Status: GOOD (  11.92  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Thierry et al.

I noticed that since commit 3dde5a2342cd ("ARM: tegra: Add VIC on
Tegra124") graphics on Apalis TK1 is broken. During boot it fails
loading the vic firmware:

[    1.595824] tegra-vic 54340000.vic: Direct firmware load for
nvidia/tegra124/vic03_ucode.bin failed with error -2
[    1.606140] tegra-vic: probe of 54340000.vic failed with error -2

Subsequently Tegra HDMI seems to fail completely:

[    2.379860] tegra-hdmi 54280000.hdmi: failed to get PLL regulator

And finally, Nouveau even crashes:

[    8.241115] nouveau 57000000.gpu: Linked as a consumer to
regulator.31
[    8.247889] nouveau 57000000.gpu: NVIDIA GK20A (0ea000a1)
[    8.253396] nouveau 57000000.gpu: imem: using IOMMU
[    8.270210] Unable to handle kernel NULL pointer dereference at
virtual address 0000006c
[    8.278340] pgd = (ptrval)
[    8.281250] [0000006c] *pgd=00000000
[    8.284944] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[    8.290260] Modules linked in: nouveau(+) ttm
[    8.294625] CPU: 2 PID: 203 Comm: systemd-udevd Not tainted 4.20.0-
rc5-next-20181207-00008-g85b0f8e25f86-dirty #110
[    8.305055] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[    8.311331] PC is at drm_plane_register_all+0x18/0x50
[    8.316373] LR is at drm_modeset_register_all+0xc/0x70
[    8.321513] pc : [<c056200c>]    lr : [<c0564cc8>]    psr: a0060013
[    8.327768] sp : ed527c70  ip : ecc43ec0  fp : 00000000
[    8.332993] r10: 00000016  r9 : ecc43e80  r8 : 00000000
[    8.338209] r7 : bf182c80  r6 : 00000000  r5 : ed61b24c  r4 :
fffffffc
[    8.344735] r3 : 0002f000  r2 : ffffffff  r1 : 2e124000  r0 :
ed61b000
[    8.351260] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA
ARM  Segment none
[    8.358383] Control: 10c5387d  Table: ad64c06a  DAC: 00000051
[    8.364127] Process systemd-udevd (pid: 203, stack limit =
0x(ptrval))
[    8.370654] Stack: (0xed527c70 to 0xed528000)
[    8.375004] 7c60:                                     ed61b000
ed61b000 00000000 c0564cc8
[    8.383177] 7c80: ed61b000 00000000 00000000 c054b5b8 00000001
00000001 ffffffff ffffffff
[    8.391355] 7ca0: ed527cc0 c0f08c48 ed61b000 00000000 00000000
00000000 bf180c5c bf0dc900
[    8.399531] 7cc0: eda29208 5dfe844b 00000000 ee9f2a10 00000000
bf180c5c 00000000 c05a9328
[    8.407695] 7ce0: c1006828 ee9f2a10 c100682c 00000000 00000000
c05a744c ee9f2a10 bf180c5c
[    8.415871] 7d00: ee9f2a44 c05a77a8 00000000 c0f08c48 bf182980
c05a769c eefd14d0 c05a77a8
[    8.424048] 7d20: 00000000 ee9f2a10 bf180c5c ee9f2a44 c05a77a8
00000000 c0f08c48 bf182980
[    8.432226] 7d40: 00000000 c05a7884 ee9ebfb4 c0f08c48 bf180c5c
c05a5790 00000000 ee88135c
[    8.440405] 7d60: ee9ebfb4 5dfe844b c0f71168 bf180c5c ee379e80
c0f71168 00000000 c05a692c
[    8.448570] 7d80: bf15dc00 bf180ac8 ffffe000 bf180c5c bf180ac8
ffffe000 bf1aa000 c05a84a0
[    8.456746] 7da0: bf182b80 bf180ac8 ffffe000 bf1aa170 c0fbd220
c0f08c48 ffffe000 c0102ed0
[    8.464924] 7dc0: ed53f4c0 006000c0 c01b3d98 0000000c 60000113
bf182980 00000040 c02592d0
[    8.473102] 7de0: eda60200 2e124000 ee800000 006000c0 006000c0
c01b3d98 0000000c c025a8cc
[    8.481281] 7e00: c024ce54 a0000113 bf182980 5dfe844b bf182980
00000002 ed53f4c0 00000002
[    8.489459] 7e20: eceba000 c01b3dd4 c0f08c48 bf182980 00000000
ed527f40 00000002 eceb9fc0
[    8.497625] 7e40: 00000002 c01b61a4 bf18298c 00007fff bf182980
c01b2f88 00000000 c01b279c
[    8.505800] 7e60: bf1829c8 bf182a80 bf182b6c bf182ab0 c0b03ab0
c0d58964 c0ca726c c0ca7278
[    8.513978] 7e80: c0ca72d0 c0f08c48 00000000 c02654a0 00000000
00000000 ffffe000 bf000000
[    8.522157] 7ea0: 00000000 00000000 00000000 00000000 00000000
00000000 6e72656b 00006c65
[    8.530336] 7ec0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    8.538502] 7ee0: 00000000 00000000 00000000 00000000 00000000
5dfe844b 7fffffff c0f08c48
[    8.546677] 7f00: 00000000 0000000f b6f761cc c0101204 ed526000
0000017b 004a3270 c01b66a4
[    8.554855] 7f20: 7fffffff 00000000 00000003 00000001 004a3270
f0ced000 06e8994c 00000000
[    8.563032] 7f40: f0e37f3a f0e50a40 f0ced000 06e8994c f7b75f9c
f7b75d34 f63e62dc 0016b000
[    8.571209] 7f60: 0017f6f0 00000000 00000000 00000000 00050a48
0000003b 0000003c 00000023
[    8.579388] 7f80: 00000000 00000014 00000000 5dfe844b 00000000
004c0ec0 00000000 00000001
[    8.587554] 7fa0: 0000017b c0101000 004c0ec0 00000000 0000000f
b6f761cc 00000000 00020000
[    8.595730] 7fc0: 004c0ec0 00000000 00000001 0000017b 0048e114
00000000 00000000 004a3270
[    8.603908] 7fe0: bea8f990 bea8f980 b6f71269 b6e9f6c0 400d0010
0000000f 00000000 00000000
[    8.612096] [<c056200c>] (drm_plane_register_all) from [<c0564cc8>]
(drm_modeset_register_all+0xc/0x70)  
[    8.621499] [<c0564cc8>] (drm_modeset_register_all) from
[<c054b5b8>] (drm_dev_register+0x168/0x1c4)
[    8.630855] [<c054b5b8>] (drm_dev_register) from [<bf0dc900>]
(nouveau_platform_probe+0x6c/0x88 [nouveau])
[    8.640739] [<bf0dc900>] (nouveau_platform_probe [nouveau]) from
[<c05a9328>] (platform_drv_probe+0x48/0x98)
[    8.650574] [<c05a9328>] (platform_drv_probe) from [<c05a744c>]
(really_probe+0x1e0/0x2cc)
[    8.658827] [<c05a744c>] (really_probe) from [<c05a769c>]
(driver_probe_device+0x60/0x16c)
[    8.667096] [<c05a769c>] (driver_probe_device) from [<c05a7884>]
(__driver_attach+0xdc/0xe0)
[    8.675543] [<c05a7884>] (__driver_attach) from [<c05a5790>]
(bus_for_each_dev+0x74/0xb4)
[    8.683729] [<c05a5790>] (bus_for_each_dev) from [<c05a692c>]
(bus_add_driver+0x1c0/0x204)
[    8.692004] [<c05a692c>] (bus_add_driver) from [<c05a84a0>]
(driver_register+0x74/0x108)
[    8.700324] [<c05a84a0>] (driver_register) from [<bf1aa170>]
(nouveau_drm_init+0x170/0x1000 [nouveau])   
[    8.709857] [<bf1aa170>] (nouveau_drm_init [nouveau]) from
[<c0102ed0>] (do_one_initcall+0x54/0x284)
[    8.718980] [<c0102ed0>] (do_one_initcall) from [<c01b3dd4>]
(do_init_module+0x64/0x214)
[    8.727079] [<c01b3dd4>] (do_init_module) from [<c01b61a4>]
(load_module+0x21b8/0x246c)
[    8.735094] [<c01b61a4>] (load_module) from [<c01b66a4>]
(sys_finit_module+0xc4/0xdc)
[    8.742937] [<c01b66a4>] (sys_finit_module) from [<c0101000>]
(ret_fast_syscall+0x0/0x54)
[    8.751114] Exception stack(0xed527fa8 to 0xed527ff0)
[    8.756157] 7fa0:                   004c0ec0 00000000 0000000f
b6f761cc 00000000 00020000
[    8.764333] 7fc0: 004c0ec0 00000000 00000001 0000017b 0048e114
00000000 00000000 004a3270
[    8.772510] 7fe0: bea8f990 bea8f980 b6f71269 b6e9f6c0
[    8.777556] Code: e5b5424c e1550004 0a00000c e2444004 (e5943070)
[    8.784011] ---[ end trace ad8c21587c118655 ]---

Of course my root file system does include resp. vic firmware:

7ef01d2e3f507c91ca79584e89edcc64  /lib/firmware/nvidia/tegra124/vic03_u
code.bin

If I bake that one into the kernel binary, Nouveau still crashes like
above albeit VIC loading and Tegra DRM now at least showing something
on HDMI.

Just reverting above mentioned commit still leaves Nouveau crashing.

This has been observed using latest next-20181207.

Does anybody know what exactly is going on and how exactly one may get
graphics working again as before?

Thanks!

Cheers

Marcel
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
