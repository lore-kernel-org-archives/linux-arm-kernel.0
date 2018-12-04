Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E2FC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:20:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22280206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X4YkmIAj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="OQwdjQgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22280206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FX9N9MIKbO9WN0JPiLW0VtR4d3xDx66GNLXBy+jF/X4=; b=X4YkmIAjYy0lLh
	gCZUbQGAEF7PHCR9WioiXZHuS0+wWjT6Ragniaa0lHQjrp1p/nckVRDX7bX1NQ28CoEv3MaMaoo4f
	LU23e5opj/1sYBlKY8+NjShPWWUctyLHQqjDCcMOJfUG4O48ee/gCyY5tzYXsiz1ADtZtIT6gK5on
	yMhx3xkwaUFaSENfdu0gX+ranu3WWoX+Pm180UcMDMZju2/qhFJ3mQ8fPk7dqcU9qg0YFbww2uC0r
	VzP58UGrPFUhw8sLdrRd1lQAjTqxF9Ki8GY6ZiXkwaDqlcTWY3vjDd3AiJu327EpYBNzN2e6z+KnV
	003oVqhn4d2iVrhpbIFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUBYo-0006Jo-E3; Tue, 04 Dec 2018 14:20:26 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUBUJ-0000YZ-Fm
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 14:16:19 +0000
Received: by mail-pg1-x541.google.com with SMTP id n2so7440284pgm.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 06:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=g.ncu.edu.tw; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1qTK7eo+F9woQYTaQMAKzg3EGdvHcywuYbLGRNZvzTY=;
 b=OQwdjQgVRBJwEyLrdYBj7mq8dYG/M6M/mznos1R0E01NL+Xjc5RwH+RHaIRpTC/j7d
 bKOR5AqgGy1llutSnc9qMySvd5wmNg81/BLLJ6TL3cH7UgZWmR6UEVKOfDmTwb/mJ5Ir
 iwn2jsBny66PzLYwIcraxCanEHUgO/WwH+aWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1qTK7eo+F9woQYTaQMAKzg3EGdvHcywuYbLGRNZvzTY=;
 b=tKNK/2vr0jXtxJwhnSICynBzSnXuSUgLrAcnTi3sW2nUWIhl+dmHPgOsldaEhUr4X6
 nOJCWhqBM6fMvjVSDLKTdHD1adkxixEAY2o7CC7jtUPRJEBWEFk7Hc0QextE/d07aciN
 S9J10eXl7ZAmZFrlRe7eRD0DLRITao46n6Q35EVWA62a2T09a2Tx/wFG+K+yDTuHaxyX
 idVK3dtvR8g6fSCOKooZBx0ZuRvt6uP5T/iF8Nhopr/tVTw8oaSUzbAwSqjAiIK9c+HV
 9Yx+QjgFMAbTpHl0QDch7dJAiW52ywPsHBPt/5qu0NjU2FdeDBvObDLfbWwCTYNG48ia
 nDVA==
X-Gm-Message-State: AA+aEWbGDx3aD4WO9tWIyBFziHFNgiBn+uu6CBIsz9ioHDlvw3CZ5Ldq
 OOnHRgdxcmnBOY7oNwfWJSzMzA==
X-Google-Smtp-Source: AFSGD/XlTbkn1QZMkiZAg874zWUdUjjC7oNVYKUmbviUyg/u4n2/Cftx4+30ueC3nTYDnESVPqghSg==
X-Received: by 2002:a63:6ac5:: with SMTP id
 f188mr17018931pgc.165.1543932936468; 
 Tue, 04 Dec 2018 06:15:36 -0800 (PST)
Received: from starnight.local ([150.116.248.145])
 by smtp.gmail.com with ESMTPSA id n66sm36975863pfk.19.2018.12.04.06.15.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 06:15:36 -0800 (PST)
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
To: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
 "David S . Miller" <davem@davemloft.net>
Subject: [PATCH V4 2/6] net: lorawan: Add LoRaWAN API declaration for LoRa
 devices
Date: Tue,  4 Dec 2018 22:13:39 +0800
Message-Id: <20181204141341.4353-3-starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <CAC=mGzhs0smXzRxn1k9jDFsaLNAkpCd7rMs--E-SafQVTob7JQ@mail.gmail.com>
References: <CAC=mGzhs0smXzRxn1k9jDFsaLNAkpCd7rMs--E-SafQVTob7JQ@mail.gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_061548_190536_F4464ADA 
X-CRM114-Status: GOOD (  15.37  )
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
 linux-kernel@vger.kernel.org, Stefan Schmidt <stefan@datenfreihafen.org>,
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
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
