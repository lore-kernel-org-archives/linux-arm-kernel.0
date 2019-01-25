Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DE4C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:24:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 365DD2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ffKhyF+I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365DD2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2IFzVvXs72ve0NjwtNNY+oCIqcLMH9cAtdHfqCuYYGo=; b=ffKhyF+Ie2j0/c
	mEcEz7AeaJFiUE9cOXXXEG325ulBC8WhxzTBrPIGMowqZQjM0QpWVBOnRzexgBLHbgnatS1pnOwtx
	gc4EOT23IoEG9hOjeG3eowI98NwRknhzXRRP8XQYGKCU4q16a4awEfZ7+jfreZjKXojD74/UkINj1
	VZQcqGymgebRgiFyWSwlOvjCLrYujYADU9ZWt2UAYCFQZwBIKywiq4dR92og2zS9/BA6qm/hgDioE
	/1wIK0rTMH1F+fqfw3pURFD5HLop6LhImoRnpHlHKRy5OAUqh32HIVu0qkGcFYkKmw+TlUToiVZk6
	qMRoYh9AsJTq/wjU0kcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gms6y-0007hO-AC; Fri, 25 Jan 2019 03:24:56 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gms5Q-0006dQ-IS
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 03:23:26 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 333CE5FCE9; Fri, 25 Jan 2019 11:23:15 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 02/11] dt-bindings: display: sun4i-drm: Add compatible strings
 for A23 display
Date: Fri, 25 Jan 2019 11:23:05 +0800
Message-Id: <20190125032314.20915-3-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125032314.20915-1-wens@csie.org>
References: <20190125032314.20915-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_192320_749707_856BBE79 
X-CRM114-Status: UNSURE (   9.83  )
X-CRM114-Notice: Please train this message.
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The A23's display pipeline is similar to the A33. Differences include:

  - Display backend supports larger layers, 8192x8192 instead of 2048x2048

  - TCON has DMA input

  - There is no SAT module packed in the display backend

Add compatible strings for the display pipeline and its components.

As the MIPI DSI output device is not officially documented, and there
are no A23 reference devices to test it, it is not covered by this
patch.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../devicetree/bindings/display/sunxi/sun4i-drm.txt          | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index f426bdb42f18..31ab72cba3d4 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -156,6 +156,7 @@ Required properties:
    * allwinner,sun6i-a31-tcon
    * allwinner,sun6i-a31s-tcon
    * allwinner,sun7i-a20-tcon
+   * allwinner,sun8i-a23-tcon
    * allwinner,sun8i-a33-tcon
    * allwinner,sun8i-a83t-tcon-lcd
    * allwinner,sun8i-a83t-tcon-tv
@@ -276,6 +277,7 @@ Required properties:
   - compatible: value must be one of:
     * allwinner,sun6i-a31-drc
     * allwinner,sun6i-a31s-drc
+    * allwinner,sun8i-a23-drc
     * allwinner,sun8i-a33-drc
     * allwinner,sun9i-a80-drc
   - reg: base address and size of the memory-mapped region.
@@ -303,6 +305,7 @@ Required properties:
     * allwinner,sun5i-a13-display-backend
     * allwinner,sun6i-a31-display-backend
     * allwinner,sun7i-a20-display-backend
+    * allwinner,sun8i-a23-display-backend
     * allwinner,sun8i-a33-display-backend
     * allwinner,sun9i-a80-display-backend
   - reg: base address and size of the memory-mapped region.
@@ -360,6 +363,7 @@ Required properties:
     * allwinner,sun5i-a13-display-frontend
     * allwinner,sun6i-a31-display-frontend
     * allwinner,sun7i-a20-display-frontend
+    * allwinner,sun8i-a23-display-frontend
     * allwinner,sun8i-a33-display-frontend
     * allwinner,sun9i-a80-display-frontend
   - reg: base address and size of the memory-mapped region.
@@ -419,6 +423,7 @@ Required properties:
     * allwinner,sun6i-a31-display-engine
     * allwinner,sun6i-a31s-display-engine
     * allwinner,sun7i-a20-display-engine
+    * allwinner,sun8i-a23-display-engine
     * allwinner,sun8i-a33-display-engine
     * allwinner,sun8i-a83t-display-engine
     * allwinner,sun8i-h3-display-engine
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
