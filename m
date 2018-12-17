Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E8DC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:49:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51AA2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XYdPv1Wr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QetYrpog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51AA2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=jR6gPDxyVZgHqLe/Fmt7UnMDgR32rvMZ92Og2j6MaQE=; b=XYdPv1WrIuE9yRF3u1vvOqcoFU
	MV1dsyKHQPW02uU4c1RA0Xt7PwxVkoO73vkBIRvNuVIzT7fFtaTIbYAzG58+XzofGVdalyTAsxkP2
	dGTdzXf3c5Hx7G9Q8OWR+PmMqRX6pI5750uG9mSjgvqR9dN8l93w7mKtllUEalO4KEuk24f81PjRa
	yCUKXe8XryuokDKHx8w0iWndMc4BaEV7Ymvj325M0yWkmrZoXZHXTN0EBwjCd8F/BtrTjZSoLSQq1
	0xoXpdCrGtqvH4i2sLkFLWxYjjqvU49sR23lZuNYBSyWmppFB5LNzdg+ob/UzJw2qtGEtC4I4/Omk
	Ywbozvug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYpWF-00080q-Ti; Mon, 17 Dec 2018 09:48:59 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYpUM-000656-Kr
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 09:47:08 +0000
Received: by mail-wm1-x342.google.com with SMTP id r24so4280236wmh.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 01:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7zUfQ5k1UaGNLQZWqXUVxUrsnDmZIr72/O/z7L/p8XE=;
 b=QetYrpogRHsbPuvIb1lnhOHGRCb5X9owoV/AIv0hvqBsfvxhCRXjPEGrdGgYn5v1Mc
 HDpWdDIMxrVXmwqNDPiKsFQTZ2a3O7LCK+kRPiAVQeN0rDu653kusvLwkrVNLaTx+X0T
 qCry9q5eEfUmIK4pOEKIOKe3nD8pUN+sIxWUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7zUfQ5k1UaGNLQZWqXUVxUrsnDmZIr72/O/z7L/p8XE=;
 b=pUyARljthwRD+E5LzQww/fuMSdYvJQtRwaoEomZ2LvncL0X9UOwTxAHKDVxlgUgGQm
 Ae32j17gYH2nil553WmFrCzJXv1EvCvi54OnlpSgI1eepcMLQFNwpbW7oZdnUPaHvC64
 0t/S6S3c+qbnDCXg0yGuXa70VJ6BsARglMxCXfz1ZSV1JMSWmO+gO9ZjNr4feJCmM8oF
 +oMmqjznGjSTMvvj2QklX82LmgVXy48RARBWz9DMy/yO4asc2v2uHpJP7bm7ytvyX1Bl
 RNCzZJyiHe8mFXg0PV27QKzrA8aj1sAhVn+wSj9l0s9kxD+WdzEWr6eZ10qB4HWU0tG8
 BzTA==
X-Gm-Message-State: AA+aEWZ5/bifEkd28iFYJ/l1aWi/pVGvFXVvLuYxVt901rhQ1FwNTVk9
 7QhnKWnugOsNWIt1S+TtZdw3gw==
X-Google-Smtp-Source: AFSGD/W7AfI98CnyZ0p8vcdpfYDXkTB7x6OrV/CwFqF8fuIpp5WZTRDIcwA7oulJja30ZZ/F4hIh8w==
X-Received: by 2002:a1c:2884:: with SMTP id o126mr11386163wmo.17.1545040020936; 
 Mon, 17 Dec 2018 01:47:00 -0800 (PST)
Received: from localhost.localdomain (58.red-81-47-145.staticip.rima-tde.net.
 [81.47.145.58])
 by smtp.gmail.com with ESMTPSA id h12sm28878113wma.48.2018.12.17.01.46.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 17 Dec 2018 01:47:00 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
 andy.gross@linaro.org, david.brown@linaro.org, sboyd@kernel.org,
 will.deacon@arm.com, mturquette@baylibre.com, jassisinghbrar@gmail.com
Subject: [PATCH 13/13] arm64: defconfig: Enable HFPLL
Date: Mon, 17 Dec 2018 10:46:30 +0100
Message-Id: <1545039990-19984-14-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_014704_017228_FCE69FA5 
X-CRM114-Status: GOOD (  11.47  )
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
Cc: devicetree@vger.kernel.org, heiko@sntech.de, arnd@arndb.de, olof@lixom.net,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, bjorn.andersson@linaro.org,
 enric.balletbo@collabora.com, vkoul@kernel.org, sibis@codeaurora.org,
 niklas.cassel@linaro.org, horms+renesas@verge.net.au, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org, jagan@amarulasolutions.com
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
index 5c2b1f6..da390aa 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -615,6 +615,7 @@ CONFIG_MSM_MMCC_8996=y
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
