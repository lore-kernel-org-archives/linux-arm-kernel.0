Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDF2C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:01:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C99B217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aWM6f0p0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="pmYQ0npJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C99B217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=zYzLQ1dHj5bhR5DX5pczzFwPx1JurBqq4wXarHZuG2k=; b=aWM6f0p0+uJyJf
	lipK3/5zFX3LiUt/UEmRCWoHcY/tGXms+0vev5+NaPUhwTyH62eQ++GfXlAtP+nn3XPBQef8sZb3z
	J7ssRJXTyrPDJGI3PEx6LEDGMVzTzhfhqjVTqtuT6ZiMoTf8ohk4EkGgUcnrIW6abzzr+I6yTsMar
	67URV8Cn7cYWh2X4hGb5KaRBtsIDCxQlBfbV5hrpDxdl8Sn5BvBIGXnZNW9G3NxIGS8QMkTNHbM7l
	SX52B6CWwbtGr1qF8G3EAmCF3yjDUP/aIF4GcfxVRpscMmD5JJOPkSnT3BhZLQkLhtZ2tk60HIgWo
	6QPm7xID8E4Y7JG78q8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsCKz-0002kU-H6; Fri, 08 Feb 2019 20:01:25 +0000
Received: from mail-he1eur02on072d.outbound.protection.outlook.com
 ([2a01:111:f400:fe05::72d]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsCKl-0002cp-94
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 20:01:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnNsFQDhbcqVjmDHwLRWRL2t6NcQKxPV7y8Tuags7W4=;
 b=pmYQ0npJ64ivb1WYIAPX41Lz1JJenUQ5wGGTJgUACGwV592gNEu+B69xQc4K8e9K31AJ+BDILNGHsCB/Peu6zE91ne4EBMAqqvz2xPUWwQnoZNE5dbMrDV1iudWVD0nVUZqIGNK0f1Ez7VZqYaN4z2GwADx+qUntFL7UQV7RoUs=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2445.eurprd05.prod.outlook.com (10.168.136.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Fri, 8 Feb 2019 20:01:03 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::ecc4:fecf:6aa7:8e44]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::ecc4:fecf:6aa7:8e44%6]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 20:01:03 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
 <linux-tegra@vger.kernel.org>
Subject: [REGRESSION] drm/tegra: hdmi: tegra_hdmi_setup_audio: division by
 zero in kernel
Thread-Topic: [REGRESSION] drm/tegra: hdmi: tegra_hdmi_setup_audio: division
 by zero in kernel
Thread-Index: AQHUv+kFtqxGkuwKjUCjzQ4r35fWrg==
Date: Fri, 8 Feb 2019 20:01:03 +0000
Message-ID: <87f8fd40b25e2842b547059a8d28295533e8c09c.camel@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [2a01:2a8:8103:a500::2bc]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0501MB2445;
 6:IJFiF6M/TRlm+NckAgnYaiTo5v0j8g8FhfCnX1DI3VK7RKIT9gcYlG5sjuNCejUL8ohF/kcAVQptMLvdSMRA2H10xJDMqKTWlTHtz5xXqh1tdkvCseU2cQF/e1r3sPIUKqWI0hSYSkREFeiTcYHqf1sT5LTR7LuMFWQpimjfLLqktI9zexTnYhpN/nQLOi/dNhb69MNd94ZMItZrAynd5mIddJcvPd9Lihf3k1CfpQchjbIoz2O8/8JI/RpAYXfmiWLN179r2/91HWRe9tclH7rM9Jk98E8d/MqYkRSAPGzth9QehaIeoZTCADCQcPqpKjKD4kkrJs4KA/ncuzTpU/3XwCcMNBy9iNqt2uJf73miHtCurwfHECbJb0VpaUtWg9WQBh5ecS/2t+CPBSysl9jNTA/rcOsf33KxnUoIu9ETAc4zjFBx9QRnjQImRi76MWtIKv6bWjpln6+x6SOVCg==;
 5:Jmk+XS+RGWoO0r8zAC6zqVFSdCwF4fpKk5ncgZsGWw7j64dk8iPTkeQfLMmqMfxpyaH43jZB3SyaKbB+/+fLxfmf5fPp1N6JcePhWQmgDxThswA+MFbPkxGmOQtrwJitftFqEnuQB/Cvy1YTsvHHGu05lkF8BcTeB+dHUY3XM3LCE4q7TU65O69EdKCUzBMRjGMDQeLxsbkPnCireAa2Jw==;
 7:IqkBWWuqCZ55svsgWl7ZH8w7qqQuVo4tvFpZNJYpEU28N1PaL1OMuHYJD8z3A3yQqtXQ2QvcnpXLmKAMAV0ar2jz5wm2vRtDrKxXRb5+CxSoPIi3IEopwWbCiEOAwvTKUYy14+2bue+BdmogLdE2qQ==
