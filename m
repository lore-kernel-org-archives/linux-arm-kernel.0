Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D70C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:22:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 898B320855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ePy6mNGM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xi0qgQmk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898B320855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HRcjr5MLvReI2RbDfRcX0xN/A5ZKIiPHeuF7cSf9IFU=; b=ePy6mNGMtmGqjy
	A1e6Cby8SfOoM8ek59Nm6cN2hngzhVdAW6YEyr0OPnT1vHVey8MzbKSndclqI5BQY9U5nuVlBfJiU
	t1PyU42Q5NAy+JIkasRa/L5hhYQuwD+IfIeoZOc+ItCJyGC3ow+KgMOPV8C4iOghWBd2KOMwEGFgX
	hD6Goi1MQwuo8LJYVSbKUUmP+W2JMSnxqZRGHrXN9zezF2FdPRRaLYvxPJND/abemz0wXXalOn8gj
	6KQyavbuDcEh3c7iUxRPfJKWidvdgJAnspFfZVTALx1kas+44GX9RDragirYr4IB00n01pOK7EK//
	+tpWCyhuPMPjqD3f6sTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs9qw-0000ei-8w; Fri, 08 Feb 2019 17:22:14 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs9qh-0000QQ-8G
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 17:22:01 +0000
Received: by mail-wm1-x344.google.com with SMTP id g67so4182880wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 09:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=51b5idztAmsBLdKrAGRyeDKLK40XaiNredOFEPB/oqc=;
 b=xi0qgQmkanzf5BVr+xvxJi2kcVeiXtOfM9/vbQzwle5ocH36VmOTP4v43q+2unVzH9
 iqIkAgrwG2Cvx6JSqw3zVH0QQgpjqZEDpSTGEJPf+ImxTrMO+t8UMzLy7864zKm/7U83
 ql4rY1U3QoYrOBLH5nLHUuF0FB8KL5jx/NYgDZ8xCKjw6s0A3zVuFBXAGaCTGVHK+R8b
 p/gFNDtqmlcvGgJ2/Vh5+jOuw8kQ4kHScTXlXpfmV1cpBc97IW9FW0ZynmEKq3MUB0XP
 wO5079nKJ8ogoU9ZolG3wndPJJiPfRZmBG2YpLmPdaNjLVgi8WoQDQQdqPBgvfASYCHq
 7B/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=51b5idztAmsBLdKrAGRyeDKLK40XaiNredOFEPB/oqc=;
 b=ix2n2f2Ukf7drZLdjeQHSr54hjxr+dpstYuxYPJqnKasclih/nXw2PMX72DM7t0C9e
 L/1j07A/XWgjxI2L5Db6Ks1QuyKVEMCSEYiuyHVo+kl8wArghAk0cscaBSMETA6W+YZV
 YvQRmevfFDl4xLVkGBoEtzOwvb/wS6yDQDh6SeY3i8WqSSBDUNgoWCS1By7YcftYIAhb
 u3cH2d1R9dkzjaiZNlHLZoHbhe8zWCS75/RRXLCqVerbfuvyK88c1cwS1X+dwUgfpWM2
 8+N3yKs+itwWZLa/NR5zkHvEoGnhs8EU/3bz8V9FCOdLD+RPIF+hN7kSco/nPr2VlqZa
 IiLw==
X-Gm-Message-State: AHQUAubRb8XUeunEXahUYh3/ZauSbPnvpzCpl7WtQ/0VdAqZ8EJDU8St
 KCunExPMYswLDxAo2uM1hiuW5Q==
X-Google-Smtp-Source: AHgI3IbyOZw/W+qbcepe3mkBtyyejFrchJVn4GP84ftIEqG3DFmG8it3jLWLTRCLVlslDB5ciOL4ig==
X-Received: by 2002:adf:fe43:: with SMTP id m3mr16904061wrs.290.1549646516529; 
 Fri, 08 Feb 2019 09:21:56 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
 by smtp.googlemail.com with ESMTPSA id k23sm4097150wmj.32.2019.02.08.09.21.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 08 Feb 2019 09:21:55 -0800 (PST)
From: Georgi Djakov <georgi.djakov@linaro.org>
To: linux-pm@vger.kernel.org
Subject: [PATCH v1 1/2] interconnect: Add support for path tags
Date: Fri,  8 Feb 2019 19:21:51 +0200
Message-Id: <20190208172152.1807-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190208172152.1807-1-georgi.djakov@linaro.org>
References: <20190208172152.1807-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_092159_291586_237EF632 
X-CRM114-Status: GOOD (  18.75  )
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

