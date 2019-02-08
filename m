Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B1CC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:22:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCE3620855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pchNkMhu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NRfnV9a5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE3620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=10vN43ioJYXNLG84V8nu2slCb/z3gpySSL05IsXgTZo=; b=pchNkMhurJ0XfA
	zwcZKFwg/WSLoa4nKER35uvQOHXc0NUgGBzQ61egTO8t/YPJW2i4sWblCysNESyHwf9Pu1l9OjC1a
	fomRel8lMj+0nPvC91WizxvEYh4rDqnyu+IfiwzJagOV8SHwmT6Tf+0CXSPxakN/uwgD2ZwIHQn+H
	Up3f+cYdiQN7lxfnFjo8uE1vFKFbjEQzcfTz2DAdX1ygN+DZTPqT+n51SLf7l99nYV/UXheunL2Uq
	LYo6n58YlkQtE1qYfuzjCbQ54XgpLttkaFhD9FLQjsuq8i1nYGsZZFHXxDgJzaGyk4r6TVcXNtp0Q
	3tZejdJUR/gkAtfkDrTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs9rE-0000uE-54; Fri, 08 Feb 2019 17:22:32 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs9qi-0000Qh-03
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 17:22:01 +0000
Received: by mail-wm1-x344.google.com with SMTP id a62so4259829wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 09:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9ELIDzrFuDE4fv0H7ZmmXRZO/WnsGeJX4P6W+1XXVUI=;
 b=NRfnV9a540UmNDKscNJAOYXOcEyFaaX8bPbnN++HLDJnypKbdEz6liciFdRn1wcNfi
 PGUHa4X+nTbJuFKsM6OXlu8ssaLc0mgIh+bdoxtjsAweLEQZmfJ+mkyGlAU38d0brE55
 xjAV8U3Ej3uPiRhFaYsZ6svKUA0jzzdTONgMwWk0Y20lmjmjr75HWi+bt/7bLodDvwBg
 qmNVkPO6qD9OgGDp+OgtiBt5kd7pGcFF53ph03VnYe2baWXVbofhnvYHQjghX387wCxT
 vCzSZXZy9p3kYhvb0Gf03Ev65jet852z+os9RYnpCJnF2JIWCxZqAmLb0Gh4utqi+Vjk
 skxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9ELIDzrFuDE4fv0H7ZmmXRZO/WnsGeJX4P6W+1XXVUI=;
 b=jMrhQhz/1nY6Vyc+F45H1xEe+glwLEKx3PZ7xrt9PUzm8estDiFM4vAu5V8ETe5nHi
 sCc6opBPSLSiJHqPWbCzOHbuOwIGUJ1VuK1fzW2VDpk2kmgWH8IDtzDEkATHQtGY4604
 e/TCJsPdifGjwpKx59eBdn99J/78EHlVEzwrMPS4h3DtgiDXJLntFJnAeClvg1DRHp25
 Ke6limvb8ibHXOJjoEcafpqv3sZkgtFhRRpb1o3k5USxWkretaaXDKI/U+BQVxNRZcAf
 Yc0eVfCu1KswMkZJrdrv0zfIsfFQNjEj8TR/XMm936CeR7Tsc8ScFnnYX0bT1dBRgXuM
 GRQQ==
X-Gm-Message-State: AHQUAubUnRfJS/RNXBpDvKCuL8K3tdE2C0PfBUOCGWjumqdJMNpoPQ+/
 r59nH1jPJgQCnUMI6bUmW8hVBA==
X-Google-Smtp-Source: AHgI3IaR1xFVAO9b2qxaU0otLVQUTY6EsoNLrmwz4hZ6r6RNdzpR5VBVU2tncDgrUueX3odkeTfxtQ==
X-Received: by 2002:a05:6000:120a:: with SMTP id
 e10mr17621512wrx.85.1549646518598; 
 Fri, 08 Feb 2019 09:21:58 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
 by smtp.googlemail.com with ESMTPSA id k23sm4097150wmj.32.2019.02.08.09.21.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 08 Feb 2019 09:21:57 -0800 (PST)
From: Georgi Djakov <georgi.djakov@linaro.org>
To: linux-pm@vger.kernel.org
Subject: [PATCH v1 2/2] interconnect: qcom: Add tagging and wake/sleep support
 for sdm845
