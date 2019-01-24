Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F5BC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:02:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E13F821726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aeNIf2/7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="eVLx2Scb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13F821726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zVSzOqQRq3MnQfFEubmYcBwmm7FCNFybgM3nqoD02kU=; b=aeNIf2/79OwPa5
	yJszYFbdQ2pwB/FLy21DKtqLg6XjRe/TznohiCamwKP+IOMKtDEuE9opjKxScLH1g8Ya7/wW6wemN
	XB3Ah6KFLcxWV+2e+dByTWDieI9DH85bLgvkDgpSN4ep0f3SrfuxaZBN4XpURtcG8Rv7WNPaE2xz2
	q43ruofJOfdilbKAZzPB7UGAZZT+THDYdfJZ6F2nfTaxjvwwqu6rjPMW6hIKElBZZA/JoncZnD1LM
	luWXusaMC7Mtf5Zw26g5K0SiqaRFx15SBd59zg4eJezf/0qCP2LszAxz2t4UWVLbGjSReGZoeYq/k
	B0zei+zGV+rBliy9J0eQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmlCz-0002sB-CQ; Thu, 24 Jan 2019 20:02:41 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmlAv-0000xi-Rb
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 20:00:43 +0000
Received: by mail-pg1-x544.google.com with SMTP id y4so3113084pgc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 12:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tfGb6WOVY/NDozRdyqo5VBI3IXqzYkAU2KTM1oN3JpM=;
 b=eVLx2Scb54qXLYKHQhAIy8GjghcY+WNLEcnq1+AwxpJbrX8t7UoCTNy9dWt9tXhIYC
 gu059x4BEqGJQn8NorjkQMj23JRjWw+JCt3C2VXhPiRDDdJaCUGQQkk+9IaSd+gWT2js
 d7DZW1hYeQ+yJT5ibGVIxU0TAYY8+uKGnvd1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tfGb6WOVY/NDozRdyqo5VBI3IXqzYkAU2KTM1oN3JpM=;
 b=KiRhX6lV72ybALRvq/eyhcrRgyCZ3qHKvtoUCDPnhhuoC4sHPD9uDB7FmwvrVM57+s
 T5gfc3jRA8PSyr45RIKGt/9Tdj2nkCJjZMuI8CExcPeoqyH9xj5uJwclzC8r+bVIrdVy
 BBR96/1BIPjXIr+nT+O1OGBPFQ2vH1HlbModUPhRBFx7OV4/Tqo2KNlu0gChRNLReTB2
 vr/SCz2ttWuKquNNQVlb3Lej69kw6eT+0fZhb0gK5qdonzKtV++4WarGM6gvQDzp4tka
 UC9ZONzvQTaUOuE0v+2yU5+NRqTB7Z6UzGZCJxzeb3DUwwFvK8t7ejtbhN1FB3mssUc8
 vXow==
X-Gm-Message-State: AJcUuke669zXPV76MuC47uzwaESqQkrqw7LATPSNQsLrsQw9ijNI8Dtb
 X5xV4tpLyVaLPDIZC8IU4nNmOg==
X-Google-Smtp-Source: ALg8bN5zmYWSAPZjYomfF7mFoGKlUGobeKyjO/hE41V45BdXSRRWP3tXd9FVoYY6eSB/NMn3NEw4Pg==
X-Received: by 2002:a63:5455:: with SMTP id e21mr7255476pgm.316.1548360033058; 
 Thu, 24 Jan 2019 12:00:33 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.12.00.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 12:00:32 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v6 14/22] dt-bindings: sun6i-dsi: Add A64 DSI compatible (w/
 A31 fallback)
Date: Fri, 25 Jan 2019 01:28:52 +0530
Message-Id: <20190124195900.22620-15-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124195900.22620-1-jagan@amarulasolutions.com>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_120033_982092_E1441F8C 
X-CRM114-Status: GOOD (  12.52  )
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

The MIPI DSI controller in Allwinner A64 is similar to A33.

But unlike A33, A64 doesn't have DSI_SCLK gating which eventually
set the mod clock rate for the controller.

So, use the DSI_DPHY gating for the similar purpose of mod clock
so-that the controller can operate properly.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
index 69e233e8fad1..dbda2e567760 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
@@ -12,6 +12,7 @@ The DSI Encoder generates the DSI signal from the TCON's.
 Required properties:
   - compatible: value must be one of:
     * allwinner,sun6i-a31-mipi-dsi
+    * "allwinner,sun50i-a64-mipi-dsi", "allwinner,sun6i-a31-mipi-dsi"
   - reg: base address and size of memory-mapped region
   - interrupts: interrupt associated to this IP
   - clocks: phandles to the clocks feeding the DSI encoder
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
