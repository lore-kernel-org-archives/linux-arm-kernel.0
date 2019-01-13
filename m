Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB39C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 15:30:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F1F620675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 15:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XTuLTk7E";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHhYTRi7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1F620675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Ww6It6xOvQWLU+5KCuqKvyIGzP2uAWKm/PNdHhG+hHc=; b=XTuLTk7E8H6+Ty
	dqTVQBArMxP7n6MwPiLezd4RQdTqR5W7leex7UyAKjOCHiCmviT4jZf55iJf9sdEPvvu5yHlEPQBN
	e55t/xM+DE87X875otrcDTrDh4FNLk72lH8bvKP8k9kUudPatzTOUYYwNWpNcE6XO5i/vLrwmHgQu
	iGTGu9qPMzgMD8dafHaxTnGNj84soMsWTXWUF6/tISYNSzknGz/w0gdD/F/hh4CfWeFKDqS1YvfUI
	oLKf07PeUYlFj65iudMCdpSGA2saHor6A/91zl7qa6kP///G9TkoIE7At0/moI3gBNJHGi37nVfw5
	OYgaX9F7s0PTG6x8tE4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gihif-0002mZ-R8; Sun, 13 Jan 2019 15:30:37 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gihic-0002kB-EC; Sun, 13 Jan 2019 15:30:36 +0000
Received: by mail-pl1-x641.google.com with SMTP id y1so8972802plp.9;
 Sun, 13 Jan 2019 07:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Yxtl4xAhD5jcWinVdYK9YK7xH7lUQQ4/XKSFL5L2mM0=;
 b=oHhYTRi7JNmPhsBKis+XD+K3QM+wiVEuKDRqRpv32qZdvxAVuQrNFq1jhAh9ez3c0M
 xH1YoxjRIOEpInNxhqBLJtNWMVj3cp4R92X1oOGw8LGhPIgUlNKV8AoXfHab1joolAd3
 0Z1QyMTyPV9qTDTijnT0uIwKnHJ5yvt7pmv8uE77dpF9rNnKgZvaFDuJS8Z74i6Nan/x
 FBjsg7qJeZghj/fZFRjUZTEaInBOVJyBWLPFlkxjUhyexdftFqu6zwByNc9kkF1y5kg8
 NZRqqVL1CC3mPHozuKChzgAxMjJfwrivvxFiblGswC8r7ycUZKGwGCOcv3gFSe+7RzT2
 jlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Yxtl4xAhD5jcWinVdYK9YK7xH7lUQQ4/XKSFL5L2mM0=;
 b=FX9lNbElVJS9MddQa+sGA0UkT2WZeaCkDa1vihw8wkgCRP9Bz9cZwtaa9WbkZcU+w/
 exnlGPZuLtmRC42NkeKZ9h8alxet7z0RhEEbzD0PoDKjSEBT5P+SfX1IF4rKQ5coN1fD
 6x4vILpMgUCTrSQgmrsnyzUZmcdkTUzsFLtuiAa3xxnjBiLDPjNBac83ueky4LRjg1w4
 84Y0dLB8Hhn8I72YzfVn9pP7PnFmTkvLvJvrKAYY2M6SL2e5gHNDCtg7PcWWdquq2fMp
 MGaAneyxX/PVkn8gyAQG7IyhONUMyha402WdEEXITHfbhqet93wrQvcgfJN7BLA99SYi
 VxkQ==
X-Gm-Message-State: AJcUukfVYZYqd5X0SMn8fdiKC/nY1IRC7UgnadOTRebPwXECrD5ILVUj
 nEtFS478IbowxDsI2e+rVeo=
X-Google-Smtp-Source: ALg8bN4ZzS45dTfO0vrp9LSOssKJOEmHnS09cR+HpEAGROLEZo1cRUyuXRVbhUr36hBOaxvG2UlSiQ==
X-Received: by 2002:a17:902:48:: with SMTP id 66mr21525803pla.68.1547393432501; 
 Sun, 13 Jan 2019 07:30:32 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.105])
 by smtp.gmail.com with ESMTPSA id r187sm265107745pfc.63.2019.01.13.07.30.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 13 Jan 2019 07:30:31 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PatchV2 1/2] ARM64: dts: meson-gxbb-odroidc2: Fix usb phy regulator
 power failed warning