Date: Fri,  8 Feb 2019 19:21:52 +0200
Message-Id: <20190208172152.1807-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190208172152.1807-1-georgi.djakov@linaro.org>
References: <20190208172152.1807-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_092200_035387_C7618B54 
X-CRM114-Status: GOOD (  18.70  )
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
Cc: vincent.guittot@linaro.org, sanjayc@nvidia.com, seansw@qti.qualcomm.com,
 linux-kernel@vger.kernel.org, mturquette@baylibre.com,
 daidavid1@codeaurora.org, dianders@chromium.org, evgreen@chromium.org,
 bjorn.andersson@linaro.org, thierry.reding@gmail.com, henryc.chen@mediatek.com,
 amit.kucheria@linaro.org, linux-arm-msm@vger.kernel.org, ksitaraman@nvidia.com,
 georgi.djakov@linaro.org, linux-arm-kernel@lists.infradead.org,
 abailon@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: David Dai <daidavid1@codeaurora.org>

Add support for wake and sleep commands by using a tag to indicate
whether or not the aggregate and set requests are active only or
dual context for a particular path.

Signed-off-by: David Dai <daidavid1@codeaurora.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/sdm845.c | 101 +++++++++++++++++++++--------
 1 file changed, 75 insertions(+), 26 deletions(-)

diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index fb526004c82e..13499f681160 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -65,6 +65,12 @@ struct bcm_db {
 #define SDM845_MAX_BCMS		30
 #define SDM845_MAX_BCM_PER_NODE	2
 #define SDM845_MAX_VCD		10
+#define SDM845_MAX_CTX		2
+#define SDM845_EE_STATE		2
+#define EE_STATE_WAKE		0
+#define EE_STATE_SLEEP		1
+#define AO_CTX			0
+#define DUAL_CTX		1
 
 /**
  * struct qcom_icc_node - Qualcomm specific interconnect nodes
@@ -86,8 +92,8 @@ struct qcom_icc_node {
 	u16 num_links;
 	u16 channels;
 	u16 buswidth;
-	u64 sum_avg;
-	u64 max_peak;
+	u64 sum_avg[SDM845_MAX_CTX];
+	u64 max_peak[SDM845_MAX_CTX];
 	struct qcom_icc_bcm *bcms[SDM845_MAX_BCM_PER_NODE];
 	size_t num_bcms;
 };
@@ -112,8 +118,8 @@ struct qcom_icc_bcm {
 	const char *name;
 	u32 type;
 	u32 addr;
-	u64 vote_x;
-	u64 vote_y;
+	u64 vote_x[SDM845_EE_STATE];
+	u64 vote_y[SDM845_EE_STATE];
 	bool dirty;
 	bool keepalive;
 	struct bcm_db aux_data;
@@ -555,7 +561,7 @@ inline void tcs_cmd_gen(struct tcs_cmd *cmd, u64 vote_x, u64 vote_y,
 		cmd->wait = true;
 }
 
-static void tcs_list_gen(struct list_head *bcm_list,
+static void tcs_list_gen(struct list_head *bcm_list, int ee_state,
 			 struct tcs_cmd tcs_list[SDM845_MAX_VCD],
 			 int n[SDM845_MAX_VCD])
 {
@@ -573,8 +579,8 @@ static void tcs_list_gen(struct list_head *bcm_list,
 			commit = true;
 			cur_vcd_size = 0;
 		}
-		tcs_cmd_gen(&tcs_list[idx], bcm->vote_x, bcm->vote_y,
-			    bcm->addr, commit);
+		tcs_cmd_gen(&tcs_list[idx], bcm->vote_x[ee_state],
+			    bcm->vote_y[ee_state], bcm->addr, commit);
 		idx++;
 		n[batch]++;
 		/*
@@ -595,32 +601,42 @@ static void tcs_list_gen(struct list_head *bcm_list,
 
 static void bcm_aggregate(struct qcom_icc_bcm *bcm)
 {
-	size_t i;
-	u64 agg_avg = 0;
-	u64 agg_peak = 0;
+	size_t i, ctx;
+	u64 agg_avg[SDM845_MAX_CTX] = {0};
+	u64 agg_peak[SDM845_MAX_CTX] = {0};
 	u64 temp;
 
-	for (i = 0; i < bcm->num_nodes; i++) {
-		temp = bcm->nodes[i]->sum_avg * bcm->aux_data.width;
-		do_div(temp, bcm->nodes[i]->buswidth * bcm->nodes[i]->channels);
-		agg_avg = max(agg_avg, temp);
+	for (ctx = 0; ctx < SDM845_MAX_CTX; ctx++) {
+		for (i = 0; i < bcm->num_nodes; i++) {
+			temp = bcm->nodes[i]->sum_avg[ctx] * bcm->aux_data.width;
+			do_div(temp, bcm->nodes[i]->buswidth * bcm->nodes[i]->channels);
+			agg_avg[ctx] = max(agg_avg[ctx], temp);
 
-		temp = bcm->nodes[i]->max_peak * bcm->aux_data.width;
-		do_div(temp, bcm->nodes[i]->buswidth);
-		agg_peak = max(agg_peak, temp);
+			temp = bcm->nodes[i]->max_peak[ctx] * bcm->aux_data.width;
+			do_div(temp, bcm->nodes[i]->buswidth);
+			agg_peak[ctx] = max(agg_peak[ctx], temp);
+		}
 	}
 
-	temp = agg_avg * 1000ULL;
+	temp = agg_avg[AO_CTX] + agg_avg[DUAL_CTX] * 1000ULL;
+	do_div(temp, bcm->aux_data.unit);
+	bcm->vote_x[EE_STATE_WAKE] = temp;
+
+	temp = max(agg_peak[AO_CTX], agg_peak[DUAL_CTX]) * 1000ULL;
+	do_div(temp, bcm->aux_data.unit);
+	bcm->vote_y[EE_STATE_WAKE] = temp;
+
+	temp = agg_avg[DUAL_CTX] * 1000ULL;
 	do_div(temp, bcm->aux_data.unit);
-	bcm->vote_x = temp;
+	bcm->vote_x[EE_STATE_SLEEP] = temp;
 
-	temp = agg_peak * 1000ULL;
+	temp = agg_peak[DUAL_CTX] * 1000ULL;
 	do_div(temp, bcm->aux_data.unit);
-	bcm->vote_y = temp;
+	bcm->vote_y[EE_STATE_SLEEP] = temp;
 
 	if (bcm->keepalive && bcm->vote_x == 0 && bcm->vote_y == 0) {
-		bcm->vote_x = 1;
-		bcm->vote_y = 1;
+		bcm->vote_x[EE_STATE_WAKE] = 1;
+		bcm->vote_y[EE_STATE_WAKE] = 1;
 	}
 
 	bcm->dirty = false;
@@ -631,14 +647,16 @@ static int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 {
 	size_t i;
 	struct qcom_icc_node *qn;
+	u32 ctx = 0;
 
 	qn = node->data;
+	ctx = (!!tag) ? AO_CTX : DUAL_CTX;
 
 	*agg_avg += avg_bw;
 	*agg_peak = max_t(u32, *agg_peak, peak_bw);
 
-	qn->sum_avg = *agg_avg;
-	qn->max_peak = *agg_peak;
+	qn->sum_avg[ctx] = *agg_avg;
+	qn->max_peak[ctx] = *agg_peak;
 
 	for (i = 0; i < qn->num_bcms; i++)
 		qn->bcms[i]->dirty = true;
@@ -675,7 +693,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	 * Construct the command list based on a pre ordered list of BCMs
 	 * based on VCD.
 	 */
-	tcs_list_gen(&commit_list, cmds, commit_idx);
+	tcs_list_gen(&commit_list, EE_STATE_WAKE, cmds, commit_idx);
 
 	if (!commit_idx[0])
 		return ret;
@@ -693,6 +711,37 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 		return ret;
 	}
 
