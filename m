Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081EFC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:25:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8BDA2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nDE7/zax";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="bpcuFGma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BDA2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=vQEEQ83VfFo9ns2/YSMALGQq+qUgxZkx3WbTVtMZpbE=; b=nDE7/zaxSq8tH8
	eXN/8YbhF7s1qiySRq4PVmW43W1oxVTlDy8x292yohnkxgVbQKgz08EJB3QTiZOHlejJ/0opGPyPs
	KwXZTnOHlwcJ1yr4kyf3f8WZ6DXJpBskeKpNa/XIcFuX6/puSsj4zxMo6cEMFM2pyubl0ZH2wsKw3
	HOVMRjlyzRfsq9QTiAspbUawWnBrNAvR6m4gi5jJb40PL1lIgXxZY33Y8+Sp0SMDdGcs01ZfFIJqS
	ySu/TUnIt/7Z1FoX8QzL0CSPVfaGGtjUwFD02IgWV5lIqbGKX+FycPXTOlvVWt5kaJM4scv5EL+zK
	MVBhByuQVWxBEpGpbxOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqxvQ-0007Ll-EB; Tue, 05 Feb 2019 10:25:56 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqxvM-0007Ka-GP
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 10:25:54 +0000
Received: by mail-wr1-x444.google.com with SMTP id v13so2979974wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 02:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gsNW22ssNcRzeaLbI3kaHnMCg+AMjSvUm5/De6rVJv0=;
 b=bpcuFGma4ARp+rS3F1Y6V4YUidcHMBR5+qlz7Kp8QZJQIJB6LAnK6mtZWs6glMlX6h
 IF9N2vdbUKgh9CkWOI7eFXROxa2V0v8FbbWDy75SMS5JnymJbcATlH2E5Uhv6T35WofX
 l7s6JMnkipTc0TwBjvsPs7Vub0rK6RXf3ijQqBg3I+tELDTpjgP/ZLMReQMhSj1k7RaD
 IGxQUcaJCDIdpTpx+2zmag4HZrxM3gsQgUyj/t62BRXGh9+0uf7JGfMuErGhcoDwUPl0
 p6kyMZm6AZng2bf2TDdhd4lZdH9WqbfG5m+GLTo7xtDLiaVpOkvctD90nJuC1H0y0Yyg
 GLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gsNW22ssNcRzeaLbI3kaHnMCg+AMjSvUm5/De6rVJv0=;
 b=JpGeOsMHfs9N94v8+iC626rdAkVzSTOQDU/kRwzkPMsWsXh3ORcSEs/3bVoPvmO7MD
 0WsaH5Ycvtsoh1E7zVVwH8NLVMejU8ETwmeBgqDYc5ryMXTM4ZsFEfT/ozp8rx0Tmkh/
 4Bh1PnC2UdLU3udhViJMydhtn2Xopr8kx71ncE+RmsnsybF1glm3077pJrogywtDlSGc
 rqWRkpEPcnUdKHRPF9JxgAqIj8WzCnFOKFR/M1NquJcpFAQ4ZLdLXeSuv1gMpRbvWh19
 IDXaAQfsVgk6U5bxo78tFgAhxVPyYeqIcIkI0T+V8Ak9OFPHyE1Gvj41fo5/w7XfjBBx
 7cvQ==
X-Gm-Message-State: AHQUAubKwQRAwlmE3e4WEAV54k6ef55JHtll+O0kUi2uB5Ss+06ibjy+
 RAuLNlv+cMurq09ktikP4is1ag==
X-Google-Smtp-Source: AHgI3IYtZh9j91EE8qCq+sT6sMUlF8AIU8mOHOTsUv757AKgBdtKOyzNSYAfc+NbMCTx7Ocgay6M6A==
X-Received: by 2002:adf:f903:: with SMTP id b3mr3193749wrr.82.1549362350470;
 Tue, 05 Feb 2019 02:25:50 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id r11sm5132396wrx.75.2019.02.05.02.25.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 02:25:49 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/8] ARM: davinci: move the da8xx-ohci GPIO logic into the
 driver
Date: Tue,  5 Feb 2019 11:25:38 +0100
Message-Id: <20190205102546.29457-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_022552_689819_4D55DE32 
X-CRM114-Status: UNSURE (   9.60  )
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
