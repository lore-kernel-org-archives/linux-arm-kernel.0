Return-Path: <SRS0=AzG1=P3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5B0C61CE8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 20:52:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68B9620883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 20:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PjlsXj1Z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EJZhMqa5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B9620883
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nLrTqeqsqHwGqbaznx2/WTWKYBoJe9EJwwvZHisRmqI=; b=PjlsXj1ZUXQwAu
	Dw/a1r6gMrvcDbK0au1iMNnSPATSptAsWt+rRGP6kcWrTov/KE/Z3d/+a+C99x3P12RLCTjEOo5Pq
	AX+HS6rjOlV+TVe6SezyZ+kpjHtUp6FtQXODET+zFVsS6mYZQsmxSOfk8jfIOcWg9ct7fV0VEmgB4
	O5IXHsnRqYmT7PsN9yHqSrBhk7FC/RlV2PP6OOuIdDqqVDZkkrEPPRhro4GXp2ddLLTB5hBMug1fe
	mc6a8Ju39MuQ+RREdAkTVrrTXRG25t1tOpTgo1MBi7O1erJy/Ovvy5OOcSMTHM5UKkI6dnk9LjPbE
	FHzPcpY1djWUcnzHAiCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkxbD-00053Z-DW; Sat, 19 Jan 2019 20:52:15 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkxaX-0004R3-Dd; Sat, 19 Jan 2019 20:51:35 +0000
Received: by mail-wm1-x333.google.com with SMTP id p6so7490307wmc.1;
 Sat, 19 Jan 2019 12:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mfga5LPr/J3+vtuLs6sE/4iTgznBPBA3E+j5LobqNYM=;
 b=EJZhMqa5fQqTJmlghkIfuLCEMOmi48PSWTE5qyegX9Uubem0S/mX2THXZEkvuwKQ1T
 z/4mwV1wNpAKZ4/aYapso4cq30p/1S1M2h6fdwDqBW+JV0ZI9ogTPOlqtazC3DjySZAz
 dgnGd1NwjKSYx9z95K5rpcwELS133MLnPKXm8zOzuGVLssHyC2ym02zsQcE6ulBwZ/pE
 aHB6CQq7YlvPOfo6GNNsQZQmPip/eyFKzUVMHoP7nuO6Dr6DfoSg26leMksoxIFs0Q8b
 La2VLE/WvfzNAI+396CCgwhJN+Rt8VkUx+tHxyX1MeSoOaHPp1v0kbUYM7WT0rlhp90q
 kYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mfga5LPr/J3+vtuLs6sE/4iTgznBPBA3E+j5LobqNYM=;
 b=KI4dDfI55snRlpYCe6bkXuyduKkq+2CZhgziGWj87Y+jeBgxzbCiqxAnOABf/HRhHQ
 8/z9GtQ9kbGlE87jmQtNHBbMwXiiGUeTbC/2QHrKyVagsRTCFjPZZlaKWVGrBjz37MhA
 AKR/Lfg4YzGbw1odHXCpJhCc6Uw5+VdfZpeKF/8wCVAn4q8zxKezp+BAZQHVP0Afrx6R
 NEoEybm5bmLqoTIkhV4kLfb15BYN8B7hn8jSM0Jm9CMSWtxN/FBWPbT8Km5jA474x3dP
 rZU+RGFt2XHEHYZ8L26iteGTkG4+8T5U6Rzsams8vmWHKERoCiwd521ehqeKTYMylFy7
 6qPg==
X-Gm-Message-State: AJcUukdKkKJwqnXk3moiTh5jFUIok/r57KZH5bXKF/lxr+P8dQoDLjD2
 9zE2Llv6RaKApIVRq8f+/aZt3zoE
X-Google-Smtp-Source: ALg8bN4y5b0+bvYgqHjfawOqam5SUACzfUYhonkChTE8cEjTKNxwf5Rdy6cPF/WFZPTbvp/63Mx3eQ==
X-Received: by 2002:a1c:8acf:: with SMTP id
 m198mr20859820wmd.143.1547931089236; 
 Sat, 19 Jan 2019 12:51:29 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73A8100FDA9BD4E9DEACC2C.dip0.t-ipconnect.de.
 [2003:dc:d73a:8100:fda9:bd4e:9dea:cc2c])
 by smtp.googlemail.com with ESMTPSA id 10sm58176662wmy.40.2019.01.19.12.51.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 19 Jan 2019 12:51:28 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, narmstrong@baylibre.com,
 jbrunet@baylibre.com
Subject: [PATCH v2 1/2] dt-bindings: clock: meson8b: add APB clock definition
Date: Sat, 19 Jan 2019 21:51:20 +0100
Message-Id: <20190119205121.9621-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190119205121.9621-1-martin.blumenstingl@googlemail.com>
References: <20190119205121.9621-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_125133_454025_76ED2D9C 
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
Cc: sboyd@kernel.org, Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 mturquette@baylibre.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Commit 8e1dd17c8b0e3f ("dt-bindings: clock: meson8b: export the CPU
post dividers") added a clock with the name "ABP". The actual name of
this clock is "APB".

Add a new #define with the same ID but the correct name. The old #define
will be dropped in a follow-up patch because each commit in the tree
must compile on it's own (the old #define is still used by the clock
controller driver).

Fixes: 8e1dd17c8b0e3f ("dt-bindings: clock: meson8b: export the CPU post dividers")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 include/dt-bindings/clock/meson8b-clkc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/meson8b-clkc.h b/include/dt-bindings/clock/meson8b-clkc.h
index 5fe2923382d0..8067077a62ca 100644
--- a/include/dt-bindings/clock/meson8b-clkc.h
+++ b/include/dt-bindings/clock/meson8b-clkc.h
@@ -104,6 +104,7 @@
 #define CLKID_MPLL2		95
 #define CLKID_NAND_CLK		112
 #define CLKID_ABP		124
+#define CLKID_APB		124
 #define CLKID_PERIPH		126
 #define CLKID_AXI		128
 #define CLKID_L2_DRAM		130
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
