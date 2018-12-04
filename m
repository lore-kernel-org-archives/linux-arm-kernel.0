Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C84BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:19:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A7412082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f//xYerx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="eck9SQUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A7412082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6b3U+1533C0VQfn7rpjRZiWnjDOFK4X3HyFHZrtWJGE=; b=f//xYerxeYfwaQ
	y7jqJS2B8t9KDwYUAZ0isk1jbcqWMwY5a0Yc4ggH6fWKfFNbfHKjoEw4l5Epd2/f4t6/v1OKnOXyW
	8/+XJzr9PdyMWJDgbUKiVYAInnA6REY9IVDuqbydLAgzSnEaHgqYN87YgpVazeWoSOg/V3miAIBAL
	2XypAGJhoIsMoFK8Ypnt8YAXQS822qEzmII1sRf4VqcZFR5t396aTYuHhGgnd675gP4YrMVHP4fyB
	qrDFNvSViMwzGvurMryLUkC2z+0YPoEFHEmXaHyKJ6FdJgI3ZVGk6Gb8bOy6tcvakZ35F9ZGf1qWo
	IlIsIMcNG6CV19jaEfgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUBXW-0003wu-Bl; Tue, 04 Dec 2018 14:19:06 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUBUE-0000bR-4z
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 14:15:47 +0000
Received: by mail-pg1-x543.google.com with SMTP id w6so7426139pgl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 06:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=g.ncu.edu.tw; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QT/jwpU9ivKbEFe6HNlLtAKOm/2gOedicUVpenMpNWY=;
 b=eck9SQUYRqWwcMG4f3ZkERiQhM1+bbdR5dLK/Kn6uTChNAQDbmOUD1V9MrkXIlDM/Q
 kpDcS94Pl2Ups0YlXtwGUSwYcnN41sZp/Cx7RbJkYeBXNxhW7hfrVILQjKlXW1FUsrFf
 V2OuhFAdQ6DQzVnKZ0F1TEy2fXXi/TJpRwUEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QT/jwpU9ivKbEFe6HNlLtAKOm/2gOedicUVpenMpNWY=;
 b=p3mODUYAECe9ZTN5kIJ7f1xC86APnL/BHbKC5hn+USENWpli4LpB6tecI2aJ8N75Hm
 LJR0EZ0aB949VMHIAWw9OUKdpws1Z0yBqFMBcgojSVCg/RPDQsb0AKz8yCzf5/LWApav
 b79dRVGVbRavygAa3xgaKUKqsFp0y73kK1B3e6shoa5yydgiuvXlakr11SC+5yu8/huh
 7HHrtgfFTiouraa6xEyTFMZx/HKDQjkB/iY+VzV5j81W5mRmsFdIZsNeRHZFL86/Dw5Z
 uhnT2C3kHs3rIL5sKRLkoFtsNcK0tBFoFu4YBWBe229l35GkRwDlS5Yk+YXWH6v5Rt2w
 O0Jw==
X-Gm-Message-State: AA+aEWYKs00xumusgQSLQqsJzEJDNr5bgpOj38gepMTDL2UOUsDDvIOx
 04yZARkOHxWCGtTrN1+9CKbATORv97L5vQ==
X-Google-Smtp-Source: AFSGD/V4gYHI9BZv96TnW3s4KyhpGGmdE6ZqrgX3h+wHapy2NxajIkXX/3EYORxfIQI96wZWvR4i+g==
X-Received: by 2002:a63:6c48:: with SMTP id h69mr16052195pgc.139.1543932938838; 
 Tue, 04 Dec 2018 06:15:38 -0800 (PST)
Received: from starnight.local ([150.116.248.145])
 by smtp.gmail.com with ESMTPSA id n66sm36975863pfk.19.2018.12.04.06.15.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 06:15:38 -0800 (PST)
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
To: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
 "David S . Miller" <davem@davemloft.net>
Subject: [PATCH V4 3/6] net: maclorawan: Add maclorawan module declaration
Date: Tue,  4 Dec 2018 22:13:40 +0800
Message-Id: <20181204141341.4353-4-starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <CAC=mGzhs0smXzRxn1k9jDFsaLNAkpCd7rMs--E-SafQVTob7JQ@mail.gmail.com>
References: <CAC=mGzhs0smXzRxn1k9jDFsaLNAkpCd7rMs--E-SafQVTob7JQ@mail.gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_061543_045433_2CE3E7F9 
X-CRM114-Status: GOOD (  16.06  )
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

