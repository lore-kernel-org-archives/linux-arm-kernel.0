Return-Path: <SRS0=d92h=OZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E39C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:20:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F6D8217FB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="agkSVVtr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="RD54j+V/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6D8217FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AzRkgQzeUg3zSqzUn4RQbldz+VfhCzDnXHaixQBB0kk=; b=agkSVVtrruPhd1
	tDd3Njjas/jE5EqEUEUPHzTx2IANZ3chYPE+BuGuCQmGCZcE8tDACVRI+1C2zXamDP/e5Qt+NajRR
	CyMVpgIzaXUFFu+XQNdOhU4QQ0XC2+UsI/fGfRCvtPFUVA/mhSfA9S/gRuylOy8lYd7Iq/d025Vk5
	NZLKhoZml74dCko+hrqN0yWrbUpXH4cjzwnqB7BB1GnOxxeDSU2Q+dkdgcDG2kP4qBiDY8XxyWH1p
	1W+mNGpN1WSrKZdkItOnjAwtOgYz78yStzL7qZ63bxZm5HVMW6thPww3GhnSfUZ6QSv+wqaAd7wS6
	0GBflQ+smA3i8exXY2TQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYTXR-0004YA-Lm; Sun, 16 Dec 2018 10:20:45 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYTWy-00036r-1o
 for linux-arm-kernel@lists.infradead.org; Sun, 16 Dec 2018 10:20:19 +0000
Received: by mail-pl1-x644.google.com with SMTP id w4so4766807plz.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 16 Dec 2018 02:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=g.ncu.edu.tw; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PHPOHUSEf09J0y5cet2zObb7uVSKpnQvHKWGF9UR7Is=;
 b=RD54j+V/qi4y+ErvR6gcyrzqd7FWw9UFcaYYsAAsaAB3V2EG6uLU2nQ8QW6d4KAPcX
 JL3FH4KTDrT+oOawGgw2BX5dkEWL8qjMssgaYYVMqlQTnSSTGUTdg8p0Ydfj2geFNigV
 FaflcXkAuQaLrMQJ3nWA5jZdNfgI8KLiZq7mE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PHPOHUSEf09J0y5cet2zObb7uVSKpnQvHKWGF9UR7Is=;
 b=G7i8Aw9nIKoDLSyP5rW+y3raqQAF87Awqfp+VJZM2fqGl/HMT/Xt+OYPVuDJEqVwRL
 Zh2O28GODBhjOBMYpHCg/RSxltxU84StMKWZ9dr9HbcqDF4ZDelRfxXn3pw9BZqTkdWc
 4t680Saj7/hVHD0PH0TglB5FYWfQtHDKHVg6YZPFgKf9phMTJROHOtT9jPYVd/xnVUzI
 Rx8qG5rKdHDmX08rnCigF8LZIJDtdztlz9Gp3/U04EgCf2PUAiceG+qoTT1u8d+2k8n9
 GrNeZxT2pgZFQZ5Cw9AaSHOQkkTh5+Tf4vHyY79IG204od1LK4c7Pba1PIA6X3zuBQkd
 RMBw==
X-Gm-Message-State: AA+aEWaPqVZJM8ZTiUHe7fLW2MLv0tVYUB+EAv7B6ZPCFRsdljQ/ZF1v
 cySItxcyFHza1/Awy4j+aQm9uQ==
X-Google-Smtp-Source: AFSGD/WbXm2rW/wCIYMwCz0IQtVhf2/LkNRGzpkca/a04Y0PVzDbBk/nF/BScSiKAKLTi+yysj+KCA==
X-Received: by 2002:a17:902:503:: with SMTP id 3mr9166909plf.233.1544955605471; 
 Sun, 16 Dec 2018 02:20:05 -0800 (PST)
Received: from starnight.local ([150.116.255.181])
 by smtp.gmail.com with ESMTPSA id d21sm14964454pgv.37.2018.12.16.02.20.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 16 Dec 2018 02:20:05 -0800 (PST)
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
To: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
 "David S . Miller" <davem@davemloft.net>,
 Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: [PATCH v5 2/6] net: lorawan: Add LoRaWAN API declaration for LoRa
 devices
Date: Sun, 16 Dec 2018 18:18:56 +0800
Message-Id: <20181216101858.9585-3-starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_022016_379458_4F4C5607 
X-CRM114-Status: GOOD (  14.87  )
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
Cc: netdev@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 linux-lpwan@lists.infradead.org, linux-kernel@vger.kernel.org,
 Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>,
 linux-wpan@vger.kernel.org, Jian-Hong Pan <starnight@g.ncu.edu.tw>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add public LoRaWAN API for compatible LoRa device drivers.

Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
---
V2:
- Split the LoRaWAN class module patch in V1 into LoRaWAN socket and
  LoRaWAN Soft MAC modules
- Merge the lrw_operations: set_bw, set_mod, set_sf into set_dr
- Use SPDX license identifiers

V3:
- Remove the unused lrw_random_addr function

