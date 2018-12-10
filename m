Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E80C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:21:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CF5C2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tmpRs6Ty";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YF3sJk2r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF5C2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Izq6e5uA9wBOZ8k5fc5yov4Du23UAkytZzAGHxZzoHU=; b=tmpRs6Ty80Iegu
	K4CV6C/0A6b/SieV7VVHQWQynL+4EtNCTM6dExPNKHd3ljwcDE3hGEzuOq6I3x85zaMFL3ufNjkTA
	VDmVY2HkZ9KwiNaZ3xfc6bJGJU6I6lNY0iH+NxodTGPA0fAkdZjvHaToSAAbVvYsPep3bSs2Hh3+u
	X5uq3GKL4VuqK4r2dbPTiQ25QekMCgzfsYbzefQFCUm0JuZeNHMB9vCSMv09/xf5X2Nh6ECgPQn5f
	sJTwSvrP6e03TulfD/qL9CYVAdW8NfTq/M9JmdSYE/l0LyNq77UMOrJRl5VzqGhWEMx4EZDd9Ysz3
	zsUacI/8rlxns+WDhQbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOIp-0003gF-EN; Mon, 10 Dec 2018 16:21:03 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOG8-0007p8-F4
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:18:21 +0000
Received: by mail-wm1-x341.google.com with SMTP id g67so11837524wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 08:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0A16quYt+swrquBMzw4Px8WMyAYxU03soI2v/Bfgb1A=;
 b=YF3sJk2rubhEazU2ITO1ZU+iTOrr+E5kT9wdu2ixC/aNx3jRrsdVG/2WpQLVD7SFv9
 x06odRqVx9/4OBPP6uv8S0TTYoO80v57K8Ubf7WIXDiFtUq7zLE442UUdgNRoSeCDlJV
 YbmTAWm+nTXXDjGe30+BwZV3cxtoLv/Erft5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0A16quYt+swrquBMzw4Px8WMyAYxU03soI2v/Bfgb1A=;
 b=rapmqDkVEJcLa8g152IUyK7zsKE6J0nbSdNj3dnejyasI3MnL2nMIehk7gZocoesqh
 zui5czaZsu9zPnVkuqj91k622NHXy1zlr8/d6XRMrWTiO3/n1W0yGRYbtwfNWZiGWf4S
 ZiWusYL4NJIYTOwbcXRSB4TWkCnhwMzEY4nG6M3TCyqg3x+YZikmHaipMCUixcosgvxF
 vTyk6+mZElvrCIbLT5Grk/hHtk4nzcrGPd+CvddZFrba5j/bcbMiO7ilKJFzkbloa5TT
 DhzFVZ7G/OQfUjAwI8wEmzwHJsyuKySsEty82gt8SnQPd9Pg7XCkVnJJAa8JpLwG8alf
 xwLQ==
X-Gm-Message-State: AA+aEWYvCetiPH91srLv3VbKVfUIoXyKa01C2RhJWQCPpGD33+dDzJTH
 KnK7XVwLhUMgKJ+mogtlq3iIXQ==
X-Google-Smtp-Source: AFSGD/X4P2P8IWz19Jw4ghafGW1XCdsWJRT1xawLts5BHe68/7lQ0SenyM2uKUJlIk2b3q5hqzzE8A==
X-Received: by 2002:a1c:1707:: with SMTP id 7mr11448132wmx.150.1544458688215; 
 Mon, 10 Dec 2018 08:18:08 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com.
 [213.198.162.59])
 by smtp.gmail.com with ESMTPSA id b13sm8397503wrn.28.2018.12.10.08.18.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 08:18:07 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v5 14/17] dt-bindings: sun6i-dsi: Add VCC-DSI supply property
Date: Mon, 10 Dec 2018 21:47:26 +0530
Message-Id: <20181210161729.29720-15-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210161729.29720-1-jagan@amarulasolutions.com>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_081816_589089_698C4F3D 
X-CRM114-Status: GOOD (  11.90  )
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

Most of the Allwinner MIPI DSI controllers are supply with
VCC-DSI pin. which need to supply for some of the boards to
trigger the power.

So, document the supply property so-that the required board
can eable it via device tree.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
index 9fa6e7a758ad..adc7cdf129dd 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
@@ -28,6 +28,9 @@ Required properties:
     first port should be the input endpoint, usually coming from the
     associated TCON.
 
+Optional properties:
+  - vcc-dsi-supply: the VCC-DSI power supply of the DSI encoder
+
 Any MIPI-DSI device attached to this should be described according to
 the bindings defined in ../mipi-dsi-bus.txt
 
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
