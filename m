Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C1EC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:04:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88A0F20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kMpuSGDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A0F20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Xn2tJ6PK0tu6DwGldXAgjpXqPwQEBFDlIseD9K19OKY=; b=kMpuSGDq0q8gHL
	BEcoxD7m+lKiMnxJ3XLSmESy7TVX2vmBMacU0ud5S7txz+0FQ8jIYIRXRetX1XyzFa2cY+rnGpPuO
	i+sVsRUJBMXpTjEDvKIm71yaiI0F5BgMkrhRcqVoFIxAP0j7osVlGqShnOID3Dhq6Q2lSRWSHysnG
	qwsifMPpejRuVlSgNy/1L6KrYe22tkYMghCIEKIlGL0pBcGTgeAyPW9ZF3hgIDauCROZE+ZqSbGE0
	5n5PGfRRVPLkhKK2OQ4/L+LYk6vaVfoq3G6ybgiiXHZbqxxrkHxGTj1jvpXnbXuYw9ntKulwPhA65
	7iRKINw1ILEuDFd7Z4oA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grRZ2-00073z-Of; Wed, 06 Feb 2019 18:04:48 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grRYz-00073Z-8u
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 18:04:46 +0000
X-IronPort-AV: E=Sophos;i="5.58,340,1544511600"; d="scan'208";a="23506335"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 06 Feb 2019 11:04:44 -0700
Received: from tenerife.corp.atmel.com (10.10.76.4) by
 chn-sv-exch05.mchp-main.com (10.10.76.106) with Microsoft SMTP Server id
 14.3.352.0; Wed, 6 Feb 2019 11:04:44 -0700
From: Nicolas Ferre <nicolas.ferre@microchip.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches
 <ludovic.desroches@microchip.com>, <linux-arm-kernel@lists.infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
 <robh+dt@kernel.org>
Subject: [RESEND PATCH] dt-bindings: arm: atmel: add new sam9x60 SFR binding
Date: Wed, 6 Feb 2019 19:04:25 +0100
Message-ID: <20190206180425.27324-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_100445_345814_DCBF7CAA 
X-CRM114-Status: UNSURE (   8.63  )
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
Cc: devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
 Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add this SFR compatible definition for the sam9x60 SoC. Will be needed
in OHCI driver: ohci-at91.c.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
Hi Rob,
It seems that this patch was lost in my series "[PATCH 0/8] ARM: at91/dt:
update to existing drivers for the sam9x60 SoC". I split it and resend it only
for USB tree.

Hi Greg,

This DT bindind goes with the patch already queued in your usb-next tree "USB:
host: ohci-at91: add sam9x60-sfr definition for ohci".

Once Rob added his tag, can you please queue it in your tree as I reviewed my
first idea of adding it to the arm-soc tree?

Best regards,
  Nicolas

 Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
index badce6ef3ab3..dfc91bc02b97 100644
--- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
@@ -148,6 +148,7 @@ required properties:
 - compatible: Should be "atmel,<chip>-sfr", "syscon" or
 	"atmel,<chip>-sfrbu", "syscon"
   <chip> can be "sama5d3", "sama5d4" or "sama5d2".
+  It also can be "microchip,sam9x60-sfr", "syscon".
 - reg: Should contain registers location and length
 
 	sfr@f0038000 {
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
