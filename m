Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB970C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:12:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAC3120675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k+PKKnQ0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V10Xf+8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC3120675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BMlHdTDUmH/dWs67Gvjtu8QAkIqF3ATnu8MjniSkpAY=; b=k+PKKnQ00b1/Nr
	N3gQbyrg6CrLf7/b7HLR6OUOLwC0HXvPOJbqNIN9Tv+16zgcln7MK4+qIw26d2tgl+3aKpNUGP2A8
	MTmLThouXawwR+dsR6jcdl7IRm10J+cKItM7NGmGL5qCz0c3Fdhni1TTYse0X/BWUY7bsTZmfoFgT
	zHQXBNYiiMEYDc7N1dV79XA+Hwjr5LENaietYVUiwymFCIldkTbLloi/5tjOZ+2JUlLIvfqDULtAc
	27Bm8eT/kSIGk/7u7EwDjwQhrqJokjmMTW3ufDXIr1BU++Zsi8B1rWhI207+RuYNpYr2UTeh4nn+g
	SWHs/ojIfKj0maFve7Cw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjnnj-0007KO-SQ; Wed, 16 Jan 2019 16:12:23 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjnmf-0006GL-U4
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 16:11:22 +0000
Received: by mail-wm1-x344.google.com with SMTP id t200so2619947wmt.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 08:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Dv+pY3mbEG8oP8SFilyrA7S//jhmEn3muBmKLb21XKY=;
 b=V10Xf+8KYu71ENB3vcyeUopKffaiT51jsBZls2odIK7kw5Y8dIv56eEAIIzjrybAG9
 vOgyOzqCglBya7XcA5m26ckA+YRM8MIN8UR9CLyKXGpXBh5uk+7p6kHk9YnaSWxWkhgL
 lJQBJasKTLzQilSE9BGczPMWfLMcj/TDvjvnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Dv+pY3mbEG8oP8SFilyrA7S//jhmEn3muBmKLb21XKY=;
 b=WKUGwvTGSbVRNm2MClqjmLmdfiOFGzbDKVnCdTSs1+8PUDfmCObobvbLGso8a++xLb
 Btjg3gDUIPsVgVU2ggQ9OHwRPQ9DXH5ngzvzTFEpCuUQvqt7K8QSlRx/q624VQhq68Gx
 zOx2xlDqAVrXxj1Sa8y+AOCVi3SixcdAI4AVN6mzt7MvP2tX8C+gc2CZ9VuH2kwL6zmW
 RaejBlCLism+7PiGAEGHC54Lks+bNjFXwBHCJByH3TctuVVs5YQeYrWIw+F2fRP1qDu1
 AbU+y9WTEjtM4vOyI4D0E5nBRtrGdby3uoEBsg28ly0TU1YuE7msFk9Hk4Oe922xDQCW
 nfkw==
X-Gm-Message-State: AJcUukcu7S4h6On1oTx6ayqtXGyDEvX1Z/dSwSNZ9rGPzNaZDX1qIya6
 Gi1xfdVWx81jN65hfJ/jidHkkw==
X-Google-Smtp-Source: ALg8bN4cYcmgoilU0xqMkpeUodS5QeOWtixKPD21xBXPjFmrKmTuguVUJIRPKzsEq4RBDMmUC1ncHQ==
X-Received: by 2002:a1c:a8d2:: with SMTP id r201mr7887736wme.81.1547655076200; 
 Wed, 16 Jan 2019 08:11:16 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
 by smtp.googlemail.com with ESMTPSA id a17sm78193407wrs.58.2019.01.16.08.11.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 16 Jan 2019 08:11:15 -0800 (PST)
From: Georgi Djakov <georgi.djakov@linaro.org>
To: gregkh@linuxfoundation.org
Subject: [PATCH v13 4/8] interconnect: Add debugfs support
Date: Wed, 16 Jan 2019 18:10:59 +0200
Message-Id: <20190116161103.6937-5-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190116161103.6937-1-georgi.djakov@linaro.org>
References: <20190116161103.6937-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_081118_384279_D9382C0A 
X-CRM114-Status: GOOD (  12.73  )
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

Add a functionality to provide information about the current constraints
per each node and provider.

Reviewed-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c | 70 +++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index a8c2bd35197f..8091d998549a 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -6,6 +6,7 @@
  * Author: Georgi Djakov <georgi.djakov@linaro.org>
  */
 
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/idr.h>
 #include <linux/init.h>
@@ -21,6 +22,7 @@
 static DEFINE_IDR(icc_idr);
 static LIST_HEAD(icc_providers);
 static DEFINE_MUTEX(icc_lock);
+static struct dentry *icc_debugfs_dir;
 
 /**
  * struct icc_req - constraints that are attached to each node
@@ -48,6 +50,59 @@ struct icc_path {
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
@@ -711,6 +766,21 @@ int icc_provider_del(struct icc_provider *provider)
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
