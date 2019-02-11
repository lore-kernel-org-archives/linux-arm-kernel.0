Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43960C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:39:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CB582084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FI6IvBcs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="sKVAHfBS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB582084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FKKi4gk+lPsT+CsNKnEDRq6DmWNovrIND9zjmPvn7nk=; b=FI6IvBcsT9QUME
	tLWOOL9OYdbIckaOJdI34QwZVS0z7MISPKdu56x3PvWftC6IwojIuHmrnxx9cxALYVpXwhPXWX1AI
	jYLCVqlFAgm4Qx22ARl2guXWOY9RXB75m+NuAfNxsnX2jUsyOzftosOdI7Xfk1msCMUAc3bDY00cS
	XWypyr43fNrNoj7UvdFcoARvvMzifGaAMI7GBTPCSO5AF04eliTXQYinb7+cpYcGrJmVcsOOeZWr0
	n8KKvc/6lSAcelNoftIz9gw3MG64SK3+HFRUy5eBxTrfVioWnvb6V0dhHYduEix5ZHfWHNgdiKH+a
	rQ+O03SWo5LArKfPMcUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt8zv-0000Ew-BX; Mon, 11 Feb 2019 10:39:35 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt8xh-0006fK-8A
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 10:37:21 +0000
Received: by mail-wm1-x344.google.com with SMTP id v26so16309169wmh.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 02:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Tt06UGkm6C60fE3GnCLmVsdN1KETvFT9lYr7KKnVtso=;
 b=sKVAHfBSGT6IdWdNE5LktbYFBiksZLEdXjYNRPMNh/GHaXkR3ztP+XBnsm2wyoHB2q
 3cto1e4KOLLe/rXUPUAGVkHxDVxBs1x6pVtED2SMpSPk7Bv0LogoZQ5B3ea/t96px4ju
 J1GTy/Rgg3e1E7i/Ofwr0h1+9SWIHY0iGCHYshVVwCZ8uuK5U/bTgmA+0gKdRHndXe1H
 i6KFuoM7eNHrEqG4cpZIKGPJEfc2QXQdCigw99YbtgpVpnb+0B4qbad+lO+1QHhA2uw1
 eRTpomgOFVp6bUdXLqYSFc9+BcvOc3nqtJ/rWFQc2jFpDTEYOiCTgt8ZxBsjZOKClXVP
 H0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Tt06UGkm6C60fE3GnCLmVsdN1KETvFT9lYr7KKnVtso=;
 b=FQcbZ7UbF3c/VGPjoEdbDYUjKlgWCoto1lmjxk+DU/uGy4eg3N/WNV7Os5foVPwE1K
 0gUlEUiPXBcSYlbef0JwtSQISoSlo4G4YoHaeGWb1tV9WMRo4/Cx5+snchwVwVjL0Ky3
 J5QDbbr+1X3or2pu6NcH6STOKRDz+KjTKQWQstl/3rAfQKJMU1IqQxIQtQ8HkQtMz+Qw
 mVjkG/ZsRCO5EcRCQe36DZ7Twy6cviaOnLcbM/l3P7YWHokcJkethkaO5ZJ97nAXYTnj
 iow1Wkde0Y9CWYcFj0E0aJB73D7CvzgRtTjTq/sEetGYKnvCn3YD4g/7qaogYN0ZRBJx
 +7Ug==
X-Gm-Message-State: AHQUAuYWP0Z3YsGuqlRTaieg+wE5qsLzyK43KNuO8inYybPzvDgr0yuy
 hqY6SOe55hh6ZxWfHSPnBNhakw==
X-Google-Smtp-Source: AHgI3IZDb7JzDbFuJfzdE5f/zY5bCfx61C1chkHlbE9OBlu3hXjXN3Fp4mm2dOAV7e75keLcB04ftw==
X-Received: by 2002:a1c:7304:: with SMTP id d4mr6467825wmb.136.1549881435805; 
 Mon, 11 Feb 2019 02:37:15 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id i192sm11121275wmg.7.2019.02.11.02.37.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 02:37:15 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 8/8] usb: ohci-da8xx: remove unused callbacks from platform
 data
Date: Mon, 11 Feb 2019 11:37:02 +0100
Message-Id: <20190211103702.4277-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211103702.4277-1-brgl@bgdev.pl>
References: <20190211103702.4277-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_023717_707971_04C6A273 
X-CRM114-Status: GOOD (  11.78  )
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
 Linus Walleij <linus.walleij@linaro.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There are no more users of the platform_data callbacks in ohci-da8xx.
Remove them.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 include/linux/platform_data/usb-davinci.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/linux/platform_data/usb-davinci.h b/include/linux/platform_data/usb-davinci.h
index 0926e99f2e8f..879f5c78b91a 100644
--- a/include/linux/platform_data/usb-davinci.h
+++ b/include/linux/platform_data/usb-davinci.h
@@ -11,22 +11,8 @@
 #ifndef __ASM_ARCH_USB_H
 #define __ASM_ARCH_USB_H
 
-struct	da8xx_ohci_root_hub;
-
-typedef void (*da8xx_ocic_handler_t)(struct da8xx_ohci_root_hub *hub,
-				     unsigned port);
-
 /* Passed as the platform data to the OHCI driver */
 struct	da8xx_ohci_root_hub {
-	/* Switch the port power on/off */
-	int	(*set_power)(unsigned port, int on);
-	/* Read the port power status */
-	int	(*get_power)(unsigned port);
-	/* Read the port over-current indicator */
-	int	(*get_oci)(unsigned port);
-	/* Over-current indicator change notification (pass NULL to disable) */
-	int	(*ocic_notify)(da8xx_ocic_handler_t handler);
-
 	/* Time from power on to power good (in 2 ms units) */
 	u8	potpgt;
 };
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
