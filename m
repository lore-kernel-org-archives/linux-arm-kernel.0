Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C190C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 15:23:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15AE021B6A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 15:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="soDS5Ee4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="gtdTEaQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15AE021B6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=mail.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=je8RxopO7WGxSoelXWHWx/fdZqA7GmG3rkWN0+m+J2Q=; b=soD
	S5Ee439Hv7YvcYCogVxejiB9xdhHOWVTlv8DM3apkjakLFx2EqU8LBJL3EWV9BYdnitqHXwknM57q
	mx5mVprYsmo/U5lyHp/rvoQFKOVlJHtAsu9+gqk5MXQ9pvzc3n0JYFeQfv/4Nih5DX1vFsXY0T2oR
	gCqVElTTKf9AR4i/izPpmohwje9VSQ/TKhGAknjI72+4lAXW89tmEmAVcNGquA/7DFDfISds4wOHb
	JCJBztxWMqeFrseSeGF4PCOA3lPCiLQm+sULezw/9A0d1ifFbxRGACiTn31OXNZQlzSlxNUPw/ol+
	ZRAJacqjrl3opvhFF0ickSR27dJJImw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaj7v-0000NT-4g; Sat, 22 Dec 2018 15:23:43 +0000
Received: from smtp37.i.mail.ru ([94.100.177.97])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaj7e-0000Ma-QO
 for linux-arm-kernel@lists.infradead.org; Sat, 22 Dec 2018 15:23:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail2; h=Message-Id:Date:Subject:Cc:To:From;
 bh=r/XVRQTDbYEG1lkw+uqBeqOFgHBwi6cHKSInrzWnklA=; 
 b=gtdTEaQ2D32/4niIlVxI+h0zOf9+kD3D9ZsnM97iR3/V12hskiAnbr/3Xr9uAX0kkZR10NqE7sLoYcK2s4jjWt0pKfv9Le/Mr0Keg6GkTqBCRretzOdq7wkOuQjBe6Nte8U0GEICNNbSLBBJO6B8hKoKpkcqAhFWzp2S9vb6Izs=;
Received: by smtp37.i.mail.ru with esmtpa (envelope-from <shc_work@mail.ru>)
 id 1gaj7P-0000O3-85; Sat, 22 Dec 2018 18:23:11 +0300
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: Remove clps711x_defconfig
Date: Sat, 22 Dec 2018 18:23:08 +0300
Message-Id: <20181222152308.26244-1-shc_work@mail.ru>
X-Mailer: git-send-email 2.10.2
Authentication-Results: smtp37.i.mail.ru; auth=pass smtp.auth=shc_work@mail.ru
 smtp.mailfrom=shc_work@mail.ru
X-77F55803: 260C666A7D66B36A5A78504BD2AC29419868B496DAF47A9F866A6982B43102E9AD7F454762E322E4895CE55B35FF23A6
X-7FA49CB5: 0D63561A33F958A508D9C670768DFD6D431EA7FD53979BFA7D67B4EF99483F558941B15DA834481FA18204E546F3947CC2B5EEE3591E0D35F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8BECADA55FE5B58BB7A471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249E20791DD86E535D73AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE79C0DA0AD91AF617ECD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE7EF4A64DAA4462830C4500323284D7146EFF80C71ABB335746BA297DBC24807EA27F269C8F02392CD20465B3A5AADEC6827F269C8F02392CD5571747095F342E88FB05168BE4CE3AF
X-Mailru-Sender: 139A7956A63CACCF2A18077BC60D2445C56762CB6CB559FA4BE5C93FD63A0F7C19C48A81677E02396B3B2BD4812BFD4DC77752E0C033A69E93554C27080790AB3B25A7FBAAF806F0AE208404248635DF
X-Mras: OK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181222_072327_220134_DE1AD919 
X-CRM114-Status: UNSURE (   8.83  )
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
Cc: Alexander Shiyan <shc_work@mail.ru>, Russell King <linux@armlinux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

We have everything we need in multi_v4t_defconfig that exists in
clps711x_defconfig, so get rid of that file to reduce the maintenance
burden.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/configs/clps711x_defconfig | 91 -------------------------------------
 1 file changed, 91 deletions(-)
 delete mode 100644 arch/arm/configs/clps711x_defconfig

