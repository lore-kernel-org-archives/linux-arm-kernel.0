Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62114C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:35:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34CC720672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ban4kXFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34CC720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=mJHhOeT4RiivNpgbbE9VD3Ee+784ix2OXwWPYzf0hOA=; b=ban4kXFH5iqodT
	MbZdWcMYy8EpdyYBe4eYtSILzKdWaMT9uLUeTM2vE2bkF/t3EJBFD0VU5oA3xQoja470l/aLwcRRr
	2xTujw6lp/3mfgA0A81YEj2FU/eAG75RoxJBYB762+09qHQt4TRIwML5rgdnl3Ne25ats1xYsrky/
	W92Xlq0gfCa4dVQqJnOO8Cxb/oBbhTjTAlXRnmDR2ulojOmtqsQspHG0f6Ro6hb7Gct32WjcablBM
	nG91245MsUeCemo/LjzH8cT1xy9w8wqmYJ3Jilk+CvpORbwXyzyBt3AhYdLuTCVdV+nwYCCR+2Lqi
	gair7ybm8rWWuGkaj68Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUzQt-0002k7-R6; Thu, 06 Dec 2018 19:35:35 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUzQq-0002jF-SN
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 19:35:34 +0000
Received: by mail-ot1-f67.google.com with SMTP id e12so1536224otl.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 11:35:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oXsFqVkQvC9jOdOHTS5EB/PSIvwqVFJymMgC+jRnc5E=;
 b=mLwCPU7SQYeDlkwkVpFUCxsny0STJ+pBH05Y5NrpjevNpH+v0CCTnZiG+v5dKM6gqx
 brxdB/BxYPVosrlWloefimNVt07GokbKPce+M8mfYOp+FbbusE2fnIaHxq/T+ylVeDZz
 /xmyPxxoLavNR/QT+JTn9q2r5DG13qnmuG7QsrG6hlA+ctO49yUTmisdKfVNV+sh07Ne
 hFSsI/SRVHDf/8pw8O8mYLbyrghTcHKfxyCBpY3UkgbZfj9vSmeKzs35Zip8knj1OivW
 COk7SrlSX8Jof/IQl2EVuvfX3jAelAH4i7AiOZ1tVJ6a6F/BXbgrkzdCy1kuYyrkh5Sa
 SYrg==
X-Gm-Message-State: AA+aEWb8sOBpjYsMThN8I8r5/jXG8ba/1COlhYW4ilH12dtE31MMmKCU
 hsK6gp2iJ4xgBKJ2PZMxFQ==
X-Google-Smtp-Source: AFSGD/W8XFH2Psgs0x83Hrsvy1LIY2/jRtw6qCC/mA0S8JBZN7c2SpwLaeyi50GDB1avIdxRhe5qZQ==
X-Received: by 2002:a9d:a78:: with SMTP id 111mr18561582otg.229.1544124921409; 
 Thu, 06 Dec 2018 11:35:21 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id i5sm479863oia.46.2018.12.06.11.35.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 11:35:20 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] media: Use of_node_name_eq for node name comparisons
Date: Thu,  6 Dec 2018 13:35:19 -0600
Message-Id: <20181206193519.13367-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_113532_911522_A55F4559 
X-CRM114-Status: GOOD (  14.11  )
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
Cc: linux-samsung-soc@vger.kernel.org, Hyun Kwon <hyun.kwon@xilinx.com>,
 Michal Simek <michal.simek@xilinx.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Benoit Parrot <bparrot@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>,
 Kukjin Kim <kgene@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Hyun Kwon <hyun.kwon@xilinx.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-media@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Benoit Parrot <bparrot@ti.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- Also convert tabs to spaces between the 'if' and '('

 drivers/media/platform/exynos4-is/media-dev.c | 12 ++++++------
 drivers/media/platform/ti-vpe/cal.c           |  4 ++--
 drivers/media/platform/xilinx/xilinx-tpg.c    |  2 +-
 drivers/media/v4l2-core/v4l2-fwnode.c         |  6 ++----
 4 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/exynos4-is/media-dev.c b/drivers/media/platform/exynos4-is/media-dev.c
