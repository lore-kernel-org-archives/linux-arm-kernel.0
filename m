Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400F1C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:47:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 134E62086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eP3kJZ3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134E62086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e3NuoZ3Cio737bKZDVzeARnbMU7a91fWbZbNxJckljQ=; b=eP3kJZ3SMyUdn7
	Ufb6UPI+MGL69ZMHU6JXbp0AqyBfZPF48MZgbGXyb9wNUUMgkF9vP1QeyPKjt6uqQWJQ/i37REXLw
	1oWYrqTXA838dIum4fTYGAf+hlK2DJI4ND8VeeFZN7NTg+Oxjjno6rvGNHUIUFIovKyuyNRSGYlRV
	9icsE08pjyhK2TTf3grTIs+JiXa/yoi7EN0/3TYEXFqAKJxfHsUGN66pv3Mjzo6o0EO56Whhtq/PT
	GHvPbxsi03c67Lt8BQVrJANb485tAAMnIFoNEIA48FJqFbzdoawJUvl6NAmNOVxSdKFEBUJz2/Eih
	5YyFK/wMOWpvpSA0xuOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpBky-0005ZK-Uu; Thu, 31 Jan 2019 12:47:49 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpBkg-0005Je-Bg; Thu, 31 Jan 2019 12:47:36 +0000
Received: by mail-qt1-f193.google.com with SMTP id d19so3225925qtq.9;
 Thu, 31 Jan 2019 04:47:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:organization:content-transfer-encoding;
 bh=DOY0na8Wg7iyK4mJ/SZnMyCR5yw4bav4pLPRTRGmFrg=;
 b=fTtiztswNeTjDJM3YMKRZcdOz75DAyGymbD+Axe2cqNhAf4mQ3LwarGyuchCJeUnhI
 ZlpS8O85CxyGvkJ3vaSAmzLSrrr+lJ9gZpr0kF7hXdOZDCHqGdfCNX78G5VVweibvuIE
 QPgz/v2ZvE5r8qTrW5M6sjL/pVlFdqu1qSz3oQnho9yfZxg3qGC9vdvEaQnm6C8NnCSJ
 BpE4lNA8FKr/IGNI8hiCUfIRi9dkINeqoBvF7E3rJfJpLwPu3mg274q5uyC8GzcfkYoG
 SfhReL7PlYVx0SwaWsQg82gJ9S+pNidZEPZHxe9uTBzst/dpA7knzA6OpPLCl13GUD4m
 +Svg==
X-Gm-Message-State: AJcUukcAEeFnpc5HGFWmTemcAXUuHqvQJcrOaa3tZ57oqRFKvj5/Umjc
 jFB0cWt2crWF+k2qw0vCqpEDsBN+
X-Google-Smtp-Source: ALg8bN6ZFd7Wi+q3Xu4AZh7PdCMFxAFu+vydlguUiIFOCGI22nIgqT5+2P09Nq3yMWONZazJQ6WA7Q==
X-Received: by 2002:a0c:d065:: with SMTP id d34mr31290726qvh.209.1548938848924; 
 Thu, 31 Jan 2019 04:47:28 -0800 (PST)
Received: from localhost.localdomain ([181.220.86.121])
 by smtp.gmail.com with ESMTPSA id y68sm2886835qkd.49.2019.01.31.04.47.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 31 Jan 2019 04:47:27 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation);
 Thu, 31 Jan 2019 10:47:21 -0200
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/3] ARM: dts: rockchip: rv1108-elgin: Use the correct
 regulator properties
Date: Thu, 31 Jan 2019 10:47:08 -0200
Message-Id: <20190131124710.30238-2-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131124710.30238-1-otavio@ossystems.com.br>
References: <20190131124710.30238-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_044730_815555_60940664 
X-CRM114-Status: GOOD (  13.11  )
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
Cc: Jason Zhu <jason.zhu@rock-chips.com>, devicetree@vger.kernel.org,
 Heiko Stuebner <heiko@sntech.de>, Otavio Salvador <otavio@ossystems.com.br>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-rockchip@lists.infradead.org, Tony Xie <tony.xie@rock-chips.com>,
 Vicent Chi <vicent.chi@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Philipp Tomsic <philipp.tomsich@theobroma-systems.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following properties:

- regulator-state-enabled
- regulator-state-disabled
- regulator-state-uv

are not valid ones as per
Documentation/devicetree/bindings/regulator/regulator.txt

Fix it by using the correct properties as per the dt bindings.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

Changes in v2: None

 arch/arm/boot/dts/rv1108-elgin-r1.dts | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/rv1108-elgin-r1.dts b/arch/arm/boot/dts/rv1108-elgin-r1.dts
index 66688fdf4fd8..1c4507b66fdd 100644
--- a/arch/arm/boot/dts/rv1108-elgin-r1.dts
+++ b/arch/arm/boot/dts/rv1108-elgin-r1.dts
@@ -85,8 +85,8 @@
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
-					regulator-state-enabled;
-					regulator-state-uv = <900000>;
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <900000>;
 				};
 			};
 
@@ -97,7 +97,7 @@
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
-					regulator-state-disabled;
+					regulator-off-in-suspend;
 				};
 			};
 
@@ -106,7 +106,7 @@
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
-					regulator-state-enabled;
+					regulator-on-in-suspend;
 				};
 			};
 
@@ -117,8 +117,8 @@
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
-					regulator-state-enabled;
-					regulator-state-uv = <3300000>;
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
 				};
 			};
 
@@ -129,7 +129,7 @@
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
-					regulator-state-disabled;
+					regulator-off-in-suspend;
 				};
 			};
 
@@ -140,7 +140,7 @@
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
-					regulator-state-disabled;
+					regulator-off-in-suspend;
 				};
 			};
 
@@ -151,8 +151,8 @@
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
-					regulator-state-enabled;
-					regulator-state-uv = <1000000>;
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1000000>;
 				};
 			};
 		};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
