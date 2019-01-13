Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E070C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 18:18:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25B9B206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 18:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vA0dFVLp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swFYHZlf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B9B206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7JtRBl64jidmhXlXjBlyF01HrSgrayLSm/e75hgRy7M=; b=vA0dFVLppSi/TH
	iL0BrbExwNcUfAm8KfTZa7JnGQKt4xgemDpGwesmG1bqUVGdqG6P2FsU1rHVGzd6hed6KhQUTXwb1
	f91MMoCzJJ4AUwO3+EPFJy0J7lk7F2Uqi37jX2R8mQ53HUzwG5mtQor83Lg9jn8p5PhAhk1lGjkgU
	buGavrplKlCBlIkX4mJIy1DFPA9zQeURqq3Ly6kJYXuHwKAnUuBNIVH3qbkFw7V8imZm3k1wkO5d6
	G/PDnVd1iaVePpEdpHLGx8kJssjTcykkQR2eLY33rYfrXazt9Z/HCnrvNxAsJyJ+F8545ZSbRUgvB
	VBETbGQTa/Mo2fgPMsyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gikLN-0008SX-2y; Sun, 13 Jan 2019 18:18:45 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gikL7-0008EK-A0; Sun, 13 Jan 2019 18:18:30 +0000
Received: by mail-pg1-x544.google.com with SMTP id w6so8483176pgl.6;
 Sun, 13 Jan 2019 10:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qh1Vvz9nFt0zbkJ37Q8bDQfJww+y6baj77fJu8mv98I=;
 b=swFYHZlfdSg6jCEkobODwgnPuE6nEjJPb3gCppvr+w/wWhlYMhNhkpdli0TsuPs1xU
 LiPfvXrWVD1YZenmBCRbBIUcU1NlxKLj6noaSmaDDwGEay1PQS82tug/nRt3b5ySrrib
 JhQKHQI43TFPHc26H7D99Jyos/romqrC0+XSFier8LOeAasMYNDbUDjCNhVa6x0dow96
 3aeCwoGWgnwlVFQ8xb/nTEd5B0kfJ3pq8t2W8BO+waZg/pvzoQ916HYusyXU6idwrx8q
 nY1OMC/wh0r7BpKC1hLlyPmx4pJFx0r7h8epi8w8h6HnDQHHTO8nrzvp3eqbUvvOv/ey
 ycKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qh1Vvz9nFt0zbkJ37Q8bDQfJww+y6baj77fJu8mv98I=;
 b=mXZvWUDgKcJr4UlN3cFDGRsK3XSu/ZGI5G03H7F0w88viFQgC5FRRiZiTzMGI8oi3F
 jy12gHjZc5GgDInNlpcrmsQx4d+R8x0ZnCEWHwutnpTpekTYtX7+qrAR0zx7k0fkDfEf
 jOH1iOh93i8dJjK+q0yp0p70xyqeBB6H06kdGMlYQYiQlIl42DR+EOIE0dFtVB5Wx52w
 jxkgbx7gy79AUCzfMI7qMW1EKb6OtuWmd1Dq/0Jh4onn5Rh/5//wJPcvs5PuO5tESSCk
 MN+m+fCtn0lDSWSb7kYjnjDh2utFUJSxGmi8YigRaQ7v3gVUEYcXUnAOXZsLZ91cvMVv
 EtuA==
X-Gm-Message-State: AJcUukfNJWv4gnheul3cMi3j9TjEqPP6hZK7+5X/U2IhM40jL9fRN1Gz
 hYXNLcZhJQkNYUMoDBqBcZ4=
X-Google-Smtp-Source: ALg8bN5zH9qH94ZZJjYOfVGfLt2TvQIJ/wKbeMQOEPYGeoGwZN29QJ8K9d3ZnoCFHJQyGixOX2BN9A==
X-Received: by 2002:a63:9b11:: with SMTP id r17mr20476965pgd.416.1547403508296; 
 Sun, 13 Jan 2019 10:18:28 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.105])
 by smtp.gmail.com with ESMTPSA id i193sm157504416pgc.22.2019.01.13.10.18.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 13 Jan 2019 10:18:27 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: meson8b: odroidc1: Fix usb phy regulator power
 failed warning