diff --git a/arch/arm/configs/clps711x_defconfig b/arch/arm/configs/clps711x_defconfig
deleted file mode 100644
index fc105c9..0000000
--- a/arch/arm/configs/clps711x_defconfig
+++ /dev/null
@@ -1,91 +0,0 @@
-CONFIG_KERNEL_LZMA=y
-CONFIG_SYSVIPC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_RD_LZMA=y
-CONFIG_EMBEDDED=y
-CONFIG_SLOB=y
-CONFIG_JUMP_LABEL=y
-# CONFIG_LBDAF is not set
-CONFIG_PARTITION_ADVANCED=y
-# CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_CLPS711X=y
-CONFIG_ARCH_AUTCPU12=y
-CONFIG_ARCH_CDB89712=y
-CONFIG_ARCH_CLEP7312=y
-CONFIG_ARCH_EDB7211=y
-CONFIG_ARCH_P720T=y
-CONFIG_AEABI=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
-# CONFIG_COREDUMP is not set
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-# CONFIG_IPV6 is not set
-CONFIG_IRDA=y
-CONFIG_IRTTY_SIR=y
-# CONFIG_WIRELESS is not set
-CONFIG_MTD=y
-CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_CFI=y
-CONFIG_MTD_JEDECPROBE=y
-CONFIG_MTD_CFI_INTELEXT=y
-CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_CFI_STAA=y
-CONFIG_MTD_PLATRAM=y
-CONFIG_MTD_NAND=y
-CONFIG_MTD_NAND_GPIO=y
-CONFIG_NETDEVICES=y
-# CONFIG_NET_CADENCE is not set
-# CONFIG_NET_VENDOR_BROADCOM is not set
-CONFIG_CS89x0=y
-CONFIG_CS89x0_PLATFORM=y
-# CONFIG_NET_VENDOR_FARADAY is not set
-# CONFIG_NET_VENDOR_INTEL is not set
-# CONFIG_NET_VENDOR_MARVELL is not set
-# CONFIG_NET_VENDOR_MICREL is not set
-# CONFIG_NET_VENDOR_NATSEMI is not set
-# CONFIG_NET_VENDOR_SEEQ is not set
-# CONFIG_NET_VENDOR_SMSC is not set
-# CONFIG_NET_VENDOR_STMICRO is not set
-# CONFIG_NET_VENDOR_WIZNET is not set
-# CONFIG_WLAN is not set
-# CONFIG_INPUT is not set
-# CONFIG_SERIO is not set
-# CONFIG_VT is not set
-CONFIG_SERIAL_CLPS711X=y
-CONFIG_SERIAL_CLPS711X_CONSOLE=y
-# CONFIG_HW_RANDOM is not set
-CONFIG_I2C=y
-CONFIG_I2C_GPIO=y
-CONFIG_SPI=y
-CONFIG_SPI_CLPS711X=y
-CONFIG_GPIO_CLPS711X=y
-CONFIG_GPIO_GENERIC_PLATFORM=y
-# CONFIG_HWMON is not set
-CONFIG_FB=y
-CONFIG_FB_CLPS711X=y
-CONFIG_LCD_PLATFORM=y
-CONFIG_BACKLIGHT_PWM=y
-# CONFIG_USB_SUPPORT is not set
-CONFIG_NEW_LEDS=y
-CONFIG_LEDS_CLASS=y
-CONFIG_LEDS_GPIO=y
-CONFIG_LEDS_TRIGGERS=y
-CONFIG_LEDS_TRIGGER_HEARTBEAT=y
-# CONFIG_IOMMU_SUPPORT is not set
-CONFIG_PWM=y
-CONFIG_PWM_CLPS711X=y
-CONFIG_EXT2_FS=y
-CONFIG_CRAMFS=y
-CONFIG_MINIX_FS=y
-# CONFIG_NETWORK_FILESYSTEMS is not set
-# CONFIG_FTRACE is not set
-CONFIG_DEBUG_USER=y
-CONFIG_DEBUG_LL=y
-CONFIG_EARLY_PRINTK=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
-# CONFIG_CRYPTO_HW is not set
-- 
2.10.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
