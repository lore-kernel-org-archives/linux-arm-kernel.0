Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E2AC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:20:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E9D20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j/x9kWT+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="VVDRDjQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E9D20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=tFw4d/E/lP0pZ5wIJCs/MREzidVfnzgnhcYuRkZMbWM=; b=j/x
	9kWT+Pu8RvwTTWB9ZA1SJpxy7fhKZ/h0tDWSx2nHH0fnRyU68jiGxvrmK/LyaMpufPeDElCkox69C
	9Lve9BbUe5/QIAl+DB6MRYQV68SW+oeilvxLLwKNJ9zQ2HIxRp1cZQWf8daANfjwxN+0Q9/yObWY6
	hb8sZKVpGXfvFhIcnHW8Vn5uwPpK2s+dSphAl2iYT8gnzR5wRUqsyoenhqAlOwki5iBPHMdI5J2XF
	B+wN1cDL4WhVKwD11lnEyFhcH4Fun2xkW1ttrZiVNFAUAYVwz3YKBcc89HbrxRCZ8Ow91sou0cvqh
	pGFIgD3eV8nE3y/gzMCwLzShtoqQYdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUX6U-0003LU-8v; Wed, 05 Dec 2018 13:20:38 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUX6L-0003Jr-MD
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 13:20:36 +0000
Received: by mail-wm1-x344.google.com with SMTP id n190so10794625wmd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 05:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20150623.gappssmtp.com; s=20150623;
 h=sender:from:to:cc:subject:date:message-id;
 bh=2/kWzSPXQ+g9IzAwdqQK9pspdaUmQmZp604OR3Ol9F4=;
 b=VVDRDjQMAiePU/UmXAewImUcYfIee8a8aSVG4rqENqzYNbnohBj0g1ESMboIMYBogq
 vBV8qi5GYKN1ZJsGMyuTCurU3jGPE1021E5uSRrSVygd6QSI2WRV+p+XmAdEB2RDlQ12
 4r2Bq3T3PuHWPvlIgDATYskppM7LRK1K9Tfz7u/Y1OtURQbvjr0O/YB71dPXNAHdvt5b
 UbHQX3croqJ/J5RUT3iRc9rL+i+oWvJ5R/eTucEUjnVmc54zsfNaejfqKfyZ7F3OwmpJ
 dDDN49fs2L4XKh2E2KgALp20nud6jmF0x/NQgl6FvDcnprj6h4sQBR978yzVOyvN6ICl
 +mAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=2/kWzSPXQ+g9IzAwdqQK9pspdaUmQmZp604OR3Ol9F4=;
 b=ByBfe0ecP2EoFdl7swoqa+pqBnseT2dAUqpNr4FJriILO77WCSTqpsM7Xp5bgEb2A6
 YGwZwQQpzmQ/0QrP7FBNaNXzPdy8xWObhNZDBH/bhgLrlC1fcFdVsUGTKUgXv2EmIusr
 vJcqO+vmfHzieTWQSXZLQ0QzM9Q6hoNvN5y2y72TKwTv+/2jtqqas5FKoMH/xDX+MV35
 WRimjknc5fKtEMCF16hozvAetSCuNMNfYKN7p/LGKwmXeCeo67zMRH3oTolc3npPKeji
 6CzyHi4sNK9Wr8z9nZA4AyOgZsP5hVY3eA2Ijt1yohmcgckjNpvYmB8RQsagnXnVxY4Q
 Kztw==
X-Gm-Message-State: AA+aEWZAb47VB6CrXTtwEBZLdkFEUY4gsuT6uDB1Glh7nkUn0ZASYs+a
 fRikZKyNCwL1h/NOUFr+WBAfjg==
X-Google-Smtp-Source: AFSGD/VXWvI0GfqkOkDTNp4gngw3LRwT7uq+xj32X1p6Ti9G4UMPxZP8l/VyD72swxO0r/Bl4az+vQ==
X-Received: by 2002:a1c:b607:: with SMTP id g7mr16640399wmf.97.1544016013563; 
 Wed, 05 Dec 2018 05:20:13 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id j8sm17913635wmd.0.2018.12.05.05.20.12
 (version=TLS1_2 cipher=AES128-SHA bits=128/128);
 Wed, 05 Dec 2018 05:20:13 -0800 (PST)
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH] serial: uartps: Add the device_init_wakeup
Date: Wed,  5 Dec 2018 14:20:11 +0100
Message-Id: <ec9fdbdf1c444dc60edfc75a31583630e76a9b72.1544016009.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_052030_226126_696567CF 
X-CRM114-Status: UNSURE (   9.73  )
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
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Initialise the device wakeup.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 379242b96790..0140644391df 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1624,6 +1624,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	pm_runtime_set_autosuspend_delay(&pdev->dev, UART_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
+	device_init_wakeup(port->dev, true);
 
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 	/*
@@ -1702,6 +1703,7 @@ static int cdns_uart_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	device_init_wakeup(&pdev->dev, false);
 
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 	if (console_port == port)
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
