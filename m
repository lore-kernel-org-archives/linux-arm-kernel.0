Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4147C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:48:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0DFF2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qqODmRUX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Co23MviV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0DFF2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Zof7umGYupjpkNto2wcchrjA2UnvB4go2v9o0dT6jIk=; b=qqODmRUXX3lwYL
	lVvpKGjnFBRese60lU4heE2GEa97yyBZj9nUTCJMgawj8QiB9YqHkATrLVE/+YpVOC+aU+Q05NgGI
	ajFhtP/jQ58L+e4zgdJ12XM8Yeepxz6v92cduqTBOAaeSpPG2QJ8VtrLbZlkce9oWzSdio7XZskYt
	Gdt+nP1Gwyx6w94LlEy8sFfVWxec+aOmYSqh18noOvcnH+v4gg1l450d3+jyov6TeupqdZSUdrQWm
	ICjF0M3kuZyHCrvb+w2mtYUEW0yR5A281gMtk835qviaLjjc5uOF4cIka15yXxPvnOsnOLDiffBOP
	mcOA1ednzPCe8S81igoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt8CO-0002sf-FK; Mon, 11 Feb 2019 09:48:24 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt8CJ-0002sG-Su
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 09:48:21 +0000
Received: by mail-wm1-x341.google.com with SMTP id f16so15922303wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 01:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=J7RvHl+LPyQ1r+IJhJsVjEYgSCpW++Q68IDAp7yfvaQ=;
 b=Co23MviVHoCJtaftk/ogaut2GcR80AOZRLj2qZrI43o6uqgkgaFSw+I9z0eGKwDITt
 jJkaF/QLmsqwQRhe57ZAuc9IlIC8CNwDVL7pjMifu5LwMoecb3xcaSFGTQKtijs4zApy
 lP4rxMJon4oaMFGU/qumarAEMbN/CgG4M3BuRvZlh6IREHjEFGZ962HuSrnTvotyfcDZ
 CyD8jziIMFCVRg69mdDnRmGRBkPqpmOB5BWpBDhRo0UU2ImDyAWoMmlp957jRFKqaQuW
 +zrU10rV5rHYJkyKAoPDy6zM3buO5tiAXoTrQ1PrEeVd02hMgyTEdFwqDce1x7iirdWG
 zLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=J7RvHl+LPyQ1r+IJhJsVjEYgSCpW++Q68IDAp7yfvaQ=;
 b=SokBjoa0WkGWIfOh4CXZ1DQAuKm3u38c82mSfhwgMdfgZbzVyUyeHnB8pYCGhQoErW
 nEb81h0qljVE+HaoyxktgRV6ZCNAy7FvX5kkM7EvFYVosut2WYFZ4G5gRiq+scTtFptL
 m7AfpuA0vvekQzjTf2fXQ/JogQccVzrKSpurw2EQRBGjeCy5wtXr/AjutJPHM8ZA9K21
 Fh5Jbe0yCBJTQ2tHDLCAMvE3v/sB7EZWNd6U10x8bwsUoL+O8Kx+tFBVoG5brxVB+i9A
 5sUA/pHpIUaVEELrj9W5EPqv1WxQ6hDmPIhkPDqrfO9sYYC6JokpsD/6ucO2KBzFpnGY
 BrgQ==
X-Gm-Message-State: AHQUAuaV1EFNL01cVE7oH3kYEQowTW1dTHlWbC99p5IpSYCVUXMh8gPb
 FyhdROuTk/tr7KmhCnl2Vm4=
X-Google-Smtp-Source: AHgI3IY7wrdkXPItNFXhdB/LELTHryuZzPN6aLOR/jrCYGTjcLImEWDAKhiQAib4MxDu7eeWQIwx+A==
X-Received: by 2002:adf:ba8d:: with SMTP id p13mr21735320wrg.53.1549878497627; 
 Mon, 11 Feb 2019 01:48:17 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id c14sm995449wrn.12.2019.02.11.01.48.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 11 Feb 2019 01:48:17 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] ARM: tegra: Restore DT ABI on Tegra124 Chromebooks
Date: Mon, 11 Feb 2019 10:48:15 +0100
Message-Id: <20190211094815.4561-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_014819_955021_E1B5299E 
X-CRM114-Status: GOOD (  15.79  )
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
Cc: linux-tegra@vger.kernel.org, Tristan Bastian <tristan-c.bastian@gmx.de>,
 linux-arm-kernel@lists.infradead.org, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Commit 482997699ef0 ("ARM: tegra: Fix unit_address_vs_reg DTC warnings
for /memory") inadventently broke device tree ABI by adding a unit-
address to the "/memory" node because the device tree compiler flagged
the missing unit-address as a warning.

Tegra124 Chromebooks (a.k.a. Nyan) use a bootloader that relies on the
full name of the memory node in device tree being exactly "/memory". It
can be argued whether this was a good decision or not, and some other
bootloaders (such as U-Boot) do accept a unit-address in the name of the
node, but the device tree is an ABI and we can't break existing setups
just because the device tree compiler considers it bad practice to omit
the unit-address nowadays.

This partially reverts the offending commit and restores device tree ABI
compatibility.

Fixes: 482997699ef0 ("ARM: tegra: Fix unit_address_vs_reg DTC warnings for /memory")
Reported-by: Tristan Bastian <tristan-c.bastian@gmx.de>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---

 arch/arm/boot/dts/tegra124-nyan.dtsi | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index d5f11d6d987e..4433008d7aa6 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -13,7 +13,19 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory@80000000 {
+	/*
+	 * Note that recent version of the device tree compiler (starting with
+	 * version 1.4.2) warn about this node containing a reg property, but
+	 * missing a unit-address. However, the bootloader on these Chromebook
+	 * devices relies on the full name of this node to be exactly /memory.
+	 * Adding the unit-address causes the bootloader to create a /memory
+	 * node and write the memory bank configuration to that node, which in
+	 * turn leads the kernel to believe that the device has 2 GiB of
+	 * memory instead of the amount detected by the bootloader.
+	 *
+	 * The name of this node is effectively ABI and must not be changed.
+	 */
+	memory {
 		reg = <0x0 0x80000000 0x0 0x80000000>;
 	};
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
