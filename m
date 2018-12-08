Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F9BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 22:23:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3DD220837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 22:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b2JELQvi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gqr3Ddi5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3DD220837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=G+OHazz9yrlf7CLbRVovtsxY5YvEEdOSZkGuT6REwN0=; b=b2JELQviRtRWiF
	iLsrVE01reAkkkX1lduco583c9G/hKpjzCzuqQgn0lJYpV3TWU91FNt5f454oGEyIFI8o7w6Vtl/w
	Jv98x2fZapZlSN0y6/Es3CBOiy6tadToJUijQ+jad+q4/WdEPpI5tKI8Pthtm7ee5r3EfPiwAmLHt
	KFBuTeA015mMlyzvjNm4PFHF9iV7Q36XR3IwE+CjbTc3GsECzrBaExhIuPJCtj0nwOOVun741qmDy
	RNbAU1XFbInFBLqXejjZeiP6nBIGwHiFKR9BWZbZuDzjbQ1nbsa1cEHlgogyUY2QRuUBY1ySqRe8z
	agFboJoG2zgHuguYqwtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVl0b-0003eB-UD; Sat, 08 Dec 2018 22:23:37 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVl0L-0003LI-3i
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 22:23:22 +0000
Received: by mail-lj1-x244.google.com with SMTP id k19-v6so6445624lji.11
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 08 Dec 2018 14:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SxeQ2RgM6pAXInveUvpv7Wd8q2eUfyUc70lKdcQupf4=;
 b=gqr3Ddi5eve7Mgqt6oAviU0QiwfUcKg6RsGkvNBagF7lm6joI6b36sA+lr6O/wGZU4
 +yG8x7COcsUjotw1mQ4gjnHmmO/nwMu+HUF6nMRdahm369/2Hphjq40ir+YKcNmz0LJ8
 1Q81XUn4A5/Jw88BT2t96c9VJ24xozdhKulo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SxeQ2RgM6pAXInveUvpv7Wd8q2eUfyUc70lKdcQupf4=;
 b=KpZx0ijVqeCAMd4VIhnIbmk2WfxsVXX+rPXNXBA4pdOJwDL7t+pmd2JQdBwbL3W7/w
 hj11bzjKG1xzH4VBivITj1Lrvpw9/3BgQhzQjGpFIY8LA8ANbk7XFIALx8CSbOLV46wG
 fSQ0H/PF+wbFuWLhz1QBqux2nuUpWf3CrfYF/xpk2GPTKzx9cFN9FbKzyLOYlMxwvrvn
 vFZwAbnoRp9wU/wbRwtoq99mhev4IVljgDtPkqnlw/RLJfhzdgEeHcyyYnER/usApLAs
 4ccd4hXhI2enCPyUut7Krfvt3ztxW8hrC1xFhc1dD6irDDCzoQBlih8ksb6qIiGfL3Qj
 71ng==
X-Gm-Message-State: AA+aEWbxpwcRArpjozzYqHSphDeob1wPqLfvCG99I4QQ8LIl39VKw4Zf
 qjG5r051JINdq817b7wT0uvBRfWUNTxUOw==
X-Google-Smtp-Source: AFSGD/U+hJ2NsiGfQxYeUWT9OOyEHlDyZhVIi5OrXDysa2Dh437HA7JmYFb9CG53x9zqRQ/7GHC0sw==
X-Received: by 2002:a2e:21a9:: with SMTP id
 h41-v6mr4026847lji.103.1544307788291; 
 Sat, 08 Dec 2018 14:23:08 -0800 (PST)
Received: from localhost.bredbandsbolaget
 (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id b69sm1310884lfl.28.2018.12.08.14.23.05
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 08 Dec 2018 14:23:06 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
 Hans Ulli Kroll <ulli.kroll@googlemail.com>,
 Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 1/5] ARM: dts: Fix up the D-Link DIR-685 MTD partition info
Date: Sat,  8 Dec 2018 23:22:57 +0100
Message-Id: <20181208222301.5303-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_142321_204791_C74B7CB8 
X-CRM114-Status: GOOD (  15.13  )
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

The vendor firmware was analyzed to get the right idea about
this flash layout. /proc/mtd contains:

dev:    size   erasesize  name
mtd0: 01e7ff40 00020000 "rootfs"
mtd1: 01f40000 00020000 "upgrade"
mtd2: 00040000 00020000 "rgdb"
mtd3: 00020000 00020000 "nvram"
mtd4: 00040000 00020000 "RedBoot"
mtd5: 00020000 00020000 "LangPack"
mtd6: 02000000 00020000 "flash"

Here "flash" is obviously the whole device and we know "rootfs"
is a bogus hack to point to a squashfs rootfs inside of the main
"upgrade partition". We know "RedBoot" is the first 0x40000 of
the flash and the "upgrade" partition follows from 0x40000 to
0x1f8000. So we have mtd0, 1, 4 and 6 covered.

Remains:
mtd2: 00040000 00020000 "rgdb"
mtd3: 00020000 00020000 "nvram"
mtd5: 00020000 00020000 "LangPack"

Inspecting the flash at 0x1f8000 and 0x1fa000 reveals each of
these starting with "RGCFG1" so we assume 0x1f8000-1fbfff is
"rgdb" of 0x40000.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/gemini-dlink-dir-685.dts | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/gemini-dlink-dir-685.dts b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
index 6f258b50eb44..502a361d1fe9 100644
--- a/arch/arm/boot/dts/gemini-dlink-dir-685.dts
+++ b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
@@ -274,20 +274,16 @@
 				read-only;
 			};
 			/*
-			 * Between the boot loader and the rootfs is the kernel
-			 * in a custom Storlink format flashed from the boot
-			 * menu. The rootfs is in squashfs format.
+			 * This firmware image contains the kernel catenated
+			 * with the squashfs root filesystem. For some reason
+			 * this is called "upgrade" on the vendor system.
 			 */
-			partition@1800c0 {
-				label = "rootfs";
-				reg = <0x001800c0 0x01dbff40>;
-				read-only;
-			};
-			partition@1f40000 {
+			partition@40000 {
 				label = "upgrade";
-				reg = <0x01f40000 0x00040000>;
+				reg = <0x00040000 0x01f40000>;
 				read-only;
 			};
+			/* RGDB, Residental Gateway Database? */
 			partition@1f80000 {
 				label = "rgdb";
 				reg = <0x01f80000 0x00040000>;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
