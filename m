Return-Path: <SRS0=jr7z=PG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92300C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:57:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60B9D20836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L40DTgcc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fP1kLUwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B9D20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=IIz9POmP9+a8BCb9HpHpQmqWTO54dj1jMaQ+2X1IK4A=; b=L40DTgcckZ9KzR
	zcOrs+ur2utDXhDVve4+nzuEO4InM28RzAi7Pui8j0KB16SaYT+xj4gR0+TiJCuwUyhdjV1bMXfZd
	Khq/0qPST0nxJIhJsGTcJhHYXJDTA0vcT5jS4ypMl45QZNOTu2TzhDcgnjoEIm9h9bfwjPRDhsnD7
	LsvH/hZXz9fpOo9oDad7zUMnh/eRt0MmV1QlcMHSwvryTRT1S1fNiupR91FoR3ko5Beg18F2I1FpD
	u7hN6i2HWWfbI5jsX0hFUDtOBF91t3qniHwoR08ly5JG2sXdim0s3kTv5hzB9KRQbfrhNde79z8X2
	pYLO9wd0BKRhebffUKKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdEBa-0002zf-Tm; Sat, 29 Dec 2018 12:57:50 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdEBV-0002wd-Ig; Sat, 29 Dec 2018 12:57:47 +0000
Received: by mail-wr1-x444.google.com with SMTP id p4so23050703wrt.7;
 Sat, 29 Dec 2018 04:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nErJpKAwV6v3cNENjeI9CDTkclquEZvVeh0G8X/uw04=;
 b=fP1kLUwipjo7o1AqmxrKUs+2djifqLaZq7ixEd5WR2bwQNpe+MxQGxRo5utxAxCII3
 JIBrbENkC71sIdgqJE09HU97vnmUmlCZ+ZNsJgGbEJuS3W5ByTXxgQ6kQmxpBJ6UlqMh
 fHMsVbLYOHbJBP4RcO0Bv9ngO+EJUTgmusktd/whH3lL+5SHCtvbfSYs/dXfUNNItck0
 pceYtHZRFP8cEg/LgW7TWw0VUSxkik6s1fkqpsxu793FSZkQoeOkAsIsCQQuMrlYot0x
 p1Vf9lfg6XUOQkB1nOorC7GyEqoqJiPb51gVk0uStIalXnncFX2WX+Bzc+x+cz5LfGSd
 Fylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nErJpKAwV6v3cNENjeI9CDTkclquEZvVeh0G8X/uw04=;
 b=m5UatkBXy0OIRaJy6fJIWxs6uvPCdr1M+JR4cxchL7IWOuhbCWBj7kMiiWZMtOB8bT
 4GUo9cPL+xNtUoTcW3nHWrcxF5RTKzHc14UpEjoWYC4FNTzocYoCbHrbCxBuvFYhgssQ
 TO84tGi0rGn95qmn7iNIqVDK02KoE5O0bHh6D5Unm5NVySRDcJk2WQJgGQ2b+2p4VszI
 94EtI4/6n+YlxtEEsxJF7gdVySxgl585DHVDdXEjEO2K0lj2qdDZqBBaIPPfbGP5GHyN
 7EScGHePfxAVkmtiQNjm8pHOzQ0M7o3jxGVaL+QPjYvZYam6TqSNJdT+OPzcdvBU0wpX
 Vviw==
X-Gm-Message-State: AJcUukfSi/FTV44IE28dc7cabT9DIf5y2QbXjqozFGkK/eGghvsL1fTq
 jaEUdMBuczcducHnJiZW3YCeL5k1
X-Google-Smtp-Source: ALg8bN4fyuA4pZj7UtJ0m0t5JRJztB1zmBIcdw+CwAo3wQgD6BECjRbGyBfOFc+P5eHHqvHYX4wegw==
X-Received: by 2002:adf:a28d:: with SMTP id s13mr29769487wra.100.1546088253189; 
 Sat, 29 Dec 2018 04:57:33 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD7294600914F24DE1716D3FC.dip0.t-ipconnect.de.
 [2003:dc:d729:4600:914f:24de:1716:d3fc])
 by smtp.googlemail.com with ESMTPSA id h17sm31987059wrt.59.2018.12.29.04.57.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Dec 2018 04:57:32 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, khilman@baylibre.com,
 linus.walleij@linaro.org
Subject: [PATCH 0/3] ARM: dts: meson: fix SD card cd-gpio (pre v4.21-rc)
Date: Sat, 29 Dec 2018 13:57:08 +0100
Message-Id: <20181229125711.5205-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181229_045745_621539_68E43994 
X-CRM114-Status: GOOD (  15.32  )
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

Today I noticed that my Odroid-C1 doesn't see it's SD card anymore.
My board is not the only one, Odroid-C1 on KernelCI suffers from the
same problem:
v4.20-6428-g00c569b567c7 still sees the SD card (mmc0): [0]
v4.20-8955-g903b77c63167 doesn't see the SD card (mmc0) anymore: [1]

My Endless Mini (EC-100) is also affected by this issue.

a git bisect run points to this commit:
89a5e15bcba87df5120d4656e0ff33d4f7cd6152 ("gpio/mmc/of: Respect polarity
in the device tree")

and indeed, reverting it makes my Odroid-C1 and EC-100 see the SD card
again.

However, while reviewing the .dts files for the 32-bit Amlogic Meson
boards I found that the cd-gpios are specified incorrectly in the .dts.
Documentation/devicetree/bindings/mmc/mmc.txt states: "[...] using the
"cd-inverted" property means, that the CD line is active high, i.e. it
is high, when a card is inserted".
This is not the case on all currently supported 32-bit Meson boards, so
this switches the cd-gpios
- from GPIO_ACTIVE_HIGH with the "cd-inverted" property being set
- to GPIO_ACTIVE_LOW with the "cd-inverted" property being absent

This fix also works even if the following two commits are reverted:
- 89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device tree")
- 81c85ec15a1946 ("gpio: OF: Parse MMC-specific CD and WP properties")

Linus, I have seen that there was some fallout that commit
89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device tree") is
supposed to fix. In commit 81c85ec15a1946 ("gpio: OF: Parse
MMC-specific CD and WP properties") you mentioned "the [MMC]  core will
use the MMC_CAP2_CD_ACTIVE_HIGH [...] I plan to clean this up at a later
point passing the handling of inversion semantics over to gpiolib". I'm
not sure how the MMC core / GPIO subsystem is supposed to handle the
"cd-inverted" case since I believe this property is now evaluated twice:
- first in of_gpio_flags_quirks
- but also in mmc_gpio_get_cd (using ctx->override_cd_active_level)
doesn't this essentially make "cd-inverted" a no-op?
(attention: this series only fixes three 32-bit Meson boards, but I
believe that this issue is not limited to the 32-bit Meson boards)


[0] https://kernelci.org/boot/id/5c25a73d59b51464fb6edd2c/
[1] https://kernelci.org/boot/id/5c27306159b514268f6edd2e/


Martin Blumenstingl (3):
  ARM: dts: meson8b: odroidc1: mark the SD card detection GPIO
    active-low
  ARM: dts: meson8b: ec100: mark the SD card detection GPIO active-low
  ARM: dts: meson8m2: mxiii-plus: mark the SD card detection GPIO
    active-low

 arch/arm/boot/dts/meson8b-ec100.dts       | 3 +--
 arch/arm/boot/dts/meson8b-odroidc1.dts    | 3 +--
 arch/arm/boot/dts/meson8m2-mxiii-plus.dts | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
