Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3439C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:47:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 624732082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ur7bCcsI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EADkc+hD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624732082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C5mbnaM47FBhdb57iX1ba6pIfyXZyCRlBHKyObzsuMU=; b=Ur7bCcsI1Y41j7
	OhlDydH8v+8KRhVwBP9RIFwjNaPP3n5Wov3M9BGL6toDAQ7tZcga64naMhHd3DAeKF3BMgFq9TAFx
	AsviBTNYQaOxeBGCYOmpiP9VxVv1KVTWyfZj9WAmAHcHX1HgGrOx7t31XXkWneLOuskKonOaoeACI
	G966MYR5pqtzQaDK3ECZhs2nEDXuLA9twF/FzqR0Hm1UdHGRfT12rfBUHj66vOo2EIjTGUxRron5A
	GlqMeBL0GPpGCLwM1Dy5zvnNNV1J9Qdv9ITsM5i8fGNCwbj7sR84x3nlLJyr3BVKmnNwuudgKO3Fo
	TIHACB/DqBu5q3qf7GQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVflE-0007CR-MJ; Sat, 08 Dec 2018 16:47:24 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVfkx-0006vU-RL; Sat, 08 Dec 2018 16:47:09 +0000
Received: by mail-wr1-x443.google.com with SMTP id r10so6517860wrs.10;
 Sat, 08 Dec 2018 08:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1p+sohtf5jrUJp2H5mL48UiI2Qzr6hi8YtOOpDvGfZc=;
 b=EADkc+hDTXi2/FipORPTeaAjS/bdPbWuSIZAutntqYHBGlzbMXY5JS3vTpLVjXZi2J
 FOrxgSMHIKWz6v8nDpKIZuFM3M00rgku10gdLcM7Dm/OGmt+O3+XizoGUf5CRpvFZ1qr
 0wRbzpFGoGb3p5scuvrFH6WvIqTMwDt1e8/rbXxh/udVtnqac1vpoqGmQUO7Jnovf7/n
 fFeLxfSbKWaMKX1PYWU2xV/xklsSJ5qeo66PWslK6gCzZW96AKniVjZh6c3gYbclfldk
 7+G0WIn8rOcXFf/Y0FFG+fmezUA0tr/cKH/dg2EAtuvDwNW2+9UNftAtfoWftGQPXgI6
 OZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1p+sohtf5jrUJp2H5mL48UiI2Qzr6hi8YtOOpDvGfZc=;
 b=uS9Fn+Gy6tDoo/mOtUDX6+a+na+PJINRNeAu8Zy6srDzezJ5UZGfUaE1uusAcPjyOJ
 7xP9uIgECjgPK3bRs7uoAXIY4CLJnmW90r0/Z1X9ElRxi94wSxxwqY65G89+DJempQCN
 dKyaLuSZ3CAOeW1rueVlwVaVQUg8eo+gFYqcTk4cSvXUzkJliH3s24InB7jElkc7lnh6
 Xb+9Ix1Vg5o+PPXbwl/WyY7h7PnplFSdFhVOq3Dc0l9Rs2SZ8os4q2FWS2a7bVZDvkln
 2YoRZ0rE+wbbWfIyTMDAC9CBGzGrTdNgMCmQPzjXGHEMdEnOGBmUCr/8B0xf5DDGXpSd
 7xvQ==
X-Gm-Message-State: AA+aEWaBbfBYWKwIisG+Yv/XQsFIBtqexpn2zn7Jo6QI1rWwN4JUOxhZ
 R65Mzvu0LmZtNbO7Ms7CcYWwp7qv
X-Google-Smtp-Source: AFSGD/XYI1mUQp9bBLX2yFDj+vJndJgR28t+Y3rYHO9mkF9yJR7VBtMPt69Xmidy4zR2qBXHA2b2fw==
X-Received: by 2002:a05:6000:1287:: with SMTP id
 f7mr5284042wrx.302.1544287617728; 
 Sat, 08 Dec 2018 08:46:57 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de.
 [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
 by smtp.googlemail.com with ESMTPSA id c9sm11100690wmh.27.2018.12.08.08.46.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Dec 2018 08:46:57 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	khilman@baylibre.com
Subject: [PATCH 2/3] ARM: dts: meson8: add the ABP bus
Date: Sat,  8 Dec 2018 17:45:52 +0100
Message-Id: <20181208164555.26527-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208164555.26527-1-martin.blumenstingl@googlemail.com>
References: <20181208164555.26527-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_084707_884493_9515C366 
X-CRM114-Status: GOOD (  10.46  )
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
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Various peripherals (Mali GPU, NAND controller, VPU, etc.) are located
in the ABP bus. Describe this bus so we can add devices to it.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index e5cd325d7ea8..3fd8260eba92 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -201,6 +201,14 @@
 			no-map;
 		};
 	};
+
+	apb: bus@d0000000 {
+		compatible = "simple-bus";
+		reg = <0xd0000000 0x200000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0xd0000000 0x200000>;
+	};
 }; /* end of / */
 
 &aobus {
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
