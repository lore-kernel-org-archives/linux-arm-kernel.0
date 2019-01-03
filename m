Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAAAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:12:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A1802070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MvIBH2WE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Ltx6QoPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1802070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xiVUHDhnlWQotUnWxtjOsc1KdxsmFg6SOMQXWBTSj+U=; b=MvIBH2WE2aGMrF
	hBnFD5uY0dBuby3tZOeYryIc3tU5SRaQ39i7EomCeZKtGf4bDxyuGPwqAuBcHqrAC01ioJ7Y0iOFB
	UHfqSesBVUYi5m+Io1i6zLBX1JaUBdCVQKK8WDgzds762Zsie+MtX+MftZdveR231XKcN7JGJx3AD
	xvryVZ7F5PbDpnoGmAQzIWBs95Vwv/HAcQv5k3tA/hlEIK9duVqy0sazaWlixQdfM95LPDNsro8Iv
	OQhGU+VqCLVB2DOz2+vU58+WVWKNUVQFqgargVE7aRULFuMgW5FH5t4EAgFZwNyNq/NItWmUSFqya
	96gbplHya2315B9xBgKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf4fQ-00059C-GF; Thu, 03 Jan 2019 15:12:16 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf4eY-0004CM-Fo
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 15:11:26 +0000
Received: by mail-wr1-x444.google.com with SMTP id j2so33986239wrw.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 07:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9YQ2TzxTUSfp2DIUx4vV2/rZOoYPnNHF0DkPFTWj6gs=;
 b=Ltx6QoPU8u/ClrcHN8/KYiqxZk7gJ6gSAVVoZtKSfUJ5PPR8x5pJ0bswRjV6iXKD/O
 elTmtLVJLACcjZwaQjInwyvb+lb0jTm3j1CFd8LQC4gShxVaqWgCr3wtQ30Co/skrR+Y
 e9EREm1CmhUtWgGLXItXdYtn83TYXxm0pO6p1+JyoWl2mrx+Ff+SS1Y+qccZ+6T70g2B
 lZLzmex1GsBrZdmESBHRSl9P+WNV94uzeMrc/2DTuriapZJEwoTI/Yql48TFjGfU3hTq
 2jZ0HSim1Vmgwd1ZNykpn6WrW1rxaYUXyOM47KE4Z2erJoXVaaPH6us8xESBFCkIYTDY
 XtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9YQ2TzxTUSfp2DIUx4vV2/rZOoYPnNHF0DkPFTWj6gs=;
 b=BcaB0MK+cFdy/tl2l4p1FW7GXSUIfLxvLB/sEdX8sccvAVr8ceJJqnpsnGoKQ3IfI+
 U4f9UNSbkhvN6m3RXpo1m2b65ECWxhAqaT1TfaRdp4qzZ0tIbeHIUsuNZfbk5V+A+TkE
 YYHz1XLpAcQM02LM2ZiIIFk12r1B/yhQv9XIE7BJKaowfHducQQHKIOck3Cy4VsvXPGG
 rE/FrFi030/fQ0wKxry2gQNLVNZSX168HkuJo01vXw156dhFTmuqsXJiopMfSpkE/PZI
 Roq8V9sSiG3zGVUgFaiTHL+bv1v3DBCE73n+oP2Rh1i1LrXtJu6lz5jb0NwnSWnYLD0g
 QIBg==
X-Gm-Message-State: AJcUukfDvuIlemD/ueZyFYuDow2IlbQVEudtG1WIoosNyVVjqLVWtwQN
 QowC5jDa6NvwUYNlPh93I1aPfA==
X-Google-Smtp-Source: ALg8bN6lsWuJBPaMucgfyH1x9LfnTyfJbLdWwp8Hpy1I171Vf/C8ksE+M2IyGZjj4GmTbmG8k3cXUQ==
X-Received: by 2002:adf:dc4e:: with SMTP id m14mr42352116wrj.107.1546528280732; 
 Thu, 03 Jan 2019 07:11:20 -0800 (PST)
Received: from debian-brgl.baylibre.local
 (astlambert-681-1-88-79.w90-86.abo.wanadoo.fr. [90.86.3.79])
 by smtp.gmail.com with ESMTPSA id n5sm45620707wrr.94.2019.01.03.07.11.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Jan 2019 07:11:20 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>,
	Kevin Hilman <khilman@kernel.org>
Subject: [PATCH 4/5] ARM: davinci: dm644x-evm: fix label names in GPIO lookup
 entries
Date: Thu,  3 Jan 2019 16:11:03 +0100
Message-Id: <20190103151104.11839-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190103151104.11839-1-brgl@bgdev.pl>
References: <20190103151104.11839-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_071122_778724_AF9474B7 
X-CRM114-Status: GOOD (  12.02  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Since commit 587f7a694f01 ("gpio: davinci: Use dev name for label and
automatic base selection") the gpiochip label no longer has an ID
suffix. Update the GPIO lookup entries.

Fixes: 587f7a694f01 ("gpio: davinci: Use dev name for label and automatic base selection")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-dm644x-evm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index e1428115067f..b80c4ee76217 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -660,9 +660,9 @@ static struct i2c_board_info __initdata i2c_info[] =  {
 static struct gpiod_lookup_table i2c_recovery_gpiod_table = {
 	.dev_id = "i2c_davinci.1",
 	.table = {
-		GPIO_LOOKUP("davinci_gpio.0", DM644X_I2C_SDA_PIN, "sda",
+		GPIO_LOOKUP("davinci_gpio", DM644X_I2C_SDA_PIN, "sda",
 			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
-		GPIO_LOOKUP("davinci_gpio.0", DM644X_I2C_SCL_PIN, "scl",
+		GPIO_LOOKUP("davinci_gpio", DM644X_I2C_SCL_PIN, "scl",
 			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 	},
 };
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
