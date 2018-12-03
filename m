Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9399C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:40:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1BF82087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RzGOzX0R";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZSBwLdg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1BF82087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=hjNBBJ6bTfQPWYXbnQ2FkESzrxINSkOZutzoIaJ/tFU=; b=RzG
	OzX0RewPp5HnPVkyQjBNl0rUy87xgQlZSdxoOdXouPUbg+1kDOXM9Q9KegUf9dg1fQSJSMAwawBvp
	Jp+YsFhzvdy09euqC8XqSXB/KNw8c+8Je/7I7sdZWBBxjRZy89c3+blJAcN0j0nzdFiCpEYpL0pUy
	yif2xpWQOwlBAZiGMfm5EpDEtjINw+doQG/0v5hHZg9fT2NKCZKSZjGSm7Yt3uk7VqvKmGF9Y3r/r
	8tHWxa6PXDWI6ZUXxDx6d9NkbJhS7mcGNLHmQB2E/F2VOu2UT163ZuznA8JELSdajdrw4vPV/4Bqz
	GHtiaIWgk6f+MbFO3G9+tGjLTI92NnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTsDE-0001oh-9q; Mon, 03 Dec 2018 17:40:52 +0000
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTsD9-0001Zw-My
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 17:40:50 +0000
Received: by mail-qk1-x744.google.com with SMTP id n12so7841459qkh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 09:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=4gyd+wlfvADAcvE+zUDPF6qL/GvW34LQJGB7IsoHNHs=;
 b=vZSBwLdgf83S1ycVfqqFMt+7naddJu/ppaYyKttDrIvk6zYKPkxk9cLPdyXG4/Mdvd
 GbqjnH63NW6jQWt+BLP0DLiQ57pVdXKbh6M03Xbcn6kaqae4pih+s7p5kVoVuak+MYPH
 z+C3Pgw8IcqAZaDiPuL0/7eVX80mauOKTdw583XIyPXTvPwykFTIiSJKllTYZMIl9ZBF
 6cEKLYsYd12+lPeXyiNfV9htq4xlM7jlxeVJjBn5xBwDholZ+CwMnQoUU3AKRl3u8VG6
 GzCqX9GOTwfVBEp/C9ckmJJPgHQ8D9nMXZdgKMSE4azGUUdft3uqmOpfihDBQu+d4wXf
 nvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=4gyd+wlfvADAcvE+zUDPF6qL/GvW34LQJGB7IsoHNHs=;
 b=R7lTL/chkUr99WtPvKTAO0jNYZdhYL8KwtYBPIVofxK7mWnqNZoC2mTyjduuIIHlw9
 HwLd7vfjljwMiAE0J7qda7b4le5A/eyJjpDZTu3EWSEMmnp7P/UYMnhOTCorTpJgz4G8
 KxldeOY6WrKsZAIxQlMnGTEonqzEWhrHfs2AgwimdG1uMCkg/ubpN+2DmggHcyVgfqsK
 /lanbb+/huNP+dL1ORh7T4sMyt9JwV4sPEvRvtXsavypwd0NffdvghcmJ5tgR+ji5k97
 WfjIwL7ZP5ztG3RHmwQfY6L/WN67uaBerRhGsqMcsCCV12HgPEzX3nkt82VchME0yIP3
 xFkA==
X-Gm-Message-State: AA+aEWYSRrbHWSs4cwWvssyq1dRX0G0frLSt6+NzEOPicbVwCC2tsj2w
 YihRQ9GWLmkqlAJw5xSk24Y=
X-Google-Smtp-Source: AFSGD/VKo85wKbna4RkERe8io4XIYEJA0UM7mVJs6ZdH8jGCL+n7xlF0DQulfUF1jmzRU1vgNpQvWw==
X-Received: by 2002:a37:50c4:: with SMTP id
 e187mr15599249qkb.276.1543858836205; 
 Mon, 03 Dec 2018 09:40:36 -0800 (PST)
Received: from localhost.localdomain ([201.82.144.36])
 by smtp.gmail.com with ESMTPSA id m1sm11835694qkh.15.2018.12.03.09.40.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 03 Dec 2018 09:40:35 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: shawnguo@kernel.org
Subject: [PATCH 1/2] ARM: dts: imx6ul: Correct mask for GIC PPI interrupts
Date: Mon,  3 Dec 2018 15:40:19 -0200
Message-Id: <1543858820-3354-1-git-send-email-festevam@gmail.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_094048_081425_1E937256 
X-CRM114-Status: GOOD (  15.95  )
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
Cc: devicetree@vger.kernel.org, marc.zyngier@arm.com, liviu.dudau@arm.com,
 robh+dt@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
 Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The GIC_CPU_MASK_SIMPLE() macro should take as its argument the actual
number of CPU cores the interrupt controller is wired to.

i.MX6UL contains a single Cortex-A7, hence the second interrupt specifier
cell for Private Peripheral Interrupts should use "GIC_CPU_MASK_SIMPLE(1)".

Tested on a imx6ul-evk.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Hi,

This is based on the following commit:

commit 2acb79e15119512da9b6a49906840e7678cfb618
Author: Geert Uytterhoeven <geert+renesas@glider.be>
Date:   Mon May 7 15:19:52 2018 +0200

    ARM: dts: r8a7790: Correct mask for GIC PPI interrupts

    R-Car H2 (r8a7790) contains four Cortex-A15 and four Cortex-A7 cores,
    hence the second interrupt specifier cell for Private Peripheral
    Interrupts should use "GIC_CPU_MASK_SIMPLE(8)", to make sure interrupts
    can be delivered to all 8 processor cores.

    Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
    Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

and the confirmation from Liviu Dudau that GIC_CPU_MASK_SIMPLE()
should take the number of cores in the system as the argument:

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/315298.html

 arch/arm/boot/dts/imx6ul.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 99c3663..0efc85f 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -94,7 +94,7 @@
 
 	intc: interrupt-controller@a01000 {
 		compatible = "arm,gic-400", "arm,cortex-a7-gic";
-		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
 		#interrupt-cells = <3>;
 		interrupt-controller;
 		interrupt-parent = <&intc>;
@@ -106,10 +106,10 @@
 
 	timer {
 		compatible = "arm,armv7-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
 		interrupt-parent = <&intc>;
 		status = "disabled";
 	};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
