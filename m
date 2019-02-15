Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C60C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:54:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 516F92086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TGNEjtva";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cb0QzSvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516F92086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=I7rlD2JsQeWr5RDNu6ThPBi7ysAxpSM3eUBmGSEfZm4=; b=TGNEjtva9HxinT0EkE9z82Keaq
	tp2Yu3bQMfsrgD2LNrMwP43VwJgzHUr1L7jbiHsilehg7oaEuM+OnDYkRlly1p/CErUdKugTYYCpo
	ARoKVHh8ZhboHsLMGfEnPOjSscO6F7PjQCGh/xOyS5iulBviOq745RQxCuJWefpEZuD3PAqpP44uJ
	feP+MzDRbjSy31x8nY8t+MxwnMbjsqytWfjwlV5+oQ8C285zJ9tyjRYPl7qWd8V9MxzuTFBnZUHm5
	P8sox/POU9TUPsum9RG0GmHdD9bxQR/DrCxYTALNzKgneWHWCsl686xLEo0yM9jBu0IQmJDDmSx2Y
	lmkABwEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufoj-0006qa-UK; Fri, 15 Feb 2019 15:54:21 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufoS-0006V2-LL
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:54:06 +0000
Received: by mail-pl1-x644.google.com with SMTP id o6so5130810pls.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YN48q3Zw1C88JTVxjBmspop5bBKX5JFTmVnaYzS0vaw=;
 b=cb0QzSvId+z25WhlzgfX5mIlvBFIAUsRQ0SctR9h2phfPj2w1odL1yoTdMbz62oOE1
 cqdjg1Kl255cn94fOlOjuKvZRDCHRRuKkRGoE0NeO/MClnP3bmGW4BqPwA3Ako4/LOlK
 mAIwfoJrPBBRuHeSOwkKGaMGslizuZWDcDZV0htArlTuFX5Id14T/+yRH6s64QTt23Aw
 k/0QeF9TvrPXNhoZcYZK3GgziLhcAOKYc29dmeXMLykwXXSrwbyM32+cEQyPsZcelU/q
 cmsf2ZYjEhzI9VzbLTy5eyiCt3mlCuKB3Dty74Gua3meRrhH7e+JFFPRFkgjH0eelQs2
 hCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YN48q3Zw1C88JTVxjBmspop5bBKX5JFTmVnaYzS0vaw=;
 b=Ax0rTqYCc76PyjDQ8b/BNaLSn9c4yajFtATGRgfMbwup/Pfd+7f/rzyVMbIYmvnTcy
 yWFE5+Wf16wLhLqacEikbqNIXbuOGxv0RZ7+XychdADSHFNeVmIdStnV6/slsH83xHpk
 a9gjfs5i8fzMHt/bkhxueTbAOpcG80a/YySRtHmy0YVXfPOGelMH9LE7iUal3/h6vjZo
 Baa5C2UD29kzo92NECIs2LvzUp5cWRyRn6Go3JaXK5uqPdyLNPKJai1Xr/n2S6+1k9uu
 P3X5+DeRw7vhA7fYpsayN9KTu96ZSMTB57fNzl54Ifc52feckTeYZgQaXj85Q7rZmQ01
 qfbg==
X-Gm-Message-State: AHQUAuYug5f0rU4Ldk6oZTRds4xRcVbV9nRsyBYv9iVVWsHb7V83RCky
 KC7AMUwftVY7PJPKAHBks7k=
X-Google-Smtp-Source: AHgI3IaV+xJCF4+x5CO7mMHlTRM5Lh4YexFgYI8b++u1BnbiH7vz1DsuQQ9HSkIoW0uO+QBiv3WNRw==
X-Received: by 2002:a17:902:6bc9:: with SMTP id
 m9mr10731462plt.173.1550246044191; 
 Fri, 15 Feb 2019 07:54:04 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id b9sm5956952pgt.66.2019.02.15.07.54.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 15 Feb 2019 07:54:03 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
 mark.rutland@arm.com
Subject: [PATCH v3 2/4] arm64: dts: allwinner: h6: pine: Add CPU supply
 regulator
Date: Fri, 15 Feb 2019 10:53:36 -0500
Message-Id: <20190215155338.10564-3-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190215155338.10564-1-tiny.windzz@gmail.com>
References: <20190215155338.10564-1-tiny.windzz@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_075404_708840_14FA81D2 
X-CRM114-Status: GOOD (  13.38  )
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
Cc: Yangtao Li <tiny.windzz@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The original pine use the dcdca to supply the CPU cores. According
to the axp805 spec, the range of dcdca is 0.6 to 1.1v, 1.12 to 1.52v.
In order to support more CPU frequency, slightly increase the voltage
maximum and minimum.

In fact, in sunxi's sdk, the actual minimum and maximum voltage of the
cpu is smaller or larger than the datasheet.

For some better quality ic, the minimum voltage can be smaller. For
some poor quality ic, the maximum voltage needs to be increased a
little.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index bdb8470fc8dc..95c81250c2b3 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -213,8 +213,8 @@
 
 			reg_dcdca: dcdca {
 				regulator-always-on;
-				regulator-min-microvolt = <810000>;
-				regulator-max-microvolt = <1080000>;
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1160000>;
 				regulator-name = "vdd-cpu";
 			};
 
@@ -251,6 +251,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdca>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ph_pins>;
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