Date: Sun, 13 Jan 2019 15:30:21 +0000
Message-Id: <20190113153022.5040-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_073034_504789_7E6C2A12 
X-CRM114-Status: GOOD (  10.53  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Rob Herring <robh+dt@kernel.org>,
 Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Override the dr_mode from "host" to "peripheral" for dwc2
usb_phy0->usb0 initilization of OTG Micro-B type.
Changes fix the below warning for phy poweron failed --> -22

Changes fix the initialization of c9000000.usb phy

[    1.203900] phy phy-c0000000.phy.0: USB ID detect failed!
[    1.208048] phy phy-c0000000.phy.0: phy poweron failed --> -22
[    1.213877] WARNING: CPU: 1 PID: 44 at drivers/regulator/core.c:2054 _regulator_put.part.11+0xf0/0xf8
[    1.222953] Modules linked in:
[    1.225976] CPU: 1 PID: 44 Comm: kworker/1:1 Not tainted 5.0.0-rc1-xc2ml #3
[    1.232872] Hardware name: Hardkernel ODROID-C2 (DT)
[    1.237794] Workqueue: events deferred_probe_work_func
[    1.242878] pstate: 80000005 (Nzcv daif -PAN -UAO)
[    1.247623] pc : _regulator_put.part.11+0xf0/0xf8
[    1.252280] lr : regulator_put+0x34/0x48
[    1.256159] sp : ffff00001176bb00
[    1.259437] x29: ffff00001176bb00 x28: 0000000000000000
[    1.264698] x27: ffff80007f31beb8 x26: ffff000010eeb7e0
[    1.269959] x25: 0000000000000000 x24: 0000000000000009
[    1.275220] x23: ffff00001176bbc8 x22: ffff80007ed9d500
[    1.280482] x21: ffff0000111bd6c8 x20: ffff80007ed9d700
[    1.285743] x19: ffff80007ed9d700 x18: 000000000000006f
[    1.291004] x17: 0000000000000000 x16: 0000000000000000
[    1.296265] x15: 0000000000000400 x14: 0000000000000400
[    1.301527] x13: ff00000000000000 x12: ffffffffffffffff
[    1.306788] x11: 0000000000000038 x10: 0000000000000040
[    1.312049] x9 : ffff0000111d58b0 x8 : ffff0000111d58a8
[    1.317310] x7 : ffff80007ed9db00 x6 : ffff80007ec21b00
[    1.322571] x5 : ffff80007f400248 x4 : ffff80007fba9b00
[    1.327833] x3 : ffff0000112d9eb8 x2 : ffff80007ec21b00
[    1.333094] x1 : 0000000000000000 x0 : 0000000000000001
[    1.338356] Call trace:
[    1.340773]  _regulator_put.part.11+0xf0/0xf8
[    1.345085]  regulator_put+0x34/0x48
[    1.348621]  regulator_bulk_free+0x30/0x50
[    1.352675]  devm_regulator_bulk_release+0x18/0x20
[    1.357421]  release_nodes+0x1b0/0x220
[    1.361127]  devres_release_all+0x34/0x50
[    1.365094]  really_probe+0xec/0x290
[    1.368630]  driver_probe_device+0x54/0xe8
[    1.372684]  __device_attach_driver+0xb8/0xe8
[    1.376997]  bus_for_each_drv+0x78/0xc8
[    1.380792]  __device_attach+0xd4/0x130
[    1.384587]  device_initial_probe+0x10/0x18
[    1.388727]  bus_probe_device+0x90/0x98
[    1.392522]  deferred_probe_work_func+0x6c/0xa0
[    1.397010]  process_one_work+0x1e0/0x318
[    1.400975]  worker_thread+0x228/0x428
[    1.404684]  kthread+0x124/0x128
[    1.407876]  ret_from_fork+0x10/0x18
[    1.411410] ---[ end trace de5fd1b262c1f56a ]---
[    1.416055] WARNING: CPU: 1 PID: 44 at drivers/regulator/core.c:2054 _regulator_put.part.11+0xf0/0xf8
[    1.425123] Modules linked in:
[    1.428144] CPU: 1 PID: 44 Comm: kworker/1:1 Tainted: GW 5.0.0-rc1-xc2ml #3
[    1.436422] Hardware name: Hardkernel ODROID-C2 (DT)
[    1.441340] Workqueue: events deferred_probe_work_func

Fixes: 5a0803bd5ae (ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes)
Tested-by: Kevin Hilman <khilman@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Rebased on Kevin's amlogic/v5.0/fixes branch
Changes from patch v1 [0] https://lore.kernel.org/patchwork/patch/1031243/
- Split the patch into two part
- Fix the commit message
- Added Tested by Kevin Hilman
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 1cc9dc68ef00..25a36d117183 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -302,6 +302,7 @@
 
 &usb0 {
 	status = "okay";
+	dr_mode = "peripheral";
 };
 
 &usb1 {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
