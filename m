Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B5DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 04:51:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBFCC218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 04:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Oh+qUBAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBFCC218CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=LXMNzGo248pv1H5Najing93WynFTBiqAi+OO9XKU3qo=; b=Oh+
	qUBAd0m7GKHEe5YIQP4v3xrPbzZaajF64nl3f9CDPt+pQ9R04rJhR/bQCNZMJjzbf0jQ2XVG/VaGZ
	2m/w4aeC8H9ibe3DPXYibK1MSi4rcYxp16fVVxtMS33cKCRUAPShK2GvUs0Klr3oE8vWsCa9V4NZ+
	fleMtMBpRulHQkYQkW3e2pGpvf1BPUYRfiX66gsMLTT3nuPtqEcC2XxBoG+/t1ZqQ/wivXQY3k0DZ
	0yRE+D8QPSjYWiMgGK0pGxZitp4eWZT78DJsxIMDMrT4kUUncLs1CgHGuRm04vZO0KxWc2adOWfU9
	ZHSx6v7JV5RG4F8pnpUdOgbdDSjzs+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyrCE-0002OK-4J; Wed, 27 Feb 2019 04:51:54 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyrC9-0002NH-TT
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 04:51:51 +0000
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
 by mx.socionext.com with ESMTP; 27 Feb 2019 13:51:48 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
 by kinkan-ex.css.socionext.com (Postfix) with ESMTP id F2D93180D46;
 Wed, 27 Feb 2019 13:51:48 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP;
 Wed, 27 Feb 2019 13:51:48 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by iyokan.css.socionext.com (Postfix) with ESMTP id BCEC340392;
 Wed, 27 Feb 2019 13:51:48 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
 by yuzu.css.socionext.com (Postfix) with ESMTP id A49E5121B6C;
 Wed, 27 Feb 2019 13:51:48 +0900 (JST)
From: Sugaya Taichi <sugaya.taichi@socionext.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, soc@kernel.org
Subject: [PATCH v4 03/10] dt-bindings: Add documentation for Milbeaut SoCs
Date: Wed, 27 Feb 2019 13:52:25 +0900
Message-Id: <1551243145-10635-1-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_205150_063592_05041213 
X-CRM114-Status: GOOD (  18.56  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Sugaya Taichi <sugaya.taichi@socionext.com>,
 Jassi Brar <jaswinder.singh@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds a DT binding documentation for the M10V and its evaluation
board.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 .../bindings/arm/socionext/milbeaut.yaml           | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml

diff --git a/Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml b/Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml
new file mode 100644
index 0000000..aae53fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/milbeaut.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Milbeaut platforms device tree bindings
+
+maintainers:
+  - Taichi Sugaya <sugaya.taichi@socionext.com>
+  - Takao Orito <orito.takao@socionext.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - socionext,milbeaut-m10v-evb
+          - const: socionext,sc2000a
+...
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
