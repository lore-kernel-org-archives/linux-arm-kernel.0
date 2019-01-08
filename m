Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CFDC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:16:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40A862089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QcgvTHm4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Zg8t0ZSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A862089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J4OMrGaPFw+nSilPhTqa4g1WAM5BzhCB1CsJaX2T9m8=; b=QcgvTHm4x+mS3U
	3CYsjftdr1aVYLXgkzrzzh0uBZpCDQUarN+IymwUwnRLQH5DXR9An6kJ45maWAcWk6SlYFJc7Mv+I
	Tp6YZr2jgAbbgWDEpu+wXZp3kmqUf1sOZiTNC5QFC5hk2NLA8wGvVfV/wh3kFgJy+O3pl5Cro1Lac
	V58nPtxX5ngO9soBkfiSfSqe8idDYTNT/YrcM+yPUsiGZMgDeXvk/9Y2XcxWAOu8IL3PZtP1IZOlG
	FWM4t/JxI/UyzIpuaY6tBNbMlznZhblQhNN1e4SWySq/YUrcTsKNB7IpfYJtC4oWSVTEsqaG8fsiu
	BGngiNnqQUp/4ZOlV/+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggnV2-0007eA-5Y; Tue, 08 Jan 2019 09:16:40 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggnUH-0006rU-Mi
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 09:15:55 +0000
Received: by mail-ed1-x542.google.com with SMTP id h50so3457490ede.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 01:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d9WKYwfle5iDpDbapbl3IuLnt+LCk29VTN7zfdkUdEk=;
 b=Zg8t0ZSHGq5+XwEHztECZ+pq2NswnAhNF+REWdT0SKfdX9bJ4nN5h+wBoHhxfB7Hk1
 0tYBwmAbTGnqQuRkZt093/IZtkl0JToxqIqwSukwlN5wfuP8nGUS0AGWw1yteG5kpnA+
 6drX4ac/iaBeCUwrMrEzd88ZA4W20PuqHb0qfWSHYe/3BflsEDZXE465wfz+/ystnhvY
 jA4RAOzgdWuqQgrYcUs5lzYEUfdObdtiP2moeyRXDi3AAy8xgCpWla1/LltR1wp9Iu5c
 Mkjq1xQb5z30kpkoUIDPhIK0ruEuYlYqQ+JlyHMtdrL0pkG0csZF208L1zj3iBWshYHs
 drLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d9WKYwfle5iDpDbapbl3IuLnt+LCk29VTN7zfdkUdEk=;
 b=MzU1FtmRlywV7Euut4WU6YdJdLTrIFZKEL+XXUkoHGQIhsm7kAyftfTPGVaoscbLDQ
 I6sBT7EHFvwUZMaaL6PKXlpv5c9cdF7ZpBzG118RzCg18wXsNKapmiEPPGTY7ig9xvSH
 2hROz8OX15cxgJUHxhmxx1FviBrfG5NdhUln5cDmVX3MrVOK5ajDQhO26witTx692KE6
 R3xKTqWAcKoLUNONECCMqVMRYbefjb760QCjwO3oLvuHg36qwZmk0f+B3ZSLewcAFVIe
 qFzCfelWsgU7AE+jizEGD/3bPfiFceMdL+PSOXegNgVoLuxq/dTJcDngiI6vUJ2fW9+D
 Du/A==
X-Gm-Message-State: AJcUukcnqlWC3YDuM1m2ywZzfl+fiXE9oVYSdBMIMlePGgrGJwpBb+Ii
 z5e61JFhQf075K9KrCVQywVJ6A==
X-Google-Smtp-Source: ALg8bN7iyeVeqgk7+KcFyN4P5TwNc2Mc07Xw4RCmf0MMVwMtYaz66rhQQSMeftjM+C4+1Q1Ydkjimw==
X-Received: by 2002:a50:d753:: with SMTP id i19mr1316410edj.75.1546938952367; 
 Tue, 08 Jan 2019 01:15:52 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id gp22-v6sm18373560ejb.4.2019.01.08.01.15.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 01:15:51 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RESEND PATCH 03/12] ARM: davinci: dm365-evm: use device properties
 for at24 eeprom
Date: Tue,  8 Jan 2019 10:15:30 +0100
Message-Id: <20190108091539.16674-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108091539.16674-1-brgl@bgdev.pl>
References: <20190108091539.16674-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_011553_741575_DFDC90F7 
X-CRM114-Status: GOOD (  13.10  )
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

We want to work towards phasing out the at24_platform_data structure.
There are few users and its contents can be represented using generic
device properties. Using device properties only will allow us to
significantly simplify the at24 configuration code.

Remove the at24_platform_data structure and replace it with an array
of property entries. Drop the byte_len/size property, as the model name
already implies the EEPROM's size.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 arch/arm/mach-davinci/board-dm365-evm.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index e3b0b701e395..f21dc8d3b28c 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -18,7 +18,7 @@
 #include <linux/i2c.h>
 #include <linux/io.h>
 #include <linux/clk.h>
-#include <linux/platform_data/at24.h>
+#include <linux/property.h>
 #include <linux/leds.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
@@ -225,18 +225,15 @@ static struct nvmem_cell_lookup davinci_nvmem_cell_lookup = {
 	.con_id		= "mac-address",
 };
 
-static struct at24_platform_data eeprom_info = {
-	.byte_len       = (256*1024) / 8,
-	.page_size      = 64,
-	.flags          = AT24_FLAG_ADDR16,
-	.setup          = davinci_get_mac_addr,
-	.context	= (void *)0x7f00,
+static const struct property_entry eeprom_properties[] = {
+	PROPERTY_ENTRY_U32("pagesize", 64),
+	{ }
 };
 
 static struct i2c_board_info i2c_info[] = {
 	{
 		I2C_BOARD_INFO("24c256", 0x50),
-		.platform_data	= &eeprom_info,
+		.properties = eeprom_properties,
 	},
 	{
 		I2C_BOARD_INFO("tlv320aic3x", 0x18),
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
