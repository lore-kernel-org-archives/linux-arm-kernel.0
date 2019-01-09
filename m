Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292CCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:58:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB2DD20883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f3FZ3Yu+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D0yS7Bc2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JRMrjNqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2DD20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=d5VPel5opW1y9J/WRZ4HFuO3w1bYUoun++xLTq0gHPA=; b=f3FZ3Yu+l0BBIs
	aqwO3CSALyrZey9Ir0UhrqgEwwVexsDEjA/Qg2iWP9BZ+slOotq0AkX+nYzrSDtkF2t9XqrRmepNM
	ezWWakoGYiOn6v4bk/r+FSDLCjahg5DqfP35dRMxxADZ18iMjC/EsrQ4vtmE0ffoAENzUyPw+cQvg
	/8sfpYgw7hlOGppPwbyMkqthxAF3rbbYtJ2d02CV0mYf7fPvEVzn9YcY3Xogw9MxXBlEaC8cL9NWz
	flViteTEbGAzVejh1Lv75gsH4+e/ZS6dFwnjQTswZh3miEl7P3BElwenqxY4h4pNxJRvvDgNko0iM
	vD1FlJfd18F5AlF87fgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gh6sG-0005Gf-4J; Wed, 09 Jan 2019 05:57:56 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gh6sE-0005GE-Kh
 for linux-arm-kernel@bombadil.infradead.org; Wed, 09 Jan 2019 05:57:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Aa1uCBP59MSaio3VSgOuyxVekJ64BN6jptSWeh729UM=; b=D0yS7Bc2m49xJu9yQVNKyTaTJm
 dFxymyYGDeqE6irk56zH85MR4Lh9WQnBOTIumvl4T+T6VmVKYWHKMAYU70veBKiNXjlWTrY0/FUzv
 7+RGbM81cIlTpChmY+z9ZM5n8Owvh6456fCdZMaKcOY4Y4+x8xO5atseEky6JrkpkZcDMGlAVMpys
 2dMykm5YKVceIK+wSCZ7CAWKQNj7gdUwfNnb94RfQ59c7qowKJWG37UnZZTmlh3VWlocnZ3K/Ax1A
 3d9fnKVkC14te8XftZ7sbGOj56Ea+MvwTYedK+Q/gSQ3jo/cpxmuhGzaGvs2p3fvQ7acdPMpOGGO/
 0aF2kfPA==;
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gh6sB-00076C-K4
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 05:57:52 +0000
Received: by mail-pg1-x542.google.com with SMTP id d72so2818665pga.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 21:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Aa1uCBP59MSaio3VSgOuyxVekJ64BN6jptSWeh729UM=;
 b=JRMrjNqvaANp2nwjIVi+v62CRRtIdsNdmrS4Xik+9U7Ze3Q3sZ79s8pImwHbYTgQjS
 Dv+rbhL7lHgHqTtv6NNNHHhY87BF4q3oM9eBrLFz9thIB3V/f8TqwV0lhqohwKlxYWDB
 p07mbFI5okRzpWqPFYdIgURZ1V/O/oYdbhPO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Aa1uCBP59MSaio3VSgOuyxVekJ64BN6jptSWeh729UM=;
 b=E/DBrWllXEXEnppWe61pztrjQnn/PVMgCuOdEXWez1h/2Yua98fmhK0M+VB15eEnI0
 O/qbnHBoRDsakUgCPBrhYnZMd78XiR+T0ue5JaTA348PAV9h0uFwb7NaqZxdfdQbCQ+z
 omkbWGpQfU779Sv1D9y4BLTJFNAFOufb548GgDZSocKryfeVp/Wt/3FbdcQ0B7D1IZ5o
 VM8VIhUxQczb92KaEh8r5fUTXBnaYTDEZeHmGFuC6uUlnzSPXNo3QpLsvpCCj45vnY/G
 Tdblgk72BRd7HsD2BfZKYbTqL4GNZ56Spe3bFG1USgXi6zUwMi47uarA7Do9AAjTQt1M
 cl/w==
X-Gm-Message-State: AJcUukdsltLKRfA8KXo8sltpRioHR2yIrMw8mkO4VS0d6WTdOxvNF4dI
 Xq/TLMVAu1HzOOMYkj7xoEHPUA==
X-Google-Smtp-Source: ALg8bN67dfDF9e4WDOng/a/8ks/+HlzffpdXluuxKI+qUAPC45qiOTRTz4GtqYR9pVsdAlmUUxwtnA==
X-Received: by 2002:a63:a91a:: with SMTP id u26mr4147921pge.349.1547013465557; 
 Tue, 08 Jan 2019 21:57:45 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com
 ([2401:fa00:1:10:7889:7a43:f899:134c])
 by smtp.googlemail.com with ESMTPSA id i1sm102627966pgb.46.2019.01.08.21.57.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 21:57:44 -0800 (PST)
From: Pi-Hsun Shih <pihsun@chromium.org>
To: 
Subject: [PATCH] thermal: mtk: Allocate enough space for mtk_thermal.
Date: Wed,  9 Jan 2019 13:57:24 +0800
Message-Id: <20190109055724.184692-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_005751_670290_4F802104 
X-CRM114-Status: GOOD (  11.64  )
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
Cc: "open list:THERMAL" <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 open list <linux-kernel@vger.kernel.org>,
 Eduardo Valentin <edubezval@gmail.com>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Pi-Hsun Shih <pihsun@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Zhang Rui <rui.zhang@intel.com>, "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The mtk_thermal struct contains a 'struct mtk_thermal_bank banks[];',
but the allocation only allocates sizeof(struct mtk_thermal) bytes,
which cause out of bound access with the ->banks[] member. Change it to
a fixed size array instead.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
 drivers/thermal/mtk_thermal.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 0691f260f6eabe..ea11edb3fcced6 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -159,6 +159,9 @@
 #define MT7622_NUM_SENSORS_PER_ZONE	1
 #define MT7622_TS1	0
 
+/* The maximum number of banks */
+#define MAX_NUM_ZONES		8
+
 struct mtk_thermal;
 
 struct thermal_bank_cfg {
@@ -178,7 +181,7 @@ struct mtk_thermal_data {
 	const int *sensor_mux_values;
 	const int *msr;
 	const int *adcpnp;
-	struct thermal_bank_cfg bank_data[];
+	struct thermal_bank_cfg bank_data[MAX_NUM_ZONES];
 };
 
 struct mtk_thermal {
@@ -197,7 +200,7 @@ struct mtk_thermal {
 	s32 vts[MT8173_NUM_SENSORS];
 
 	const struct mtk_thermal_data *conf;
-	struct mtk_thermal_bank banks[];
+	struct mtk_thermal_bank banks[MAX_NUM_ZONES];
 };
 
 /* MT8173 thermal sensor data */
-- 
2.20.1.97.g81188d93c3-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
