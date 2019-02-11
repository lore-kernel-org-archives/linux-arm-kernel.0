Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5F6C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:37:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 180E020863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EdoCT2zY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Sufvb4eg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180E020863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=aTjr4cGWXwOKOaLDFtgs5Pk64WusQk/MarG4CjxEoKI=; b=EdoCT2zYV/JWOg
	yOsBEqVmAWP9N8+i0wZr4i5T6KnzOfNeI8YtnzjOZOGF+QWeqVcvS9yEPU6RnPCGiQxO13Rs1ozZX
	yEd7073uL6X1e9JFThjM6oP5C1L368LXTxda0sytflJ2XkO59LMfv+yxYau/SuZS3vXb8zq0RHkOZ
	a/D1GSD6uDpwIOLsUiH4ceACvYgil8xMrTeGL9L0hBIUwUGrXmNJoUZOOWl5KMpZGscoo8FdDuQ61
	gxMpVuYCkrOVxk/bDKBrkBax3dRzge2/kyb0aVzeMIpRERcvUvxmEiMVexn3zOBGx9ZiPZOx139N0
	rzUTq6w6Q0qjhusJmrVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt8y3-0006xJ-Bo; Mon, 11 Feb 2019 10:37:39 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt8xY-0006TX-I8
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 10:37:16 +0000
Received: by mail-wm1-x344.google.com with SMTP id b11so16817559wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 02:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Lp1z88rmSvOgpHJjKgNZ/hWDt9IGj1pIXD05fNWwKy8=;
 b=Sufvb4egsQ51rirVphDLxi9YG0kRqBsdDsj4Xa5r1xMgynbkKEnv3/RwUr6Tl5lwJi
 VPO0szmPHap3TVe5iNXXwocVml2yBvtoPYhHxlNR1keVFD8eXvKKoZuYsF8KOQZZX8s6
 27AxLaF92J3Okhx1Wqs5nKs/2NgmqpdONsgTxarYyj7fNESL/h55iG+yDsjKn9TenNEk
 U5kFti2fGgffjnQPuGFG0ZkNoEe2yr+vNWl/4rr6ahKoQe+JCoeb+1G05qstAvS1HJCo
 5CP9ygbRa+K6EbTVQ209WEmnVOT+kZihhcJszN3kXZVBRP0Qr6vILVpf1WWBCGoeCP03
 +9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Lp1z88rmSvOgpHJjKgNZ/hWDt9IGj1pIXD05fNWwKy8=;
 b=kkdsK5oRDcKHjdy2SxkhDlBFQO+/hTRURf/wrq3IRVQj/dJ1QKmAr7XB1SZnp4h7i1
 uxogQ3EGwUxSfNYRnO+YTKtyzsJAWRmRN8aPn8h0M2+hWjFMsGI0Fr58Vy2jGBWs2w4T
 91hlpr7dRhXC9hJVsVAlnVQye2lxXilq7bW52cZuHi+P5FTRf3ZMRi/aW6xFZMFqbgi9
 Nu/FeBoCZLOG03Ta0gIaUXpIE4BKBaZ+xMIf0Rjnbdrr7WeeW0lrPm4TCAukcDxnSYL5
 c8fh7oO/B9tMgmCW804fC58rkbCAeCXLL9gNYLFFpsDkpH0UMxnpRsZhPwS0dEwBSRCB
 ENXw==
X-Gm-Message-State: AHQUAubxeKMjcYo1j1dVt9PgYIGB2OWRUkfeKmznX3aNn/fH6EtxruVI
 51WFs512DTJqvOkugmyaHo5BDQ==
X-Google-Smtp-Source: AHgI3IYo5IcQW4kWbVn+7JxJfi7KrWkt9X31jdXtUzSKteRW1gb7ZzGR5lRcQWfbO0GA9UnxpZfVcA==
X-Received: by 2002:adf:e647:: with SMTP id b7mr1739112wrn.260.1549881426304; 
 Mon, 11 Feb 2019 02:37:06 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id i192sm11121275wmg.7.2019.02.11.02.37.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 02:37:05 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 0/8] ARM: davinci: move the da8xx-ohci GPIO logic into the
 driver
Date: Mon, 11 Feb 2019 11:36:54 +0100
Message-Id: <20190211103702.4277-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_023709_474721_6DB66EAD 
X-CRM114-Status: GOOD (  10.86  )
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

In order to drop the hard-coded GPIO base values from the davinci GPIO
driver's platform data, we first need to get rid of all calls to the
legacy GPIO functions.

This series moves the GPIO logic related to da8xx-ohci out of the board
files and into the driver code.

First two patches are just coding style tweaks. Next two add the GPIO
lookup entries to the board files. Patch 5 add the vbus and overcurrent
GPIO logic to the davinci USB host driver. Last three remove code that's
no longer used.

v1 -> v2:
- use the non-sleeping version of gpiod_ functions in the irq handler
- improve commit messages (make them readable without the subject line)
- collect Acked-by and Reviewed-by tags
- rebase on top of v5.0-rc6

Bartosz Golaszewski (8):
  usb: ohci-da8xx: add a new line after local variables
  usb: ohci-da8xx: add a helper pointer to &pdev->dev
  ARM: davinci: omapl138-hawk: use gpio lookup entries for usb gpios
  ARM: davinci: da830-evm: use gpio lookup entries for usb gpios
  usb: ohci-da8xx: add vbus and overcurrent gpios
  ARM: davinci: omapl138-hawk: remove legacy usb helpers
  ARM: davinci: da830-evm: remove legacy usb helpers
  usb: ohci-da8xx: remove unused callbacks from platform data

 arch/arm/mach-davinci/board-da830-evm.c     |  73 ++----------
 arch/arm/mach-davinci/board-omapl138-hawk.c |  81 ++------------
 drivers/usb/host/ohci-da8xx.c               | 118 ++++++++++----------
 include/linux/platform_data/usb-davinci.h   |  14 ---
 4 files changed, 77 insertions(+), 209 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
