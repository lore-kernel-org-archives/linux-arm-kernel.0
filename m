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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A824C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 13:12:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2297A2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 13:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VOcmJ0NV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Qv1nZQT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2297A2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XG4BPJ/TDKHCU490Qip9PKOwSu/cFURKE83v5gJcyzs=; b=VOcmJ0NVd0aqET
	D8v8+B08Fb4ejReChZ57koQqTvddw3xKZ0z8ANI2zFzVXjlWGRnSl1BaHUwK/U0/Fvt7yPZT8LAb0
	LqiA88QnqSIFtu1Tn1O/vaEmQmiCmk8DolKKA/tyL0ej0KXNNbpxpa+0O4BMcPZ4xKm5ubn+H+sSC
	AsxUZFaQubC64a3lKUfWjTjHh704wKDF6LDsZLSQAgpMnELRWbV2pv9TnH9f76tUp7zidaHs+U7Hm
	UqP1Dw1hm60lCE699DiCvtrntA5xjexhhTX7RNG1BeNzh5zCYzTLdawO9ysiGwWr+LJamqhpBAFxL
	VeLDbAC1IHkknqHleMxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giJ54-0002ld-Ab; Sat, 12 Jan 2019 13:12:06 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giJ09-0007ri-Va; Sat, 12 Jan 2019 13:07:10 +0000
Received: by mail-wr1-x444.google.com with SMTP id u4so18056596wrp.3;
 Sat, 12 Jan 2019 05:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6l6WolcewijNZ7C3qoRDiIawTtYi7pkKh2E+h6KjBjU=;
 b=Qv1nZQT7lbDeJyhdLuUrTSn4WSa4vTbILXfVwfvX2G13FsMWoYzWsrWXI4iAIHp1sV
 cPqDmv2lAU+alvmscrDWgkUVXH5hlnzfjfjSxcclVKgWUJ0/mCSTqg4TPeegGOUHZVom
 mRh6b5yKOUScsQ1vihq7L2YbfWhHXUYcIkWsE5JM3AcwrnlAceM5os/Re2JZDYvFxaj2
 tdFonFQdzwtpD143ztPtceU5Oz+EZ3ecZO25usCGikxSnl2DGmbiFvz6tCbp+J4kR7hP
 2viFrSvgItDM+Hz9a75GCRI34V4Imvxqd9QCdkIFUjHLR1TiCXpONHHbr+6bpk6CvreM
 KzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6l6WolcewijNZ7C3qoRDiIawTtYi7pkKh2E+h6KjBjU=;
 b=JADq+xvur+gbMN+ullwXkrkJDl1+9GD3vC4i4pHkOo9c8CAlxUbu2PwbJ0Qz+Qfa85
 qGb+Uwg5Mtks7vonDjH0ATdP9rqoXMV3AHvOn2uJAmL5eMR4b0IwJs0sWP3QXimFWCkw
 BJCPVG4w67o/038jzLeOA6EUXY0qM5q3A86yW660oQAWpLJ1rb3NZfxNR7H3jettvhzG
 iHO3NULbKHKfp6b7VC9hNjCb/qFfjUuTExX0ESRVZDhuwPt68eNvZ0vnsaUvPRYM0FkP
 h0XQiqx9DKMfE53O4xoqZp/A0FK+HB2BrUeVTZJSpiinzQGv5pEmIy0FL8lPsdjGwjMY
 mxXA==
X-Gm-Message-State: AJcUukeHx4njnjAdWUUDoi0oZQynHzt/4NUj6XZhbdFRyx1+eZlpLcOy
 BZrPx2QKNLVzm0l4Wm+EoxAscjJC
X-Google-Smtp-Source: ALg8bN4vldF5n3FNip2AuU3Ba+zsVUgaeBCbCX8DpJ54f65UlIR3VnFy5T6CmGZCPHzXegSLwB03/A==
X-Received: by 2002:adf:e78f:: with SMTP id n15mr17666919wrm.115.1547298420120; 
 Sat, 12 Jan 2019 05:07:00 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD7329F008D685E3E728ED25E.dip0.t-ipconnect.de.
 [2003:dc:d732:9f00:8d68:5e3e:728e:d25e])
 by smtp.googlemail.com with ESMTPSA id o5sm37804630wmg.25.2019.01.12.05.06.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 12 Jan 2019 05:06:59 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	khilman@baylibre.com
Subject: [PATCH 5/6] ARM: dts: meson8b: odroidc1: add iio-hwmon for the chip
 temperature
Date: Sat, 12 Jan 2019 14:06:48 +0100
Message-Id: <20190112130649.23838-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190112130649.23838-1-martin.blumenstingl@googlemail.com>
References: <20190112130649.23838-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_050702_415669_BFBD5BA0 
X-CRM114-Status: GOOD (  10.34  )
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
 arch/arm/boot/dts/meson8b-odroidc1.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index 0f0a46ddf3ff..8c83590810a8 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -118,6 +118,11 @@
 			  1800000 1>;
 	};
 
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&saradc 8>;
+	};
+
 	vcc_1v8: regulator-vcc-1v8 {
 		/*
 		 * RICHTEK RT9179 configured for a fixed output voltage of
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
