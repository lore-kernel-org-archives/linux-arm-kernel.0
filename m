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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD0EC64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:24:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7103B2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="djca53dd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsWJOX1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7103B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=hFuBIMejxIfISR/NW4FRPToiNKYkxoaYs9WNwaktc0E=; b=djca53ddUsO+pdZC5C5iOGMopT
	GfgGFhOMAqaFitFTsJc9UmLKMaoOnVmgw6EYX6HYS4MwG6Ey3x5c0c9h329QljGuFbI4LDPKiRRp7
	J25fnXEAlLF2UUpaqi4m6Kxr2AJ9Hc0nwHCZWmTEmm0+8KTYO0ylhIbI1EVjfA796TuJQW6uI6ojC
	SXjDkcTbfsExeawaFFLOx67NJVj/nxVJgCCCo9jHXA8BEsygfHBERd7/1nQi3bluIFcSdQqw5Zw8T
	Gz84nHGLq1vwCiBAH6/YloVfrgJELROd39iCEufSg+jAbcf0p2V66htkw3nslODh0UhYrSEfjfueO
	vsOrpBlw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTZER-00036m-Aj; Sun, 02 Dec 2018 21:24:51 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZDS-0001u1-L0
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 21:24:01 +0000
Received: by mail-wr1-x442.google.com with SMTP id t27so10142710wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 13:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PgAUgZMYJZIjzRzJK9ypNa/fl9KY0ic1eUS2w2DfDF0=;
 b=KsWJOX1kMXTN80csaT5pPTEjQrx3VGGFOkan/bulTcciI/fs5Gd6Bq5+7MQj/EhBzG
 ZDV/X3f3cbWYzoiJlkztlQRKq0Asn1DSH/gkWPRtM/REYGHD83t5J5dAB2jxKSXf/0m9
 8lWqSdRt0o1t/T3LlI9KNbR3ouNNC3ZEtXXAHEA1ufpIZrEPkG+V3Fzq5BylH4EMIXKZ
 Aug7gujK8oWxHBJXSENhl7yIisztp4XT32LhhBOW7LkpXcjJj+q33NGJCJpPkUHDvjZ2
 1pn2GggsZiHum3TZZBMFwSKr7KWd6NM03165FhwUH246TmUcPJX9+XeckNHCU/obweW7
 Xxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PgAUgZMYJZIjzRzJK9ypNa/fl9KY0ic1eUS2w2DfDF0=;
 b=eXi4rMLeLnbDS5jtB8XC05qp7z6UFLUxR2lqyYZhJ55ModrSpWT6HG4szJMbKUKtTd
 HO5PJb4JPZf+39Mh/FlRO5mcqmme4iT9+KUB20geQVluWoLR30s1TsfahDPSgHi4iR/B
 BXH9cB5ECoMPMUFAhHDENB7uFxQl9qy3bBSqhe/Hp1OZmyL0hJjEWTpNnXWEAIedCy5R
 SMcdo+dSghiGYEwNlJETwmh7RYPQCDB6mqcI6zHyrGlWVk5pja5mpOYI/ReeFH+b5LAR
 n9MgDK77T8l35jJT9QgaSZUbTzl4OKIRP1ZD++LqQVLLow8kKUQSmkwvdKfGt0HlX0RT
 ScGA==
X-Gm-Message-State: AA+aEWan66C/oQYv3QOAOAPcaiwohwcyqi21zaFO/Enh+HjB0/jo0np9
 h+qT+XnHrSIqifsot+vH7LQ=
X-Google-Smtp-Source: AFSGD/VGtijuXWwQ+C02/bsi4yr+HAVA7HQj8jMz2mHPV6Dge5x2BZL/rumzO+6MJvMGiSAsX1ag2A==
X-Received: by 2002:adf:d4c9:: with SMTP id w9mr11737329wrk.119.1543785819180; 
 Sun, 02 Dec 2018 13:23:39 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
 by smtp.gmail.com with ESMTPSA id d2sm9551043wrs.97.2018.12.02.13.23.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 02 Dec 2018 13:23:38 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-sunxi@googlegroups.com
Subject: [RFC PATCH 05/10] ARM: dts: suniv: f1c100s: Add support for DMA
Date: Mon,  3 Dec 2018 00:23:12 +0300
Message-Id: <7978afbd9bb4a114e84df44c129d86e784659915.1543782328.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543782328.git.mesihkilinc@gmail.com>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_132351_421358_31DC4D56 
X-CRM114-Status: GOOD (  12.71  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Mesih Kilinc <mesihkilinc@gmail.com>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Allwinner suniv F1C100s now has DMA support. Enable it under device
tree.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 arch/arm/boot/dts/suniv-f1c100s.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/suniv-f1c100s.dtsi b/arch/arm/boot/dts/suniv-f1c100s.dtsi
index aff5f90..4c96a9e 100644
--- a/arch/arm/boot/dts/suniv-f1c100s.dtsi
+++ b/arch/arm/boot/dts/suniv-f1c100s.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/clock/suniv-ccu-f1c100s.h>
 #include <dt-bindings/reset/suniv-ccu-f1c100s.h>
+#include <dt-bindings/dma/sun4i-a10.h>
 
 / {
 	#address-cells = <1>;
@@ -65,6 +66,16 @@
 			};
 		};
 
+		dma: dma-controller@1c02000 {
+			compatible = "allwinner,suniv-f1c100s-dma";
+			reg = <0x01c02000 0x1000>;
+			interrupts = <18>;
+			clocks = <&ccu CLK_BUS_DMA>;
+			resets = <&ccu RST_BUS_DMA>;
+			#dma-cells = <2>;
+		};
+
+
 		ccu: clock@1c20000 {
 			compatible = "allwinner,suniv-f1c100s-ccu";
 			reg = <0x01c20000 0x400>;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