Consumers may have use cases with different bandwidth requirements based
on the system or driver state. The consumer driver can append a specific
tag to the path and pass this information to the interconnect platform
driver to do the aggregation based on this state.

Introduce icc_set_tag() function that will allow the consumers to append
an optional tag to each path. The aggregation of these tagged paths is
platform specific.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c           | 27 +++++++++++++++++++++++----
 drivers/interconnect/qcom/sdm845.c    |  2 +-
 include/linux/interconnect-provider.h |  4 ++--
 include/linux/interconnect.h          |  5 +++++
 4 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 6005a1c189f6..31eacd0f5349 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -42,10 +42,12 @@ struct icc_req {
 
 /**
  * struct icc_path - interconnect path structure
+ * @tag: path tag (optional)
  * @num_nodes: number of hops (nodes)
  * @reqs: array of the requests applicable to this path of nodes
  */
 struct icc_path {
+	u32 tag;
 	size_t num_nodes;
 	struct icc_req reqs[];
 };
@@ -206,7 +208,7 @@ static struct icc_path *path_find(struct device *dev, struct icc_node *src,
  * implementing its own aggregate() function.
  */
 
-static int aggregate_requests(struct icc_node *node)
+static int aggregate_requests(struct icc_node *node, u32 tag)
 {
 	struct icc_provider *p = node->provider;
 	struct icc_req *r;
@@ -215,7 +217,7 @@ static int aggregate_requests(struct icc_node *node)
 	node->peak_bw = 0;
 
 	hlist_for_each_entry(r, &node->req_list, req_node)
-		p->aggregate(node, r->avg_bw, r->peak_bw,
+		p->aggregate(node, tag, r->avg_bw, r->peak_bw,
 			     &node->avg_bw, &node->peak_bw);
 
 	return 0;
@@ -396,6 +398,23 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
 }
 EXPORT_SYMBOL_GPL(of_icc_get);
 
+/**
+ * icc_set_tag() - set an optional tag on a path
+ * @path: the path we want to tag
+ * @tag: the tag value
+ *
+ * This function allows consumers to append a tag to the path, so that a
+ * different aggregation could be done based on this tag.
+ */
+void icc_set_tag(struct icc_path *path, u32 tag)
+{
+	if (!path)
+		return;
+
+	path->tag = tag;
+}
+EXPORT_SYMBOL_GPL(icc_set_tag);
+
 /**
  * icc_set_bw() - set bandwidth constraints on an interconnect path
  * @path: reference to the path returned by icc_get()
@@ -434,7 +453,7 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 		path->reqs[i].peak_bw = peak_bw;
 
 		/* aggregate requests for this node */
-		aggregate_requests(node);
+		aggregate_requests(node, path->tag);
 	}
 
 	ret = apply_constraints(path);
@@ -446,7 +465,7 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 			node = path->reqs[i].node;
 			path->reqs[i].avg_bw = old_avg;
 			path->reqs[i].peak_bw = old_peak;
-			aggregate_requests(node);
+			aggregate_requests(node, path->tag);
 		}
 		apply_constraints(path);
 	}
diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index 4915b78da673..fb526004c82e 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -626,7 +626,7 @@ static void bcm_aggregate(struct qcom_icc_bcm *bcm)
 	bcm->dirty = false;
 }
 
-static int qcom_icc_aggregate(struct icc_node *node, u32 avg_bw,
+static int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 			      u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
 {
 	size_t i;
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index 63caccadc2db..4ee19fd41568 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -45,8 +45,8 @@ struct icc_provider {
 	struct list_head	provider_list;
 	struct list_head	nodes;
 	int (*set)(struct icc_node *src, struct icc_node *dst);
-	int (*aggregate)(struct icc_node *node, u32 avg_bw, u32 peak_bw,
-			 u32 *agg_avg, u32 *agg_peak);
+	int (*aggregate)(struct icc_node *node, u32 tag, u32 avg_bw,
+			 u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
 	struct icc_node* (*xlate)(struct of_phandle_args *spec, void *data);
 	struct device		*dev;
 	int			users;
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index dc25864755ba..d70a914cba11 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -30,6 +30,7 @@ struct icc_path *icc_get(struct device *dev, const int src_id,
 struct icc_path *of_icc_get(struct device *dev, const char *name);
 void icc_put(struct icc_path *path);
 int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw);
+void icc_set_tag(struct icc_path *path, u32 tag);
 
 #else
 
@@ -54,6 +55,10 @@ static inline int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 	return 0;
 }
 
+static inline void icc_set_tag(struct icc_path *path, u32 tag)
+{
+}
+
 #endif /* CONFIG_INTERCONNECT */
 
 #endif /* __LINUX_INTERCONNECT_H */

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