Add the maclorawan header file for common APIs in the module.

Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
---
V2:
- Split the LoRaWAN class module patch in V1 into LoRaWAN socket and
  LoRaWAN Soft MAC modules
- Use SPDX license identifiers

V4:
- Fix typo in comments
- Fix by coding style report from scripts/checkpatch.pl

 net/maclorawan/maclorawan.h | 200 ++++++++++++++++++++++++++++++++++++
 1 file changed, 200 insertions(+)
 create mode 100644 net/maclorawan/maclorawan.h

diff --git a/net/maclorawan/maclorawan.h b/net/maclorawan/maclorawan.h
new file mode 100644
index 000000000000..572c26c7cf40
--- /dev/null
+++ b/net/maclorawan/maclorawan.h
@@ -0,0 +1,200 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause */
+/*-
+ * LoRaWAN soft MAC
+ *
+ * Copyright (c) 2018 Jian-Hong, Pan <starnight@g.ncu.edu.tw>
+ *
+ */
+
+#ifndef __MAC_LORAWAN_H__
+#define __MAC_LORAWAN_H__
+
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/skbuff.h>
+#include <linux/workqueue.h>
+#include <linux/netdevice.h>
+#include <uapi/linux/if_arp.h>
+#include <crypto/hash.h>
+#include <crypto/skcipher.h>
+#include <linux/lora/lorawan.h>
+
+#define	LORAWAN_MODULE_NAME	"maclorawan"
+
+/* List the message types of LoRaWAN */
+enum {
+	LRW_JOIN_REQUEST,
+	LRW_JOIN_ACCEPT,
+	LRW_UNCONFIRMED_DATA_UP,
+	LRW_UNCONFIRMED_DATA_DOWN,
+	LRW_CONFIRMED_DATA_UP,
+	LRW_CONFIRMED_DATA_DOWN,
+	LRW_RFU,
+	LRW_PROPRIETARY,
+};
+
+/* List the communication directions */
+enum {
+	LRW_UPLINK,
+	LRW_DOWNLINK,
+};
+
+/* States of LoRaWAN slot timing */
+enum {
+	LRW_INIT_SS,
+	LRW_XMITTING_SS,
+	LRW_XMITTED,
+	LRW_RX1_SS,
+	LRW_RX2_SS,
+	LRW_RXTIMEOUT_SS,
+	LRW_RXRECEIVED_SS,
+	LRW_RETRANSMIT_SS,
+};
+
+#define	LRW_MHDR_LEN		1
+#define	LRW_FHDR_MAX_LEN	22
+#define	LRW_FOPS_MAX_LEN	15
+#define	LRW_FPORT_LEN		1
+#define	LRW_MIC_LEN		4
+
+/**
+ * lrw_fhdr - Hold the message's basic information of the frame
+ *
+ * @mtype:		this message's type
+ * @fctrl:		the frame control byte
+ * @fcnt:		this message's frame counter value
+ * @fopts:		this frame's options field
+ * @fopts_len:		the length of the fopts
+ */
+struct lrw_fhdr {
+	u8 mtype;
+	u8 fctrl;
+	u16 fcnt;
+	u8 fopts[LRW_FPORT_LEN];
+	u8 fopts_len;
+};
+
+/**
+ * lrw_session - LoRaWAN session for Class A end device
+ *
+ * @lrw_st:		points to the belonging lrw_st
+ * @entry:		the entry of the ss_list in lrw_struct
+ * @devaddr:		the LoRaWAN device address of this LoRaWAN hardware
+ * @fcnt_up:		uplink frame counter
+ * @fcnt_down:		downlink frame counter
+ * @fport:		the LoRaWAN data message's port field
+ * @tx_skb:		points to the TX skb, the frame
+ * @rx_skb:		points to the RX skb, the frame
+ * @tx_fhdr:		hold the message's basic information of the TX frame
+ * @rx_fhdr:		hold the message's basic information of the RX frame
+ * @tx_should_ack:	flag for determining the TX which should be acked or not
+ * @retry:		retry times for xmitting failed
+ * @state:		this session's current state
+ * @state_lock:		lock of the session's state
+ * @timer:		timing for this session and the state transition
+ * @timeout_work:	work if waiting acknowledge time out
+ * @rx_delay1:		RX1 delay time in seconds
+ * @rx_delay2:		RX2 delay time in seconds
+ * @rx1_window:		RX1 window opening time in milliseconds
+ * @rx2_window:		RX2 window opening time in milliseconds
+ * @ack_timeout:	time out time for waiting acknowledge in seconds
+ */
+struct lrw_session {
+	struct lrw_struct *lrw_st;
+	struct list_head entry;
+
+	u32 devaddr;
+	u16 fcnt_up;
+	u16 fcnt_down;
+	u8 fport;
+	struct sk_buff *tx_skb;
+	struct sk_buff *rx_skb;
+	struct lrw_fhdr tx_fhdr;
+	struct lrw_fhdr rx_fhdr;
+
+	u8 tx_should_ack;
+	u8 retry;
+	u8 state;
+	spinlock_t state_lock; /* lock of the session's state */
+
+	struct timer_list timer;
+	struct work_struct timeout_work;
+	unsigned long rx_delay1;
+	unsigned long rx_delay2;
+	unsigned long rx1_window;
+	unsigned long rx2_window;
+	unsigned long ack_timeout;
+};
+
+/**
+ * lrw_struct - The full LoRaWAN hardware to the LoRa device.
+ *
+ * @dev:		this LoRa device registed in system
+ * @hw:			the LoRa device of this LoRaWAN hardware
+ * @ops:		handle of LoRa operations interfaces
+ * @rx_skb_list:	the list of received frames
+ * @ss_list:		LoRaWAN session list of this LoRaWAN hardware
+ * @ss_list_lock:	lock of the session list
+ * @_cur_ss:		pointer of the current processing session
+ * @rx_should_ack:	represent the current session should be acked or not
+ * @state:		the state of this LoRaWAN hardware
+ * @app_eui:		the LoRaWAN application EUI
+ * @dev_eui:		the LoRaWAN device EUI
+ * @devaddr:		the LoRaWAN device address of this LoRaWAN hardware
+ * @appky:		the Application key
+ * @nwkskey:		the Network session key
+ * @appskey:		the Application session key
+ * @nwks_shash_tfm:	the hash handler for LoRaWAN network session
+ * @nwks_skc_tfm:	the crypto handler for LoRaWAN network session
+ * @apps_skc_tfm:	the crypto handler for LoRaWAN application session
+ * @fcnt_up:		the counter of this LoRaWAN hardware's up frame
+ * @fcnt_down:		the counter of this LoRaWAN hardware's down frame
+ * @xmit_task:		the xmit task for the current LoRaWAN session
+ * @rx_work:		the RX work in workqueue for the current LoRaWAN session
+ * @ndev:		points to the emulating network device
+ * @_net:		the current network namespace of this LoRaWAN hardware
+ */
+struct lrw_struct {
+	struct device dev;
+	struct lrw_hw hw;
+	struct lrw_operations *ops;
+
+	struct sk_buff_head rx_skb_list;
+	struct list_head ss_list;
+	struct mutex ss_list_lock; /* lock of the session list */
+	struct lrw_session *_cur_ss;
+	u8 rx_should_ack;
+	u8 state;
+
+	u64 app_eui;
+	u64 dev_eui;
+	u32 devaddr;
+	u8 appkey[LRW_KEY_LEN];
+	u8 nwkskey[LRW_KEY_LEN];
+	u8 appskey[LRW_KEY_LEN];
+	struct crypto_shash *nwks_shash_tfm;
+	struct crypto_sync_skcipher *nwks_skc_tfm;
+	struct crypto_sync_skcipher *apps_skc_tfm;
+
+	u16 fcnt_up;
+	u16 fcnt_down;
+
+	struct tasklet_struct xmit_task;
+	struct work_struct rx_work;
+
+	struct net_device *ndev;
+	possible_net_t _net;
+};
+
+#define	NETDEV_2_LRW(ndev)	((struct lrw_struct *)netdev_priv(ndev))
+
+struct lrw_session *lrw_alloc_ss(struct lrw_struct *lrw_st);
+void lrw_free_ss(struct lrw_session *ss);
+void lrw_del_ss(struct lrw_session *ss);
+int lrw_start_hw(struct lrw_struct *lrw_st);
+void lrw_stop_hw(struct lrw_struct *lrw_st);
+void lrw_prepare_tx_frame(struct lrw_session *ss);
+void lrw_xmit(unsigned long data);
+void lrw_rx_work(struct work_struct *work);
+
+#endif
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
