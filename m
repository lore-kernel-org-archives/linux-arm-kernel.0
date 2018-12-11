Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77697C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:57:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B3120849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N7IM+FZ5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="kYZO8us5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B3120849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=fDw8ti8er/GRJzskI7v4uEhLPYqqFp+O0DzZcLOHrHQ=; b=N7I
	M+FZ5xh6Cxj4E4VsTepKFRbfbhaU0L5YEF/Z5nI7Qhd6djiecUzqXvubpp9Bixq7xzlqkEni3CixA
	lDZjZ0PWkGpqebL9XBfXJaVqi+e9MiZcNNK29uI4AHqLSiOljNdLaCPOa3TU/8lJA+FSlZXEAlyrY
	OFd/ZoCihLVycrX+d2nzWCyBoTNJL81+d1c6RiiOfCBQg9G3tQn8BavCgmeCTt1iqB1SyCZO84BkK
	baFIkkP5koTOwE1r/OwBGjZHtnoKo95Kb5pk0jKinZf+f5D50jo8znlBikTqfqeAf28L/Je4a45GZ
	VUrrwY0h/aFXLAP9DJE6JeZJ7x9o/Lw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWhbA-00050m-47; Tue, 11 Dec 2018 12:57:16 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWhb7-0004zP-BZ
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 12:57:14 +0000
Received: by mail-lf1-x142.google.com with SMTP id p6so10714323lfc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 04:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=B5OxVxVCV5CgTbspOHE6zw8Koc7T4ZCxbFbcoeMSHX0=;
 b=kYZO8us5Gx4VJmd5uQFfW6enIIeXVvyDTOxvIevbfhqal1l6vawCccOwwmgCWtp0De
 oOQUmmTk41oxs8YlYAnbv7FQL4m4ZbE456flWc70ElgqdYzY/SnFf80IcnM4wk3kgIQ1
 YWDvBFRtzsqVLytytpsR7VSTQhHZbnI8ytbDmHd1RShTElZg3p3n4XAZsSey5fXXHApX
 3s5RIGSeZ/XqZGYmOW3hlWYe23AX6F9xC3VeyfZuIeNFYcls8BhCq7O64iJ+5+gmhlqr
 4RlIP/7Ct+ETgifO4dKFNCnMzGmBEdFtGQo4MiNajsiHzYxZMrZ4bZTNZNW1B9H1ejRi
 9mUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=B5OxVxVCV5CgTbspOHE6zw8Koc7T4ZCxbFbcoeMSHX0=;
 b=JA6s9mmHNFQUK6huO0ZBReppufTxoWaCHbdFlybCnxCbL7ByuB26rDBHXiY5Q+h4Ar
 4JQTYxcb2ovedVFb9P46vCOmDTP510+2H+ZXKUk5AXxIRJSncY/MNAaZzDlgTqOaHwBi
 Thwr/H4memWJRMz3DNCHJfotqypIBlp86sQW0KzsZOozaAl5iYMOjNiN8e0hcflufBdb
 VqhGnimfnSj5eGc/vGT7vkiCyf4LEvosg7zSw2+d35Nz54RgIYRLDKxUjZBuScpZaEmj
 gOQN3tA/f6W0uFGHt4cn5zT6z5af3Kry75MMKbaTZwnhXQcb4jJddfICAj0z2kPyZud4
 1PfA==
X-Gm-Message-State: AA+aEWapQUaxHcZG85aqk3yFwWq0dv3B1Bs9KwOlDKCUGczXHDP7rl94
 CbFHpwuv2ZtTO4mChstzX1P/2Q==
X-Google-Smtp-Source: AFSGD/ULZv8g+nHqpBmCn8i5r2krP5fpZoCRpGJt/70nLzwN2pEa3a4BGXkDF92INUt2sltVKOETsw==
X-Received: by 2002:a19:c014:: with SMTP id q20mr8698803lff.16.1544533020958; 
 Tue, 11 Dec 2018 04:57:00 -0800 (PST)
Received: from gilgamesh.semihalf.com (31-172-191-173.noc.fibertech.net.pl.
 [31.172.191.173])
 by smtp.gmail.com with ESMTPSA id g4-v6sm2736636lji.17.2018.12.11.04.56.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 11 Dec 2018 04:57:00 -0800 (PST)
From: Marcin Wojtas <mw@semihalf.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org
Subject: [PATCH net] net: mvneta: fix operation for 64K PAGE_SIZE
Date: Tue, 11 Dec 2018 13:56:49 +0100
Message-Id: <1544533009-12425-1-git-send-email-mw@semihalf.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_045713_400210_96FF877A 
X-CRM114-Status: GOOD (  13.98  )
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
Cc: antoine.tenart@bootlin.com, jaz@semihalf.com, gregory.clement@bootlin.com,
 linux@armlinux.org.uk, maxime.chevallier@bootlin.com, nadavh@marvell.com,
 thomas.petazzoni@bootlin.com, stefanc@marvell.com,
 Marcin Wojtas <mw@semihalf.com>, davem@davemloft.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Recent changes in the mvneta driver reworked allocation
and handling of the ingress buffers to use entire pages.
Apart from that in SW BM scenario the HW must be informed
via PRXDQS about the biggest possible incoming buffer
that can be propagated by RX descriptors.

The BufferSize field was filled according to the MTU-dependent
pkt_size value. Later change to PAGE_SIZE broke RX operation
when usin 64K pages, as the field is simply too small.

This patch conditionally limits the value passed to the BufferSize
of the PRXDQS register, depending on the PAGE_SIZE used.
On the occasion remove now unused frag_size field of the mvneta_port
structure.

Fixes: 562e2f467e71 ("net: mvneta: Improve the buffer allocation
method for SWBM")

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index e5397c8..61b2349 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -408,7 +408,6 @@ struct mvneta_port {
 	struct mvneta_pcpu_stats __percpu	*stats;
 
 	int pkt_size;
-	unsigned int frag_size;
 	void __iomem *base;
 	struct mvneta_rx_queue *rxqs;
 	struct mvneta_tx_queue *txqs;
@@ -2905,7 +2904,9 @@ static void mvneta_rxq_hw_init(struct mvneta_port *pp,
 	if (!pp->bm_priv) {
 		/* Set Offset */
 		mvneta_rxq_offset_set(pp, rxq, 0);
-		mvneta_rxq_buf_size_set(pp, rxq, pp->frag_size);
+		mvneta_rxq_buf_size_set(pp, rxq, PAGE_SIZE < SZ_64K ?
+					PAGE_SIZE :
+					MVNETA_RX_BUF_SIZE(pp->pkt_size));
 		mvneta_rxq_bm_disable(pp, rxq);
 		mvneta_rxq_fill(pp, rxq, rxq->size);
 	} else {
@@ -3760,7 +3761,6 @@ static int mvneta_open(struct net_device *dev)
 	int ret;
 
 	pp->pkt_size = MVNETA_RX_PKT_SIZE(pp->dev->mtu);
-	pp->frag_size = PAGE_SIZE;
 
 	ret = mvneta_setup_rxqs(pp);
 	if (ret)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
