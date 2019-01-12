Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230C3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 13:07:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8F4220854
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 13:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OMopstjv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Yi1XJ6K7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F4220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tFsbCic2FzZPpauswzEa30TOpzOb9IBTKWFfIIcr9As=; b=OMopstjvH40jQm
	EA9Ep/Q//zs2uz4scohFc9z93u+tOJ1LFE3OMyHQG+60uO9hWvkzgLkICCD3ZTMAGLah1gCDBEPql
	r8a+AXt/0GEAXQY6YeqzwAP3zkouocj4Nvwl9amC3m2gvfZou6PUADZ0ChQMsux6XkRvLzHt0/o+i
	8ooX9Czip3nCl0pOxGKhEfuaDmcq8fY+ctIET7KQY2InVXkUnoEG08bttqkReBqHG4nFifduUn2Nf
	G0xxQAPZYpl+86Lg6w7dMZ/d/tt5iRPWeIcof5wxTPoi8HxQItn0BReQVE/l6LZjtPfexwBCkI7D6
	Oh2SLAPLMb7ysmWzTEZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giJ0R-00089k-6o; Sat, 12 Jan 2019 13:07:19 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giJ09-0007qL-1f; Sat, 12 Jan 2019 13:07:04 +0000
Received: by mail-wr1-x441.google.com with SMTP id u4so18056483wrp.3;
 Sat, 12 Jan 2019 05:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1uHQ4bAZjvNO49qpkLTZD4pYtUclz2GooyqEYvlGNx0=;
 b=Yi1XJ6K7Egz432Q6FVhEN6C/3Wz7DtElkRVQcCnxd0RxSivuDpK8q6Fy4sKPSOBc5Y
 KF7oCUIFQ4hDBA6pf8sNBkmVzVaOI+DwzBD8BQN9cZyFjDQ/DEXJVFFAPUpfWn121Cx+
 kOGp7knpDmKsIxcz3C8otlQX2y9mM3EXwAN7Eh3QMRA5ICRVf9dY1SPY4aZPvYbIWCEr
 SbVqbd6vjPf2iXFRWBhif+sldjXS1MsPh6Ee4g4rpESu0Jcd17HgELX902Zle/QWaK2V
 VleNVBD5v84Y8XlHDv5P0brRHEteQv8KXPGlrVWSX/kBpITgEFBdvLT1yvdBfV6Z++Zn
 1nWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1uHQ4bAZjvNO49qpkLTZD4pYtUclz2GooyqEYvlGNx0=;
 b=n1TLvAGXv85r8rE4lgRgQZVr2DBVTqXheOn5/QX6/EwgUgGRJJLJ2PZt/KxPRcLdeD
 blLCLwJLBz5sfuUI+KarPummeT171Ii2CWcrbYy4tdaPrqp1pdLvZeQjfIwQQpJOWR7a
 EUO9dUpJ4BZEhdW3k5O4rGWvezFCHIBCV+cBYy+DVW/UnTtt9YyD7CvrcME+gaMdDg3v
 SG9odITc814ClCpuN8Vd0Tko8a5eii9+p6Y8WYFu4/F+Yhm2Rb0WRCznAZBXdAOdeqzA
 fXXFX6IoiQ5UqP6bVkifdb9ESlb5K1GoWHyNMQgFnKcxEbMA2Ne5EONaWpK7+2HIcSu9
 6p6g==
X-Gm-Message-State: AJcUukeP+xe4v1wtud2UkJIhv/5Ipjxa0xEi6UuVL9IyxnRooU3xsWKD
 nQ/oJ5nc2QRhwg+ZX/doq+K+wL4i
X-Google-Smtp-Source: ALg8bN6oKrtpJcpBPXFYbJMXhbtYjvdAsL4ZSNLxrD1cptjhN/qZtMmpPqOv9Jsdc+eaZbeZfbXD3g==
X-Received: by 2002:adf:f504:: with SMTP id q4mr18065614wro.321.1547298415663; 
 Sat, 12 Jan 2019 05:06:55 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD7329F008D685E3E728ED25E.dip0.t-ipconnect.de.
 [2003:dc:d732:9f00:8d68:5e3e:728e:d25e])
 by smtp.googlemail.com with ESMTPSA id o5sm37804630wmg.25.2019.01.12.05.06.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 12 Jan 2019 05:06:54 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	khilman@baylibre.com
Subject: [PATCH 1/6] ARM: dts: meson8m2: use the Meson8m2 specific SAR ADC
 compatible
Date: Sat, 12 Jan 2019 14:06:44 +0100
Message-Id: <20190112130649.23838-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190112130649.23838-1-martin.blumenstingl@googlemail.com>
References: <20190112130649.23838-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_050701_292877_873D2AA0 
X-CRM114-Status: UNSURE (   9.50  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The SAR ADC on Meson8m2 is slightly different compared to Meson8. The
ADC functionality is identical but the calibration of the internal
thermal sensor is different.

Use the Meson8m2 specific compatible so the temperature sensor is
calibrated correctly on boards using the Meson8m2 SoC.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8m2.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/meson8m2.dtsi b/arch/arm/boot/dts/meson8m2.dtsi
index d1a28c2adac5..bb87b251e16d 100644
--- a/arch/arm/boot/dts/meson8m2.dtsi
+++ b/arch/arm/boot/dts/meson8m2.dtsi
@@ -50,6 +50,10 @@
 	};
 };
 
+&saradc {
+	compatible = "amlogic,meson8m2-saradc", "amlogic,meson-saradc";
+};
+
 &wdt {
 	compatible = "amlogic,meson8m2-wdt", "amlogic,meson8b-wdt";
 };
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