Date: Sun, 13 Jan 2019 18:18:08 +0000
Message-Id: <20190113181808.5768-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190113181808.5768-1-linux.amoon@gmail.com>
References: <20190113181808.5768-1-linux.amoon@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_101829_356516_09F56E9F 
X-CRM114-Status: GOOD (  11.79  )
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
 Kevin Hilman <khilman@baylibre.com>, Rob Herring <robh+dt@kernel.org>,
 Emiliano Ingrassia <ingrassia@epigenesys.com>,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Override the dr_mode from "host" to "peripheral" for dwc2
usb_phy0->usb0 initialization of OTG Micro-B type.
Changes fix the below warning for phy poweron failed --> -22

This fix the initialization of c9040000.usb phy.

[    1.639706] phy phy-c1108800.phy.0: USB ID detect failed!
[    1.643850] phy phy-c1108800.phy.0: phy poweron failed --> -22
[    1.649706] ------------[ cut here ]------------
[    1.654273] WARNING: CPU: 0 PID: 29 at drivers/regulator/core.c:2054 _regulator_put.part.8+0xf8/0xfc
[    1.663400] Modules linked in:
[    1.666439] CPU: 0 PID: 29 Comm: kworker/0:1 Not tainted 4.20.0-xc1ml #11
[    1.673192] Hardware name: Amlogic Meson platform
[    1.677894] Workqueue: events deferred_probe_work_func
[    1.683027] [<c0312204>] (unwind_backtrace) from [<c030cb8c>] (show_stack+0x10/0x14)
[    1.690746] [<c030cb8c>] (show_stack) from [<c0e223b8>] (dump_stack+0x8c/0xa0)
[    1.697953] [<c0e223b8>] (dump_stack) from [<c0346334>] (__warn.part.3+0xbc/0xd8)
[    1.705418] [<c0346334>] (__warn.part.3) from [<c03464b0>] (warn_slowpath_null+0x44/0x4c)
[    1.713579] [<c03464b0>] (warn_slowpath_null) from [<c07df6b8>] (_regulator_put.part.8+0xf8/0xfc)
[    1.722437] [<c07df6b8>] (_regulator_put.part.8) from [<c07df6e4>] (regulator_put+0x28/0x38)
[    1.730859] [<c07df6e4>] (regulator_put) from [<c07df71c>] (regulator_bulk_free+0x28/0x38)
[    1.739112] [<c07df71c>] (regulator_bulk_free) from [<c0943858>] (release_nodes+0x1bc/0x200)
[    1.747537] [<c0943858>] (release_nodes) from [<c093f82c>] (really_probe+0x110/0x2cc)
[    1.755350] [<c093f82c>] (really_probe) from [<c093fb4c>] (driver_probe_device+0x60/0x16c)
[    1.763599] [<c093fb4c>] (driver_probe_device) from [<c093dcd4>] (bus_for_each_drv+0x80/0xc4)
[    1.772110] [<c093dcd4>] (bus_for_each_drv) from [<c093f6ac>] (__device_attach+0xd0/0x138)
[    1.780359] [<c093f6ac>] (__device_attach) from [<c093eae4>] (bus_probe_device+0x84/0x8c)
[    1.788522] [<c093eae4>] (bus_probe_device) from [<c093ef80>] (deferred_probe_work_func+0x60/0x8c)
[    1.797470] [<c093ef80>] (deferred_probe_work_func) from [<c035fdb8>] (process_one_work+0x218/0x504)
[    1.806585] [<c035fdb8>] (process_one_work) from [<c0360ea8>] (worker_thread+0x2a8/0x5bc)
[    1.814748] [<c0360ea8>] (worker_thread) from [<c0365a18>] (kthread+0x14c/0x154)
[    1.822128] [<c0365a18>] (kthread) from [<c03010e8>] (ret_from_fork+0x14/0x2c)
[    1.829331] Exception stack(0xee0ebfb0 to 0xee0ebff8)
[    1.834369] bfa0:                                     00000000 00000000 00000000 00000000
[    1.842534] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.850695] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    1.857311] ---[ end trace e28bbc26874282a4 ]---
[    1.861984] ------------[ cut here ]------------
[    1.866524] WARNING: CPU: 0 PID: 29 at drivers/regulator/core.c:2054 _regulator_put.part.8+0xf8/0xfc
[    1.875629] Modules linked in:
[    1.878658] CPU: 0 PID: 29 Comm: kworker/0:1 Tainted: GW         4.20.0-xc1ml #11
[    1.886817] Hardware name: Amlogic Meson platform
[    1.891513] Workqueue: events deferred_probe_work_func
[    1.896641] [<c0312204>] (unwind_backtrace) from [<c030cb8c>] (show_stack+0x10/0x14)
[    1.904366] [<c030cb8c>] (show_stack) from [<c0e223b8>] (dump_stack+0x8c/0xa0)
[    1.911573] [<c0e223b8>] (dump_stack) from [<c0346334>] (__warn.part.3+0xbc/0xd8)
[    1.919041] [<c0346334>] (__warn.part.3) from [<c03464b0>] (warn_slowpath_null+0x44/0x4c)
[    1.927203] [<c03464b0>] (warn_slowpath_null) from [<c07df6b8>] (_regulator_put.part.8+0xf8/0xfc)
[    1.936060] [<c07df6b8>] (_regulator_put.part.8) from [<c07df6e4>] (regulator_put+0x28/0x38)
[    1.944483] [<c07df6e4>] (regulator_put) from [<c07df71c>] (regulator_bulk_free+0x28/0x38)
[    1.952734] [<c07df71c>] (regulator_bulk_free) from [<c0943858>] (release_nodes+0x1bc/0x200)
[    1.961159] [<c0943858>] (release_nodes) from [<c093f82c>] (really_probe+0x110/0x2cc)
[    1.968974] [<c093f82c>] (really_probe) from [<c093fb4c>] (driver_probe_device+0x60/0x16c)
[    1.977224] [<c093fb4c>] (driver_probe_device) from [<c093dcd4>] (bus_for_each_drv+0x80/0xc4)
[    1.985734] [<c093dcd4>] (bus_for_each_drv) from [<c093f6ac>] (__device_attach+0xd0/0x138)
[    1.993984] [<c093f6ac>] (__device_attach) from [<c093eae4>] (bus_probe_device+0x84/0x8c)
[    2.002147] [<c093eae4>] (bus_probe_device) from [<c093ef80>] (deferred_probe_work_func+0x60/0x8c)
[    2.011092] [<c093ef80>] (deferred_probe_work_func) from [<c035fdb8>] (process_one_work+0x218/0x504)
[    2.020209] [<c035fdb8>] (process_one_work) from [<c0360ea8>] (worker_thread+0x2a8/0x5bc)
[    2.028371] [<c0360ea8>] (worker_thread) from [<c0365a18>] (kthread+0x14c/0x154)
[    2.035752] [<c0365a18>] (kthread) from [<c03010e8>] (ret_from_fork+0x14/0x2c)
[    2.042955] Exception stack(0xee0ebfb0 to 0xee0ebff8)
[    2.047993] bfa0:                                     00000000 00000000 00000000 00000000
[    2.056158] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    2.064320] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    2.070934] ---[ end trace e28bbc26874282a5 ]---

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Rebased on Kevin's amlogic/v5.0/fixes branch
Note the warning is not getting produced on the latest kernel.
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index a49a8509b288..9d7f725cfe35 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -318,6 +318,7 @@
 
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
