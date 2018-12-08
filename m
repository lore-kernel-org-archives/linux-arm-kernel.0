Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF4AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 22:25:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B54720837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 22:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hcrmTBFn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AeNFeV1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B54720837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ssyA6qTT4yEWR1Jhwxehj3pL/b0TycXoBLptrNaV5Qw=; b=hcrmTBFnuYdrJ4
	oRsI9M0E50A661cIOKmnDhSjxGSFTiuXuxKAhydpcV9PTHiQa0g41sTq5plsdCHwd8ZUz/vJ4uXBj
	dGdJfAUh0Wd5yQUZZ6/yW13p7IOZt6gVapQEBHnbAoH9H7WGgFaYjEbeY5mtqJt9H8/Q/zuvqSpJS
	0sEoJOEUXsTPtvHr3PDf3a1KsphVOCTfzEHNZGbT8+q8B6TNd7/WA0pWz3vIBM1ZKOg4iVHTA+Xw5
	MuKPjLVi/qK0bzm4QQ+SCyCS/u+gMHegLXQweprtJffsokShZEYMkj3JegjVKQgKm9ZONhtW8wwmH
	9giteN47kjyDHRv13peg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVl22-00051S-0I; Sat, 08 Dec 2018 22:25:06 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVl0O-0003Lc-0R
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 22:23:27 +0000
Received: by mail-lf1-x141.google.com with SMTP id p86so5461460lfg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 08 Dec 2018 14:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AKeMSKov7AHQwHfd85g+W8Oq6xXcT+CwfQ8H/UQOhg4=;
 b=AeNFeV1zmCfVKzsgvqoQGMJJgjLpmYv/wBWFrxYIJHLVuQNOO4hu6pGNV9nG89sp+T
 5/0yBMpDXJGPpbfREVjVRr0OTEjPOipfHvYSHp483ui9oipAX+IOh3WJdynn8MzrFozg
 bebrhiXFPzVG/02yrP+i3Z+xn5CGKHzR/5vlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AKeMSKov7AHQwHfd85g+W8Oq6xXcT+CwfQ8H/UQOhg4=;
 b=ZAEd+HGad2ENpyzB7X2VUn3cQuAmN5GLUrn4QfuqAqnp7v908E91tYHXPaVNsySV/A
 Qkn0bxoASsgfZhTMTAVfq1v0Ty/i+G85Ca6yeXKZhoIc2V++b8y3CunHuR76W46VCfCA
 pPEBtmeLt38bE1lUR0ZnUqrV3yHWOcs6lFYtVfzR6UgWkYuuc+135Rrhw8VyIlTGIDL1
 PItJALdLKQKLMxPl3VYjoch4Leoyywxcb6cZcTJOOrLAIOvW4zWCFf/uizwEi2a4AB9q
 /gkuz8ut+5vS1fYlW0dPUbX1LTMFrWJqpsOCQ/NlaeWQxt6nMorCOttuzBKwleP4BMQf
 4YFg==
X-Gm-Message-State: AA+aEWbJ3GSr7tqRxmyNM42DuviiqmtKrCPZPtqtf+/JVMQ6c0RL41Kd
 l5Ks5isDgBVEnHm1iZDogUQVR2atM/7kgg==
X-Google-Smtp-Source: AFSGD/Xwkuf1HnFBEA0R/zGio6K6R4GEZl+L7uNmrLUq7sfCdvLEyeoJ+OZv+vj9MODCttIAnIDhZg==
X-Received: by 2002:a19:5402:: with SMTP id i2mr3791457lfb.128.1544307793221; 
 Sat, 08 Dec 2018 14:23:13 -0800 (PST)
Received: from localhost.bredbandsbolaget
 (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id b69sm1310884lfl.28.2018.12.08.14.23.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 08 Dec 2018 14:23:12 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
 Hans Ulli Kroll <ulli.kroll@googlemail.com>,
 Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 3/5] ARM: dts: Fix up SQ201 flash access
Date: Sat,  8 Dec 2018 23:22:59 +0100
Message-Id: <20181208222301.5303-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208222301.5303-1-linus.walleij@linaro.org>
References: <20181208222301.5303-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_142324_110444_0844E249 
X-CRM114-Status: GOOD (  13.78  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Linus Walleij <linus.walleij@linaro.org>,
 LEDE Development List <openwrt-devel@lists.openwrt.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This sets the partition information on the SQ201 to be read
out from the RedBoot partition table, removes the static
partition table and sets our boot options to mount root from
/dev/mtdblock2 where the squashfs+JFFS2 resides.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/gemini-sq201.dts | 37 ++++--------------------------
 1 file changed, 5 insertions(+), 32 deletions(-)

diff --git a/arch/arm/boot/dts/gemini-sq201.dts b/arch/arm/boot/dts/gemini-sq201.dts
index af4be6ecb02c..c5bb24102b75 100644
--- a/arch/arm/boot/dts/gemini-sq201.dts
+++ b/arch/arm/boot/dts/gemini-sq201.dts
@@ -20,7 +20,7 @@
 	};
 
 	chosen {
-		bootargs = "console=ttyS0,115200n8";
+		bootargs = "console=ttyS0,115200n8 root=/dev/mtdblock2 rw rootfstype=squashfs,jffs2 rootwait";
 		stdout-path = &uart0;
 	};
 
@@ -131,37 +131,10 @@
 			/* 16MB of flash */
 			reg = <0x30000000 0x01000000>;
 
-			partition@0 {
-				label = "RedBoot";
-				reg = <0x00000000 0x00120000>;
-				read-only;
-			};
-			partition@120000 {
-				label = "Kernel";
-				reg = <0x00120000 0x00200000>;
-			};
-			partition@320000 {
-				label = "Ramdisk";
-				reg = <0x00320000 0x00600000>;
-			};
-			partition@920000 {
-				label = "Application";
-				reg = <0x00920000 0x00600000>;
-			};
-			partition@f20000 {
-				label = "VCTL";
-				reg = <0x00f20000 0x00020000>;
-				read-only;
-			};
-			partition@f40000 {
-				label = "CurConf";
-				reg = <0x00f40000 0x000a0000>;
-				read-only;
-			};
-			partition@fe0000 {
-				label = "FIS directory";
-				reg = <0x00fe0000 0x00020000>;
-				read-only;
+			partitions {
+				compatible = "redboot-fis";
+				/* Eraseblock at 0xfe0000 */
+				fis-index-block = <0x1fc>;
 			};
 		};
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
