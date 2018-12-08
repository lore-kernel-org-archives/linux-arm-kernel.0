Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B84FC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:03:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A9062081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FSva8xvc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h1mrLExA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9062081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9PnAbcnWok83o+LyBtH7pQTJ5QcwNgBkfW2QEDTNbj4=; b=FSva8xvcQb7WbU
	hGk8UW4M6sfPnDGLH6iEex5O5BfX0+isBrdfDcc9JNGxwe4FOy0nggJiVmfDqmGK6ZPlIs904C8ZN
	9/+3HoHbIR/oTxNkDUygoLOdYUMnLzz+O/kkUCCwqzCt4/HFaCYEz0or/v1qVFUsNiDIE4yzCXUWd
	15UvqDj0NXvly9D0TlGHJgMg9rQQjngKvtnFTDWM8UevYcm/+/Xzlu/jAxDvHpXXTomaAuRHgs7fb
	uTfQTrnKyHw4K8Lz0XoS1Cx7xt7NWDQdKFZQmI+gmIV7WtncE7/J28x/PNqA/BrpBxW+qWyX8W6Gj
	A2xGloQ83+I2MCrqMEHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVg0e-0007aA-1Q; Sat, 08 Dec 2018 17:03:20 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVfzx-0006jB-0U
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 17:02:41 +0000
Received: by mail-wr1-x443.google.com with SMTP id j10so6572798wru.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 08 Dec 2018 09:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JeTBhfBfzyxVyKb92c1M4ktd+D+3Hu4luMY6labBrj0=;
 b=h1mrLExAt1RwZJW5PX3uL4+GkYl+uQfWR6jmxsTtE1RrSNAlQ4Ql/Q1UCp44fRhcAa
 5ykXuBrqcMfnazlhmxjfGu3TYYO82ZsRyg00z2+PLyyv2tvCl3iFf520eNZwCCkLzk3U
 lpC9CVK4qyQuwOvSd6z8fG0ZJmwi9R2lDjhLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JeTBhfBfzyxVyKb92c1M4ktd+D+3Hu4luMY6labBrj0=;
 b=QCh6XbalSOYD7vFTbZCdJMHwk/kpEYNmB2WFy3I00/iaGv8XLlI0r0ssRf1vJffN91
 gld8y4dUSuIlHwxKtYaDYzyauY1hR54G1wyse8javWWQt14bn5PqUo1GKpBmX2/wXeNf
 NrYWgSGSYJMi7M2qjojxXSmvKLL4h5zJGNZ6W5R9ZuNRFTYvVoDMJP55vdJ4Uorkmzxf
 gpSjWcJycqp19D246OWfGfCRTTdTbtZfdRUw4hJUgTKhTvn+gXiYGUJ2Zub4cJ2IL3Vf
 mQha//gc1j5J7wIGsHjI5Y8eKdS8eWXcjh5VdyrdPinCGk9g2oAJRwNqQHQ26PTJRIyV
 kH+g==
X-Gm-Message-State: AA+aEWafyPJSHFeIUUhNgZhtS/ZqrJwiXlU7wL4uXXJMPRV5XsQedsLm
 zuH+cScB4nq6NDCt6rP8mvyq2w==
X-Google-Smtp-Source: AFSGD/WX9VXA/8pjoDiC6n7BC1sizodv63YNAgJWrx5QCIw1EO7Wz1Uk38MqAPxkjDmFbyh2Y7aokQ==
X-Received: by 2002:adf:93e6:: with SMTP id
 93-v6mr4949477wrp.311.1544288545375; 
 Sat, 08 Dec 2018 09:02:25 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
 by smtp.googlemail.com with ESMTPSA id l20sm17411344wrb.93.2018.12.08.09.02.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 08 Dec 2018 09:02:24 -0800 (PST)
From: Georgi Djakov <georgi.djakov@linaro.org>
To: gregkh@linuxfoundation.org, andy.gross@linaro.org, olof@lixom.net,
 arnd@arndb.de, linux-pm@vger.kernel.org
Subject: [PATCH v12 3/7] interconnect: Allow endpoints translation via DT
Date: Sat,  8 Dec 2018 19:02:12 +0200
Message-Id: <20181208170216.32555-4-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208170216.32555-1-georgi.djakov@linaro.org>
References: <20181208170216.32555-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_090237_246580_4AA61DE0 
X-CRM114-Status: GOOD (  21.84  )
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
 linux-arm-msm@vger.kernel.org, robh+dt@kernel.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net, dianders@chromium.org,
 amit.kucheria@linaro.org, linux-kernel@vger.kernel.org,
 thierry.reding@gmail.com, georgi.djakov@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Currently we support only platform data for specifying the interconnect
