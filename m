Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBB9C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:09:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C835218AE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H+PKYghK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=bitwise.fi header.i=@bitwise.fi header.b="ZRYkaWiv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C835218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=bitwise.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=GynzYn/eEvBFJSBDzuyp+wgLEBb3XW54Ybm6KnpS4Fk=; b=H+P
	KYghKAXH8w/LJA5mfRiUevLIsD3GeqTR4V8v+SwJq+TDky36Vg9JoQa2NFltRrAKQaLqovIHs5skC
	j/UeMnlgdnIMaAy/st4Nf13BGR8o9odUb6RMh++E2tDSGU+BuDFda6Q3X4DkVu12ZVn2FwVWnv1v7
	lNNE+dz5ZUX43Yb540s9EmZSRUPkvPrJpJX6WVXM63gEHrsMaku3tJE3KwBPocDFKlBXWgu+8CBxp
	NooaX+Z0g+2pYZqGB9XWDHDS5s6Ab+CY/nVxVrKem83LPN4teob+jHursPdFv7EaJzl/2v0yMqJ81
	rdWMNtJ3weZdnfLzOx2WEUdSqNwm05Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grNtS-0002R8-V4; Wed, 06 Feb 2019 14:09:38 +0000
Received: from mail.bitwise.fi ([109.204.228.163])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grNtO-0002NB-I3
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 14:09:37 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.bitwise.fi (Postfix) with ESMTP id AE47960992;
 Wed,  6 Feb 2019 16:09:28 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at mail.bitwise.fi
Received: from mail.bitwise.fi ([127.0.0.1])
 by localhost (mail.bitwise.fi [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dyIMq20jm7GS; Wed,  6 Feb 2019 16:09:26 +0200 (EET)
Received: from localhost.sec.bitwise.fi (fw1.dmz.bitwise.fi [192.168.69.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested) (Authenticated sender: anssiha)
 by mail.bitwise.fi (Postfix) with ESMTPSA id 9BF22606FF;
 Wed,  6 Feb 2019 16:09:26 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bitwise.fi; s=mail;
 t=1549462166; bh=pKrsoAsQnqlnzVhUDv/5WDWnzmS+/gusyR3tSVbVZcg=;
 h=From:To:Cc:Subject:Date:From;
 b=ZRYkaWivdb65hfFmT9a3OYEHPS0FWSa/1UfZ341B41Y1DPFWvzKccFk9BCgXS+nFs
 7gfNZdwTdpE/xhqtJn/Oaz+vt01DVUGLI0xeEbU60Yez9PlY4eER9Jvmn9evG9XDHY
 3voUqZvhA4UmkCie/vdnTq6dZZzSwYU/4g4lZa0Y=
From: Anssi Hannula <anssi.hannula@bitwise.fi>
To: Michal Simek <michal.simek@xilinx.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] serial: uartps: Fix stuck ISR if RX disabled with non-empty
 FIFO
Date: Wed,  6 Feb 2019 16:08:13 +0200
Message-Id: <20190206140813.15349-1-anssi.hannula@bitwise.fi>
X-Mailer: git-send-email 2.17.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_060934_937421_9427FD19 
X-CRM114-Status: GOOD (  10.23  )
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
Cc: stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

If RX is disabled while there are still unprocessed bytes in RX FIFO,
cdns_uart_handle_rx() called from interrupt handler will get stuck in
the receive loop as read bytes will not get removed from the RX FIFO
and CDNS_UART_SR_RXEMPTY bit will never get set.

Avoid the stuck handler by checking first if RX is disabled. port->lock
protects against race with RX-disabling functions.

This HW behavior was mentioned by Nathan Rossi in 43e98facc4a3 ("tty:
xuartps: Fix RX hang, and TX corruption in termios call") which fixed a
similar issue in cdns_uart_set_termios().
The behavior can also be easily verified by e.g. setting
CDNS_UART_CR_RX_DIS at the beginning of cdns_uart_handle_rx() - the
following loop will then get stuck.

Resetting the FIFO using RXRST would not set RXEMPTY either so simply
issuing a reset after RX-disable would not work.

I observe this frequently on a ZynqMP board during heavy RX load at 1M
baudrate when the reader process exits and thus RX gets disabled.

Fixes: 61ec9016988f ("tty/serial: add support for Xilinx PS UART")
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Cc: stable@vger.kernel.org
---
 drivers/tty/serial/xilinx_uartps.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 094f2958cb2b..f0c4f59d9314 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -219,6 +219,13 @@ static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
 
 	is_rxbs_support = cdns_uart->quirks & CDNS_UART_RXBS_SUPPORT;
 
+	/*
+	 * RXEMPTY will never be set if RX is disabled as read bytes
+	 * will not be removed from the FIFO
+	 */
+	if (readl(port->membase + CDNS_UART_CR) & CDNS_UART_CR_RX_DIS)
+		return;
+
 	while ((readl(port->membase + CDNS_UART_SR) &
 		CDNS_UART_SR_RXEMPTY) != CDNS_UART_SR_RXEMPTY) {
 		if (is_rxbs_support)
-- 
2.17.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
