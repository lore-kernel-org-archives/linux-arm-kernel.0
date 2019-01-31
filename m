Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85959C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:07:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BA1D218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q5jYNA1e";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaVku2eO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA1D218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=RDPVEnQHyzNoSe1p8vKBf6bFrSBoxFGY56wqAT5qKCw=; b=q5jYNA1echRGj8
	dlCJ3ZS2xZiebS3VXsw+B19fn7zEZsJ3qIZZEjXoePjWuJUZ0PZ5mPEosVYJw1viKNLzA8TAP8KBs
	OCUxC587RcifNR9CrjFV54eb73ZVbO2aZAx+T0yLXYD/By5dI2SuePOmcEoiRoHyf9P08piQymNHT
	hYxaZP8bNO9WLzXElp5/nJ1B922Sws+9EUFmocxofDGKCWAOnFs4Kc1xXxlVkVbqbhtNJzRDTdw2d
	WhKLQxvRisWoZ5RE461pwYqM4WXCdHe6OPj4gQGXfO+R2PbkRm1UQ8sqV097D+wVK/E1efJ9CLcmx
	0nTnSk0fQWWFA7y9Tgew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpGjr-00045p-S9; Thu, 31 Jan 2019 18:06:59 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpGjo-00045O-5O
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 18:06:57 +0000
Received: by mail-ed1-x544.google.com with SMTP id g22so3338499edr.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 10:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Spvj1aXjtPpiHKV6tIt1Dff7PW1cp6KBnnoKkHYDIwo=;
 b=kaVku2eOA5PY99iDda5fa6jQcUgVZVErdLGHjsUrhm7dfj/uD2PlvQNh2qgZwD1qsX
 xLoM2IxZp0UpHDFs8hRSVYRdc2ZLnXKa28ZVTaSCQZgOum+HWmRarE2v8p2oWDklOnC0
 x8bnXg0XO09BBcPn8HuBYBnuWES7mqgZGKNZ3zQ7rVYuiE+JU7R2neSYa1U+yjvITQok
 6Ql9VfWrox6aRlKfonQHzuGWRrjxZfep1sVl7dN/0bVfRHMQbadQpSinPMeZDSjm4ECj
 0v/KVV8V95U4608BsUgi577OSncF8Vn4mpPvBsaXbhwL9BeDCxbwOHM3e+Pe+2sG9mxE
 pdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Spvj1aXjtPpiHKV6tIt1Dff7PW1cp6KBnnoKkHYDIwo=;
 b=i2Pa2ZD5Yz6/O/wRZiNdIMYt988EIHx3gHw/aJw6dGuW8WTdypRyZW/wz/8vNToSNY
 4BHXf3OrmI/QQeAG9ShOGpjRefaEPv/j53Qd1raWMdwOLFk6j0B6QwUOT0+td0OnmjAM
 jFpAxagPd3ddxdPeZrv6C7JPf4Vk29LujAScuR+4YqCamSlUZeGRPInXZYbfCN9TaXfF
 /FRHaibmui+uPA7GIvkdKbU/CRnhiAmbQoIDA9j1L7CvoCle4ICbW0hfWaKD+Na2nCyP
 yh/uoz1emfCgS5IfyeeLP/3p7eMJeKz2diJJLHLvBhkjn9BsneJCxmCDcW1MsK67TMXl
 TYvg==
X-Gm-Message-State: AJcUukc8uj5C/NvTRvKcp8iA/Ix7Ooew0OJ9pWRi0IdsuV32u2QRrf5R
 /QB50Sh4zP8WAoCKSdZyqx4MIsrb
X-Google-Smtp-Source: ALg8bN6I044GGdctYhw7YLNI+sj6rT1xzCGad80eNZdVzssn4k/JWMMAsThg0pC4VzDabf3nextjgQ==
X-Received: by 2002:aa7:c248:: with SMTP id y8mr34675650edo.205.1548958013470; 
 Thu, 31 Jan 2019 10:06:53 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
 by smtp.gmail.com with ESMTPSA id e51sm1476890edd.35.2019.01.31.10.06.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 10:06:52 -0800 (PST)
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vladimir Murzin <vladimir.murzin@arm.com>
Subject: [PATCH] serial: mps2-uart: Add parentheses around conditional in
 mps2_uart_shutdown
Date: Thu, 31 Jan 2019 11:06:28 -0700
Message-Id: <20190131180627.19944-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_100656_210181_664C1C47 
X-CRM114-Status: GOOD (  13.33  )
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Nick Desaulniers <ndesaulniers@google.com>, Jiri Slaby <jslaby@suse.com>,
 Liviu Dudau <liviu.dudau@arm.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Clang warns:

drivers/tty/serial/mps2-uart.c:351:6: warning: logical not is only
applied to the left hand side of this bitwise operator
[-Wlogical-not-parentheses]
        if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
            ^                ~
drivers/tty/serial/mps2-uart.c:351:6: note: add parentheses after the
'!' to evaluate the bitwise operator first
        if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
            ^
             (                                       )
drivers/tty/serial/mps2-uart.c:351:6: note: add parentheses around left
hand side expression to silence this warning
        if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
            ^
            (               )
1 warning generated.

As it was intended for this check to be the inverse of the one at the
bottom of mps2_init_port, add parentheses around the whole conditional.

Fixes: 775ea4ea2fd9 ("serial: mps2-uart: support combined irq")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/tty/serial/mps2-uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
index 4404eb7d118f..587b42f754cb 100644
--- a/drivers/tty/serial/mps2-uart.c
+++ b/drivers/tty/serial/mps2-uart.c
@@ -348,7 +348,7 @@ static void mps2_uart_shutdown(struct uart_port *port)
 
 	mps2_uart_write8(port, control, UARTn_CTRL);
 
-	if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
+	if (!(mps_port->flags & UART_PORT_COMBINED_IRQ)) {
 		free_irq(mps_port->rx_irq, mps_port);
 		free_irq(mps_port->tx_irq, mps_port);
 	}
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
