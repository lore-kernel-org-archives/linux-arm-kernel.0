Return-Path: <SRS0=jr7z=PG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA09C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:58:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A41F20836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HWpvp58N";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="vSUJsCZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A41F20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Mn1YpqpjTHtoQlCIILfy7TZvozf1mtkxygI03EDoSO8=; b=HWpvp58Nofecex
	evbdSKKG5Xov5lqO4mkw1OWINIvn1i/P9ow9jFntenjUYNY0NC3gRGVUu445TI85E3yTkkbXtWhz6
	ByLmwqBbWTRclItUNpNp2pZjqfDbnzeSys8pxM1e+Ah9rjTBe6xHKelwU73DpfhjV5b/kcB+yBlsa
	15qfmN3mclUFITd5oPsGG5CJWBnqq1zhbMO7QSqv1nC0/dDFSqVBuZKsYLIhN92mCc36LyckPjRvS
	OJu71Q5IqlP01ixc4JjdO7iMi+UJD63Bq46uCMItdIi4oStTamqCOUL/evILSPI8p+izeJJzsUTb2
	fsu3mdk189ggXe3HNoVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdEBn-0003CK-QS; Sat, 29 Dec 2018 12:58:03 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdEBW-0002wh-ES; Sat, 29 Dec 2018 12:57:47 +0000
Received: by mail-wm1-x341.google.com with SMTP id f188so21506483wmf.5;
 Sat, 29 Dec 2018 04:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xIicdGAZhx3oX8Do8U6owJozuwFheS9BvjevYH1ytJA=;
 b=vSUJsCZJay6P1s9+cUUsg4EyQY9B6g4wPoUkRr8ugPyFd3BGS7dx8WDQOHQvZTJeKJ
 dUTXEIadRwkCclQbLgGyaYVodzD+2fQE12cyRzh7sNQ6ud2O1TyrnO6yYqGS+GzYv5hR
 seYqOs5MAMtjG7Ltrqy5DkmNkRONLjnVWAp8Fx1cUow2JaSlRZNK66CUiTtb1OR0h4Ne
 D3lARx2Hp3r2b4Ib3diJs5ckbOayVD94K7QHwjZt4Le2IyNFrE8utt8YNY4gIh6bZ6mN
 9HkhTH7Cc/AggtlefXDjnlZd7s4KU2ld+/Vw0KaPDlWZRiE/GToc+LBvjW9kKC+pwV/P
 xvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xIicdGAZhx3oX8Do8U6owJozuwFheS9BvjevYH1ytJA=;
 b=MMaARdG4osbjdO0Rq90uNwLKfAtLTUoqZ8O1afAMNNCjN+SDZcd61thh+NYV+SxcaL
 cw/3wFsTsrbtLLhzh3Uw0kklIn+XwIV1kEj+85JbsBnDO8aOgy7+ixU/fzejew7V87Yi
 CaGtUQ6DnyT2Lkef+k+hcm6XVLkRftqGQpvXqlpgxS5E1SmOhW3FfFkJIQ1rtoL/R2CZ
 cOjR2KsOY8QkH/wPstRk7i2X+eYxcCiRJCsW/+WwcvHdSbZRb/yPo1O5VN646pAodn2P
 xBSQSQeaB/RmHsekZzt3joi/iX81feHnHtlGPwzl7J6mTac2GyjzmUx8EVqfbbKd80w/
 eW1Q==
X-Gm-Message-State: AJcUukcftBEIa9Ff8xN1ybKs1yO9Wq+TwGnRTe2Dno559poR7vf3gOA6
 DiuY+C6IoyKYRubRmXG86P/eFcfp
X-Google-Smtp-Source: ALg8bN5/l9t6q0dLNUkjDZUDqscN0lPtglIgBb1+hFQqy60FkUOIXZDXWxyVoBbpJYIP5/WaH2GCWA==
X-Received: by 2002:a1c:1a43:: with SMTP id a64mr25464631wma.136.1546088254367; 
 Sat, 29 Dec 2018 04:57:34 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD7294600914F24DE1716D3FC.dip0.t-ipconnect.de.
 [2003:dc:d729:4600:914f:24de:1716:d3fc])
 by smtp.googlemail.com with ESMTPSA id h17sm31987059wrt.59.2018.12.29.04.57.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Dec 2018 04:57:33 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, khilman@baylibre.com,
 linus.walleij@linaro.org
Subject: [PATCH 1/3] ARM: dts: meson8b: odroidc1: mark the SD card detection
 GPIO active-low
Date: Sat, 29 Dec 2018 13:57:09 +0100
Message-Id: <20181229125711.5205-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181229125711.5205-1-martin.blumenstingl@googlemail.com>
References: <20181229125711.5205-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181229_045746_481588_50701C18 
X-CRM114-Status: GOOD (  13.66  )
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
Cc: linus.luessing@c0d3.blue, bgolaszewski@baylibre.com, balbes-150@yandex.ru,
 linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux@roeck-us.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

After commit 89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device
tree") SD cards are not detected anymore.

The CD GPIO is "active low" on Odroid-C1. The MMC dt-bindings specify:
"[...] using the "cd-inverted" property means, that the CD line is active
high, i.e. it is high, when a card is inserted".

Fix the description of the SD card by marking it as GPIO_ACTIVE_LOW and
drop the "cd-inverted" property. This makes the definition consistent
with the existing dt-bindings and fixes the check whether an SD card is
inserted.

Fixes: e03efbce6bebf5 ("ARM: dts: meson8b-odroidc1: add microSD support")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index 58669abda259..070d69889f3e 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -273,8 +273,7 @@
 		cap-sd-highspeed;
 		disable-wp;
 
-		cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-		cd-inverted;
+		cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 		vmmc-supply = <&tflash_vdd>;
 		vqmmc-supply = <&tf_io>;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
