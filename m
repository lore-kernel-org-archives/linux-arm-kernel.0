Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCC1C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:35:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CEF720892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lm6Kv7N7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CEF720892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:Reply-To:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Message-Id:To:Subject:Date:From:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=Ppdz7XfYgdKsJpcvcLDMnuHInETPr2PzAKH9cuwDM/A=; b=Lm6
	Kv7N7DBj0nR0iZ6OKxtQ+QOVQUZzB/fKXMcEsJm7Ut2IANSzF5Mzv0ER8nLI0BjWaae4IapvZkMwL
	4wQwRoCAxLVKvDAc8UhsPB+iTEmeOH3oFG2b9Hn5xkyY7aXA+KJmgFtlZc5KWorhKtjTaNOVheVwB
	hLKk2A+txUL9lYktAshZJ46lhokVjG1/DRVKL4W/PhDBkD6Z8KZLqwJ4+wN0AUmLEf/59dttW4TaY
	U90PJeipFTvGyjKdc0nP9H+sH+JdtAK2ylxR7uYxXezGovYw8cT/8FLS3AOi1HqprHoDNSVmBu9nd
	hV+L3b4PuW1saLWOq9Qua1Ye1aYDpLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVGIA-0005dD-Hi; Fri, 07 Dec 2018 13:35:42 +0000
Received: from www.linuxtv.org ([130.149.80.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVGI5-0005cX-BI
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 13:35:40 +0000
Received: from mchehab by www.linuxtv.org with local (Exim 4.84_2)
 (envelope-from <mchehab@linuxtv.org>)
 id 1gVGHk-00065f-Lz; Fri, 07 Dec 2018 13:35:16 +0000
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Date: Fri, 07 Dec 2018 13:28:54 +0000
Subject: [git:media_tree/master] media: Use of_node_name_eq for node name
 comparisons
To: linuxtv-commits@linuxtv.org
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Message-Id: <E1gVGHk-00065f-Lz@www.linuxtv.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_053537_549739_8CF144D7 
X-CRM114-Status: GOOD (  11.14  )
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
Reply-To: linux-media@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, linux-samsung-soc@vger.kernel.org,
 Hyun Kwon <hyun.kwon@xilinx.com>, Michal Simek <michal.simek@xilinx.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Benoit Parrot <bparrot@ti.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: Use of_node_name_eq for node name comparisons
Author:  Rob Herring <robh@kernel.org>
Date:    Thu Dec 6 14:35:19 2018 -0500

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Hyun Kwon <hyun.kwon@xilinx.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Benoit Parrot <bparrot@ti.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

 drivers/media/platform/exynos4-is/media-dev.c | 12 ++++++------
 drivers/media/platform/ti-vpe/cal.c           |  4 ++--
 drivers/media/platform/xilinx/xilinx-tpg.c    |  2 +-
 drivers/media/v4l2-core/v4l2-fwnode.c         |  6 ++----
 4 files changed, 11 insertions(+), 13 deletions(-)

---

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
index 1399e71d42c2..ed01bedb5db6 100644
--- a/drivers/media/platform/xilinx/xilinx-tpg.c
+++ b/drivers/media/platform/xilinx/xilinx-tpg.c
@@ -722,7 +722,7 @@ static int xtpg_parse_of(struct xtpg_device *xtpg)
 		const struct xvip_video_format *format;
 		struct device_node *endpoint;
 
-		if (!port->name || of_node_cmp(port->name, "port"))
+		if (!of_node_name_eq(port, "port"))
 			continue;
 
 		format = xvip_of_get_format(port);
diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 7a3cc10fbe36..f0a6c0c6f162 100644
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
 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
