Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3C4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:46:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBEAE21B18
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nK/q6hyB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=bitwise.fi header.i=@bitwise.fi header.b="Ro4OLpK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBEAE21B18
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=bitwise.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=DruwTkPD2aqnhXdFcPBmj9xoVWPMSuQT1lJRZvTFRoM=; b=nK/q6hyB1kQ1XtplmhvCPqHVzw
	bt3HNd2vWVAjxfTZKPeXtffvB3PGXcyGHBPiT5OsD+tdB0PoS0Z7h4ah/vofD5O3VYW/xvM3LaUvq
	QMeQxenTH550eSu/B6n+wwj+HNX7/I9V2TyU+9VoxtcGJs8nYwpLd6qQA51HNn3IrpqM0QJuDjWd8
	6Du9FyrE/hIFIxcp2uqTfVDWiaSS9yZytU1JXdkBhlTml613UHxwPnEKnJrDV4jwdGfj1zEc+Fd8z
	wEnqSGREh8RgJkTnbQmFkz+UoqbNv2L605+EqjJRtlWL6msXrKVAd2kCSZpnCCGHDxxxn/XvfNxjV
	dKemNfiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugct-00044P-S3; Fri, 15 Feb 2019 16:46:11 +0000
Received: from mail.bitwise.fi ([109.204.228.163])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugco-00042D-VZ
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 16:46:09 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.bitwise.fi (Postfix) with ESMTP id 3257860088;
 Fri, 15 Feb 2019 18:46:03 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at mail.bitwise.fi
Received: from mail.bitwise.fi ([127.0.0.1])
 by localhost (mail.bitwise.fi [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r8vUauP-50Zo; Fri, 15 Feb 2019 18:46:01 +0200 (EET)
Received: from localhost.sec.bitwise.fi (fw1.dmz.bitwise.fi [192.168.69.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested) (Authenticated sender: anssiha)
 by mail.bitwise.fi (Postfix) with ESMTPSA id 03CC560047;
 Fri, 15 Feb 2019 18:46:01 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bitwise.fi; s=mail;
 t=1550249161; bh=uVbbuhxyaEUkCF1dG1rkaTTB4f4/frsQ2s4asHqK3pI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ro4OLpK4x+YgDhSP9dT37AXk1OOb1ZmhHmBlsUUDfWkOEdAo7Cd9rV5GDIAOzT/Q/
 byyubDqa3H0mDYTk/igbfG6O7CcMZqb0bsLQAut/mZ9dKvRF0yn16KnKrDbZYCknAd
 wy1TpyCBK+Fk3uVVpPazttRrHxgbCiv3hHBYNtJo=
From: Anssi Hannula <anssi.hannula@bitwise.fi>
To: Michal Simek <michal.simek@xilinx.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Shubhrajyoti Datta <shubhraj@xilinx.com>
Subject: [PATCH v2] serial: uartps: Fix stuck ISR if RX disabled with
 non-empty FIFO
Date: Fri, 15 Feb 2019 18:45:08 +0200
Message-Id: <20190215164508.27237-1-anssi.hannula@bitwise.fi>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <BL0PR02MB491508D8FDFECD3211BF1943AA670@BL0PR02MB4915.namprd02.prod.outlook.com>
References: <BL0PR02MB491508D8FDFECD3211BF1943AA670@BL0PR02MB4915.namprd02.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_084607_524781_BFB46D85 
X-CRM114-Status: GOOD (  13.34  )
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

Shubhrajyoti Datta wrote:
> Minor nit below.
> The call to the cdns_uart_handle_rx could be prevented in  cdns_uart_isr 

OK, changed, thanks.

Personally I liked it slightly better in handle_rx() closer to the
problematic loop (and RX being disabled here should be rare), but I'm
fine with either.

v2: Moved check from cdns_uart_handle_rx() to caller.

 drivers/tty/serial/xilinx_uartps.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 094f2958cb2b..ee9f18c52d29 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -364,7 +364,13 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
 		cdns_uart_handle_tx(dev_id);
 		isrstatus &= ~CDNS_UART_IXR_TXEMPTY;
 	}
-	if (isrstatus & CDNS_UART_IXR_RXMASK)
+
+	/*
+	 * Skip RX processing if RX is disabled as RXEMPTY will never be set
+	 * as read bytes will not be removed from the FIFO.
+	 */
+	if (isrstatus & CDNS_UART_IXR_RXMASK &&
+	    !(readl(port->membase + CDNS_UART_CR) & CDNS_UART_CR_RX_DIS))
 		cdns_uart_handle_rx(dev_id, isrstatus);
 
 	spin_unlock(&port->lock);
-- 
2.17.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
