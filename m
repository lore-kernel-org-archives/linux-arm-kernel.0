Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A446C64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:27:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E968920851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GPZb4y+j";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjxfy4Zx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E968920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=G+Mmr7KK0LTL7oDHULHhQrm0Kto4/Bv6oUgkSkEStEo=; b=GPZb4y+jVqeOQcXA8CDbILcH7y
	wjnTP7s/ouhQstO893k4KCsy0VvAWcfLEHPU6bx6jkfWuvk4Wb1QtmsKEvz9dkQXiRGhkI1lI8tVg
	ThChAIDKQnid4m7hlE3IB5wlPAbIknyfob+TWDRnIrmCtOZv4om8T6OAEICU7kaR3D2akassTbT7n
	ERWuSPqg8F6GDkbaxUrePbddmu+fju4nrtlooYXO3V7rBD+8Ksb1m3dQg0eAAcbgSS6FHZAHq7p/l
	NKOO3Evby/Elcah+RboRM36GJR4JIa+RbejBadA17UHeZadpWmUDRT5ZVzFDpVMO2y1nX5djhOtD3
	Z7GU/OYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTYKe-00061j-Up; Sun, 02 Dec 2018 20:27:12 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTYID-00028p-TR
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 20:24:48 +0000
Received: by mail-wr1-x443.google.com with SMTP id u3so10054181wrs.3
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 12:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0dF58WahZEvNWNI14RwNxBlOsuvWUlXAKVfNdqdb48I=;
 b=bjxfy4Zx1SjlZDb5rL/xrvQHQET/ZFAd+Donf4xWLce8TAsWEv4j9eLj1rli6nKwHW
 Y2uWkSWVCCAn62qPiTFZw+SZlhn5PLRyNIXcmq5lUHhQgwUPVKbB9dhZNPC75l6/z9j4
 y+B8JNAl09+IxsGVg1dILhEYPYBbDjfjM2w0+aWxrTkqmGXzCWWKA1FNn29RDpTJChDp
 2f8xJeLyT0HTxenEeYKGTyzzlOmOqsnJcGWGC6pKiQrxyFSYbMb/8oR45xM47gljmYHN
 Qgl3X+s27T7lpz+LgQT6HGHON5bkZHnDj2+H3FlffBUL2xfnnf1pxDftSz7RyiCXJ/77
 /o1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=0dF58WahZEvNWNI14RwNxBlOsuvWUlXAKVfNdqdb48I=;
 b=JXNRBiwjXtwtqK9dxmKRFFjrkHi34jtC9PKcfjIX8nmIk4JVOXp602iObVNc7l4xs4
 Siu//m9CBKqgNVH2VcOo3V0ooFIBKf+B0JODoTjgOmVQbW1Ok61hjq4pYn+dy5olKcmg
 cepZK82FtMQ2l+bsJMs64H5GVoLtBBMY6HJpAmu5UEtgDzMZ3sBmJ2pdNgDgV08gF/WM
 xHT7LacIPFCO29YMcG/9K0jRoYRtJUuLehPI6PYGuQve5UaDCARcCyIog595ZqPCDtXM
 XvnIxCOmSj8n57/EphLtrMhWaHI+10aez54sknTjleLzIjXu7I6SNMPWdFJsNTH9eyiQ
 A1+w==
X-Gm-Message-State: AA+aEWblZTO/EOKmCyt2t+Bklm/XT9bp3rCv5dX58u3e6iEx82g50f4K
 lGi0qoBd9oqX7PRkbJv+87MK/YEbq58=
X-Google-Smtp-Source: AFSGD/UIBMpoEYOixHcQIADhaHNr5OeWHuua7IJ0G0x5OlPs1bOGAvxLi6k5dK31vLPTSh1JVyZd6g==
X-Received: by 2002:adf:891a:: with SMTP id s26mr11571809wrs.44.1543782275282; 
 Sun, 02 Dec 2018 12:24:35 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
 by smtp.gmail.com with ESMTPSA id l3sm14451510wma.44.2018.12.02.12.24.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 02 Dec 2018 12:24:34 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH v6 14/17] dt-bindings: sram: Add Allwinner suniv F1C100s
Date: Sun,  2 Dec 2018 23:23:48 +0300
Message-Id: <0b60c924d30ce3e04325214789de2c5b0403a056.1543781680.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543781680.git.mesihkilinc@gmail.com>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_122442_892311_E45BC247 
X-CRM114-Status: GOOD (  10.79  )
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
Cc: Mesih Kilinc <mesihkilinc@gmail.com>,
 Julian Calaby <julian.calaby@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Marc Zyngier <marc.zyngier@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Icenowy Zheng <icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The suniv ARMv5 F1C100s chip has similar sram controller to sun4i A10.
Add compatible string for it.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sram/sunxi-sram.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sram/sunxi-sram.txt b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
index 62dd074..5c84850 100644
--- a/Documentation/devicetree/bindings/sram/sunxi-sram.txt
+++ b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
@@ -19,6 +19,7 @@ Required properties:
     - "allwinner,sun50i-a64-sram-controller" (deprecated)
     - "allwinner,sun50i-a64-system-control"
     - "allwinner,sun50i-h6-system-control", "allwinner,sun50i-a64-system-control"
+    - "allwinner,suniv-f1c100s-system-control", "allwinner,sun4i-a10-system-control"
 - reg : sram controller register offset + length
 
 SRAM nodes
@@ -58,6 +59,9 @@ The valid sections compatible for A64 are:
 The valid sections compatible for H6 are:
     - allwinner,sun50i-h6-sram-c, allwinner,sun50i-a64-sram-c
 
+The valid sections compatible for F1C100s are:
+    - allwinner,suniv-f1c100s-sram-d, allwinner,sun4i-a10-sram-d
+
 Devices using SRAM sections
 ---------------------------
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
