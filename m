Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B85C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:20:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 595042147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="smG+EMWp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="fDEUd1Kb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595042147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=norrbonn.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ccqHqwALzI3/nZthy8V3eDYhwY3wwin+Y/mOK3VUP5Y=; b=smG+EMWp5UUqRb
	L09OyU++Twjcaq7TsFKTBwVPu83g13tDYfN48q+ZyWUk9NBXj2MJ1OCN7KlaVtfElZtUmf+CzatRy
	wwwtVQ9KNyxyBbY/V0q6gO+1ETaT3f9LhrD01ws5+iyvOZlOmpQdyW76bi4IPqJ7/eBmLwvvKDk+g
	VGk7Z2lFN37MnVBUv/p2/ZmjgavbAKAvIi2pkMKUCPCt6YjPNFBtPHTLE3wnP2Ryon3rFRYJKxLVG
	mB7H/eei/G9Aqr4S1LpE5n566UKpteW/4i+dmJH9faXvPXm7FBM3HSj+20BCmOKDwsG3HplchNWRI
	1u0FaE0dbIRPYcQIbtRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwQrr-0004aj-7Z; Wed, 20 Feb 2019 12:20:51 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwQrM-0003zj-Fd
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 12:20:22 +0000
Received: by mail-lf1-x142.google.com with SMTP id z15so1135944lff.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 04:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FSRWwTVoBrMl78Zf6MgLukE/51IJ1VvujWzWa2NPdSc=;
 b=fDEUd1Kbd4xOXUo32pDS6RZFh9/z99uqXUrrWCFvE5tCnP8faZpMQiu1QpldIGRr2w
 PVLaMMYxjlpgpKVMuBBMEuXyjirZg+KEZvFymFzl90msykZoE035PcZm68cvwzc3Mq4U
 +NQ+BsDl0TcO+GSnyw0909rlIRwfwHLpBakqxF32inxI2PPR4Q8c6NR6XHjWoSkfYs5h
 247kaP1lo8gkfO+BMjEnrHiR36ghO/jmmUVVW22vzxm5FvqAkr8bsGtoHRAJauNZgh4A
 LxLaCaUuJNy3RaESgvLU75qAXrPPS2Hi8inmux7+TqTav+HbXqjgc3R0OZF3mTQQceRd
 LIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FSRWwTVoBrMl78Zf6MgLukE/51IJ1VvujWzWa2NPdSc=;
 b=nU/Ynt+TJNLBnx5PA911xK3+RHmBroSi5k9QG4XeXZs4v1c+7UMkPFSNPF990Ykj2D
 gKtn1e3Gn83RH3sXO9m+DtUNIWcKLUp1h1rZXvHh5OJ1oAO2zjwOnrh343aZI1lmAtpE
 d+chXV0OdEoyDtu/DJAPxd9cylmJNjuT5338rLXd5ZeEx5iqOGuF8caHNB45aGXIH2vS
 lSmktblQJhBMDYJWHSqw4Kk4W7hqWf9fOgZP8IVFJWGo1CgzcliG0MK9e69zbWaaLdKP
 i2Pc2wiIbsOBa9oRfK+QAcmuYiEi1/tTTBHICjlJ3BYfsrHOAogIutezIsmeFBN6MBQp
 QeNQ==
X-Gm-Message-State: AHQUAuYqb2Pi7xsTZk/GiklOPaU7w5ni14ZmHyRjixrM1IWM2AzhJZO+
 cf+9MxGX0ojjH7GB6eq4RAdiRw==
X-Google-Smtp-Source: AHgI3IbbedkxmXWV3M9a5yKzldNsxhoImr4snDWLw4L5vmCzdVdnHciIz0cWhZJnqf2SSMtybemGeQ==
X-Received: by 2002:ac2:5288:: with SMTP id q8mr21278268lfm.157.1550665218561; 
 Wed, 20 Feb 2019 04:20:18 -0800 (PST)
Received: from mimer.lan (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
 by smtp.gmail.com with ESMTPSA id r2-v6sm5270270lja.78.2019.02.20.04.20.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 20 Feb 2019 04:20:17 -0800 (PST)
From: Jonas Bonn <jonas@norrbonn.se>
To: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH 3/3] usb: gadget: atmel: tie wake lock to running clock
Date: Wed, 20 Feb 2019 13:20:01 +0100
Message-Id: <20190220122001.5713-4-jonas@norrbonn.se>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190220122001.5713-1-jonas@norrbonn.se>
References: <20190220122001.5713-1-jonas@norrbonn.se>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_042020_517476_6A0E3D70 
X-CRM114-Status: GOOD (  12.43  )
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
Cc: Felipe Balbi <balbi@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonas Bonn <jonas@norrbonn.se>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 linux-arm-kernel@lists.infradead.org,
 Cristian Birsan <cristian.birsan@microchip.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

If the USB device is connected to a host, the CPU cannot be suspended or
else the USB device appears to be disconnected from the host's point of
view.  Only after a "USB suspend" state has been entered (as set by the
host) or the host is disconnected can the system safely be suspended: in
both these states, the clock is stopped.  As such, this patch associates
a "wake lock" with the running clock of the UDC to keep the system awake
as long as the host maintains the USB connection active.

Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
CC: Cristian Birsan <cristian.birsan@microchip.com>
CC: Felipe Balbi <balbi@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: Ludovic Desroches <ludovic.desroches@microchip.com>
CC: linux-arm-kernel@lists.infradead.org
CC: linux-usb@vger.kernel.org
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 740cb9308a86..864d03c3c9db 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -1859,6 +1859,8 @@ static int start_clock(struct usba_udc *udc)
 	if (udc->clocked)
 		return 0;
 
+	pm_stay_awake(&udc->pdev->dev);
+
 	ret = clk_prepare_enable(udc->pclk);
 	if (ret)
 		return ret;
@@ -1881,6 +1883,8 @@ static void stop_clock(struct usba_udc *udc)
 	clk_disable_unprepare(udc->pclk);
 
 	udc->clocked = false;
+
+	pm_relax(&udc->pdev->dev);
 }
 
 static int usba_start(struct usba_udc *udc)
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
