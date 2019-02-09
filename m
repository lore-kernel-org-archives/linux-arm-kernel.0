Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD2CC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:27:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AFD120821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F53890sS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="G67Q2MUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AFD120821
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bOb7xPacSJ5VFU5GS+eVD64R6NRBgK0VSeLpxPJwZb4=; b=F53890sSTH2/SQ
	cb65YexLcXqkyE/dKAYMGjjYiaWd9msyY7mIHwTv/+QAwjGWzuwAwoXLOhTc0D+Csp3HUMqoc7EtN
	VSkPcDspP2EZjVyEmqR3qHgurIzi1pjuCZCfUtnM8I11uCG+vdU0kI1hx+qDUFadF8WssBupEoWHl
	u7lcS8TjlBPrIsbokLHXdTtZp3I858lBaTI+5V7jOHKNdMrU3tXzJg96X8ft2JLjvr7gFQ3/ae+0O
	UvnZo6GCwF7bIEgXF+3SN1MadchGR22+HZCJhuCoUkcT7lqP2LzeBvKgQaZgCoFLc0VU2tNcCzAN5
	t35IJYta0y4wURpV8dkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsGUf-0006fD-RE; Sat, 09 Feb 2019 00:27:41 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsGU4-0005xP-99; Sat, 09 Feb 2019 00:27:05 +0000
Received: by mail-wm1-x343.google.com with SMTP id y185so8188839wmd.1;
 Fri, 08 Feb 2019 16:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4ZPYq9UgmLhZEoa8kZDGFThhLWBuuQUEtDdDzkII580=;
 b=G67Q2MUBkq62KXhg0yU8wFgaHnEr1jAQ5l4mUVvw18odrm4oHk0HltV3a5nUWXqmwm
 ICRlqL7QCGEqZmkZwXHzXS/lr5t9lnixsDvPnEnQoZ7jsgrHLRsSV0ulFbnTaKKwG0tQ
 vCehVRPID/1CECG4V8UrarVDfpU6LaZY9xx3oklGKP7nOY2Mdt/m9pxn9aCJZXemIzsU
 QN2f8/C5HAjaPuUuGPUgaiDz1xBhnEX5W445ekdNlSf3XRK0C4mhYT1vseT1ZFad0Qy9
 qURCrkWxfixg9VVj2dAnlUC1qOd81OX3MIMImvTUwMcz3yQ1qgEFihY3o04QCgROanOc
 DsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4ZPYq9UgmLhZEoa8kZDGFThhLWBuuQUEtDdDzkII580=;
 b=FDKwlO1Ug+fOsC542FN5oLAN4z7JVUH9MSqHup+f+O2u4I8YZlrRGMYWQzah3KvM6r
 kXPbjdCd6jjG2j4jaNvujYU8UQrsU+bAobHkvr027ZduVqfc4+fxTYCXL2LfCyYNWmT6
 JQ38KOCTyLUSV1e0HHR/OXSU9lgJUd6eRBDNBuRAOFItv22V9x5XjEG+eTqtek6reWBT
 nXumRET7XZZgH9o4UU9B+RPMeNDgcojhvaSCGVXfGVf8rGormduV4HN+9UvJ42d8KMpD
 MP56FayLDt8Tf9nQTxilPqfBGTx1zxuf1Qr4Um6qiFUfG43awxiEvlR9yppEwljXGIsQ
 Rt7Q==
X-Gm-Message-State: AHQUAubxnsi5todEkkFqGZG00432xFNOCoT/O5Ds8P2kVSwBOS8B3Ul8
 xDDMgtxMZcpNvkcuNCdGnczN8Grk
X-Google-Smtp-Source: AHgI3IbuhC9sXuUTSOse1ptFT4ndzsQ9fdT9fONz0ACLeiQTQWCOisKhdqWXVSQ+KZ/gfXSsuEQKyQ==
X-Received: by 2002:adf:f4d0:: with SMTP id h16mr4877794wrp.103.1549672021783; 
 Fri, 08 Feb 2019 16:27:01 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD70B4600C545FEF64E1C6C81.dip0.t-ipconnect.de.
 [2003:dc:d70b:4600:c545:fef6:4e1c:6c81])
 by smtp.googlemail.com with ESMTPSA id a12sm6569066wro.18.2019.02.08.16.27.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 16:27:01 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	khilman@baylibre.com
Subject: [PATCH 1/2] ARM: dts: meson8: add the internal clock measurer
Date: Sat,  9 Feb 2019 01:26:40 +0100
Message-Id: <20190209002641.9105-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190209002641.9105-1-martin.blumenstingl@googlemail.com>
References: <20190209002641.9105-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_162704_315907_2975BC10 
X-CRM114-Status: GOOD (  11.14  )
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
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The Amlogic Meson8 SoC has an internal clock measurer IP which allows
measuring frequencies of various clock paths.
Enable it on meson8.dtsi so we can use it.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index c9bd46120cb5..d83c6e96ace8 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -345,6 +345,11 @@
 		status = "disabled";
 	};
 
+	clock-measure@8758 {
+		compatible = "amlogic,meson8-clk-measure";
+		reg = <0x8758 0x1c>;
+	};
+
 	pinctrl_cbus: pinctrl@9880 {
 		compatible = "amlogic,meson8-cbus-pinctrl";
 		reg = <0x9880 0x10>;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
