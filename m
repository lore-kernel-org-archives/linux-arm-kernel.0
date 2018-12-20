Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F318BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:05:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE4E121741
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F8NjqAry";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BQmZ72bR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE4E121741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fU+BgW+nkS9EOw1IZpYvePEQqMgjVzt2N35WmN04GyE=; b=F8NjqArySm6yWX
	GegqfzqSKQUtvhRAuB2q4llLt5Ed2BishkJGHskqJ2fFpbg/fR0g5067YJwtv0g0hUkoFnKYA/7Wa
	au/Fs740oKjJ8QeMIcVSaJVT9kuUUiQX43ivIf0t/tbtpQPYjmlCE7hO6wHjiUN9C1XjbF0fF78NM
	NS0AfkZw372CilowiVU7++9fPJL2lfjtBa6IokJiWvkHdvEvhrRfzAQAY1+uSFPvT0x+d4/czxK9s
	0JGR7f8n2fGIfzxRGoeAXEzTUdxHh9UCVDr6LzY1mzRvh5Np6CDV+007HOwaMKgV67gpLqr1YumBp
	MLcliMsWD7HW5xBmNfWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZy0S-0008Fi-4j; Thu, 20 Dec 2018 13:04:52 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZxqv-0002gH-Q5
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 12:55:06 +0000
Received: by mail-wm1-x342.google.com with SMTP id f81so2047559wmd.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 04:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/BsYwI4MGKscqtd4fapjUVq4zzWRiadQNZwYTiXxWLI=;
 b=BQmZ72bR81ebRCVcxLtWVeYzKIe97gNe16bqUHQEdvrxZ9jQdgduSgzMhZnrpzNDvC
 4nLZ7zhSYguQz8KRJjM4qqfx1LBA7ljnIM+D1n9VSLPC5sOrwo92UiUC4iP9URlDtr+a
 cGKHO0/0xrOVFvYvrjVG1ONqrdH53rHjgH79I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/BsYwI4MGKscqtd4fapjUVq4zzWRiadQNZwYTiXxWLI=;
 b=rHdkct1/bKD581xoZL/QSX9rqXEZTj2QM5obDQCzXnvs9CjfQVRYqxBsfFMDZXKW7w
 YPT9mh44IMMCSCGh/p0nxmtFJN8tAKvc1X2Cl/UG0WqrdfJ4EYBD6QOl3O60sF+YC5Or
 ORYBK0WKNUc8Cr0N/NF9pZTKAjw6orhPfcrBd8pcES6fVECjHP1qlcsBOLLCVyhL+S9a
 +vI9blMysubM+QyvfeUHLMC0EGXZGORMAKaP3hSOi0hJmheLpoVkZYsm28gBiHg1L/pc
 us9YGRo7O32XlUy42v6ef05cmIgvP58H96yoN5otdqjYJ2L2EvuY/PzJ5s0ehKEqwU3q
 B6zA==
X-Gm-Message-State: AA+aEWbGk0r4Ec8/U5IU4LyGF6e6laIFynODQd+plymEWc1gnaW52u9k
 wXMLvPr/AlKgvQWPfrWboVPMFA==
X-Google-Smtp-Source: AFSGD/VGbWVzN9KaZCPi1PGk/1YnRjWa3GPXr7KSh29e1qnj/L28l6uVj7KIQwJJENtIrgWqp97lNg==
X-Received: by 2002:a1c:a8d2:: with SMTP id r201mr10180319wme.81.1545310497657; 
 Thu, 20 Dec 2018 04:54:57 -0800 (PST)
Received: from localhost.localdomain (ip-163-240.sn-213-198.clouditalia.com.
 [213.198.163.240])
 by smtp.gmail.com with ESMTPSA id o4sm8732756wrq.66.2018.12.20.04.54.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Dec 2018 04:54:57 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-amarula@amarulasolutions.com,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v5 5/6] arm64: dts: allwinner: a64: Add pinmux setting for CSI
 MCLK on PE1
Date: Thu, 20 Dec 2018 18:24:37 +0530
Message-Id: <20181220125438.11700-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181220125438.11700-1-jagan@amarulasolutions.com>
References: <20181220125438.11700-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_045501_932260_762021F3 
X-CRM114-Status: GOOD (  12.90  )
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
Cc: Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Some camera modules have the SoC feeding a master clock to the sensor
instead of having a standalone crystal. This clock signal is generated
from the clock control unit and output from the CSI MCLK function of
pin PE1.

Add a pinmux setting for it for camera sensors to reference.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 89a0deb3fe6a..dd5740bc3fc9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -538,6 +538,11 @@
 				function = "csi0";
 			};
 
+			csi_mclk_pin: csi-mclk {
+				pins = "PE1";
+				function = "csi0";
+			};
+
 			i2c0_pins: i2c0_pins {
 				pins = "PH0", "PH1";
 				function = "i2c0";
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