x-ms-office365-filtering-correlation-id: 800e5e69-4562-48b5-e85c-08d68e0027ce
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0501MB2445; 
x-ms-traffictypediagnostic: VI1PR0501MB2445:
x-microsoft-antispam-prvs: <VI1PR0501MB2445EAB6C771036E92D4550AFB690@VI1PR0501MB2445.eurprd05.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(376002)(136003)(39850400004)(396003)(199004)(189003)(2616005)(476003)(305945005)(6512007)(44832011)(7736002)(68736007)(6486002)(6436002)(97736004)(46003)(8676002)(81156014)(486006)(81166006)(186003)(8936002)(14444005)(256004)(6506007)(102836004)(2501003)(105586002)(106356001)(36756003)(99286004)(6116002)(54906003)(110136005)(118296001)(316002)(25786009)(478600001)(86362001)(14454004)(53936002)(71190400001)(71200400001)(2906002)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR0501MB2445;
 H:VI1PR0501MB2590.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ne1wg07OsRwAduJJ9d8QL5AtmQg6ClvDshJoiKEwdpxUholqbnVjuDP7PW7FcBLYpYxGZVgqOCNO5T/FKJW4PaZNFwVtSCE5ekGUdB+n6ClJ7KbLusz2Ub7rR0NExRdqiMqwg22TXnbd2X5xSoaNhZYasc6KTXN5xQ16kZKbPnsB0q7f9K9TR2FUG/yH3NTEWvuoG4g2s+qY+IxGBpIB/mtEUQv67GOgFyu2jI2/V0Gs1n740D3zRzNAbH7fovCNeMY0MG54/eqa2Bgi6FXT8GmGWftmj1DteWzG8VGb1vtN7mFLRfM/OsCP5jlIBAgWQ9liTVMy2DEyHm/W1ENY58rnTrstd3L4n7VH6zZCRAtIWmgngYbEjAQ7KwV/MoRfwXgtYfDS2mU5qMRvPG+KKpsf8Jd3F3QI/79m6VSffpk=
Content-ID: <9E8F86072EF4274A861A1C5D6550BD19@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 800e5e69-4562-48b5-e85c-08d68e0027ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 20:01:03.6127 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2445
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_120111_537659_116CCD01 
X-CRM114-Status: UNSURE (   5.51  )
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
Cc: "treding@nvidia.com" <treding@nvidia.com>,
 "alban.bedel@avionic-design.de" <alban.bedel@avionic-design.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi there

I just stumbled over this one:

