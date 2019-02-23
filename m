Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB7BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 23:05:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C8B0206A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 23:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MfKIZUF8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gq0hKRPX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C8B0206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=9qLlLAOnDhPuGVL4c1uBJu6oSmtbkLL+M6sgMK4BC7k=; b=MfKIZUF88XgjWK
	7kxWeZ7Obwg12S9yUFnJvRRZuL0uCsO7VbWgAsmJLRdWRtldI+RZGHL9m1Q0DfPjBr0OuGHszz55x
	bR2wK6Axj9Y/ggh1ajh2T3DHXgbfWa+mnMpO9VAlQyGv12jCaraVviB5kq35yj38EJSHclmSolAaF
	gOiiALQV2BVEtZVmqjPMHFX4snNn5aolGJOnyg9SrWObs4CB+GF6gVkxWyuDEwWzZl+qTKIS3cz6Q
	3ZyeSWlb3OZCBrnmRHCQnkpvFh+iNPGwc9d6+SqVbuvXWpJxY3yfSCpcG3ikYU1HOpIJQe19+OKgE
	H9pkocAvHUPyZJPgrTJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxgMV-0002kq-94; Sat, 23 Feb 2019 23:05:39 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxgMS-0002kN-8c
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 23:05:37 +0000
Received: by mail-lj1-x241.google.com with SMTP id w6so4453073ljd.7
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 23 Feb 2019 15:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WpiXH5h64M3sk/a6xEnem5MFSQhTbjPz6ug7lC3/Jo8=;
 b=gq0hKRPXa7ZSFOYbyf/FLp3V465UN+FWMkkGZbS9q0mzjC11yJX3nBKNBt/m3to+9o
 xH0RXyq5OULQf7qkSRjOZC6sRg5EBqSX8Gz8jTXIhis1I0HZh/rBnW18t4wqEWxMvRZb
 0DRRY/fafb5V8305LUHW5qGi/RCm1r8DWXAIfZTjtCxgL2PS3VSBM5Wgewj3A6oh1jwd
 lzGMFYfulN0SGUVFO60rAqzKcyS4U5yFR6b8iORQ5zSoMtEhrASjxBB0mbiiZ8Z4aU//
 svHNk/H6kMdl+ioKME2hbh1CSwymkUdfSpTcyTuZa3RJ+2D5PzZ3zWs+zBhQ/Cm+BiTK
 /IEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WpiXH5h64M3sk/a6xEnem5MFSQhTbjPz6ug7lC3/Jo8=;
 b=Qaag1n1kDdQosg30NFQIBeoyPC/BPK9B7LDUeHZs3hPX10bwuxB+RWpKQTbqAs0VBK
 wlgMZcwl3EKgfPspVVc7Ikb7Z5S+aFYbXMObSLl1ajnhyyVNPOYkMKedaWz8WTxOWAcR
 ggiioVtgnrlaxrqSFPnrcjPxPxw/OEZRxjEROM3RUtvgbmb0/ihca23/pznIVoKGcAkB
 2o0DGsW0xBcGJlXi8+WZ68TvOdOJ5eQcq6DVV1vx8c4VEPzhV0cj4WCHSAJ7eksRi/xJ
 Q262QEWpqPBEJe+FSw3V8/QgziyT8GiuV3NUIBDxv1f9JFoeCrQxet4E6TFACz8CvJ+/
 UCSw==
X-Gm-Message-State: AHQUAubSW2/ibVsmggoq4DmSzQidMQzCcoHnzRjWjrJZBL9WYVEdPXiY
 izhHl6fs0oHEH5o4tKfasu2vMg==
X-Google-Smtp-Source: AHgI3IZ3Fv3b7cjhs0MRquswynTXsrM6xO37ZTWjTPFK5i7uxqNviBpKH83FZgUzToBULvP55l4law==
X-Received: by 2002:a2e:20cf:: with SMTP id g76mr6026606lji.36.1550963133167; 
 Sat, 23 Feb 2019 15:05:33 -0800 (PST)
Received: from localhost.bredbandsbolaget
 (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id p22sm1551554ljb.93.2019.02.23.15.05.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 23 Feb 2019 15:05:30 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: arm@kernel.org
Subject: [PATCH] ARM: dts: gemini: Re-enable display controller
Date: Sun, 24 Feb 2019 00:04:52 +0100
Message-Id: <20190223230452.8913-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_150536_333482_5B035F81 
X-CRM114-Status: GOOD (  14.95  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

commit 137cd7100ec6fa36d610e106df00acb4d8af99df
"ARM: dts: Enable Gemini flash access" contained a bug
by disabling the display controller, while the whole
idea with the patch was to enable flash access AND
the display controller, simultaneously. Fix it up.

Fixes: 137cd7100ec6 ("ARM: dts: Enable Gemini flash access")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this directly for ARM
SoC, as it is a regression fix (late) for a bug
appearing in the v5.0-rc cycle, it should be tagged for
stable if it does not make it into the merge window.
---
 arch/arm/boot/dts/gemini-dlink-dir-685.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/gemini-dlink-dir-685.dts b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
index 6198fe5f698a..c0f26558092e 100644
--- a/arch/arm/boot/dts/gemini-dlink-dir-685.dts
+++ b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
@@ -443,7 +443,7 @@
 		};
 
 		display-controller@6a000000 {
-			status = "disabled";
+			status = "okay";
 
 			port@0 {
 				reg = <0>;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
