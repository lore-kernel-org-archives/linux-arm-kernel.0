Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B666DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:40:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B5AB20578
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="omqX+Nw2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5AB20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=JTTMr2PVcIwsVU34cEIr4i5wCZUxb4Q7E8MPGyrMXWQ=; b=omqX+Nw2Y2AlTHh/vdijh0ylLF
	AXieXWpETFWT1PGZJNbByBnRBoyn5CQGtyc6ZKZyvNIUqdUdAjEuRzQevNV7UazYx6Nm1/zEqTO62
	A9Pj+K7eB3IyJyg3SVjvOtcFa8q8e2Uod40EyXc3CA4ce3O0rKPGCGu3+z/S3DITgZBYc5EiKNqt7
	u0yHl4Z8TPFKAcBLV4NFB9/xkBfVm2cPeqXqGzpyxxCtTw35OZhdRXSKRAN2YGD4HgK1gV2Kve+eA
	wdpO71gBXyZQeT55b5Kyh24LQhUtURLT8+87I0BJGViAKc93jJuD2bXQjVg6vy0vGtjbJ2AGm8E56
	TwNrHXzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gicFT-0000zk-GL; Sun, 13 Jan 2019 09:40:07 +0000
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gicFP-0000AG-DH
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 09:40:05 +0000
X-IronPort-AV: E=Sophos;i="5.56,473,1539640800"; d="scan'208";a="291725802"
Received: from palace.lip6.fr ([132.227.105.202])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256;
 13 Jan 2019 10:24:47 +0100
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 4/4] drm/sun4i: backend: add missing of_node_puts
Date: Sun, 13 Jan 2019 09:47:44 +0100
Message-Id: <1547369264-24831-5-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547369264-24831-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1547369264-24831-1-git-send-email-Julia.Lawall@lip6.fr>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_014003_871113_4A727048 
X-CRM114-Status: GOOD (  12.86  )
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
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The device node iterators perform an of_node_get on each
iteration, so a jump out of the loop requires an of_node_put.

Remote and port also have augmented reference counts, so drop them
on each iteration and at the end of the function, respectively.
Remote is only used for the address it contains, not for the
contents of that address, so the reference count can be dropped
immediately.

The semantic patch that fixes the first part of this problem is
as follows (http://coccinelle.lip6.fr):

// <smpl>
@@
expression root,e;
local idexpression child;
iterator name for_each_child_of_node;
@@

 for_each_available_child_of_node(root, child) {
   ... when != of_node_put(child)
       when != e = child
+  of_node_put(child);
?  break;
   ...
}
... when != child
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
Not tested.

 drivers/gpu/drm/sun4i/sun4i_backend.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 9e9255e..a021bab 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -786,17 +786,18 @@ static struct sun4i_frontend *sun4i_backend_find_frontend(struct sun4i_drv *drv,
 		remote = of_graph_get_remote_port_parent(ep);
 		if (!remote)
 			continue;
+		of_node_put(remote);
 
 		/* does this node match any registered engines? */
 		list_for_each_entry(frontend, &drv->frontend_list, list) {
 			if (remote == frontend->node) {
-				of_node_put(remote);
 				of_node_put(port);
+				of_node_put(ep);
 				return frontend;
 			}
 		}
 	}
-
+	of_node_put(port);
 	return ERR_PTR(-EINVAL);
 }
 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
