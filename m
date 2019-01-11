Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36723C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:23:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B5020872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nAmAqDqr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0sqpMDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B5020872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=p1Cq3cICpgJvgn+LQRYETclKa7tgy3PagAkEEQb6eFs=; b=nAmAqDqrCTcJmv
	ZtrN7f9kU/fyFB0Ez96DnOI6ift+bcibA5RTdkfxBI0g/lMN4DOmHtbgMoR3iE57d6ZUO7NE/7CAc
	nkIpkCVwN8IHAAV0qm5+hAMsLeskAWYzOKKPv4FJLMeK2AG5S0WeM5E2xy/6Y0lPOSA7sGvvH3A0p
	jsscWvXqJJycFRDDjExNjjE5pzERlvucKvQfmZnDzW6NlQCVTxY/k6ewNjSc7Ks4v0Zw0kGoZldrC
	QEHpE+gEfs+uGeH6AUs62ivOXUIHSAbtjVP25b48+T+S9palLyBuFF+xhrYkTIpUnG1AwOt3kaeaj
	eH92Yj2EIFDXSqu6gqdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ght1l-00043v-V2; Fri, 11 Jan 2019 09:22:57 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ght1i-00043P-VT; Fri, 11 Jan 2019 09:22:56 +0000
Received: by mail-pl1-x642.google.com with SMTP id w4so6526506plz.1;
 Fri, 11 Jan 2019 01:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JgweMQq5cDlqCc0BvnL1YU2JSCEJOrEfkNsdQxAwwqw=;
 b=l0sqpMDPIdE/maNw/fLRJKTbWowLfopxspHdAIE25mYhqvzXhOTplF3rZjWiShKsBZ
 rTG3O50j7Whgb+DV0Bo0rxqLyJvCcNNv8GXktOrvZjfOIN+doq9K2GSTPKoRFu8YgRPl
 jTnqeCdhTh7ze1gU9PYMlWJ7GeLqoihrmPQLwUG0UzZwIDTtdwt8fMtbY44NlOxCGZsW
 xLAiCWXwWHFp6SvpfvNl/QKq5s3qirPTZ0+W2zyGq2iNESoEX4MMzThUH/aIWbzCFEBJ
 iVh5ZunmTB1rMJMPoh2QN5PepjuNaG8MnHraZa2zC9HOxx5vNVwcW5XnfyvWk/dm0hlo
 mx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JgweMQq5cDlqCc0BvnL1YU2JSCEJOrEfkNsdQxAwwqw=;
 b=PXQMI/sa+Z9FN4C+5AU4EDnqRXYgf+21EJ3GnF/KW2DH3FU/iiMAcm/wRQ7rJGy3YT
 h+3nqA3WeUWkRBt4cbw4kRo4K+a4mIjXNmul7F2FkGqA7S//Sko6IuhXWyysP/kh4Izl
 +vRYputMQjjG9rAtYw9f9hszuet0GtYuXAkrm3nWW8zmabbJ9r2UQe622VWJXw5LDIS8
 JXVRGG+ylWBzJSo4whzNbj8dr8aY86eVwRC8j7tlUg+F7ccvUQQOQSEpeGj5jOB2awNu
 mMddWYtOS2MXEfgT1Nt3u11Gp+Ltjw1OYAg4N+RtBqak39x/C54iHBwMsnhIp8k5qXvO
 N7nA==
X-Gm-Message-State: AJcUukdXkQvdRSnB1mhIgAnAB5dtNQFhA0oYnRLuhdabLu2cvV+oVzuG
 5j6hBfcW05zyQJZOFPAtG1c=
X-Google-Smtp-Source: ALg8bN6BOFiMpCfsaGfi9V6CMp1OM3KTRFl6uy0J+NU7fPZQUsBcHahhHnXodIXBmrFJ2eZHKg7kKw==
X-Received: by 2002:a17:902:7296:: with SMTP id
 d22mr14219890pll.265.1547198574060; 
 Fri, 11 Jan 2019 01:22:54 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.128])
 by smtp.gmail.com with ESMTPSA id u126sm178115558pgb.2.2019.01.11.01.22.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Jan 2019 01:22:53 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM64: dts: meson-gxbb-odroidc2: Fix usb phy regulator warning
Date: Fri, 11 Jan 2019 14:52:35 +0530
Message-Id: <20190111092235.28161-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_012255_039038_56B32CF7 
X-CRM114-Status: GOOD (  12.23  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Neil Armstrong <narmstrong@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Rob Herring <robh+dt@kernel.org>,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add missing vin-supply 5V regulator node on usb_phy nodes needed
to power usb bus ports. Override the dr_mode from "host" to "peripheral"
for initialization of dwc2 usb0 phy node,changes fix the below
warning for usb initialization.

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
[    1.428144] CPU: 1 PID: 44 Comm: kworker/1:1 Tainted: G        W         5.0.0-rc1-xc2ml #3
[    1.436422] Hardware name: Hardkernel ODROID-C2 (DT)
[    1.441340] Workqueue: events deferred_probe_work_func

Fixes: 5a0803bd5ae (ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes)
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Fix the following power issue with usb device

[  795.380156] usb 1-1.2: reset high-speed USB device number 3 using dwc2
[  798.356073] usb 1-1.2: reset high-speed USB device number 3 using dwc2
[  801.331999] usb 1-1.2: reset high-speed USB device number 3 using dwc2
[  804.307919] usb 1-1.2: reset high-speed USB device number 3 using dwc2
[  807.283844] usb 1-1.2: reset high-speed USB device number 3 using dwc2

[alarm@archl-c2m ~]$ lsusb -t
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
        |__ Port 1: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 480M
        |__ Port 2: Dev 5, If 3, Class=Audio, Driver=, 480M
        |__ Port 2: Dev 5, If 1, Class=Video, Driver=uvcvideo, 480M
        |__ Port 2: Dev 5, If 2, Class=Audio, Driver=, 480M
        |__ Port 2: Dev 5, If 0, Class=Video, Driver=uvcvideo, 480M
        |__ Port 3: Dev 3, If 0, Class=Vendor Specific Class, Driver=, 480M

Similar Fix is need for Odroid C1+ to power on the phy nodes
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 2e1cd5e3a246..b4e14ff614c4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -28,6 +28,13 @@
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
+	p5v0: regulator-p5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "P5V0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
 	usb_otg_pwr: regulator-usb-pwrs {
 		compatible = "regulator-fixed";
 
@@ -36,6 +43,8 @@
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 
+		vin-supply = <&p5v0>;
+
 		gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
@@ -303,6 +312,7 @@
 
 &usb0 {
 	status = "okay";
+	dr_mode = "peripheral";
 };
 
 &usb1 {
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
