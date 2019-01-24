Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B74C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:08:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76E962082C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qoB7aFZO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RXlY0lhB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E962082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iJkVrAbakoBZGYa4GZGoYhzeVjlFTZAjchsV3RPdVfw=; b=qoB7aFZOk3r/o3
	BTWiNbK7ylU229vZwkbmjNHaNhoS5PTw/nYnnM/Rlp42Vtt3S4K/rB6KFBn1tYMc/X/5Z1pzmRJsN
	Flej3iIG+AkjSYC3FHeJ6e5QCJyRFenm5WcUvr+DlHcu1eOBGh1KqstV1zSRB6n7qqLGgJV6xcE0S
	irqewcl89b/fjJfswW3sXlPXYJl9AYV+Nw+GR3zmI582WX6ZXF7rwujlU23NitFkIOOcI3mUd5xRE
	ctrFfMUJ2u4X/8LMWfvrU4nJGoCBef8TOhgS723FIkXyxoJHhv2Cr+iiIuVU0ooWAsuI7596tVj8P
	r75t7r8KTG0ThPo6XrGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmjQb-00022z-BU; Thu, 24 Jan 2019 18:08:37 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmjQM-0001oE-Sl
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 18:08:26 +0000
Received: by mail-pl1-x643.google.com with SMTP id b5so3241982plr.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 10:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wXbv4EStlt/WSU+EIZH0OlN5Zo9WGSHjVKnuaGSJ7JI=;
 b=RXlY0lhBeHHAfn1ZoEusdajsMhzMKtu8DlU+tEnR82ZIZCqeXz6LcVt1IHozsnbtKp
 afu/I4bhUGnXxfMDmRxvGmplqN8cQw6gBwXY3YE9GMDpdT11tVyftqCsYuE3CLzia+wK
 JGevvUAuOr8KTHXi/HWznqW37CXxuwGWLsdCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wXbv4EStlt/WSU+EIZH0OlN5Zo9WGSHjVKnuaGSJ7JI=;
 b=PpJascZcFin2t8NSoUpVpRa7dSoW+st9juaAc40rkxxSRQTUlepv1knUN0M8zsXIit
 MSQfJoMK2xsDtxnv3VosnKz7JQBXQfoQsNxuCZqEAoK8UPoLEbzbKbQAxdbFKzgTa+Bk
 pu4Wwr1VJQ2Q9CA7z/+P7GmEZyac47xAuOVRirz469BPuI9M//rCCTpnww3pUnAiVsxM
 4PxFWA2owPHYXjjPC54teuMDWVr7ay8e0hbzWMb2ryxlv3itRkARoHdusRePOatOeg1d
 MkXHlSZiHfiW9rtyEkjDEJS9xiSjzywP7+RIedT9x2SX5M7YpPMGRBIBZDxwCw2vokAP
 uFeg==
X-Gm-Message-State: AJcUukcvK1ZGAh+aMv13ymmiGt+gI99IrTLDBso82MFFzhgtCoCJYiLS
 c0Wn36sy+aSBW4xH+QtUhSewGw==
X-Google-Smtp-Source: ALg8bN5bdO/M10wWvWnvl5qVQWRmF2XjjMq2zxObQuRH7GwYHUUTnLpTB1Sr481ExOEyNaw7/hrmqw==
X-Received: by 2002:a17:902:654a:: with SMTP id
 d10mr7393226pln.324.1548353302040; 
 Thu, 24 Jan 2019 10:08:22 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id k15sm36141551pfb.147.2019.01.24.10.08.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 10:08:21 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v7 1/5] dt-bindings: media: sun6i: Add A64 CSI compatible
Date: Thu, 24 Jan 2019 23:37:32 +0530
Message-Id: <20190124180736.28408-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124180736.28408-1-jagan@amarulasolutions.com>
References: <20190124180736.28408-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_100823_317008_7924D05F 
X-CRM114-Status: GOOD (  12.19  )
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
 linux-sunxi@googlegroups.com, Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Allwinner A64 CSI is a single channel time-multiplexed BT.656
protocol interface.

Add separate compatible string for A64 since it require explicit
change in sun6i_csi driver to update default CSI_SCLK rate.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/media/sun6i-csi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/sun6i-csi.txt b/Documentation/devicetree/bindings/media/sun6i-csi.txt
index cc37cf7fd051..0dd540bb03db 100644
--- a/Documentation/devicetree/bindings/media/sun6i-csi.txt
+++ b/Documentation/devicetree/bindings/media/sun6i-csi.txt
@@ -8,6 +8,7 @@ Required properties:
     * "allwinner,sun6i-a31-csi"
     * "allwinner,sun8i-h3-csi"
     * "allwinner,sun8i-v3s-csi"
+    * "allwinner,sun50i-a64-csi"
   - reg: base address and size of the memory-mapped region.
   - interrupts: interrupt associated to this IP
   - clocks: phandles to the clocks feeding the CSI
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
