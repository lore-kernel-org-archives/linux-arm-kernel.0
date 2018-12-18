Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496D9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:19:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A861F2080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dUYNAuLh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="EqZdGbpN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A861F2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=VHoVgvuFahZiF/Bl/HsBs4A+vmjs64ZHx5wqYeH3N/c=; b=dUYNAuLhojyk+bns9UkeQYP4kV
	ifUlwaIu/jxWRvN4A6rQoyS1jgasMY8GOn85hdE8qp3M67IPJgFwnguV0+50QrXijjTU4UCiVh/Qj
	IFDZksbvpeezURZ7bcFB5rsl7ZO6BJPZhCAYY+dlXx6tTWxY2FJR9vh8GyIipyzbvtnaFvEKHTIyU
	g+n/g7kK+jJTU1hHztVGMnCZyJNbqMpZXMErUpMEgWCwp2fnQMU1CexQBh2ZSDTgQktQEmoWCBcMu
	33Grwfel/ex4LxYe5saA/RaYRNRSFTjErEOogCJ8JlrQNDfBv5uQq48e90LIw4PbbXB7RiawHpUK1
	iFZSN14A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZELQ-0005T0-6I; Tue, 18 Dec 2018 12:19:28 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZEL0-00053W-2V
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 12:19:03 +0000
Received: by mail-wr1-x441.google.com with SMTP id t27so15691606wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 04:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20150623.gappssmtp.com; s=20150623;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :in-reply-to:references;
 bh=sr4wuOWXsEDaIHmkdgp5/mtEUfBN4wQ+UuMd8Oge7B4=;
 b=EqZdGbpNUKx1T/vwDwk3desDmKTHP2e28GVlgVSY4w3rfP2d5HecQH+DYwRsvXSaa4
 gR3blQRULTvGOsOh6gKGHfmTg10TZ2iJpOTYymZuNyU3Q47iWOPKubvcx9voiVtyOyTe
 8fyRpPsXBLXgVSFN0TKLiDPcqVegcxdYuYGv6tpxv/FiZzf2KGFEvWZ2cSsP1p/8xnOU
 BIDRdKUHtHP0ZCBFo6lQD2QUtMItAHlTSUmdEj1IyduV543TfP9st1nvXRTzA5ZIvSuq
 qrH88bYKpzBKS1dtK06lfFpALG2rdomM96qTIROEwSgVw9NxVW+QxbKC7UupZW/hW4iK
 31Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:in-reply-to:references;
 bh=sr4wuOWXsEDaIHmkdgp5/mtEUfBN4wQ+UuMd8Oge7B4=;
 b=B8vJi90lttggk5Hxh3qsnuGskmzwfhteWxqFdsc9jcaN+dJ3wVgEQrohbmWKKfRaLN
 4H9Fssr+C+KIYfJ7oHW6qn/Lu1Q3PnWpScWHiU9jYMkQLR4Q4UbT4PFZ8S/dCpfp+K1U
 zdn9doSbb7zUxSNMJrz4v5HDmIC9QIHI/lBl8kw/zwkrxqri1+fZiD+rIMNoP7+MvM8l
 a6WW0G9EVTzM0nkD6cuBpd09t97/6G8w+MVW+mgyij7A/9uStiw77I2G3kibonbUABRm
 MUvf5826g2E61Qh/fx8n8UtBr6mA8+N61u1aoxEeN+kaxrV9c9MVL9rziipKIewkVNO1
 lzmQ==
X-Gm-Message-State: AA+aEWathNsBzC7g2d9oXaPcY1ZJT7o1Th53eLKVHMhJj0xCfd6cFvek
 +OFuDNW125kLyxsfOp8AUkc4qA==
X-Google-Smtp-Source: AFSGD/UCRtnbBFtHMIKnjndA6yC3das3xoHh1I4qGT2mMOH0yKDXmZ05nsOBOlnUZEpEiyBRSTBQXA==
X-Received: by 2002:a5d:480d:: with SMTP id l13mr15450222wrq.175.1545135530534; 
 Tue, 18 Dec 2018 04:18:50 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id m6sm2594800wrv.24.2018.12.18.04.18.49
 (version=TLS1_2 cipher=AES128-SHA bits=128/128);
 Tue, 18 Dec 2018 04:18:49 -0800 (PST)
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v2 2/4] serial: uartps: Check if the device is a console
Date: Tue, 18 Dec 2018 13:18:40 +0100
Message-Id: <863488c6f6d7f3d8c53d46f442f25ec2f46ee651.1545135519.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1545135519.git.michal.simek@xilinx.com>
References: <cover.1545135519.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1545135519.git.michal.simek@xilinx.com>
References: <cover.1545135519.git.michal.simek@xilinx.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_041902_113661_353B437A 
X-CRM114-Status: GOOD (  12.84  )
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

While checking for console_suspend_enabled also check if the
device is a console.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 drivers/tty/serial/xilinx_uartps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 0140644391df..9cdc36be5b13 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1255,7 +1255,7 @@ static int cdns_uart_suspend(struct device *device)
 
 	may_wake = device_may_wakeup(device);
 
-	if (console_suspend_enabled && may_wake) {
+	if (console_suspend_enabled && uart_console(port) && may_wake) {
 		unsigned long flags = 0;
 
 		spin_lock_irqsave(&port->lock, flags);
@@ -1293,7 +1293,7 @@ static int cdns_uart_resume(struct device *device)
 
 	may_wake = device_may_wakeup(device);
 
-	if (console_suspend_enabled && !may_wake) {
+	if (console_suspend_enabled && uart_console(port) && !may_wake) {
 		clk_enable(cdns_uart->pclk);
 		clk_enable(cdns_uart->uartclk);
 
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
