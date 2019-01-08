Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD57C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:17:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ABBB2089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hA8P9hch";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Sfs9Aaiz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ABBB2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X7pH49yh+bf+3GzdvzlXmOpXKwsN2ehnIW5VoUKawhM=; b=hA8P9hchfHmbYZ
	ffuZlRqWTBk1qSRGBkVuYxqjDAfchFjS+c6t/1B6invZkjZ6f+dmC8jAHjLCnwPvTfJuFwuYjLZwx
	rk4VWvJCddyGBOqvr8KNL4pmG9g9KlXhrbl4vRBbb+95Cs25xPVs8qrKUX38QXzysWsZ8Yyn/Ho4Q
	Y1UjS271r0KIHubqrRH1kweLgwnjwXjgYuZ2p2xiofsaxVicMgI2PL+InfJuGO2iJB8Y4eOklZ8bq
	upiSEzWF3U+OWyKfL8Kuf3TGuyZBpNVW29rRrLJJlnpmRM6hbSJTXz6L9e0eQA1zpfm2Q2Ai8aHFn
	fPP8y7sTRNMjPCT8qWCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggnW0-0000Gb-MQ; Tue, 08 Jan 2019 09:17:40 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggnUN-0006w6-Jz
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 09:16:07 +0000
Received: by mail-ed1-x542.google.com with SMTP id f23so3467951edb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 01:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3+tDzntZFfY3GLS/4lI4221oPwYjWwUsoPxzbNeGoww=;
 b=Sfs9AaizMYDAGnIdGzo9aI6cMDMrNgpofOsNLiN+Ztc/ZFSGdh7C055MfB1L5SJZtL
 16vdeY/f0DshKMDzGI0ovkRkYsF7Uqj4G1nIPSMy7/PLNgOkM9vMtjpV9+XADW07Nic0
 LU2Ziz+GlDKATPpEOeBEecexaiVHOV0kq3d4/pYDDIRFU6UXGjEMt7YRuUrtfWw4kl7x
 QvUypi1Q9b586+Ktore16WgZwA4nhQfn6zoEGozs4R4FthVWLewOXb45pSQApy6Aye8P
 QXbsLLZTaoNohKSvieoxd8L6P1n4/2xXaZoajj9yn83xgCxDGJSbSCP6uG0wbOtITIBn
 SuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3+tDzntZFfY3GLS/4lI4221oPwYjWwUsoPxzbNeGoww=;
 b=Gen+0ZLas+vOzkcEYkR4q6NvEUlQtGPg3/V5q5miSztpN3To8YBEc/psxBNHwtTVq1
 gNVoGAU6unWkCGgM+x0KesJDCgTPu48JCM8EF/MJy83mT67NjhkT08Ex3l5M3dXsEImJ
 GHXjVyVgO9IRBwZfyDHWu7TYj1l5AxJWDQsDt6oaNPGBrPEAfDvz6u5ct8VsgUHy0A9l
 r2nWZCAn/nPwFqQi+RVmtwxOCSG7UA8pTX1+zxTWvp5GymF6crocWYfBRB7g+SBNzPZx
 05rp/9vdqK9MAB6uoJ3SDErmKFdXLXjo3mHu0lHujOALYjEPMVSuu6CjePD/PpDTl/8u
 BLlQ==
X-Gm-Message-State: AJcUukcyzOMyfSzHttQQccTNRlQJSB1Ni+OlvJaKWOzdp/FuAOattG6p
 6TsCLXba3Z3dtDNYmRrnotMV/g==
X-Google-Smtp-Source: ALg8bN4j+I8YL2AMMYbG560bpM8Oo1VADblSDU5OZamCQEc11xdzdSpUnnAfXOmYidqv8SieFvo//g==
X-Received: by 2002:a50:f10b:: with SMTP id w11mr1349052edl.0.1546938958171;
 Tue, 08 Jan 2019 01:15:58 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id gp22-v6sm18373560ejb.4.2019.01.08.01.15.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 01:15:57 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RESEND PATCH 07/12] ARM: davinci: sffsdr: fix the at24 eeprom device
 name
Date: Tue,  8 Jan 2019 10:15:34 +0100
Message-Id: <20190108091539.16674-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108091539.16674-1-brgl@bgdev.pl>
References: <20190108091539.16674-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_011600_342177_B390C9E3 
X-CRM114-Status: GOOD (  13.04  )
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
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The currently used 24lc64 i2c device name doesn't match against any
of the devices supported by the at24 driver. Change it to the closest
compatible chip.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-sffsdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index 792bb84d5011..acd9778ffa07 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -100,7 +100,7 @@ static struct at24_platform_data eeprom_info = {
 
 static struct i2c_board_info __initdata i2c_info[] =  {
 	{
-		I2C_BOARD_INFO("24lc64", 0x50),
+		I2C_BOARD_INFO("24c64", 0x50),
 		.platform_data	= &eeprom_info,
 	},
 	/* Other I2C devices:
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
