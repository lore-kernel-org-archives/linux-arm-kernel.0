Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CCAC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:45:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C850C2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GNhr1H5Q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H4J/B8qY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C850C2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9uTr8wZo1L0saTfpNOPlxONxuHIGa63kd+PC5N+A2mk=; b=GNhr1H5Qtdw4Jb
	jtjllSxtgCONsFxR912vgbgYiVgSWCzZ1EcXbNbAK/YYvT+f7uJ6/7U7pc3E76GH2XfJDjGUTz7Sj
	JRtWakEVrZAZPSM4vFW9SBzC5xl9rGut45VNH8qnH4uNjR7HkdpXkvQmr+S54+6ufmpyewr90O5fh
	EPYOxl7al+ZCEfXoyEHwV1VxL51I4xP9WEVIb+HI3PGV+0rloHuEx4LWrLJbrZbkltwvVIJS34e6A
	H5qBHcZmq5wN3V0Sj/0DW0yHukTVKI4h4Qok+24u/oNoB0jY8fb1B+v0y/RkEh2+Rsekj/tbhOtgF
	84jMhxqMyia7r1qNGHOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqPZf-0002nz-Pq; Sun, 03 Feb 2019 21:45:11 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqPXI-0008Uj-At
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 21:43:05 +0000
Received: by mail-lj1-x243.google.com with SMTP id n18-v6so10025345lji.7
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 13:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VfNJhlZwFnevZ1NziOKVHRE3ZVUCIVu/tyzYN4VflmQ=;
 b=H4J/B8qYxRBFkYgv6lEqbInzw4wDXBd882/DWjBNwBhNddkx6HEyOo5HjtrEzH516O
 ZGEseFj80piWbq6kTGPWfJ5bHbxkUeAhOsATAkFLGVXDbhn31oEYBJ9v71UOcB1PcnxL
 ILa1O6jhK45whvBr+dsCmguuITBQu46jh9q7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VfNJhlZwFnevZ1NziOKVHRE3ZVUCIVu/tyzYN4VflmQ=;
 b=eCHeehpH46fAEm0c8Ldzskc6F/zlPL1tFez+oZSaWk3XMR8EpQ8M4RVSYtEbf7kKnQ
 8aspp7B8fob7fDKS0v5bP7SDJiIkOBKuimLv5s4XrEeHP10zsXldET6+3X4iYoT2m3El
 vVegHpi1J9l42kZKhLo/DFKIS2tFonDryyNe8e9PR237I67FX3jFzK1ERSB+YYSOGZVv
 cW+9WOf17TcaAeDajO6N27WotF1q3/OEgagWVWjZ9DG/CWcUqoyDNt0nwNm/t3pvqejx
 t8Oks//+IefFItgODzxyY3lvG9fkCtP8ZH/b6FZi4t+SZzIyXC9RmXKUKEO9JYQLNHxG
 TcpA==
X-Gm-Message-State: AJcUukcPf/5srY8AmwgrVJSmvdfj17QeNdwkaQ9dEDuiX04EQvRwfgrh
 n87X+td/XivLnyEO5W+pAxOMW79SGn4=
X-Google-Smtp-Source: ALg8bN6C57gRWv70L3Kik0ZEmdHdRDNtQUj0Wd9ClRIgB56sZhJMie7unRi+jquy8B5h1AZgc7WiVw==
X-Received: by 2002:a2e:9e16:: with SMTP id
 e22-v6mr38028207ljk.4.1549230162007; 
 Sun, 03 Feb 2019 13:42:42 -0800 (PST)
Received: from linux.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id 85-v6sm2456868lja.16.2019.02.03.13.42.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 03 Feb 2019 13:42:40 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 10/17 v1] irqchip: ixp4xx: Add OF initialization support
Date: Sun,  3 Feb 2019 22:41:58 +0100
Message-Id: <20190203214205.13594-11-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190203214205.13594-1-linus.walleij@linaro.org>
References: <20190203214205.13594-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_134244_797178_33D534A9 
X-CRM114-Status: GOOD (  14.42  )
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
Cc: Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>,
 Marc Zyngier <marc.zyngier@arm.com>, Tim Harvey <tharvey@gateworks.com>,
 Olof Johansson <olof@lixom.net>, Thomas Gleixner <tglx@linutronix.de>,
 Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds support for probing and settin up the IXP4xx
irqchip from device tree.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
irqchip maintainers: I am requesting an ACK for this once
you're happy with the driver, as I intend to merge all of
this IXP4xx rework through ARM SoC.
---
 drivers/irqchip/irq-ixp4xx.c | 45 ++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/irqchip/irq-ixp4xx.c b/drivers/irqchip/irq-ixp4xx.c
index 7deaf0f82a53..741774264f37 100644
--- a/drivers/irqchip/irq-ixp4xx.c
+++ b/drivers/irqchip/irq-ixp4xx.c
@@ -15,6 +15,9 @@
 #include <linux/irqchip.h>
 #include <linux/irqchip/irq-ixp4xx.h>
 #include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/cpu.h>
 
@@ -358,3 +361,45 @@ void __init ixp4xx_irq_init(resource_size_t irqbase,
 	}
 }
 EXPORT_SYMBOL_GPL(ixp4xx_irq_init);
+
+#ifdef CONFIG_OF
+int __init ixp4xx_of_init_irq(struct device_node *np,
+			      struct device_node *parent)
+{
+	struct ixp4xx_irq *ixi = &ixirq;
+	void __iomem *base;
+	struct fwnode_handle *fwnode;
+	bool is_356;
+	int ret;
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_crit("IXP4XX: could not ioremap interrupt controller\n");
+		return -ENODEV;
+	}
+	fwnode = of_node_to_fwnode(np);
+	if (!fwnode) {
+		pr_crit("IXP4XX: no domain handle\n");
+		return -ENODEV;
+	}
+
+	/* These chip variants have 64 interrupts */
+	is_356 = of_device_is_compatible(np, "intel,ixp43x-interrupt") ||
+		of_device_is_compatible(np, "intel,ixp45x-interrupt") ||
+		of_device_is_compatible(np, "intel,ixp46x-interrupt");
+
+	ret = ixp4xx_irq_setup(ixi, base, fwnode, is_356);
+	if (ret)
+		pr_crit("IXP4XX: failed to set up irqchip\n");
+
+	return ret;
+}
+IRQCHIP_DECLARE(ixp42x, "intel,ixp42x-interrupt",
+		ixp4xx_of_init_irq);
+IRQCHIP_DECLARE(ixp43x, "intel,ixp43x-interrupt",
+		ixp4xx_of_init_irq);
+IRQCHIP_DECLARE(ixp45x, "intel,ixp45x-interrupt",
+		ixp4xx_of_init_irq);
+IRQCHIP_DECLARE(ixp46x, "intel,ixp46x-interrupt",
+		ixp4xx_of_init_irq);
+#endif
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
