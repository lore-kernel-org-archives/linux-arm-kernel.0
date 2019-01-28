Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22F2C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:40:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C11C020881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="exvRloTQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NgQTujWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11C020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=wnuzYA6y+YwPC+ZAHITs8gn589vQ++1x8WWeT/eIOew=; b=exvRloTQmCeSSRdjCHzdWgpsU1
	JM3TVnvXxIhgRU481JyZjtqOcfv5tuezIibbT2eb5lXBtfSp0eMZYb2BTgiB/AqGInWLOCBQ27dx8
	jXhF/Jzl+Q0NjVVIihO4EzUB3sH4X3L3S6ThZ5rp1AUUR8SYEeIDJu5gC4XzN2Hb2jm2UR/esPsm7
	wLWU1N69eREBnpF6Rw1m6hoKwetLQGgitM8tMPFK8sJQD/jgPt6DIWttbNvTm6n6zZeb3zgjckBdc
	rn7ueXNTGR0bFb+B/R/+yj3YjAshGbiXQo3REgRoAx3PRXiOiynHmQCjgQHFY+CITDUrtVB/o7RAQ
	/fTm5e2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goBpe-0004Do-3I; Mon, 28 Jan 2019 18:40:30 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBj5-0005rY-4m
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 18:33:46 +0000
Received: by mail-wr1-x443.google.com with SMTP id t27so19224630wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 10:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=nAEdvq5oOukgk1f4NK11o2gbGIkfrBCRV8yGimK9/ag=;
 b=NgQTujWor9c8VTUEHGHbjOFEgPwu0ve769eQ9xvenDaBYyKgxpegvFKTQxN/s4L62/
 Lj1APdMK6Ty1l0V7p70DAqg39xa+A1ji3EU01bGIg1QTzX8XGEhiZbveaMMDjPnnTcl1
 w6c4i+C1/6v5X6xcAzuKryU+xNa2qDOPYZopQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=nAEdvq5oOukgk1f4NK11o2gbGIkfrBCRV8yGimK9/ag=;
 b=BGSw9OdPJm7Bmmk7JmScG+TKIL/pCh6/KOzw3R0DipThPN+v3ddBftAnGmh19N+CVh
 7hyIGXikvk/8we7s2p613EW1WzogANN//WexW3gVoj8rH2bi43n0t/USQdhS+DiPT0t5
 blIpVuQqWTv+oeTBj4f9bt/hnivwcmaTyRT+ZAOnODh7UvFLdd5Xl93KHsr3qcTpmXYq
 YpXCxHoo+uuXc9AYdV2yMSpZbx02IdtVgYkSgZLlB94pMHlw+y/yL775Kmrl/a9k9Wp4
 5rnfr2BkeX0kIh/m0ye5qRf2FfM/gSYnC444fqLiZrCjj30ZMLDuJ9PrZ4dHvLHZohmY
 lxgw==
X-Gm-Message-State: AJcUukeiyyGAYoCRP7zL+usJtEUSiqkrs8Kz3CuKBaAaDm2cll3s79hz
 XeOLrrObYXUCU8hg+0NgtlKa4w==
X-Google-Smtp-Source: ALg8bN67yBhogyL4bLztP2bWrzOaIcBWicT0uuQ3HSZzV8dSmLhZb/MFO/i4OXLnhGrIdQFp/JTbDQ==
X-Received: by 2002:adf:9205:: with SMTP id 5mr22721276wrj.189.1548700421706; 
 Mon, 28 Jan 2019 10:33:41 -0800 (PST)
Received: from localhost.localdomain (233.red-81-47-145.staticip.rima-tde.net.
 [81.47.145.233])
 by smtp.gmail.com with ESMTPSA id l19sm270082wme.21.2019.01.28.10.33.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 28 Jan 2019 10:33:41 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
 bjorn.andersson@linaro.org, andy.gross@linaro.org, david.brown@linaro.org,
 jassisinghbrar@gmail.com, mark.rutland@arm.com, mturquette@baylibre.com,
 robh+dt@kernel.org, will.deacon@arm.com, arnd@arndb.de,
 horms+renesas@verge.net.au, heiko@sntech.de, sibis@codeaurora.org,
 enric.balletbo@collabora.com, jagan@amarulasolutions.com, olof@lixom.net
Subject: [PATCH v2 14/14] arm64: defconfig: Enable HFPLL
Date: Mon, 28 Jan 2019 19:33:01 +0100
Message-Id: <1548700381-22376-15-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_103343_459755_06B50E41 
X-CRM114-Status: GOOD (  10.84  )
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
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 khasim.mohammed@linaro.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, linux-clk@vger.kernel.org, vkoul@kernel.org,
 niklas.cassel@linaro.org, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The high frequency pll is required on compatible Qualcomm SoCs to
support the CPU frequency scaling feature.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c8432e2..67f0cca 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -628,6 +628,7 @@ CONFIG_MSM_MMCC_8996=y
 CONFIG_MSM_GCC_8998=y
 CONFIG_QCS_GCC_404=y
 CONFIG_SDM_GCC_845=y
+CONFIG_QCOM_HFPLL=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_ARM_MHU=y
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
