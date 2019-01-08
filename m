Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E79FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:17:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D1282089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bx7RAxGe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="I4DyHWq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1282089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lFK67O6D+FA/2Dpm8STBwVY3D6BTtOilP5P3F0rPa40=; b=bx7RAxGeBZu+fG
	+xJNssErsSMWr6V5+bJDlvzoLk3nN6WmNq8JqjCyzD7qCSKj6cExAtZsq1a6/25lZfxbw5S0zB0V8
	n39BAfBiHPNU6Kki/IGPDcTwJrr8JI9rpVBcXw95UPhOsWu0YsX9KyvzyOHJBLhbZ7+iVaaMnQJ5+
	413KlawdHYuvUQocuKMKnm64KEYQCx7oZbV07qQFMkhjIDmE+WbLzW4+vyASd31Z8s2gU5k/bH1AH
	1C1po9gEo3nLMkMsz98u0t2tsH/gG3B7tznE9yDSCt8+4gXHp2T551J5mAyIRJ+0XdlTlfZ50XFZd
	o+Vcd/xZ381eOphE1RlA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggnVL-0007zN-4F; Tue, 08 Jan 2019 09:16:59 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggnUJ-0006sG-J3
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 09:15:57 +0000
Received: by mail-ed1-x543.google.com with SMTP id o10so3423105edt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 01:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sPuMqMq9r2hIniTC2IBiHD0FDPb8NBERuqBhYrjNhTE=;
 b=I4DyHWq89nlR8aZjx0D2q2aocdrlMqm+kG+aFvw5KJ9VXv++ZoDBxE1IAl74cHcyyL
 EtQHjI/DLHFbuBO3/AjDqmV42fw4a2HAhICGty37EUJJaW82RYFBmjH67SfNn6ju3KJT
 DJyG+CQvP4F6ABz3Y/LO/Td/i+cRbg1o1nWeDXIGBE+0NE/RCW1EKceOq7YmCdkyx0xN
 1O2znckPFYdrLCMVb4m6n745ZnMxVCKSam1YHkyBeYZHVo9fQ9t90rjL3Lk36D+ncMqU
 Q4Orgl4USZSFhqBu3tcOacpbBS7Q9DyHevEkhy+mqgcTZHkdyuuyMVVF+1QeZ/8t/cW9
 ZfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sPuMqMq9r2hIniTC2IBiHD0FDPb8NBERuqBhYrjNhTE=;
 b=YCXArWSB0ElZMeIeCoMQTWFDTyH2qVv4jCVs2OH3gfnEllHrYWREgr/mH529e5/R1x
 7zpPycyYM9i6n7EJ4qYeuaKtiJgvM/VZYVAlyv5/Lsugp/dSvlKdOFF3W7PAh3x/tLPV
 zqcozoDssnUC9vkfFIA+a0EYwQseLRA8++dr8jhWh0E3dhiLwDluMB2ZeduyL7lRBXJw
 2lm4v3uH4K91FV/qgq7MFkGjC/DJi2g7cpNdcFbvWg+H4LJq7j0EjoCDAsYXqJiJp7uV
 xsSrpctQ6gIWYtqYQyP7hUcYb0rX05bcnVhW6r8DYzLWQ3khk2IKADZ+WhlLfo2XB+bq
 jZPg==
X-Gm-Message-State: AJcUuke2Ep0b64zXJ1ryIkq4UHXFR10mYqRzsaYNyZSP2Vul9FWg5lAG
 lpT/O9y/O27+6z8Ma/xaD44CZg==
X-Google-Smtp-Source: ALg8bN7vQdt9vfA9gw8T0N8u72GrIInXFjQyFHqNKGgwEEwOOXm5i+Aznh5L0f1FzvV1eyhNkNUTNg==
X-Received: by 2002:a17:906:6c9:: with SMTP id
 v9-v6mr1190940ejb.203.1546938953822; 
 Tue, 08 Jan 2019 01:15:53 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id gp22-v6sm18373560ejb.4.2019.01.08.01.15.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 01:15:53 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RESEND PATCH 04/12] ARM: davinci: da830-evm: use device properties
 for at24 eeprom
Date: Tue,  8 Jan 2019 10:15:31 +0100
Message-Id: <20190108091539.16674-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108091539.16674-1-brgl@bgdev.pl>
References: <20190108091539.16674-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_011555_729232_AFADAC94 
X-CRM114-Status: GOOD (  13.73  )
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
 arch/arm/mach-davinci/board-da830-evm.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index e52ec1619b70..ddd871d8b44c 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -18,7 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
 #include <linux/platform_data/pcf857x.h>
-#include <linux/platform_data/at24.h>
+#include <linux/property.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/spi/spi.h>
@@ -457,12 +457,9 @@ static struct nvmem_cell_lookup da830_evm_nvmem_cell_lookup = {
 	.con_id		= "mac-address",
 };
 
-static struct at24_platform_data da830_evm_i2c_eeprom_info = {
-	.byte_len	= SZ_256K / 8,
-	.page_size	= 64,
-	.flags		= AT24_FLAG_ADDR16,
-	.setup		= davinci_get_mac_addr,
-	.context	= (void *)0x7f00,
+static const struct property_entry da830_evm_i2c_eeprom_properties[] = {
+	PROPERTY_ENTRY_U32("pagesize", 64),
+	{ }
 };
 
 static int __init da830_evm_ui_expander_setup(struct i2c_client *client,
@@ -496,7 +493,7 @@ static struct pcf857x_platform_data __initdata da830_evm_ui_expander_info = {
 static struct i2c_board_info __initdata da830_evm_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("24c256", 0x50),
-		.platform_data	= &da830_evm_i2c_eeprom_info,
+		.properties = da830_evm_i2c_eeprom_properties,
 	},
 	{
 		I2C_BOARD_INFO("tlv320aic3x", 0x18),
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