endpoints. As now the endpoints are hard-coded into the consumer driver
this may lead to complications when a single driver is used by multiple
SoCs, which may have different interconnect topology.
To avoid cluttering the consumer drivers, introduce a translation function
to help us get the board specific interconnect data from device-tree.

Reviewed-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c           | 149 ++++++++++++++++++++++++++
 include/linux/interconnect-provider.h |  17 +++
 include/linux/interconnect.h          |   7 ++
 3 files changed, 173 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 33d927758669..d1854dfb1bed 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include <linux/overflow.h>
 
 static DEFINE_IDR(icc_idr);
@@ -194,6 +195,152 @@ static int apply_constraints(struct icc_path *path)
 	return ret;
 }
 
+/* of_icc_xlate_onecell() - Translate function using a single index.
+ * @spec: OF phandle args to map into an interconnect node.
+ * @data: private data (pointer to struct icc_onecell_data)
+ *
+ * This is a generic translate function that can be used to model simple
+ * interconnect providers that have one device tree node and provide
+ * multiple interconnect nodes. A single cell is used as an index into
+ * an array of icc nodes specified in the icc_onecell_data struct when
+ * registering the provider.
+ */
+struct icc_node *of_icc_xlate_onecell(struct of_phandle_args *spec,
+				      void *data)
+{
+	struct icc_onecell_data *icc_data = data;
+	unsigned int idx = spec->args[0];
+
+	if (idx >= icc_data->num_nodes) {
+		pr_err("%s: invalid index %u\n", __func__, idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return icc_data->nodes[idx];
+}
+EXPORT_SYMBOL_GPL(of_icc_xlate_onecell);
+
+/**
+ * of_icc_get_from_provider() - Look-up interconnect node
+ * @spec: OF phandle args to use for look-up
+ *
+ * Looks for interconnect provider under the node specified by @spec and if
+ * found, uses xlate function of the provider to map phandle args to node.
+ *
+ * Returns a valid pointer to struct icc_node on success or ERR_PTR()
+ * on failure.
+ */
+static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
+{
+	struct icc_node *node = ERR_PTR(-EPROBE_DEFER);
+	struct icc_provider *provider;
+
+	if (!spec || spec->args_count != 1)
+		return ERR_PTR(-EINVAL);
+
+	mutex_lock(&icc_lock);
+	list_for_each_entry(provider, &icc_providers, provider_list) {
+		if (provider->dev->of_node == spec->np)
+			node = provider->xlate(spec, provider->data);
+		if (!IS_ERR(node))
+			break;
+	}
+	mutex_unlock(&icc_lock);
+
+	return node;
+}
+
+/**
+ * of_icc_get() - get a path handle from a DT node based on name
+ * @dev: device pointer for the consumer device
+ * @name: interconnect path name
+ *
+ * This function will search for a path between two endpoints and return an
+ * icc_path handle on success. Use icc_put() to release constraints when they
+ * are not needed anymore.
+ * If the interconnect API is disabled, NULL is returned and the consumer
+ * drivers will still build. Drivers are free to handle this specifically,
+ * but they don't have to.
+ *
+ * Return: icc_path pointer on success or ERR_PTR() on error. NULL is returned
+ * when the API is disabled or the "interconnects" DT property is missing.
+ */
+struct icc_path *of_icc_get(struct device *dev, const char *name)
+{
+	struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
+	struct icc_node *src_node, *dst_node;
+	struct device_node *np = NULL;
+	struct of_phandle_args src_args, dst_args;
+	int idx = 0;
+	int ret;
+
+	if (!dev || !dev->of_node)
+		return ERR_PTR(-ENODEV);
+
+	np = dev->of_node;
+
+	/*
+	 * When the consumer DT node do not have "interconnects" property
+	 * return a NULL path to skip setting constraints.
+	 */
+	if (!of_find_property(np, "interconnects", NULL))
+		return NULL;
+
+	/*
+	 * We use a combination of phandle and specifier for endpoint. For now
+	 * lets support only global ids and extend this in the future if needed
+	 * without breaking DT compatibility.
+	 */
+	if (name) {
+		idx = of_property_match_string(np, "interconnect-names", name);
+		if (idx < 0)
+			return ERR_PTR(idx);
+	}
+
+	ret = of_parse_phandle_with_args(np, "interconnects",
+					 "#interconnect-cells", idx * 2,
+					 &src_args);
+	if (ret)
+		return ERR_PTR(ret);
+
+	of_node_put(src_args.np);
+
+	ret = of_parse_phandle_with_args(np, "interconnects",
+					 "#interconnect-cells", idx * 2 + 1,
+					 &dst_args);
+	if (ret)
+		return ERR_PTR(ret);
+
+	of_node_put(dst_args.np);
+
+	src_node = of_icc_get_from_provider(&src_args);
+
+	if (IS_ERR(src_node)) {
+		if (PTR_ERR(src_node) != -EPROBE_DEFER)
+			dev_err(dev, "error finding src node: %ld\n",
+				PTR_ERR(src_node));
+		return ERR_CAST(src_node);
+	}
+
+	dst_node = of_icc_get_from_provider(&dst_args);
+
+	if (IS_ERR(dst_node)) {
+		if (PTR_ERR(dst_node) != -EPROBE_DEFER)
+			dev_err(dev, "error finding dst node: %ld\n",
+				PTR_ERR(dst_node));
+		return ERR_CAST(dst_node);
+	}
+
+	mutex_lock(&icc_lock);
+	path = path_find(dev, src_node, dst_node);
+	if (IS_ERR(path))
+		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
+	mutex_unlock(&icc_lock);
+
+	return path;
+}
+EXPORT_SYMBOL_GPL(of_icc_get);
+
 /**
  * icc_set() - set constraints on an interconnect path between two endpoints
  * @path: reference to the path returned by icc_get()
@@ -519,6 +666,8 @@ int icc_provider_add(struct icc_provider *provider)
 {
 	if (WARN_ON(!provider->set))
 		return -EINVAL;
+	if (WARN_ON(!provider->xlate))
+		return -EINVAL;
 
 	mutex_lock(&icc_lock);
 
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index 78208a754181..63caccadc2db 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -12,6 +12,21 @@
 #define icc_units_to_bps(bw)  ((bw) * 1000ULL)
 
 struct icc_node;
+struct of_phandle_args;
+
+/**
+ * struct icc_onecell_data - driver data for onecell interconnect providers
+ *
+ * @num_nodes: number of nodes in this device
+ * @nodes: array of pointers to the nodes in this device
+ */
+struct icc_onecell_data {
+	unsigned int num_nodes;
+	struct icc_node *nodes[];
+};
+
+struct icc_node *of_icc_xlate_onecell(struct of_phandle_args *spec,
+				      void *data);
 
 /**
  * struct icc_provider - interconnect provider (controller) entity that might
@@ -21,6 +36,7 @@ struct icc_node;
  * @nodes: internal list of the interconnect provider nodes
  * @set: pointer to device specific set operation function
  * @aggregate: pointer to device specific aggregate operation function
+ * @xlate: provider-specific callback for mapping nodes from phandle arguments
  * @dev: the device this interconnect provider belongs to
  * @users: count of active users
  * @data: pointer to private data
@@ -31,6 +47,7 @@ struct icc_provider {
 	int (*set)(struct icc_node *src, struct icc_node *dst);
 	int (*aggregate)(struct icc_node *node, u32 avg_bw, u32 peak_bw,
 			 u32 *agg_avg, u32 *agg_peak);
+	struct icc_node* (*xlate)(struct of_phandle_args *spec, void *data);
 	struct device		*dev;
 	int			users;
 	void			*data;
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index 348957c6d767..8d4b0009b788 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -27,6 +27,7 @@ struct device;
 
 struct icc_path *icc_get(struct device *dev, const int src_id,
 			 const int dst_id);
+struct icc_path *of_icc_get(struct device *dev, const char *name);
 void icc_put(struct icc_path *path);
 int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw);
 
@@ -38,6 +39,12 @@ static inline struct icc_path *icc_get(struct device *dev, const int src_id,
 	return NULL;
 }
 
+static inline struct icc_path *of_icc_get(struct device *dev,
+					  const char *name)
+{
+	return NULL;
+}
+
 static inline void icc_put(struct icc_path *path)
 {
 }

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
