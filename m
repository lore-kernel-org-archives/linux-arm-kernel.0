Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFAEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:21:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DBBA20651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BIs4XHdu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eng73Q+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DBBA20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PPj0C/1Z/VplGjQ9iSZQpfiuswqJ3NVFJj9CeAVfzMA=; b=BIs4XHdulz4Qhz
	YJSb7kGdZdVZumdQRPgkHP818dpKmRFiem9B66O6csoNLOT02i2qK7srqeI6zVJVBOoucoz0m3PiI
	Kxhvh7uR99I7KHP185Hx5kJyaYOtmkYE8Cy9izNeqYpXVAUuq8jZGzNcezEF8IjZD0DwrC0Du/zIj
	MjT3o+FFyQWodpT63GCekWXRRGdWdv2lcTMzfAjUqpF69loPbxuzuZcTU7MHWfTaDAke+A5MmgB2p
	FC9DuakNn4/Fs1GIJOS8MvXrbvxh12mP/8r96zSf7Zxgc2rE9RJO1SKm2mfAHUzQmkcuxK93r+6r/
	rD0d5rppQ4HAtnum8r+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjnwZ-0004Yx-T7; Wed, 16 Jan 2019 16:21:31 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjnmo-0006PW-Lk
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 16:11:39 +0000
Received: by mail-wr1-x441.google.com with SMTP id l9so7502677wrt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 08:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JgRm2aO2Ij1KQwzH5NiF8dvBkSLnMrQ8RcNVlPauU/8=;
 b=eng73Q+rXVdfvwKcoCIxc2D2TnbLST3DbvtVZT8/wMBHycQWUXcjrQVVYynjYN/eNf
 VonNHpkhw1c7lT6ZkVMUAofI3642MqI0OXWXKd32g4ZlYaDCKlGeEL2s8PpN9ptmiyT0
 xqsUXzokZRLa+SpQMOVnOyL4vTE3MoqtorQrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JgRm2aO2Ij1KQwzH5NiF8dvBkSLnMrQ8RcNVlPauU/8=;
 b=Mm2uHKLBFDMcoojhjcBW3P6uWYE1OyQaIz6r2WRwiO9heLng4zNs5zLWi6T6C6DM3q
 Sa2KQnUrULIGpENEtMoBtOPioxi7tx+GUcxQbINGdvOE47W2FDpP7dW82l/u1QWUaUo4
 njlPckH/LqG+XymXsh8DpUKdTeeMflaTMYvv2KTCX8/2xTJL21eK1zdkHAlO40EMb82/
 nzi+6aMik/LRA+j+lyefREQMA6N9c6/8iyPheSKckGcLOmJ2XWljxxAzgSUqs6p948cH
 ls3XrTYEV0IaUgOKocDtKF8XLlWMo9tzMJu7qh+eV6ucD0OgzAgVk0HrhY0Qjtt8g0aU
 5ncQ==
X-Gm-Message-State: AJcUukehOkDpP3QTrbxwG6IWciyWBLFzrg0FcrA3CKKlGUMm3lyLVvRV
 3fERVoxTJKwugVSzRU/we/idFQ==
X-Google-Smtp-Source: ALg8bN5vTpTdgFrNsBazJWOvWRE+OuJSwyAUdPF+54h9gkihY+LCJgCaEB709+03Af7ay7801ioi0Q==
X-Received: by 2002:adf:b3c3:: with SMTP id x3mr8262877wrd.294.1547655085306; 
 Wed, 16 Jan 2019 08:11:25 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
 by smtp.googlemail.com with ESMTPSA id a17sm78193407wrs.58.2019.01.16.08.11.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 16 Jan 2019 08:11:24 -0800 (PST)
From: Georgi Djakov <georgi.djakov@linaro.org>
To: gregkh@linuxfoundation.org
Subject: [PATCH v13 8/8] interconnect: Revert to previous config if any
 request fails
Date: Wed, 16 Jan 2019 18:11:03 +0200
Message-Id: <20190116161103.6937-9-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190116161103.6937-1-georgi.djakov@linaro.org>
References: <20190116161103.6937-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_081127_204236_4C067FA1 
X-CRM114-Status: GOOD (  14.09  )
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
Cc: sanjayc@nvidia.com, maxime.ripard@bootlin.com, mturquette@baylibre.com,
 daidavid1@codeaurora.org, bjorn.andersson@linaro.org, skannan@codeaurora.org,
 abailon@baylibre.com, vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
 khilman@baylibre.com, evgreen@chromium.org, ksitaraman@nvidia.com,
 devicetree@vger.kernel.org, arnd@arndb.de, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, henryc.chen@mediatek.com, andy.gross@linaro.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 rjw@rjwysocki.net, dianders@chromium.org, amit.kucheria@linaro.org,
 linux-kernel@vger.kernel.org, thierry.reding@gmail.com, olof@lixom.net,
 georgi.djakov@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When consumers report their bandwidth needs with icc_set_bw(), it's
possible that the requested amount of bandwidth is not available or just
the new configuration fails to apply on some path. In this case revert to
the previous configuration and propagate the error back to the consumers
to let them know that bandwidth is not available, hardware is busy or
whatever error is returned by the interconnect platform driver.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 8091d998549a..6005a1c189f6 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -414,14 +414,18 @@ EXPORT_SYMBOL_GPL(of_icc_get);
 int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 {
 	struct icc_node *node;
+	u32 old_avg, old_peak;
 	size_t i;
 	int ret;
 
-	if (!path)
+	if (!path || !path->num_nodes)
 		return 0;
 
 	mutex_lock(&icc_lock);
 
+	old_avg = path->reqs[0].avg_bw;
+	old_peak = path->reqs[0].peak_bw;
+
 	for (i = 0; i < path->num_nodes; i++) {
 		node = path->reqs[i].node;
 
@@ -434,10 +438,19 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 	}
 
 	ret = apply_constraints(path);
-	if (ret)
+	if (ret) {
 		pr_debug("interconnect: error applying constraints (%d)\n",
 			 ret);
 
+		for (i = 0; i < path->num_nodes; i++) {
+			node = path->reqs[i].node;
+			path->reqs[i].avg_bw = old_avg;
+			path->reqs[i].peak_bw = old_peak;
+			aggregate_requests(node);
+		}
+		apply_constraints(path);
+	}
+
 	mutex_unlock(&icc_lock);
 
 	return ret;

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
