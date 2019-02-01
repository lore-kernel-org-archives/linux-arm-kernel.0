Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2210CC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:46:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7A4220855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qVmBIsgl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fuSJpcZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A4220855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2/5/wWX0X2yp8tbyOHbletDPmQh5/tknBIHDqmSjnyQ=; b=qVmBIsglBxB3yJ
	gnLGiGoD3DHV68wHnWXcxvb0dQp20Cc/mGODMFccJO3sKubsUeW9TeY0tqyngdQ4guBSFTx78pJkK
	nszj7+0aOI/wzutgqIA4arAWa54VH8FdsqRyQQ9YFOVUoNqridz/PtpuCZ9uJzPQU/6qwClb3O/Y8
	GMW9nGxrnIeDlC72Ow+0zDr+YthCiru92nKDoz6b5lHqBCdS0reiwQM1rU7qpb3gPswpp4EDu5cAA
	85ZkM5SYDvrwflpUHK3W7buKFSLNIE6rXTXOeUG/6FIqjhbnE8Yl48rnwQo7BERWyUYe9iMkMAAIr
	ze7blyPbD2spOzza+fHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpb1j-00071t-Vz; Fri, 01 Feb 2019 15:46:47 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpayF-0002Ou-2c
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 15:43:28 +0000
Received: by mail-lf1-x143.google.com with SMTP id b20so5344055lfa.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 07:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RkT9METwUUSf5QTEToG7HBPINV4tos+GivD1TLgNTbs=;
 b=fuSJpcZNCoygctJX7n5myqfviNkMrtTfal+KUTcqzhZTYZmOUvONI/NqQktM7dDAAz
 g88EPytgTbpF6fIHV9zFZMMFRWHYW7+O8+U2X7CM4EhFHOz8X4fJ2w+i5HWv2/JvzyL5
 lvVaORZInY6yDpy6pfIzCa/81v2xbhksnRNFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RkT9METwUUSf5QTEToG7HBPINV4tos+GivD1TLgNTbs=;
 b=D4rsDxUUUtLfvrPHGkZGDVokMFtZ2pHY7HdtPy/eFV33CCfgqNEVOes0rK0YHC5YF4
 rt8YRsGQZDBDXWMtztBL1EqW1gMIAdl684gMEYdb0toS4vYYhiLtE5mQIgTgjCJhw364
 k4gt6jPlKi2pf/XherK96SQB2DokaokUqnhSghEf56E9HygWHP7UYnXOKaaE2ZGcizq5
 Tmvnt/sOgeeloDqUHML21hLNKEBC9g0OFz/RxOgbLkHOLYzNgTI8Uo2I18Bj4ws2Y2Og
 8gmfGQ7E6mXPnXBCmvuEyDz+UkRI1D2R8bS4S/TsJLgm6XWqVg3J1W9L3M5e4baOD00h
 bsqQ==
X-Gm-Message-State: AJcUukerAsWbnx/JH9uy0IdIC4ukT35VkxYbUCIzG6DBPyDWSgwN4uD/
 6BYE4n9mWfmGVaQtBA1uJAr8kQ==
X-Google-Smtp-Source: ALg8bN7Kxw6Pf/EAOmaIxz8Mx9Obn9sKEf9HWZo8iulGMFl1o3mrN3mA3vv/zvG2r+/EChgFTcCU7w==
X-Received: by 2002:ac2:4116:: with SMTP id b22mr30132103lfi.19.1549035789216; 
 Fri, 01 Feb 2019 07:43:09 -0800 (PST)
Received: from localhost.localdomain ([217.76.202.68])
 by smtp.gmail.com with ESMTPSA id i13-v6sm1305712ljg.82.2019.02.01.07.43.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Feb 2019 07:43:08 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v7 14/23] dt-bindings: sun6i-dsi: Add A64 DPHY compatible (w/
 A31 fallback)
Date: Fri,  1 Feb 2019 21:12:23 +0530
Message-Id: <20190201154232.10505-15-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190201154232.10505-1-jagan@amarulasolutions.com>
References: <20190201154232.10505-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_074312_332628_B4631214 
X-CRM114-Status: GOOD (  12.92  )
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
 dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
 Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The MIPI DSI PHY controller on Allwinner A64 is similar
on the one on A31.

Add A64 compatible and append A31 compatible as fallback.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
index 9877398be69a..d0ce51fea103 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
@@ -38,6 +38,7 @@ D-PHY
 Required properties:
   - compatible: value must be one of:
     * allwinner,sun6i-a31-mipi-dphy
+    * allwinner,sun50i-a64-mipi-dphy, allwinner,sun6i-a31-mipi-dphy
   - reg: base address and size of memory-mapped region
   - clocks: phandles to the clocks feeding the DSI encoder
     * bus: the DSI interface clock
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