V4:
- Fix by coding style report from scripts/checkpatch.pl

 include/linux/lora/lorawan.h | 131 +++++++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 include/linux/lora/lorawan.h

diff --git a/include/linux/lora/lorawan.h b/include/linux/lora/lorawan.h
new file mode 100644
index 000000000000..201f27521655
--- /dev/null
+++ b/include/linux/lora/lorawan.h
@@ -0,0 +1,131 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause */
+/*-
+ * LoRaWAN compatible hardware's definitions
+ *
+ * Copyright (c) 2018 Jian-Hong, Pan <starnight@g.ncu.edu.tw>
+ *
+ */
+
+#ifndef __LORAWAN_H__
+#define __LORAWAN_H__
+
+#include <linux/skbuff.h>
+
+/* List the role of the LoRaWAN hardware */
+enum {
+	LRW_GATEWAY,
+	LRW_CLASS_A_NODE,
+	LRW_CLASS_B_NODE,
+	LRW_CLASS_C_NODE,
+};
+
+/* List the RF modes */
+enum {
+	LRW_LORA,
+	LRW_FSK,
+};
+
+/**
+ * lrw_dr - This structure holds the RF related configuration of the data rate.
+ * @bw:
+ *	Bandwidth in Hz
+ *
+ * @sf:
+ *	Spread factor of CSS modulation used by LoRa mode
+ *
+ * @mode:
+ *	LoRa or FSK mode
+ */
+struct lrw_dr {
+	u32 bw;
+	u8 sf;
+	u8 mode;
+};
+
+#define	LRW_DEVADDR_LEN		(sizeof(__le32))
+
+/* List the LoRa device's states of LoRaWAN hardware */
+enum {
+	LRW_STOP,
+	LRW_START,
+	LRW_STATE_IDLE,
+	LRW_STATE_TX,
+	LRW_STATE_RX,
+};
+
+/**
+ * lrw_hw - This structure holds the LoRa device of LoRaWAN hardware.
+ * @priv:
+ *	points to the private data of the LoRa device
+ */
+struct lrw_hw {
+	void *priv;
+};
+
+/**
+ * lrw_operations - Lists the LoRaWAN device/interface's operations.
+ * These are callback functions for the LoRaWAN module.  Compatible LoRa device
+ * driver should implement some of them according to the usage.  The
+ * unimplemented callback functions must be assigned as NULL.
+ *
+ * @start:
+ *	called when the interface is being up state
+ *
+ * @stop:
+ *	called when the interface is being down state
+ *
+ * @xmit_async:
+ *	called to xmit the data through the interface asynchronously
+ *
+ * @set_txpower:
+ *	called to set xmitting RF power in mBm of the interface
+ *
+ * @set_frq:
+ *	called to set carrier frequency in Hz of the interface
+ *
+ * @set_dr:
+ *	called to set related RF configuration of the LoRaWAN data rate
+ *
+ * @start_rx_window:
+ *	called to ask the LoRa device open a receiving window
+ *
+ * @set_state:
+ *	called to set the LoRa device's working state
+ */
+struct lrw_operations {
+	int (*start)(struct lrw_hw *hw);
+	void (*stop)(struct lrw_hw *hw);
+
+	int (*xmit_async)(struct lrw_hw *hw, struct sk_buff *skb);
+	int (*set_txpower)(struct lrw_hw *hw, s32 pwr);
+	int (*set_frq)(struct lrw_hw *hw, u32 frq);
+	int (*set_dr)(struct lrw_hw *hw, struct lrw_dr *dr);
+	int (*start_rx_window)(struct lrw_hw *hw, u32 delay);
+	int (*set_state)(struct lrw_hw *hw, u8 state);
+};
+
+struct lrw_hw *lrw_alloc_hw(size_t priv_data_len, struct lrw_operations *ops);
+void lrw_free_hw(struct lrw_hw *hw);
+int lrw_register_hw(struct lrw_hw *hw);
+void lrw_unregister_hw(struct lrw_hw *hw);
+void lrw_rx_irqsave(struct lrw_hw *hw, struct sk_buff *skb);
+void lrw_xmit_complete(struct lrw_hw *hw, struct sk_buff *skb);
+
+void lrw_set_deveui(struct lrw_hw *hw, u64 eui);
+u64 lrw_get_deveui(struct lrw_hw *hw);
+void lrw_set_appeui(struct lrw_hw *hw, u64 eui);
+u64 lrw_get_appeui(struct lrw_hw *hw);
+void lrw_set_devaddr(struct lrw_hw *hw, u32 eui);
+u32 lrw_get_devaddr(struct lrw_hw *hw);
+
+enum {
+	LRW_APPKEY,
+	LRW_NWKSKEY,
+	LRW_APPSKEY,
+};
+
+#define	LRW_KEY_LEN		16
+
+int lrw_set_key(struct lrw_hw *hw, u8 type, u8 *key, size_t key_len);
+
+#endif
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