[   31.026220] Division by zero in kernel.
[   31.026238] CPU: 1 PID: 529 Comm: X Not tainted 5.0.0-rc5-next-
20190208-dirty #153
[   31.026244] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[   31.026281] [<c01120cc>] (unwind_backtrace) from [<c010c92c>]
(show_stack+0x10/0x14)
[   31.026301] [<c010c92c>] (show_stack) from [<c0a7c5ac>]
(dump_stack+0xb4/0xc8)
[   31.026317] [<c0a7c5ac>] (dump_stack) from [<c0a7a7e4>]
(Ldiv0+0x8/0x10)
[   31.026337] [<c0a7a7e4>] (Ldiv0) from [<c0588758>]
(tegra_hdmi_setup_audio+0x1ac/0xed0)
[   31.026353] [<c0588758>] (tegra_hdmi_setup_audio) from [<c0589a68>]
(tegra_hdmi_encoder_enable+0x5ec/0x2a20)
[   31.026379] [<c0589a68>] (tegra_hdmi_encoder_enable) from
[<c054415c>] (drm_atomic_helper_commit_modeset_enables+0x10c/0x220)
[   31.026397] [<c054415c>] (drm_atomic_helper_commit_modeset_enables)
from [<c054449c>] (drm_atomic_helper_commit_tail_rpm+0x24/0x6c)
[   31.026412] [<c054449c>] (drm_atomic_helper_commit_tail_rpm) from
[<c054431c>] (commit_tail+0x40/0x6c)
[   31.026427] [<c054431c>] (commit_tail) from [<c054440c>]
(drm_atomic_helper_commit+0xbc/0x128)
[   31.026443] [<c054440c>] (drm_atomic_helper_commit) from
[<c0547260>] (restore_fbdev_mode_atomic+0x160/0x1cc)
[   31.026457] [<c0547260>] (restore_fbdev_mode_atomic) from
[<c0547420>] (drm_fb_helper_pan_display+0xc4/0x1d0)
[   31.026481] [<c0547420>] (drm_fb_helper_pan_display) from
[<c04b0250>] (fb_pan_display+0x9c/0x118)
[   31.026498] [<c04b0250>] (fb_pan_display) from [<c04b0fdc>]
(do_fb_ioctl+0x4b0/0x7cc)
[   31.026514] [<c04b0fdc>] (do_fb_ioctl) from [<c027e688>]
(do_vfs_ioctl+0xac/0x8f8)
[   31.026527] [<c027e688>] (do_vfs_ioctl) from [<c027ef08>]
(ksys_ioctl+0x34/0x60)
[   31.026540] [<c027ef08>] (ksys_ioctl) from [<c0101000>]
(ret_fast_syscall+0x0/0x54)
[   31.026546] Exception stack(0xcba59fa8 to 0xcba59ff0)
[   31.026559] 9fa0:                   001527a8 00152278 0000000a
00004606 00152808 00000000
[   31.026572] 9fc0: 001527a8 00152278 0015b368 00000036 b6f20961
0000000a bedb5dd4 00000000
[   31.026581] 9fe0: b6af7098 bedb5b1c b6af4603 b6cdb67c
[   31.026586] Division by zero in kernel.
[   31.026595] CPU: 1 PID: 529 Comm: X Not tainted 5.0.0-rc5-next-
20190208-dirty #153
[   31.026600] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[   31.026615] [<c01120cc>] (unwind_backtrace) from [<c010c92c>]
(show_stack+0x10/0x14)
[   31.026629] [<c010c92c>] (show_stack) from [<c0a7c5ac>]
(dump_stack+0xb4/0xc8)
[   31.026640] [<c0a7c5ac>] (dump_stack) from [<c0a7a7e4>]
(Ldiv0+0x8/0x10)
[   31.026654] [<c0a7a7e4>] (Ldiv0) from [<c05887ac>]
(tegra_hdmi_setup_audio+0x200/0xed0)
[   31.026667] [<c05887ac>] (tegra_hdmi_setup_audio) from [<c0589a68>]
(tegra_hdmi_encoder_enable+0x5ec/0x2a20)
[   31.026684] [<c0589a68>] (tegra_hdmi_encoder_enable) from
[<c054415c>] (drm_atomic_helper_commit_modeset_enables+0x10c/0x220)
[   31.026700] [<c054415c>] (drm_atomic_helper_commit_modeset_enables)
from [<c054449c>] (drm_atomic_helper_commit_tail_rpm+0x24/0x6c)
[   31.026715] [<c054449c>] (drm_atomic_helper_commit_tail_rpm) from
[<c054431c>] (commit_tail+0x40/0x6c)
[   31.026729] [<c054431c>] (commit_tail) from [<c054440c>]
(drm_atomic_helper_commit+0xbc/0x128)
[   31.026743] [<c054440c>] (drm_atomic_helper_commit) from
[<c0547260>] (restore_fbdev_mode_atomic+0x160/0x1cc)
[   31.026755] [<c0547260>] (restore_fbdev_mode_atomic) from
[<c0547420>] (drm_fb_helper_pan_display+0xc4/0x1d0)
[   31.026770] [<c0547420>] (drm_fb_helper_pan_display) from
[<c04b0250>] (fb_pan_display+0x9c/0x118)
[   31.026785] [<c04b0250>] (fb_pan_display) from [<c04b0fdc>]
(do_fb_ioctl+0x4b0/0x7cc)
[   31.026797] [<c04b0fdc>] (do_fb_ioctl) from [<c027e688>]
(do_vfs_ioctl+0xac/0x8f8)
[   31.026809] [<c027e688>] (do_vfs_ioctl) from [<c027ef08>]
(ksys_ioctl+0x34/0x60)
[   31.026820] [<c027ef08>] (ksys_ioctl) from [<c0101000>]
(ret_fast_syscall+0x0/0x54)
[   31.026826] Exception stack(0xcba59fa8 to 0xcba59ff0)
[   31.026837] 9fa0:                   001527a8 00152278 0000000a
00004606 00152808 00000000
[   31.026850] 9fc0: 001527a8 00152278 0015b368 00000036 b6f20961
0000000a bedb5dd4 00000000
[   31.026859] 9fe0: b6af7098 bedb5b1c b6af4603 b6cdb67c

This has been observed on a Apalis T30 2GB running todays -next.

Anybody knowing what is going on before I dig deeper?

Cheers

Marcel
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
