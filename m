Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A6DC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:41:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 885EA20837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W0STYnhQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ti8BCZpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885EA20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=22sEs1RPcYv0b5zM+WBCQsODz7HGjclHhAXzUK727Os=; b=W0STYnhQn1dFtM
	ABgdjhP43temVCRXCGLd8szN5M64KIowbNb106R5fiyXy5ZTVa3XN7Wp5EuQHd7XdNk2kJrjXfilu
	cL1enVWpVzUwhJIOtzItPyJTg/H3gRtuCYw8DlGyo6eYXTOO4+gAMlaJL0PTjrWDvEsifiSc9Xsb2
	KMr+kiqUJhYBk8uilzL7rFfa//xucYV+qsWfi/dBt7OZh/iLCcMDq+2nKYNve2p3NPGawpt84r+w1
	LYoLDcrCkczRNZa/jIASGU3nVyCzTt+IkfarZ2OkDIF9u59phyEW0VWCAuXek7NsuSIdHPf/V56Ls
	R4zUn6zFx2qA7MLxgilw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVIFb-00057K-T1; Fri, 07 Dec 2018 15:41:11 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVI4b-0004rs-B1
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 15:29:56 +0000
Received: by mail-wm1-x341.google.com with SMTP id n190so4803109wmd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 07:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+ohTwMnZy4lusdqO/qZ5ifBi8bTC/XiQ4YpI1jCqo4E=;
 b=Ti8BCZpI3o379zFrcx0Ni+pB5jemeDk8VYy5fO9mePABbce0R5TGmri39QUTmKPtqv
 pzbeZy8SoPOY6JLz1AVY0tFkiuBrd1eZQeJAzuH/7dzGMKXPhZYJ+wJ5P7wIgTbvJHPC
 ReCKjOn1vyhC1RY5puQaJgs4l3qQlfQn3vucM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+ohTwMnZy4lusdqO/qZ5ifBi8bTC/XiQ4YpI1jCqo4E=;
 b=dDpp40lDXa978vmfAFFNJ9EEpsaUWQjwTdG1djR9Zd3jcM5xjx9mZe72xLF0abPWAa
 lIxUsdWa94Z6S8f8HgvrGgfxW/NJ1Aqnu8I6FOYLOJzWzb3v86s9HYLet4RIm0E72V9f
 eqzuQ0FS3HPlnE/PJumL1OWtbvO53Q/8l7C2m8pwpo1eShsQhrmG0BvA/1NGG2vl7kSr
 zaKm79TTaUyiyAMD/HVkxbGPNBYIajXFkjAG6MF7UW+ppIORtGi9lCrPZxHrzajybnZT
 Uck0ziNxXgAxWq5GhFK8YEBqZmoHGmYwcA93yBBNMl/Ymoogh9+stqmSp7EJ3dtq/mRj
 z+Pg==
X-Gm-Message-State: AA+aEWYbDX4BsPsCXgNnhTtuIVxOcAYcH4G9SQtuEoXNHV31RtA4N6dK
 hiGWrSN0L/JQ/PwgKqGQ1v97VQ==
X-Google-Smtp-Source: AFSGD/VBiLX2VNYpEOEr8hZt9nXSDWVQ08GjLKumhZCB0fHUqfhV6wLItDkuLr6mzgvh8j4/zWla6Q==
X-Received: by 2002:a1c:9855:: with SMTP id a82mr2471256wme.20.1544196577721; 
 Fri, 07 Dec 2018 07:29:37 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
 by smtp.googlemail.com with ESMTPSA id y145sm2728721wmd.30.2018.12.07.07.29.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 07 Dec 2018 07:29:36 -0800 (PST)
From: Georgi Djakov <georgi.djakov@linaro.org>
To: gregkh@linuxfoundation.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v11 8/8] interconnect: sdm845: Fix build failure after cmd_db
 API change
Date: Fri,  7 Dec 2018 17:29:17 +0200
Message-Id: <20181207152917.4862-9-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181207152917.4862-1-georgi.djakov@linaro.org>
References: <20181207152917.4862-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_072950_062835_9E2C8BB4 
X-CRM114-Status: GOOD (  14.48  )
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
Cc: mark.rutland@arm.com, sanjayc@nvidia.com, maxime.ripard@bootlin.com,
 mturquette@baylibre.com, daidavid1@codeaurora.org, bjorn.andersson@linaro.org,
 skannan@codeaurora.org, abailon@baylibre.com, lorenzo.pieralisi@arm.com,
 vincent.guittot@linaro.org, seansw@qti.qualcomm.com, khilman@baylibre.com,
 evgreen@chromium.org, ksitaraman@nvidia.com, devicetree@vger.kernel.org,
 arnd@arndb.de, linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 rjw@rjwysocki.net, dianders@chromium.org, amit.kucheria@linaro.org,
 linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
 georgi.djakov@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Recently the cmd_db_read_aux_data() function was changed to avoid using
memcpy and return a pointer instead. Update the code to the new API and
fix the build failure.

Fixes: ed3cafa79ea7 ("soc: qcom: cmd-db: Stop memcpy()ing in cmd_db_read_aux_data()")
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/sdm845.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index f594dd6f500f..06dbc99766ee 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -487,7 +487,9 @@ static struct qcom_icc_desc sdm845_rsc_hlos = {
 static int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev)
 {
 	struct qcom_icc_node *qn;
-	int ret, i;
+	const struct bcm_db *data;
+	size_t data_count;
+	int i;
 
 	bcm->addr = cmd_db_read_addr(bcm->name);
 	if (!bcm->addr) {
@@ -496,22 +498,22 @@ static int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev)
 		return -EINVAL;
 	}
 
-	if (cmd_db_read_aux_data_len(bcm->name) < sizeof(struct bcm_db)) {
+	data = cmd_db_read_aux_data(bcm->name, &data_count);
+	if (IS_ERR(data)) {
+		dev_err(dev, "%s command db read error (%ld)\n",
+			bcm->name, PTR_ERR(data));
+		return PTR_ERR(data);
+	}
+	if (!data_count) {
 		dev_err(dev, "%s command db missing or partial aux data\n",
 			bcm->name);
 		return -EINVAL;
 	}
 
-	ret = cmd_db_read_aux_data(bcm->name, (u8 *)&bcm->aux_data,
-				   sizeof(struct bcm_db));
-	if (ret < 0) {
-		dev_err(dev, "%s command db read error (%d)\n",
-			bcm->name, ret);
-		return ret;
-	}
-
-	bcm->aux_data.unit = le32_to_cpu(bcm->aux_data.unit);
-	bcm->aux_data.width = le16_to_cpu(bcm->aux_data.width);
+	bcm->aux_data.unit = le32_to_cpu(data->unit);
+	bcm->aux_data.width = le16_to_cpu(data->width);
+	bcm->aux_data.vcd = data->vcd;
+	bcm->aux_data.reserved = data->reserved;
 
 	/*
 	 * Link Qnodes to their respective BCMs

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
