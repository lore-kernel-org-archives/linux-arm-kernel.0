Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B40FC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:49:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F21602073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h20NuBQU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="j2QRwdlK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F21602073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ObbApb7RaEKcnWwpo13otp/lMBgbgrMWJ5TGqVoRGz4=; b=h20NuBQUxmu35j
	nmFQdZRAAAYh0o6u64QB3hNgFZ7C6XuU2VGd2MsPKeW4lQrJ5e+Bpr5TCz6+OnrNYai3ntYaby7/J
	cWnrH5UDn//2IKx3AmiqDps7HVtdLzxC93qF87q7ioTjmvHl+FuYe94kZbLVmMGIkpwb4yM+P46Z2
	uo0GDQmEtNaFPXhxQJJbvkTB/EfBST3oM+JWwp5rczLVrqFGfas1xNPmZZV+ozPJBujnkdfN2mSng
	QDO/0fi4wwlXO49dO84e04NIv5fzWGtH/055OK8LuAxFRsaCeCK6pc4B9a2zPj6algbzjFAdlQt/B
	aAdceef3LO8NnYD1qO0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqxMV-0000dZ-5a; Tue, 05 Feb 2019 09:49:51 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqxMS-0000dD-GR
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 09:49:49 +0000
Received: by mail-wm1-x344.google.com with SMTP id g67so2877444wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 01:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uvO3sb+k8cXgUb28uG7hJkzIJr/t2f9+FI2ONr5oCNk=;
 b=j2QRwdlKIRs+ecR9klrAJZMs5TAgLv2AoiSGqWS7IIBRL5neWgy44AqWafGe+pZH6u
 ZoVDpjVAqp/Jh+xMuO26rRGKHcR3e1NzxwKoRVDag/5OQCvpBCDOFZ2q1VVjQJPBp+QZ
 z6VDW1iTiyVCy+l3IEuUU1G8sGKFMaE5Na4C17IUM1KsOne9wzucRI7wIWzQCOc00FMX
 2P+AY46+ZxZlBbTgd2nd5JQKqTmZ9UGBkTYFUkIQlgYxYn1tqj7aombXp/ohHT1pxkxC
 +KbbDb0iOFXL0HTb6EZcrzeXFPCF9nWpL7qjPXE/SN1wRPNvdufEifn3WSULs0qKRBmW
 1k6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uvO3sb+k8cXgUb28uG7hJkzIJr/t2f9+FI2ONr5oCNk=;
 b=j6uR0xBp0/mmxrURJzbBsFGfjpuG3GZqB26gdf0LDXYlfFkEuRtADhmHcR7OO34HeY
 1js7pPcrJd6egkpBapOViTSi4PQjRcIFin39vKzrsKvVTsXX0ZaSaB/BhaZElcoK0ttG
 AwiId2VePuaHR4U6ynXafetKu6XN8CRuf6cLbz7sdOLaRk1Mes0Ig4tKKiliPsff4Mp5
 ByWj58eWWSIoPkAX8kqWtG4sxYdU9GQzyttum3Nr/pfoRKIMdqTsgExj6sT2qVuhi7md
 hs/nGkzw2s/C9lHCtUpgF5nR4xUjt9eKTcCxMp9jj6kczPC4+YGM1Lds3DOVNv9BvYUU
 YsZQ==
X-Gm-Message-State: AHQUAub2u7bmWxSZFKoCzzQEBkSnjdKQ2dfRAJH0pTA+2ugjM0fl6dhP
 UjJC3giECmIyx4Vz7paeXTdLwA==
X-Google-Smtp-Source: AHgI3IaOcilG/mUyo6QvSlWX3pgCT8zXEEnJ/QUeuocCQXoW6onx4/teB2PLEnOYqW+Rxky0vA5NrA==
X-Received: by 2002:a7b:c315:: with SMTP id k21mr2835668wmj.145.1549360186816; 
 Tue, 05 Feb 2019 01:49:46 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id k4sm8466197wrp.8.2019.02.05.01.49.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 01:49:46 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>,
	Kevin Hilman <khilman@kernel.org>
Subject: [PATCH] ARM: davinci: da850-evm: use GPIO hogs instead of the legacy
 API
Date: Tue,  5 Feb 2019 10:49:37 +0100
Message-Id: <20190205094937.18645-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_014948_548392_9D187E06 
X-CRM114-Status: GOOD (  14.45  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

In order to drop the hard-coded GPIO base values from the davinci GPIO
driver's platform data, we first need to get rid of all calls to the
legacy GPIO functions. Convert the mdio configuration to hogging the
relevant GPIO line in the da850-evm board file.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da850-evm.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 44bca048dfd0..69eba55d4c0f 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1064,6 +1064,17 @@ static const short da850_evm_rmii_pins[] = {
 	-1
 };
 
+static struct gpiod_hog da850_evm_emac_gpio_hogs[] = {
+	{
+		.chip_label	= "davinci_gpio",
+		.chip_hwnum	= DA850_MII_MDIO_CLKEN_PIN,
+		.line_name	= "mdio_clk_en",
+		.lflags		= 0,
+		/* dflags set in da850_evm_config_emac() */
+	},
+	{ }
+};
+
 static int __init da850_evm_config_emac(void)
 {
 	void __iomem *cfg_chip3_base;
@@ -1102,14 +1113,9 @@ static int __init da850_evm_config_emac(void)
 	if (ret)
 		pr_warn("%s:GPIO(2,6) mux setup failed\n", __func__);
 
-	ret = gpio_request(DA850_MII_MDIO_CLKEN_PIN, "mdio_clk_en");
-	if (ret) {
-		pr_warn("Cannot open GPIO %d\n", DA850_MII_MDIO_CLKEN_PIN);
-		return ret;
-	}
-
-	/* Enable/Disable MII MDIO clock */
-	gpio_direction_output(DA850_MII_MDIO_CLKEN_PIN, rmii_en);
+	da850_evm_emac_gpio_hogs[0].dflags = rmii_en ? GPIOD_OUT_HIGH
+						     : GPIOD_OUT_LOW;
+	gpiod_add_hogs(da850_evm_emac_gpio_hogs);
 
 	soc_info->emac_pdata->phy_id = DA850_EVM_PHY_ID;
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
