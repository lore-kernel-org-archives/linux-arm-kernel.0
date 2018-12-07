Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DBBC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:30:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 451F3208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HFYeuGbT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H1/tGmfR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451F3208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EQJ9WKhxh5HpTsqMpkwzJtIE2nT8Rvz6RmrGFqXfVzI=; b=HFYeuGbTZWwFUv
	ZoywwkAO1nFboXQ3qn0e5dODxTOrIfr6ZVTISrRucai8siJhLqMt2kJesmBdhMJeMd0h7Ygr1mv8e
	JWochy0IV2/+SibS4nmPZvtPpfnO3P9uFdYotCXJTfevnt2Ar4zVs4ga0iEzZLSvMYPVdQy7VCXUU
	GzMZ6riZBn3n6+4Y0B1x2XlYOtbW4i40/Y8G6EPU+KMwksN+y+rvRbs16zuEGoYf2EtDBsy0lbg2V
	CnZDIlx92FDlRThQ9P22/Y0yjNRDN2U1zn9GsPLqMD11v5e3u9orfEn+4mP2xAzwKDZdtc6JebniA
	eSNuFH9RTYNiouEqO2HQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVI56-0006Dv-88; Fri, 07 Dec 2018 15:30:20 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVI4T-0004oc-3v
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 15:29:44 +0000
Received: by mail-wr1-x443.google.com with SMTP id u3so4203208wrs.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 07:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C9WXnWBuhV6priAyhwQEr5olumbkswiCcUF+DIQmTjY=;
 b=H1/tGmfRAeqQSGk4awyq0DUDJWjd0fMiXOHlLBjqcgdbr2FRG3yD4YtbkY/vr32+wW
 6pkuQwZNSO1S2/iifa83ed25sbCstaxKx/T2fq5I7BrpbmDC0yduNd9b6E7gamPfoZr1
 ahIKbU1dL9puIp6ZBZ2DEfooqWbpTEoXzfO44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C9WXnWBuhV6priAyhwQEr5olumbkswiCcUF+DIQmTjY=;
 b=A6jW6tFgyF/UHyVouc3W8Z6jgAQXF4Dp+fq9P7F04DH7Ey/IZmkEpU+Qzvg/Rjj6AR
 O5sbNuAY4Q5kOQrk+qPNj5qq+YvCFm/ffrkIqyQNmqTolLbibibhe9S5T03JMHFWlmyU
 /2G0t9XZLY+iiq+cVbMfW/T+CUBvUWP8qrUtn62K1y7gvwbgrm2Pgaz0S+JtvdmaFlFK
 hfPdNlWYj7xeNJePztp48HzjNo93Q4shNvCjN+lVIlvE6In0TVAhNTFgw1Ay+gi3Nonf
 6lgkI/NoSM3vcz/Jcr7s0n/jE0ZxscBUpYlVezSzgxFxUdTy5m3df9hMvAbCb16YUeP2
 sGwQ==
X-Gm-Message-State: AA+aEWa1XAUWWZ4Drfc79jUYUAbTNw+kiYPV7FHkns2Wp7J5wd7mBXTi
 v+0vJ+0VZNc5w0ABvI3NP969FRejwSqWzQ==
X-Google-Smtp-Source: AFSGD/XWs9V962a7O8PeuWGy0+WQ9jNXn7x3Zp0+3UAUC6e3fmV1Ff3XX5enoG8hG1yQq23HxVPrZw==
X-Received: by 2002:a05:6000:1251:: with SMTP id
 j17mr2110332wrx.315.1544196569368; 
 Fri, 07 Dec 2018 07:29:29 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
 by smtp.googlemail.com with ESMTPSA id y145sm2728721wmd.30.2018.12.07.07.29.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 07 Dec 2018 07:29:28 -0800 (PST)
From: Georgi Djakov <georgi.djakov@linaro.org>
To: gregkh@linuxfoundation.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v11 4/8] interconnect: Add debugfs support
Date: Fri,  7 Dec 2018 17:29:13 +0200
Message-Id: <20181207152917.4862-5-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181207152917.4862-1-georgi.djakov@linaro.org>
References: <20181207152917.4862-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_072941_384187_38833337 
X-CRM114-Status: GOOD (  12.94  )
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

Add a functionality to provide information about the current constraints
per each node and provider.

Reviewed-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c | 71 +++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index d1854dfb1bed..5a98192e92ad 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -6,6 +6,7 @@
  * Author: Georgi Djakov <georgi.djakov@linaro.org>
  */
 
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/idr.h>
 #include <linux/init.h>
@@ -17,10 +18,12 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/overflow.h>
+#include <linux/uaccess.h>
 
 static DEFINE_IDR(icc_idr);
 static LIST_HEAD(icc_providers);
 static DEFINE_MUTEX(icc_lock);
+static struct dentry *icc_debugfs_dir;
 
 /**
  * struct icc_req - constraints that are attached to each node
@@ -48,6 +51,59 @@ struct icc_path {
 	struct icc_req reqs[];
 };
 
+static void icc_summary_show_one(struct seq_file *s, struct icc_node *n)
+{
+	if (!n)
+		return;
+
+	seq_printf(s, "%-30s %12u %12u\n",
+		   n->name, n->avg_bw, n->peak_bw);
+}
+
+static int icc_summary_show(struct seq_file *s, void *data)
+{
+	struct icc_provider *provider;
+
+	seq_puts(s, " node                                   avg         peak\n");
+	seq_puts(s, "--------------------------------------------------------\n");
+
+	mutex_lock(&icc_lock);
+
+	list_for_each_entry(provider, &icc_providers, provider_list) {
+		struct icc_node *n;
+
+		list_for_each_entry(n, &provider->nodes, node_list) {
+			struct icc_req *r;
+
+			icc_summary_show_one(s, n);
+			hlist_for_each_entry(r, &n->req_list, req_node) {
+				if (!r->dev)
+					continue;
+
+				seq_printf(s, "    %-26s %12u %12u\n",
+					   dev_name(r->dev), r->avg_bw,
+					   r->peak_bw);
+			}
+		}
+	}
+
+	mutex_unlock(&icc_lock);
+
+	return 0;
+}
+
+static int icc_summary_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, icc_summary_show, inode->i_private);
+}
+
+static const struct file_operations icc_summary_fops = {
+	.open		= icc_summary_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static struct icc_node *node_find(const int id)
 {
 	return idr_find(&icc_idr, id);
@@ -711,6 +767,21 @@ int icc_provider_del(struct icc_provider *provider)
 }
 EXPORT_SYMBOL_GPL(icc_provider_del);
 
+static int __init icc_init(void)
+{
+	icc_debugfs_dir = debugfs_create_dir("interconnect", NULL);
+	debugfs_create_file("interconnect_summary", 0444,
+			    icc_debugfs_dir, NULL, &icc_summary_fops);
+	return 0;
+}
+
+static void __exit icc_exit(void)
+{
+	debugfs_remove_recursive(icc_debugfs_dir);
+}
+module_init(icc_init);
+module_exit(icc_exit);
+
 MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org>");
 MODULE_DESCRIPTION("Interconnect Driver Core");
 MODULE_LICENSE("GPL v2");

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
