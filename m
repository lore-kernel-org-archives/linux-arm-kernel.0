Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A6BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:20:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 198462081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BaDubaTU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="QNLv8Gki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198462081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=7+dEy3AQMZ/lbCqxxq52gw2CF9D+5c8prp9+DS/RVJ8=; b=BaDubaTU7W5vVVpRjLxSXCUfNY
	SpDwnx51TF8Gmf1c6LW4yyfMe0fUUizMy5meF8qfhc7+bWnjrBPq0SiotwB343tVfO01PrqiJTct1
	pS2fnqF648yFdmnajh3Kss/Nj9BvlVuZmPfFB5FVsTW2V3rGLOjYPdm4wf2+jXOwAcjdv+299c1ng
	1bPP+zs/fFAywYsMJZSbSiE+xnt+zM7wvdieZJZOJJu7n91tBNxAQsK+JIuDtJjw2PIhrcuUNnSdk
	3LMng6PMn2X9KLoFXpAQnGRtwnGuIZoaqGGyMkAa6+Y9dIHTiPKL4gReIovzq4+oxNVD+w198oxIF
	RBUox1gg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUCUl-0005Pr-U0; Tue, 04 Dec 2018 15:20:19 +0000
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUCUh-0004WK-DX
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 15:20:18 +0000
Received: by mail-qt1-x844.google.com with SMTP id i7so18384585qtj.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 07:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marek-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=EX3c5Y9lXJnREplZdsnECwQbW9mnnjIxQ7nV0qALrUg=;
 b=QNLv8Gkiurr6cbuowHLsrFgH2XzGVcc0CmEEkq+NymsNAqqQpwP+mpqXtWu64vJRHi
 7VfKGIHC8mPTr9tLu7a9A4ky36Ry5oIrVJVWIuhEniJfZn7SGdQzyYaDNdj426OptNln
 vlKBBCEeVbZWRgn9S8WlWYBak1oAgd8BiwVGNyC+pf2n4kr/M9a68/cC3beQSrXNyiBo
 i+ilq9Arwg2mZ0oVI39u8BwfLG7syHixyidDhrMRKXwCOR2luUyYAJqxcysnGarAtKKS
 GE2mI4CF6p8phQGyKNaPkJGjTTxSzJf+2XNUQUzaKfd68dpTIu/iNJIT7RzRUDr2XZlQ
 +3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=EX3c5Y9lXJnREplZdsnECwQbW9mnnjIxQ7nV0qALrUg=;
 b=XIVdxzW2A113v/hBquX/2ui0xVlK+eUdej13WZtRSyE/mS6/rTMDa4XsP7kCLdN2Do
 XL8+pH0Yvr5qqNHjeqmN5ZKUc1wKWGLqeIvxrhBDW2sNiYb3CawosH4MJr4Z6jjeIRc+
 mVvaLrs/nAGR5d4CN9t4viVugfv4Wz02IDgrBuWjyvbNY9tVM8DKoSYm/L4c4pKUsObI
 7DU3PrMZSnjSRnfdGda9fk1ZGeQqa4REXHdfCheJtsXPBzzOyAGPDCU9rzoBIJFQNV3O
 zoI/Yu1F6fXrSnrVbPJtDCbhz+TDG3of6YjBaqM1RCesAnXp5AQ7CLUubBcNgFiOXuPV
 bOyQ==
X-Gm-Message-State: AA+aEWYLLPCUgX/nJ/WBKDZs49yKqt3SEH0I61dpXmaS8AP3sG9iJlD2
 2gmw0GhCddmtIjw9DfY8/v03HQ==
X-Google-Smtp-Source: AFSGD/UXObyrRY2xYO3H15lFdmsPa+wIRhM9ekFvjE4M3Yog7gYq0XtsL8VHHeCWpy9dEhf0gsFZuA==
X-Received: by 2002:ac8:3879:: with SMTP id r54mr18998707qtb.69.1543936803885; 
 Tue, 04 Dec 2018 07:20:03 -0800 (PST)
Received: from localhost.localdomain (modemcable014.247-57-74.mc.videotron.ca.
 [74.57.247.14])
 by smtp.gmail.com with ESMTPSA id q17sm11053989qtc.19.2018.12.04.07.20.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 07:20:03 -0800 (PST)
From: Jonathan Marek <jonathan@marek.ca>
To: freedreno@lists.freedesktop.org
Subject: [PATCH v4 4/5] ARM: dts: imx5: add gpu nodes
Date: Tue,  4 Dec 2018 10:17:00 -0500
Message-Id: <20181204151702.8514-4-jonathan@marek.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204151702.8514-1-jonathan@marek.ca>
References: <20181204151702.8514-1-jonathan@marek.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_072015_458859_56E4D13A 
X-CRM114-Status: GOOD (  13.86  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, festevam@gmail.com,
 Sascha Hauer <s.hauer@pengutronix.de>,
 open list <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Chris.Healy@zii.aero, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, NXP Linux Team <linux-imx@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds the gpu nodes for the adreno 200 GPU on iMX51 and iMX53, now
supported by the freedreno driver.

The compatible for the iMX51 uses a patchid of 1, which is used by drm/msm
driver to identify the smaller 128KiB GMEM size.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
v4:
 added commit message
 moved to follow address order
 removed frequencies, they are not needed as clocks have fixed rate

 arch/arm/boot/dts/imx51.dtsi | 10 ++++++++++
 arch/arm/boot/dts/imx53.dtsi | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 67d462715..14dcc5a41 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -123,6 +123,16 @@
 			reg = <0x1ffe0000 0x20000>;
 		};
 
+		gpu: gpu@30000000 {
+			compatible = "amd,imageon-200.1", "amd,imageon";
+			reg = <0x30000000 0x20000>;
+			reg-names = "kgsl_3d0_reg_memory";
+			interrupts = <12>;
+			interrupt-names = "kgsl_3d0_irq";
+			clocks = <&clks IMX5_CLK_GPU3D_GATE>, <&clks IMX5_CLK_GARB_GATE>;
+			clock-names = "core_clk", "mem_iface_clk";
+		};
+
 		ipu: ipu@40000000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 207eb557c..d7d5fe4c7 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -209,6 +209,16 @@
 			};
 		};
 
+		gpu: gpu@30000000 {
+			compatible = "amd,imageon-200.0", "amd,imageon";
+			reg = <0x30000000 0x20000>;
+			reg-names = "kgsl_3d0_reg_memory";
+			interrupts = <12>;
+			interrupt-names = "kgsl_3d0_irq";
+			clocks = <&clks IMX5_CLK_GPU3D_GATE>, <&clks IMX5_CLK_GARB_GATE>;
+			clock-names = "core_clk", "mem_iface_clk";
+		};
+
 		aips@50000000 { /* AIPS1 */
 			compatible = "fsl,aips-bus", "simple-bus";
 			#address-cells = <1>;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
