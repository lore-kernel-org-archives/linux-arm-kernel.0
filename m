Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05CDC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:13:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 471A7217D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oZIt6iLF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeYDCG5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 471A7217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EkPUrbcK2VPFaYQhomKt6QQDxBSh+Vl6aeK0K8QaW0o=; b=oZIt6iLFI+UC/0
	mJkYGzQfHPep/dIgNfqwz+REeHqBe487gk16BwRgD2PbltKxvQWRZ3hrDIVNZKGOf1GcNj/OFjCsG
	h0JXwj5HkzucN1Km6/jdg+y24mAiwvyLilgYmxr+Om/w0j2VM8TxS/1sfiVfQGIQHcTbGgdOnMeE2
	2VnvGNJ9NxD7mZm0QhKEnqPmWkbjREJTx10mMJSGM6W975hokkOdAcnsEk7mLODv7bhP4hpguxm/D
	R5gbYaa/EsjWbiYzQAA3qguLqOOHMjflOi8ZSmZgv+9tHuy/4aPmlk1jENqSj7juwcMFP2bqnRIgH
	2CXuF4RZ8/AdXUp3z+BA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmKDS-0004Lm-8i; Wed, 23 Jan 2019 15:13:22 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmKCu-0003wD-53; Wed, 23 Jan 2019 15:12:55 +0000
Received: by mail-pl1-x641.google.com with SMTP id a14so1305349plm.12;
 Wed, 23 Jan 2019 07:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SsI2Oo5b+BTLRrtwVfiZrN//xsqFal3BRU4y2fjWF/U=;
 b=IeYDCG5izP4yT2qHZf9iIV9qG6SWyIw6VBe0m6k8yU6SISfW7sCFq8zPCbf7KTAxlo
 //2w07f59PsQa2CcABObUHig1EcmliXbOw8F3bpDUBNVvftKdgbxf2UF68Tpes00VSYs
 8XXjBmwenlwx8jFlDC9MPnsZfPbA3EQvaEApws2lzBjYFWKIArGTBeBNtFCt69Vs13Zi
 9NYqcwFti+QDq8+yLKOKDF1ir78+eL4ZREbkumrgQDO3mJhhZE6CJhLv43w4Nnw38MME
 PvU8mce49Ami9cI6E+gdDDI/r0mLwwWZmZdUPtdwgkAGbVjcDy4ZE+7xu1Lgy52q84lS
 WClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SsI2Oo5b+BTLRrtwVfiZrN//xsqFal3BRU4y2fjWF/U=;
 b=bWCgm1eTutRwZ7B4i84azD5BCGdkokGmcgCZfBql2GxDaI6HCTx4NimiPI+Nuq9N9q
 De16xU2hSaZBxnfVFg67fFtQAcwokMUYdo5RoE/+H49xizdJSv95/IMR1XtQczPpqGwO
 3FDwc5R579t3P5ygbsqzudEjhy41BKJLWoSyUduEwZS1i3sQ2v0m2ZmQXpe3WuHVWH1Y
 NDdA7kXcGkRMmN1UffAiGO64STRNwgjWui7YRdKkuA7wK+yIBbNJGyIN/s7D13+yPN/2
 jCWFIPz5/eZ7goS+ZhV4GLs4EHr12F4DUVHJDctwVNMGlG5OKGINRqGKKoLxy3TtPoYO
 9dSQ==
X-Gm-Message-State: AJcUukdA2e2NiIGyEyp5jQCqtb3k/E3sdKTRzwz2fG/uuEmuYJeJ8/An
 PlE8sQEoF8nxJ7YezJfKAyenPl5C
X-Google-Smtp-Source: ALg8bN5y5UemPS70Q/kz1U0LbopJSZ5IWUeS137w9iYDNKHoW0AMgMGAOHFONTuaP7dL4VH2QMVQhA==
X-Received: by 2002:a17:902:850c:: with SMTP id
 bj12mr2536937plb.46.1548256367290; 
 Wed, 23 Jan 2019 07:12:47 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.133])
 by smtp.gmail.com with ESMTPSA id v9sm24772468pfe.49.2019.01.23.07.12.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Jan 2019 07:12:46 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org
