Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5472C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:21:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 745B12082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NhrmFlep";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="SzNKA71C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 745B12082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=MQBgK33AXHkzgrHYNmnwudIrzrcw8AHUdfWTbpZBIzQ=; b=Nhr
	mFlepg/0W63C6IJczqpoDEVFBEcy75ciJvccnz6lWa0RaQ5WjdnnHcrieRHD9sZwJytSjomT7QQED
	gQ+zzuASUxAmxcICfvTMnl04e+meLrN9jcicELwMKQNvqjPmtICBzS5QsZ2pGgd5fSX1FZMOo3Fpe
	TVWpvGJTP/Mfmkevcom6QfoI6R2LJ4Fh3BGE/DKkqecAyRmtUaedPg4Wxo2LurSPXOgLM6MCUKWRX
	vkiIojuQ9XW6kwPsQsOklyNoupozYiVIM3ZrmZAUI6an6winmh8BbJY0rMMGOtoE/f47ODtCgEFFd
	B0zu+MPcSUeG5dS+0wo9itSdJAX7wkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUX7a-0004Eg-Ay; Wed, 05 Dec 2018 13:21:46 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUX7W-0004AL-55
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 13:21:44 +0000
Received: by mail-wr1-x443.google.com with SMTP id v13so19649666wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 05:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20150623.gappssmtp.com; s=20150623;
 h=sender:from:to:cc:subject:date:message-id;
 bh=CVYMWDdvwiBrckwCj37kDX9H+rrFevEUnxol0pzn1YQ=;
 b=SzNKA71C3qJ31LdOzTeH3ymqsrEHQ+7+ORRv6ddbziFhWV/B8RqUhRnsEIKmZYTqdY
 N+yog3NLee5Uv9t2hwzeqjfd1pKhTtzWQ/B3VYPNpG74+Ck4RL+Q6nqcvfD7Ci3Pp+j2
 06musafsN6VEKtfRDcF4ZAoe1izY/2fQx5XV8bJmxo90EGkDAxuPHUvlL77SjDNw4R8r
 c7GFKNtvcLy7DJAOikFU5fa+vkuyQeIx40NmRm3+/+vkjDP8nweWG+O5ixkmDZv6hMu1
 SmUEBCjZlv2Ug25tP7b+1djZ462v+wifmwdFsJ8XHfufTxAzM82TuNkeuUbTqG6ANxen
 b/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=CVYMWDdvwiBrckwCj37kDX9H+rrFevEUnxol0pzn1YQ=;
 b=Xas8PWI6nIEt3tHwFOVojDvGpRXdwdLWSIUqfScJdPtaUsZXGAFc9Q0XWU52J2LWkt
 V4AQwMttlHK5pbWeLI5l+Ry0cqVcbh7qIzcC74l6lgJ9GG9hjNkqTlqnetUX8kmsbvOC
 wOuj78iRgnCbly1bFsx5ejSgx6SfTdvW3fktdPuGG9A+a4dpEV0rcdhVLbEpxYnfemZN
 y/yrHuz0jMIHfpp2v8SyVYY14jENFUSXHls+vgcGFI89pYygbeNDPB6385f+qmhnrEli
 2OMKS+KQDFIiusDHCS0NxTQtH/Vsof+W8PrmULlepmWWDdugEAlHPKllYb3C5vJ5WypK
 G/dg==
X-Gm-Message-State: AA+aEWaPM4wSN5sqVT1w8TPDMEsdXlyLRjvgctsKxdX8o4+SAp+jPcJX
 l9XXIfab59qFKNS8Znqw8J23Qg==
X-Google-Smtp-Source: AFSGD/V4gOGFUVKyexB+Ioo7sM/kwGX7RTm3O2ylcZXXtaaXfS3yjRtdMFV5xzD0pplFWmQLdsHwqQ==
X-Received: by 2002:adf:90e5:: with SMTP id i92mr20554177wri.210.1544016090395; 
 Wed, 05 Dec 2018 05:21:30 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id 6-v6sm13406730wmd.45.2018.12.05.05.21.29
 (version=TLS1_2 cipher=AES128-SHA bits=128/128);
 Wed, 05 Dec 2018 05:21:29 -0800 (PST)
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH] serial: uartps: Fix interrupt mask issue to handle the RX
 interrupts properly
Date: Wed,  5 Dec 2018 14:21:28 +0100
Message-Id: <903d6b4f614a395d063f95bfc4658a6944526958.1544016085.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_052142_197532_05ABA365 
X-CRM114-Status: GOOD (  11.85  )
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
Cc: Nava kishore Manne <nava.manne@xilinx.com>,
 linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Nava kishore Manne <nava.manne@xilinx.com>

This patch Correct the RX interrupt mask value to handle the
RX interrupts properly.

Fixes: c8dbdc842d30 ("serial: xuartps: Rewrite the interrupt handling logic")
Signed-off-by: Nava kishore Manne <navam@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index c6d38617d622..094f2958cb2b 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -123,7 +123,7 @@
 #define CDNS_UART_IXR_RXTRIG	0x00000001 /* RX FIFO trigger interrupt */
 #define CDNS_UART_IXR_RXFULL	0x00000004 /* RX FIFO full interrupt. */
 #define CDNS_UART_IXR_RXEMPTY	0x00000002 /* RX FIFO empty interrupt. */
-#define CDNS_UART_IXR_MASK	0x00001FFF /* Valid bit mask */
+#define CDNS_UART_IXR_RXMASK	0x000021e7 /* Valid RX bit mask */
 
 	/*
 	 * Do not enable parity error interrupt for the following
@@ -364,7 +364,7 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
 		cdns_uart_handle_tx(dev_id);
 		isrstatus &= ~CDNS_UART_IXR_TXEMPTY;
 	}
-	if (isrstatus & CDNS_UART_IXR_MASK)
+	if (isrstatus & CDNS_UART_IXR_RXMASK)
 		cdns_uart_handle_rx(dev_id, isrstatus);
 
 	spin_unlock(&port->lock);
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