index 870501b0f351..463f2d84553e 100644
--- a/drivers/media/platform/exynos4-is/media-dev.c
+++ b/drivers/media/platform/exynos4-is/media-dev.c
@@ -445,7 +445,7 @@ static int fimc_md_parse_port_node(struct fimc_md *fmd,
 	 */
 	np = of_get_parent(rem);
 
-	if (np && !of_node_cmp(np->name, "i2c-isp"))
+	if (of_node_name_eq(np, "i2c-isp"))
 		pd->fimc_bus_type = FIMC_BUS_TYPE_ISP_WRITEBACK;
 	else
 		pd->fimc_bus_type = pd->sensor_bus_type;
@@ -495,7 +495,7 @@ static int fimc_md_register_sensor_entities(struct fimc_md *fmd)
 	for_each_available_child_of_node(parent, node) {
 		struct device_node *port;
 
-		if (of_node_cmp(node->name, "csis"))
+		if (!of_node_name_eq(node, "csis"))
 			continue;
 		/* The csis node can have only port subnode. */
 		port = of_get_next_child(node, NULL);
@@ -720,13 +720,13 @@ static int fimc_md_register_platform_entities(struct fimc_md *fmd,
 			continue;
 
 		/* If driver of any entity isn't ready try all again later. */
-		if (!strcmp(node->name, CSIS_OF_NODE_NAME))
+		if (of_node_name_eq(node, CSIS_OF_NODE_NAME))
 			plat_entity = IDX_CSIS;
-		else if	(!strcmp(node->name, FIMC_IS_OF_NODE_NAME))
+		else if (of_node_name_eq(node, FIMC_IS_OF_NODE_NAME))
 			plat_entity = IDX_IS_ISP;
-		else if (!strcmp(node->name, FIMC_LITE_OF_NODE_NAME))
+		else if (of_node_name_eq(node, FIMC_LITE_OF_NODE_NAME))
 			plat_entity = IDX_FLITE;
-		else if	(!strcmp(node->name, FIMC_OF_NODE_NAME) &&
+		else if (of_node_name_eq(node, FIMC_OF_NODE_NAME) &&
 			 !of_property_read_bool(node, "samsung,lcd-wb"))
 			plat_entity = IDX_FIMC;
 
diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti-vpe/cal.c
index 95a093f41905..fc3c212b96e1 100644
--- a/drivers/media/platform/ti-vpe/cal.c
+++ b/drivers/media/platform/ti-vpe/cal.c
@@ -1615,7 +1615,7 @@ of_get_next_port(const struct device_node *parent,
 				return NULL;
 			}
 			prev = port;
-		} while (of_node_cmp(port->name, "port") != 0);
+		} while (!of_node_name_eq(port, "port"));
 	}
 
 	return port;
@@ -1635,7 +1635,7 @@ of_get_next_endpoint(const struct device_node *parent,
 		if (!ep)
 			return NULL;
 		prev = ep;
-	} while (of_node_cmp(ep->name, "endpoint") != 0);
+	} while (!of_node_name_eq(ep, "endpoint"));
 
 	return ep;
 }
diff --git a/drivers/media/platform/xilinx/xilinx-tpg.c b/drivers/media/platform/xilinx/xilinx-tpg.c
index 851d20dcd550..ce686b8d6cff 100644
--- a/drivers/media/platform/xilinx/xilinx-tpg.c
+++ b/drivers/media/platform/xilinx/xilinx-tpg.c
@@ -725,7 +725,7 @@ static int xtpg_parse_of(struct xtpg_device *xtpg)
 		const struct xvip_video_format *format;
 		struct device_node *endpoint;
 
-		if (!port->name || of_node_cmp(port->name, "port"))
+		if (!of_node_name_eq(port, "port"))
 			continue;
 
 		format = xvip_of_get_format(port);
diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 218f0da0ce76..849326241b17 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -564,8 +564,7 @@ int v4l2_fwnode_parse_link(struct fwnode_handle *__fwnode,
 	fwnode = fwnode_get_parent(__fwnode);
 	fwnode_property_read_u32(fwnode, port_prop, &link->local_port);
 	fwnode = fwnode_get_next_parent(fwnode);
-	if (is_of_node(fwnode) &&
-	    of_node_cmp(to_of_node(fwnode)->name, "ports") == 0)
+	if (is_of_node(fwnode) && of_node_name_eq(to_of_node(fwnode), "ports"))
 		fwnode = fwnode_get_next_parent(fwnode);
 	link->local_node = fwnode;
 
@@ -578,8 +577,7 @@ int v4l2_fwnode_parse_link(struct fwnode_handle *__fwnode,
 	fwnode = fwnode_get_parent(fwnode);
 	fwnode_property_read_u32(fwnode, port_prop, &link->remote_port);
 	fwnode = fwnode_get_next_parent(fwnode);
-	if (is_of_node(fwnode) &&
-	    of_node_cmp(to_of_node(fwnode)->name, "ports") == 0)
+	if (is_of_node(fwnode) && of_node_name_eq(to_of_node(fwnode), "ports"))
 		fwnode = fwnode_get_next_parent(fwnode);
 	link->remote_node = fwnode;
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