+	INIT_LIST_HEAD(&commit_list);
+
+	for (i = 0; i < qp->num_bcms; i++) {
+		/* Only generate WAKE and SLEEP commands if a resource's
+		 * requirements change as the execution environment transitions
+		 * between different power states.
+		 */
+		if (qp->bcms[i]->vote_x[EE_STATE_WAKE] !=
+		    qp->bcms[i]->vote_x[EE_STATE_SLEEP] ||
+		    qp->bcms[i]->vote_y[EE_STATE_WAKE] !=
+		    qp->bcms[i]->vote_y[EE_STATE_SLEEP]) {
+			list_add_tail(&qp->bcms[i]->list, &commit_list);
+		}
+	}
+
+	tcs_list_gen(&commit_list, EE_STATE_WAKE, cmds, commit_idx);
+
+	ret = rpmh_write_batch(qp->dev, RPMH_WAKE_ONLY_STATE, cmds, commit_idx);
+	if (ret) {
+		dev_err(qp->dev, "Error sending WAKE RPMH requests: %d\n", ret);
+		return ret;
+	}
+
+	tcs_list_gen(&commit_list, EE_STATE_SLEEP, cmds, commit_idx);
+
+	ret = rpmh_write_batch(qp->dev, RPMH_SLEEP_STATE, cmds, commit_idx);
+	if (ret) {
+		dev_err(qp->dev, "Error sending SLEEP RPMH requests: %d\n", ret);
+		return ret;
+	}
+
 	return ret;
 }
 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
