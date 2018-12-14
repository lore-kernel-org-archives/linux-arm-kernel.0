Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB463C6786C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:16:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ADEA2082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sh4hAqpV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bAi+bwS0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ADEA2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b5+xDfGGYCiAQSwAEIs+5RsKTcjZ3lM5hp9g8g5yBq0=; b=sh4hAqpVjYyE6I
	dzzKXj8QQ9JtsrLnfJKNux029+480GgcZydKcVHChrm9cfvWi0LwoEqEkb9tpNRo/zZ1O0VYKypDG
	npBbSiZVtceMYtSGAxlGlOzt6ya5XrvLHa0hyl1WOabnk0R9eizqtrtiB4PSxWiMj13JBGN46+CgH
	iWWECtmeNKq9x2H9vfkhUvOY3CRmu9HlnQ7I6UFY9YUZTccWs/onojWdT4hKVlvOr/ZiWOrmKU6I6
	9vJGZ/fS7x2j8Ddf3V0m0QP1QtUtigDuWroQabbtB6F54YjALrxnMNWaGFAzGK302o3yC30+Iw89C
	atXGJYAYIGab4XC4TbTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXnKb-0003J7-IQ; Fri, 14 Dec 2018 13:16:41 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXnKY-0003Hh-7N
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 13:16:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AhY1zkgywLBenPHQfvJF+s2esQsqOmctwVJ0RWn7CYc=; b=bAi+bwS0tnhfA23qi1IX1NltG
 RBqCQLpqINtYguueZUCxs6czm+HUuSPJMRUwdnNHhlGtakb1wE1ZJ3XawHSL0JaXblzQwm1aJLfsz
 ByYAJS3p/E0AUxTVYQmHINKVwQcNA1dADqUVTdcMlgt2sgtliQAsPpyphG+dv+RSrz4ao=;
Received: from n2100.armlinux.org.uk
 ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:37224)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gXnKG-0008OY-QH; Fri, 14 Dec 2018 13:16:20 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gXnKD-0003kM-ON; Fri, 14 Dec 2018 13:16:18 +0000
Date: Fri, 14 Dec 2018 13:16:16 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ARM: dts: omap4-sdp: Make ethernet working even if
 booted with latest u-boot
Message-ID: <20181214131616.GM9507@n2100.armlinux.org.uk>
References: <20181213135845.3965-1-peter.ujfalusi@ti.com>
 <20181213155054.GK9507@n2100.armlinux.org.uk>
 <f4961633-a151-145f-4337-dedbcafa64bd@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f4961633-a151-145f-4337-dedbcafa64bd@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_051638_265840_9FA58A43 
X-CRM114-Status: GOOD (  13.33  )
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
Cc: tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 14, 2018 at 03:08:09PM +0200, Peter Ujfalusi wrote:
> I certainly have the version of u-boot which can do only one tftp load
> (or dhcp request).

That'll be because of the buggy KS8851 driver.  This is the patch I
have on top of my 2014 version of Nishanth's tree.

diff --git a/drivers/net/ks8851.c b/drivers/net/ks8851.c
index 6467dde7ebf6..f888f43ad937 100644
--- a/drivers/net/ks8851.c
+++ b/drivers/net/ks8851.c
@@ -27,6 +27,27 @@
 
 #include "ks8851.h"
 #define KS8851_SNL		1
+#undef DEBUG
+
+static void dump_mem(const char *str, const void *base, unsigned orig, unsigned len)
+{
+#ifdef DEBUG
+	const unsigned char *p = base;
+	unsigned i, j;
+
+	printf("%s:", str);
+	
+	for (j = 0; j < len; j += 32) {
+		printf("\n%04x:", j);
+		for (i = j; i < j + 32 && i < len; i++)
+			printf("%s%s%02x",
+				(i == j + 16) ? " " : "",
+				i == orig ? "|" : " ",
+				p[i]);
+	}
+	printf("\n");
+#endif
+}
 
 /*
  * GET_KS8851SNL_RWWORD_CMD
@@ -324,6 +345,7 @@ void KS8851SNL_READ_BUFFER(void *pHardware,
 		pdw++;
 		*puReadLen = (u16)((*pdw) >> 16);
 		*ppOut = pIn + 8;
+dump_mem("RX", pMove, spiBurstLen + 8, spiBurstLen + 8);
 	}
 
 	if (spiBurstFlag != SPI_READ_BURST_ALL) {
@@ -626,6 +648,7 @@ static int ks8851_eth_recv(struct eth_device *dev)
 			printf("frame count = %d\n", rxFrameCount);
 #endif
 
+			pHardware->m_uCurFrameIndex = 0;
 			pHardware->m_uFramesRemained = rxFrameCount;
 
 			if (rxFrameCount == 0)
@@ -697,7 +720,7 @@ static int ks8851_eth_send(struct eth_device *dev,
 	uiPacketLength = length;
 	GET_DATA_ALIGNMENT(length, &uiPacketLength);
 	HW_WRITE_START(pHardware);
-
+dump_mem("TX", packet, length, uiPacketLength);
 #ifdef KS8851_SNL
 	KS8851SNL_DATA_WRITE((u8 *)packet, length, uiPacketLength, &fReturn);
 #else
@@ -722,12 +745,19 @@ static int ks8851_eth_send(struct eth_device *dev,
 	return 1;
 }
 
+static int ks8851_eth_init2(struct eth_device *dev, bd_t *bd)
+{
+	return 0;
+}
+
 static int ks8851_eth_init(struct eth_device *dev, bd_t *bd)
 {
 
 	u16 txCntl, rxCntl, w, intMask;
 	PHARDWARE pHardware = &gHardware;
 
+	dev->init = ks8851_eth_init2;
+
 	pHardware->m_uCurFrameIndex = 0;
 	pHardware->m_uFramesRemained = 0;
 	pHardware->m_uCurRecvFrams = MAX_RECV_FRAMES;
diff --git a/include/configs/omap4_sdp4430.h b/include/configs/omap4_sdp4430.h
index 0d9c16ea9f04..ae94dd852f3d 100644
--- a/include/configs/omap4_sdp4430.h
+++ b/include/configs/omap4_sdp4430.h
@@ -21,6 +21,9 @@
 
 #include <configs/omap4_common.h>
 
+#undef CONFIG_SYS_PROMPT
+#define CONFIG_SYS_PROMPT             "OMAP44XX SDP # "
+
 #ifndef CONFIG_SPL_BUILD
 /* Battery Charger */
 #define CONFIG_CMD_BAT			1


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
