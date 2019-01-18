Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315E3C5AE5E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:55:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F16A52084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fw05lzVD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nvZkz3Ai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16A52084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+0o2FVqWY37R/oR7rKGFMJeltWe04UpReJRQ/Rm3yyQ=; b=Fw05lzVD7OVQPm
	k/9OWWTE6nsn5JVYRrkLpEq/CfEhn777iyzAbd3+l+KwzcM3m1is96HkWKvH/9jdDK9zaQT2Y8kBr
	uhySYBiypQCaWMAlcxVaPrrDSURDp3tiETI25hE5cC2Eab+EqRucYMBkEJ+zPcLktSPVoZ9VVGAz/
	YPqbgLKXmSNYWXS8ofbrP+Bj+P6Uin5cT3ktCSb+/ePkMkGl7MizaDoxux6EIpA5bZxqFwGrTwZQR
	uP5uu2eZFk82V0xgM32+yBTW++7HglxDuRLqPcf59gdvyOm3x6h1Kgl48N0HSVevjvoGThARndVzM
	HJAkncERL2uL4MO2fnSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkd2f-00033C-SO; Fri, 18 Jan 2019 22:55:13 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkd0Z-0000ov-Kx; Fri, 18 Jan 2019 22:53:08 +0000
Received: by mail-wm1-x341.google.com with SMTP id y185so1969013wmd.1;
 Fri, 18 Jan 2019 14:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tvVOVw+uJ/NYlsQPCS926U6L3ZI+t9KgIAVNoiuYO3Q=;
 b=nvZkz3AiE1dxyyclBHPE2lr0GIAQR0H2GjEGwnDKSgGwzmCvjXvYDYeUETqPUKA1ka
 0c52ZkAPQ+3ssNomHuSjyV/MWfu95fTB2RIY0Zt7ZLxW2SgU4J9w+9ALpyJctevmLziG
 Ptn/4YTTq1ziOetiIRm2SmuWuseqAy/eJPGrtZiua+CgF7uTOCKhI7VcCLjTQHFW63zh
 2K8F9TzA6eeIW+1sAnSEdtisNjWJgqcGtkDAYw+CqC7MmWJEIg6UU+RlJu/DVEgMisLx
 13Aq0/kVZwz0GncCbkXYxrf9awbqCeA0/5a3yY0DvuM3Rf9mx+2vVrSZFAVKmnRbqSr0
 dryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tvVOVw+uJ/NYlsQPCS926U6L3ZI+t9KgIAVNoiuYO3Q=;
 b=Ya/HwVtUQsFaNhcq0gn4nYKmXbWSa0TAp3+AHni11rzt6KqND8uP8pN7Ky9x+MRBQQ
 N32bUDJWawtZgK1rYJCMo8iS42ZFRN5FhcY/yets5Xq+jkKPCRYh0BfQNMG0g/8uOHNy
 +onngLKfEhtqRE2KkD6cGtANetlAYukcgwRZMDn7tKCY1ATBVvk6gVjpe2DA2MV+HL3k
 SOhHErZqYciNvBUfeFtmLz+djwV8pzWPn7wP3RCE5vAfMVDhxkZlbi8VOAw32KYBsgu1
 R3TuXTW+ZCmRt0k2laSVvAGOzRqOmBRcGLqxlwIe60EJLfgNtY+VtQyZQ/5zpfiXSXJw
 y6rA==
X-Gm-Message-State: AJcUukd0ZOQl8nhPN64dS68bsO2J6HRzwkuZ7LXn56UsVg0hxtEVtfld
 UaD9zXjy3O1FK1iScZeNgfrvSDuK
X-Google-Smtp-Source: ALg8bN6up0q3vhV1gscILKcvjXn2DcWjvO6ZrLKaLxu54MUOLJeIujFcYcYsmQCUs6W9JWvlipdznQ==
X-Received: by 2002:a7b:c142:: with SMTP id z2mr17908657wmi.102.1547851981905; 
 Fri, 18 Jan 2019 14:53:01 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73A810039E290CB771389D7.dip0.t-ipconnect.de.
 [2003:dc:d73a:8100:39e2:90cb:7713:89d7])
 by smtp.googlemail.com with ESMTPSA id
 x186sm51197352wmg.41.2019.01.18.14.53.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 14:53:01 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	khilman@baylibre.com
Subject: [PATCH v2 5/7] ARM: dts: meson8b: ec100: add iio-hwmon for the chip
 temperature
Date: Fri, 18 Jan 2019 23:52:25 +0100
Message-Id: <20190118225227.6516-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118225227.6516-1-martin.blumenstingl@googlemail.com>
References: <20190118225227.6516-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_145304_085202_5DDDE955 
X-CRM114-Status: GOOD (  10.40  )
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
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SAR ADC enabled channel 8 can be used to measure the chip temperature.
This can be made available to the hwmon subsystem by using iio-hwmon.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b-ec100.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b-ec100.dts b/arch/arm/boot/dts/meson8b-ec100.dts
index d50fc2f60fa3..cba0006e2de0 100644
--- a/arch/arm/boot/dts/meson8b-ec100.dts
+++ b/arch/arm/boot/dts/meson8b-ec100.dts
@@ -64,6 +64,11 @@
 		timeout-ms = <20000>;
 	};
 
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&saradc 8>;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
