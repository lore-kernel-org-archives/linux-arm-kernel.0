Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4F9C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:21:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EA862082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="glY3Du8i";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="TPVMMP2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA862082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=WDXw5zIYACgZk/5EJuDEgdnC6JalPVDgpZEWc2xCp0Q=; b=glY
	3Du8i5SdjdlHgkCwu2cN19yXDKTFfnlz9V5IQ1DXWuDBeFlnWc21cZbuGqt5EZPwLmh7j/zdxo014
	dDWKZ5P59p6Go0kbSfoQc50jpWVERxOMzcGrmctin7XTNb+JnGW8j5602pxr7xzv0NbfE8CIjBFo0
	dN4sZjOFmXRoC8SN5/R0Z7O/LiKSNGkRj0onzbAVcaAEXVFjjOVAewrykz8W3wagiF7HRDeAnD7yo
	o3I6ZXD1K+HAwhzB5x1hgq0rUbILSPf+YolUBt9v4pjQrl/hoVW6c5y5ilMxQ7XE/ABF6Won1Cd+4
	kGEEAadjYMFR+0PL3rhMfVC+C+I2eZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUX77-0003xR-Kh; Wed, 05 Dec 2018 13:21:17 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUX74-0003p6-OO
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 13:21:16 +0000
Received: by mail-wm1-x344.google.com with SMTP id c126so12835249wmh.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 05:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20150623.gappssmtp.com; s=20150623;
 h=sender:from:to:cc:subject:date:message-id;
 bh=w60EavONrQQDo0N1GYLfef4PCoyBWjUWB42v/HtDc48=;
 b=TPVMMP2jup59fvlKK+MD6keIBC57Z0XacB4D98bkAAd2wWIMxekQnO2rOIT7NQiwP4
 jzAqqc7X565Wrnl0IKsl1JFHS7t+1puE6V3ubC2M3Zb1clBAx4ZNKwGErHgY1mU7jHg8
 w9rC1bgCPRPHDIRqtnnLeDIy+LxKQFbsB6LxzSEK5Wu/62Ue4cJDlBGbF2C/nrLr8k76
 tiSGaFzHaEZwJzNjQuE8TBezPiFLFQFfC9tqXfzcQn6b7tlT/o3uN0+kuI09zg/rcusL
 cy8JKv2UvhVETYpfQQoEgzUfeJd7C24HQ3tGOL3H4GCbn4lP20cC3EImuZGZG8GJCcYW
 CTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=w60EavONrQQDo0N1GYLfef4PCoyBWjUWB42v/HtDc48=;
 b=BPwu5QWzdCg9vsD1VcE7fG5re3aQnX1NGj3qPdD9chYiNfHKwursae0YlxMYpqXkA6
 sU5NRSDZ2Vb8xLsk3rIkvMXRsPQ8UI2cjB/UDRJyfDwkXqpTI5VnNGyiIT/cIyIx3N6m
 X/7Qs8HL4BIAPJQQZbD8y9QgFYu23JEJaSDr059qold2d6oyCiPQ0nGVKtPygdc0iXn6
 EIU2LrlcaLedZSd2JOmRehatdApKiPXksrt22HXfF6rHGUHrQYu9v/2RCmtdjModGkUv
 sdX+xzBD68np3CvO+/fSwynk2CYio9kCcK/EbKOGV/GdWwe0Cf0+MfbRwyPNxfK2hloC
 zSBA==
X-Gm-Message-State: AA+aEWakxYwV7jtjGnRAgo+L7znWAuA04fpMG735Jf5RkQHohkNXXp6y
 5g2CIxZIuNQMnBfXDBh7aFDL7g==
X-Google-Smtp-Source: AFSGD/VqY7wakmLzIJz4rMPviH9oXPoeLZXXfp5xhvN7bMC7Au2ZTpuEAT3sV5LL2Hy7wtZrO6U8Hg==
X-Received: by 2002:a1c:2981:: with SMTP id p123mr15793071wmp.19.1544016063107; 
 Wed, 05 Dec 2018 05:21:03 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id v132sm1563514wme.20.2018.12.05.05.21.02
 (version=TLS1_2 cipher=AES128-SHA bits=128/128);
 Wed, 05 Dec 2018 05:21:02 -0800 (PST)
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH] serial: uartps: Fix error path when alloc failed
Date: Wed,  5 Dec 2018 14:21:01 +0100
Message-Id: <97107b23d9b3cca32c4fba3b474fe55ea4d338f4.1544016059.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_052114_790412_AA35296D 
X-CRM114-Status: GOOD (  12.33  )
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

When cdns_uart_console allocation failed there is a need to also clear
ID from ID list.

Fixes: ae1cca3fa347 ("serial: uartps: Change uart ID port allocation")
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 9cdc36be5b13..c6d38617d622 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1508,8 +1508,10 @@ static int cdns_uart_probe(struct platform_device *pdev)
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 	cdns_uart_console = devm_kzalloc(&pdev->dev, sizeof(*cdns_uart_console),
 					 GFP_KERNEL);
-	if (!cdns_uart_console)
-		return -ENOMEM;
+	if (!cdns_uart_console) {
+		rc = -ENOMEM;
+		goto err_out_id;
+	}
 
 	strncpy(cdns_uart_console->name, CDNS_UART_TTY_NAME,
 		sizeof(cdns_uart_console->name));
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
