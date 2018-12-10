Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83067C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:19:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA3020672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NtC0fTMQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="O+e/8jGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA3020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vbvy14V6lXrN8o3HEroQYvOcLmwJ+ktEyexL5x5QvEY=; b=NtC0fTMQU8sRuO
	J6HTHpHxACui71M0JkZaVQCExZrrQE4E1beDkwesuGKzXnyaTq3eRLAOEvDWc4QWDJMXhQ2qUzQhE
	sHeYPO4CjnXz5cVpwuCEjdVZVfSnmSsd9zWHfrKqzFu+yzKfx9Dn+KVFP9Y7YgxB8vElXjHAUuBKG
	4U7z/LTLZdR+bCYi9f15OCCFKVa4AWkfaZclDl94ofREx4alBEk6vcyjmhYTnTERlhQNgivblr9GD
	zahW/JbR6WDIPsTgkokQRG25kGxowYsBh+QPWPKdAED4io+WozQhJPxUDZfUij2Z1Cut1Zzjox5fX
	4+CdUr+/0F/TbR7nTIEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOH0-0000a8-IM; Mon, 10 Dec 2018 16:19:10 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOFw-0007cX-A1
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:18:08 +0000
Received: by mail-wm1-x342.google.com with SMTP id a62so4140064wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 08:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/FobAdk1F/zKxxqm1vIJo/CC8EUNzQ/B2arqE/fLkis=;
 b=O+e/8jGesF+TnCn8gM5SRD6NP0q6G5NYENXdrkyRc7q6CU8Eb4i7GTW60z95JnEKPO
 3fzgHoSR4cQxYPPHQx7cgqEWpf8VhVRVlamBtQKDyQ+1D8h+RYZ3/XueJyOGoxXBOYx7
 ArhaFDsmcOHfNIiTy6wxPHhItB8ClC60tXJgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/FobAdk1F/zKxxqm1vIJo/CC8EUNzQ/B2arqE/fLkis=;
 b=B8jtK9li+0Gwkxu3UScTPPTEMxywu+o2A5WsZ6nib3azFf76DUvAyo5FxNsg7NGqRB
 xPVea1H75gaQhOur7mecofaF1oCmwi6M5ONovCxZ4fp+PlNQctjecj50os60umA6Bf0k
 P6sQu6zLrrai0UxxNWfWxqmAehhyYqqNDDzR/xcFdsSDHHoz5FcecFu3CGiPGPaSSfC1
 22xiBy421/zZQKxu614FY/7l5wH8++5CN/uR/e/osykJ2ioAe12uELkboprBeTkpKnEK
 FFNYn7y6n74ltnb0qBlEHU2XXzmTrxMsu/w6VOt+45dN2MNc+ZnVHH7z+u2DgdX7xHMz
 9H1Q==
X-Gm-Message-State: AA+aEWa4VJm8955l2XD7xUTjpHw52Mp3C+REAoopMSJG3V6pmlYFk3BC
 /4szsb4mtCoS6bEjUQW1awHwHw==
X-Google-Smtp-Source: AFSGD/UGSus8mIueXi7G092yzijN2KgoYa8ydFRdqDZafNWarrOeEj+ecoQ1Q8xrLccYkOaSqYz39g==
X-Received: by 2002:a1c:2787:: with SMTP id
 n129mr11580381wmn.128.1544458671352; 
 Mon, 10 Dec 2018 08:17:51 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com.
 [213.198.162.59])
 by smtp.gmail.com with ESMTPSA id b13sm8397503wrn.28.2018.12.10.08.17.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 08:17:50 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v5 04/17] dt-bindings: sun6i-dsi: Add compatible for A64 MIPI
 DSI
Date: Mon, 10 Dec 2018 21:47:16 +0530
Message-Id: <20181210161729.29720-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210161729.29720-1-jagan@amarulasolutions.com>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_081804_991048_68B2F20E 
X-CRM114-Status: GOOD (  12.70  )
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
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The MIPI DSI controller on Allwinner A64 is similar to
Allwinner A31 without support of DSI mod clock.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
index 6a6cf5de08b0..9fa6e7a758ad 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
@@ -12,6 +12,7 @@ The DSI Encoder generates the DSI signal from the TCON's.
 Required properties:
   - compatible: value must be one of:
     * allwinner,sun6i-a31-mipi-dsi
+    * allwinner,sun50i-a64-mipi-dsi
   - reg: base address and size of memory-mapped region
   - interrupts: interrupt associated to this IP
   - clocks: phandles to the clocks feeding the DSI encoder
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
