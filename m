Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F80C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:54:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76B4B2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W2ZnR8k4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Jb0DCkdW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B4B2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=siFyKGilVoWO1Vd3kmTMaIhOSXoXyWnY9SWYyVXuGMc=; b=W2Z
	nR8k4ZIIctXPiox9R8WFb5hJ7lcRzaHZBzbnMxvzeEbjS6ap8WoUdsqm7f7OHe3TShxKoRwZd/1LS
	BHSMpDtPiRPZckq3gkXY/yRcs3uNobMJbEklWkA63idbyjKJ7kYTkFxCVQz2xKJXYRwBFqxZds0S7
	tnQZfbkv92tVl694ESH5RmYnCejwDQIrDHHKI5aNQCmBLyRroJ2J3uoM7R8/hLA12c3rcWCSPOs60
	e2UZrzVrz6BKpzHb9gpcT19taErQEpdoHXWdx99/gjH202bKUJ2sEu5/WZe7lFVmbKUjvbpiBnhwW
	J8kDIEP9xBS3/cviJslQ/sQudPGdxNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj5VW-0003xp-4p; Mon, 14 Jan 2019 16:54:38 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj5VR-0003vj-4V
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 16:54:35 +0000
Received: by mail-wm1-x344.google.com with SMTP id t200so285630wmt.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 08:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=YDlLAbjE1Bp+CpbdaiFh8za0XJ4VNrbI5R9WvhyxgIc=;
 b=Jb0DCkdWMu/er0vZsOggLA4HFLbM5pLR7C/JpUHBMaAHDnp8+TWTR/1n1/LMIaoCAK
 H+ale06NO9L6hXvsm1RNGK15egin4S6VCrgq4d8ExkZ0X/8SYJeqf4tiqihd6b5bGvzi
 oI/VVDIc5UYae5tGSxjpaeU6b6rUoYSWbdOqvedXbaHfnlELFOTEgfKq90zqV+5JhNoH
 lCUBS2b1nxjogAQl3uITl311zKHFFyLUq7Njwr/46b3OfYJYGDZgM6dwOL8LLbFDSJhR
 JTDM+wsehpsFprsu8oN+yoGltYjS5VrkY8JF5DJ17sfARoUIl9bB/BXpX0kXXwxtL5CH
 UQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=YDlLAbjE1Bp+CpbdaiFh8za0XJ4VNrbI5R9WvhyxgIc=;
 b=KrOSTVMijPN5pEAyf1Z2mGTisR3ow3wdaR0GXFnHSKCaKKh+9IqQeSfR4bEoIoNLGO
 2iu0LnpNVeyT8V9Xcp4iN0H7OBPc6L/MhxfoBUNx+PSqBDAzeUwNtW9sTuwPqYR2A9L6
 U/gcznb+tBEknpBeh4+HRwc0o+OeQRke9AAa9n4O4igGxKVsnnKXXzYFqbUzHfc0L7te
 Mgy4Oj8XTFAO8ACq7AREhSszttfqmtkD5p/rY288bPBpLqjGR3jGlobwUzo/SPJEwtYY
 t5m3xu9yrEoEHDCY+/OS5qJFQXS6N/f1f4LLFzoWRNRMgGp195pL6O4BFeCEoTh0JpRY
 AKBg==
X-Gm-Message-State: AJcUukct6legClqZM2zu9MkcnfUNq6ybjpX0nmC3Uf6xGN1E+JiROXEu
 GthfW4zMmYHBNVnmgVbTwiaWIA==
X-Google-Smtp-Source: ALg8bN5WKaMg8ZtcDbbOc8T92Few5xuQokHuFX92gPx15BV3tslpwz15VAQZEBvZV00HsiYBUfh9jA==
X-Received: by 2002:a1c:ba89:: with SMTP id k131mr27141wmf.85.1547484871518;
 Mon, 14 Jan 2019 08:54:31 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.googlemail.com with ESMTPSA id b18sm70411000wrw.83.2019.01.14.08.54.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 14 Jan 2019 08:54:30 -0800 (PST)
From: Loys Ollivier <lollivier@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH] tty: serial: meson: if no alias specified use an available id
Date: Mon, 14 Jan 2019 17:54:26 +0100
Message-Id: <1547484866-3600-1-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_085433_179145_6DF8970C 
X-CRM114-Status: GOOD (  15.21  )
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
Cc: linux-amlogic@lists.infradead.org, Loys Ollivier <lollivier@baylibre.com>,
 linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

At probe, the uart driver tries to get an id from a device tree alias.
When no alias was specified, the driver would return an error and probing
would fail.

Providing an alias for registering a serial device should not be mandatory.
If the device tree does not specify an alias, provide an id from a reserved
range so that the probing can continue.

Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
---
 drivers/tty/serial/meson_uart.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 8a842591b37c..fbc5bc022a39 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -72,7 +72,8 @@
 #define AML_UART_BAUD_USE		BIT(23)
 #define AML_UART_BAUD_XTAL		BIT(24)
 
-#define AML_UART_PORT_NUM		6
+#define AML_UART_PORT_NUM		12
+#define AML_UART_PORT_OFFSET		6
 #define AML_UART_DEV_NAME		"ttyAML"
 
 
@@ -654,10 +655,20 @@ static int meson_uart_probe(struct platform_device *pdev)
 	struct resource *res_mem, *res_irq;
 	struct uart_port *port;
 	int ret = 0;
+	int id = -1;
 
 	if (pdev->dev.of_node)
 		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
 
+	if (pdev->id < 0) {
+		for (id = AML_UART_PORT_OFFSET; id < AML_UART_PORT_NUM; id++) {
+			if (!meson_ports[id]) {
+				pdev->id = id;
+				break;
+			}
+		}
+	}
+
 	if (pdev->id < 0 || pdev->id >= AML_UART_PORT_NUM)
 		return -EINVAL;
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