Subject: [RFCv1 3/3] ARM: dts: meson8b: odroidc1: enable the OTG capable USB
 controller
Date: Wed, 23 Jan 2019 15:12:09 +0000
Message-Id: <20190123151209.2080-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190123151209.2080-1-linux.amoon@gmail.com>
References: <20190123151209.2080-1-linux.amoon@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_071248_472159_E9CCE394 
X-CRM114-Status: GOOD (  12.34  )
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
Cc: Neil Armstrong <narmstrong@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 Rob Herring <robh+dt@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Override the dr_mode from "host" to "otg" for USB_HOST controller (usb0)
changes help usb_phy0->usb0 initialization of OTG bus port.

Changes fix the below warning.

[    1.810267] phy phy-c1108800.phy.0: USB ID detect failed!
[    1.814333] phy phy-c1108800.phy.0: phy poweron failed --> -22
[    1.820178] ------------[ cut here ]------------
[    1.824758] WARNING: CPU: 0 PID: 29 at drivers/regulator/core.c:2054 _regulator_put.part.8+0xf8/0xfc
[    1.833884] Modules linked in:
[    1.836907] CPU: 0 PID: 29 Comm: kworker/0:1 Not tainted 5.0.0-rc3-xc1ml #1
[    1.843849] Hardware name: Amlogic Meson platform
[    1.848552] Workqueue: events deferred_probe_work_func
[    1.853683] [<c031222c>] (unwind_backtrace) from [<c030cb74>] (show_stack+0x10/0x14)
[    1.861404] [<c030cb74>] (show_stack) from [<c0e29c78>] (dump_stack+0x8c/0xa0)
[    1.868610] [<c0e29c78>] (dump_stack) from [<c03460c4>] (__warn.part.3+0xbc/0xd8)
[    1.876074] [<c03460c4>] (__warn.part.3) from [<c0346240>] (warn_slowpath_null+0x44/0x4c)
[    1.884236] [<c0346240>] (warn_slowpath_null) from [<c07e20c4>] (_regulator_put.part.8+0xf8/0xfc)
[    1.893093] [<c07e20c4>] (_regulator_put.part.8) from [<c07e20f0>] (regulator_put+0x28/0x38)
[    1.901516] [<c07e20f0>] (regulator_put) from [<c07e2128>] (regulator_bulk_free+0x28/0x38)
[    1.909770] [<c07e2128>] (regulator_bulk_free) from [<c0947f38>] (release_nodes+0x1bc/0x200)
[    1.918191] [<c0947f38>] (release_nodes) from [<c0943f0c>] (really_probe+0x110/0x2cc)
[    1.926005] [<c0943f0c>] (really_probe) from [<c094422c>] (driver_probe_device+0x60/0x16c)
[    1.934256] [<c094422c>] (driver_probe_device) from [<c09423b4>] (bus_for_each_drv+0x80/0xc4)
[    1.942766] [<c09423b4>] (bus_for_each_drv) from [<c0943d8c>] (__device_attach+0xd0/0x138)
[    1.951015] [<c0943d8c>] (__device_attach) from [<c09431c4>] (bus_probe_device+0x84/0x8c)
[    1.959180] [<c09431c4>] (bus_probe_device) from [<c0943660>] (deferred_probe_work_func+0x60/0x8c)
[    1.968127] [<c0943660>] (deferred_probe_work_func) from [<c035fd30>] (process_one_work+0x218/0x504)
[    1.977243] [<c035fd30>] (process_one_work) from [<c0360e20>] (worker_thread+0x2a8/0x5bc)
[    1.985404] [<c0360e20>] (worker_thread) from [<c0365990>] (kthread+0x14c/0x154)
[    1.992785] [<c0365990>] (kthread) from [<c03010e8>] (ret_from_fork+0x14/0x2c)
[    1.999987] Exception stack(0xee0dbfb0 to 0xee0dbff8)
[    2.005027] bfa0:                                     00000000 00000000 00000000 00000000
[    2.013191] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    2.021353] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    2.027984] ---[ end trace 81270e5c573fd4b5 ]---
[    2.032661] ------------[ cut here ]------------
[    2.037162] WARNING: CPU: 0 PID: 29 at drivers/regulator/core.c:2054 _regulator_put.part.8+0xf8/0xfc
[    2.046296] Modules linked in:
[    2.049331] CPU: 0 PID: 29 Comm: kworker/0:1 Tainted: G        W         5.0.0-rc3-xc1ml #1
[    2.057647] Hardware name: Amlogic Meson platform
[    2.062344] Workqueue: events deferred_probe_work_func
[    2.067471] [<c031222c>] (unwind_backtrace) from [<c030cb74>] (show_stack+0x10/0x14)
[    2.075197] [<c030cb74>] (show_stack) from [<c0e29c78>] (dump_stack+0x8c/0xa0)
[    2.082405] [<c0e29c78>] (dump_stack) from [<c03460c4>] (__warn.part.3+0xbc/0xd8)
[    2.089871] [<c03460c4>] (__warn.part.3) from [<c0346240>] (warn_slowpath_null+0x44/0x4c)
[    2.098034] [<c0346240>] (warn_slowpath_null) from [<c07e20c4>] (_regulator_put.part.8+0xf8/0xfc)
[    2.106891] [<c07e20c4>] (_regulator_put.part.8) from [<c07e20f0>] (regulator_put+0x28/0x38)
[    2.115314] [<c07e20f0>] (regulator_put) from [<c07e2128>] (regulator_bulk_free+0x28/0x38)
[    2.123566] [<c07e2128>] (regulator_bulk_free) from [<c0947f38>] (release_nodes+0x1bc/0x200)
[    2.131988] [<c0947f38>] (release_nodes) from [<c0943f0c>] (really_probe+0x110/0x2cc)
[    2.139802] [<c0943f0c>] (really_probe) from [<c094422c>] (driver_probe_device+0x60/0x16c)
[    2.148054] [<c094422c>] (driver_probe_device) from [<c09423b4>] (bus_for_each_drv+0x80/0xc4)
[    2.156564] [<c09423b4>] (bus_for_each_drv) from [<c0943d8c>] (__device_attach+0xd0/0x138)
[    2.164813] [<c0943d8c>] (__device_attach) from [<c09431c4>] (bus_probe_device+0x84/0x8c)
[    2.172978] [<c09431c4>] (bus_probe_device) from [<c0943660>] (deferred_probe_work_func+0x60/0x8c)
[    2.181923] [<c0943660>] (deferred_probe_work_func) from [<c035fd30>] (process_one_work+0x218/0x504)
[    2.191040] [<c035fd30>] (process_one_work) from [<c0360e20>] (worker_thread+0x2a8/0x5bc)
[    2.199201] [<c0360e20>] (worker_thread) from [<c0365990>] (kthread+0x14c/0x154)
[    2.206582] [<c0365990>] (kthread) from [<c03010e8>] (ret_from_fork+0x14/0x2c)
[    2.213785] Exception stack(0xee0dbfb0 to 0xee0dbff8)
[    2.218824] bfa0:                                     00000000 00000000 00000000 00000000
[    2.226989] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    2.235151] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    2.241774] ---[ end trace 81270e5c573fd4b6 ]---
[    2.246415] dwc2: probe of c9040000.usb failed with error -22

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Changes from previous patch.

Fix the subject and commit message as per Martin's request
--Fix the commit message.
--TODO: allthough the bus port is initialization,
  but their is not usb device detected on the otg port.
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index bfa472a679d9..a41912039522 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -323,6 +323,7 @@
 
 &usb0 {
 	status = "okay";
+	dr_mode = "otg";
 };
 
 &usb1 {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
