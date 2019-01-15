Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8159C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:18:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 885DC20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k91475sP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885DC20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=u5MOXMmY8O52kyJK/kyakKw4DCn1tTS95v10WEBDBKQ=; b=k91475sPI1en1c
	sRNesuTIntbVr9QsHm4Vd5cGXiQnukwTFZPU4VaUiJ7k859Cg83Gkr1YxZRZ2u3wfiIHgM8GMRSks
	HnQ1NbwhnvDXku1gsP6SfwHJrfM9b+WCe81jVXxvsBaru+za2cPetj2Ik6AZKAS+mYsn8coXJdzqS
	jHbtrRwOB7nBDr5TgBz6iYdI9DaI1XydbS75DIKXiLrn8228aPfBANeokQYfZdvHnF3ZYnjOcfuEO
	cByNh3OwtbD7W4wG/9Y7Pez/dxqpBIMZpnBq+91RCMoQHktH3mlklozLfICBgA/XdNG8NWTByP9xk
	o6VHSE1clRhzWAKQJVqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjSMD-000729-8h; Tue, 15 Jan 2019 17:18:33 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjSMA-00071a-0x
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 17:18:31 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id D104F20750; Tue, 15 Jan 2019 18:18:27 +0100 (CET)
Received: from localhost (alyon-652-1-22-18.w109-213.abo.wanadoo.fr
 [109.213.145.18])
 by mail.bootlin.com (Postfix) with ESMTPSA id 951AA206A6;
 Tue, 15 Jan 2019 18:18:17 +0100 (CET)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH] tty: serial: lpc32xx_hs: fix missing console boot messages
Date: Tue, 15 Jan 2019 18:18:14 +0100
Message-Id: <20190115171814.21789-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_091830_196851_3CE90A6B 
X-CRM114-Status: UNSURE (   9.10  )
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
Cc: Roland Stigge <stigge@antcom.de>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Sylvain Lemieux <slemieux.tyco@gmail.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When probing the HSUART, it is put in loopback mode in order to prevent a
potential issue that may happen on RX (Errata HSUART.1).

serial_lpc32xx_startup() moves it out of loopback mode but this is too late
to get the kernel boot messages before userspace opens the device.

Also get out of loopback mode in lpc32xx_hsuart_console_setup().

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/tty/serial/lpc32xx_hs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index d1d73261575b..f4e27d0ad947 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -151,6 +151,8 @@ static void lpc32xx_hsuart_console_write(struct console *co, const char *s,
 	local_irq_restore(flags);
 }
 
+static void lpc32xx_loopback_set(resource_size_t mapbase, int state);
+
 static int __init lpc32xx_hsuart_console_setup(struct console *co,
 					       char *options)
 {
@@ -170,6 +172,8 @@ static int __init lpc32xx_hsuart_console_setup(struct console *co,
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 
+	lpc32xx_loopback_set(port->mapbase, 0); /* get out of loopback mode */
+
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
