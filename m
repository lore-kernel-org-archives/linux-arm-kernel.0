Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EB6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:19:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB7F82080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="glI+OEUH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="GNS6SfUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7F82080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=HDB8MZRGFai8Nh2cr1ZXbd3y7RVwWZX2OR1fzzLR5oM=; b=glI+OEUHUvi1OqsrkMX6dJcqhT
	7MKycspvcSO4o7GB/Qg0b5P0qULi9JBHXoOksgsuuqMGFLYEgxtf0Ddy2cemncIa3i438gEOLICNs
	q8gMb2S2FbZmlh6+LSW4fH8XIC6VAT/k2SiCKEY8Bsfcx82lo6goaiU2lTiWyhrOu2w4xRlZXe4Fq
	/EJPGWhXKljumrroTjHAwEm+UZGfvzcLa16eKhAzdzmrqbEQCXrkEXIujlWZm5saVYjaKqeP6TtbP
	JAAoqe4T4i0nLwpPg3YNDfaSQ9Ng7GaHY8kNKdzcYrhjtpq6VdrpTA9wHOb2sAvReO6kojGXhC4Zd
	KoLF9UAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZELY-0005dw-6Z; Tue, 18 Dec 2018 12:19:36 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZEL0-00053u-2X
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 12:19:03 +0000
Received: by mail-wr1-x441.google.com with SMTP id q18so15670153wrx.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 04:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20150623.gappssmtp.com; s=20150623;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :in-reply-to:references;
 bh=gJ27nswbrpfxVG6qA2cxraDTu06pZ4WKxOLJS8Arquc=;
 b=GNS6SfUpxj34SU85j/K3BuxG0Zrs4chu/XCYqcWqcJyjFrMfSRSyYkfJBlmDXrIxce
 d59pyoiI4dIhRsI/aP0UGwBDu/N6ylueeIVmFMjox1+N3Sg1vXvBtKVT87orSTQM9lyL
 O1jKMyXDsRj1De5lnPreLB7QY9XBDClvjzvtBO4cgpRSzISEF5VsESjSlNr8qyPDOAGk
 FUVezzvflH6RoqwskrHshyXNFNe67kSJCIDkJosVYG/t2STFcZQYnieKzrrfbfKB/OlH
 2WRqrPJL59ICy9FmTnOWsmbH4TxrB0iUb4xI+xR+ZyENkz9eTfwhg9oKG4YB2I2tnlow
 6dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:in-reply-to:references;
 bh=gJ27nswbrpfxVG6qA2cxraDTu06pZ4WKxOLJS8Arquc=;
 b=ZiPoUS8CEhJq1rKr/qx/+lWkpC6ZXMFd5qS7ZqEeiX/5NdZMFEKdyZmlhgZIFyaiNW
 yOS8MwUoq/wsQ/BucijhP1IjUiE6BoUvvTzDabJOlOrQfzlzM51paIirwTR4Wf4dFMe6
 /mPAYonflX56M1Xkc2QzHS2+Y4AJmnJxh1gwpsaqrSQWGiuyXj/Cc/4NlyYOyV33oBV9
 SfnVK3GEcltgewH74qRUeRuLohqBOtyWLI3lFX/lX0JCsgRmBAvUo4HDC+NrSdRH6/fo
 rFMsGibJpbHgw7J3PNwir4/QJRBuGQ2TaWpZP4ZKbMq9LMQK/2uzZtIDtpfnicMUA7u2
 D9lA==
X-Gm-Message-State: AA+aEWYotR+xQWVLNltO4SnTzs8NQJb/SsLM6TXEoePJpELq4suPOD1R
 t97DcGxIul4OufVPpeKuU7wSrA==
X-Google-Smtp-Source: AFSGD/U+GdXHuT8ZzbO+PKI2ZZsyetLAgHnmfgmja5FkS8PJGNY/BwJgfkHs0I0m7mECgrCOalo2Cw==
X-Received: by 2002:adf:f28d:: with SMTP id k13mr15173271wro.78.1545135533622; 
 Tue, 18 Dec 2018 04:18:53 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id w80sm2290393wme.38.2018.12.18.04.18.52
 (version=TLS1_2 cipher=AES128-SHA bits=128/128);
 Tue, 18 Dec 2018 04:18:52 -0800 (PST)
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v2 4/4] serial: uartps: Fix interrupt mask issue to handle the
 RX interrupts properly
Date: Tue, 18 Dec 2018 13:18:42 +0100
Message-Id: <b0ec59d6fb0837c316e2365b2361576d0c8a82fd.1545135519.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1545135519.git.michal.simek@xilinx.com>
References: <cover.1545135519.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1545135519.git.michal.simek@xilinx.com>
References: <cover.1545135519.git.michal.simek@xilinx.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_041902_114299_CF3E8972 
X-CRM114-Status: GOOD (  12.85  )
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
Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Fix Nava's email address to align with patch email address

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
