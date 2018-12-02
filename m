Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CC4C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:26:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38B702082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tGKpWMI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B702082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lk0JAaVXYfQWNenwsYrBRS4nZ1f4ZK5Drkwtla3RV+g=; b=tGKpWMI8h/yMZH
	SM3Wl4nmbhich/XosiyTNBMDlpLiXqappak/ePbGnyEnPK0kr3ReGifxNxPsyGF27y4a9s/8N8cs8
	nvczx55+PEDpRzKAt/+LwPUr1rIFhNdTh5x/hEf84nhBvm8c7IwjmKtYk8102QAsZGKhfe+zxrhMf
	7hfUlBFQ8IQLBYhRV+rHPZlZt57zEcbioYXEEjYt5ezZJR2N3Da0jEvoWjzitqzO9x1ST+Dejc1xM
	pRJ+8APJ0dd6RJis0VUudBPj10bGtUmzgMMmLKmZis53hJdFFj9jLx/p504DgFnv1n17RZ80n9t0q
	wLxI8g5eQ/6E1guRQ4Fg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTZGE-0006Bv-Do; Sun, 02 Dec 2018 21:26:42 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZFL-00059A-PU
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 21:26:31 +0000
Received: by mail-qt1-f193.google.com with SMTP id n21so11652873qtl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 13:25:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:organization:content-transfer-encoding;
 bh=5VimbIFi7OVHRFMwGgep9oeo2PRq364OcB5EGIt48LQ=;
 b=i8/y37pc3kQaHQSpQ+obMjjdu14OXQvkj6yLZyx5NvHQ5734rlz7olyKOziblFGyft
 m1D9aBvwe6rbobfrZyiNEf4UtBl9XqA2+x0BG9O2IF54BdUl0IP45CNDVrkA8kANI6Vk
 m1ezN/7II2lloqDDrb454jhW07o4Dvdc0P0ir/OK5Y0Mb1tcog8gHcgfXvRTYbytBKhN
 X+oGaHdxPT+Zdldn8zMlkhlEw5DJSXHAiLPQvpJze/O07CKWcSJGhy/NQBgLBOmk/CIK
 3yTN2xymCJlREodtFI88iEGlz1ReXy5X4ryNXEZP4w0Vcti7B6wjMXC3y1FInJYEfVBK
 bIwg==
X-Gm-Message-State: AA+aEWahC3jPMLMk/DYlbZ8mdi4wBj/lA3QUIdqsMofIePfg7WF75JRo
 2ezudwUGhvCBPhjtdi+zUZuOKdBK
X-Google-Smtp-Source: AFSGD/WwshqPF6vSiDOimMrXQUpAYuHlpaXN17LQKoM8pHiOFoif/9z6cep3DLDm/FCD8kD0Bb+4Ew==
X-Received: by 2002:ac8:2dc3:: with SMTP id q3mr13379304qta.178.1543785936648; 
 Sun, 02 Dec 2018 13:25:36 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
 by smtp.gmail.com with ESMTPSA id w34sm6900294qtj.27.2018.12.02.13.25.31
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 02 Dec 2018 13:25:35 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation);
 Sun, 02 Dec 2018 19:25:29 -0200
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/9] ARM: dts: imx7d-pico: Do not harcode the memory size
Date: Sun,  2 Dec 2018 19:25:12 -0200
Message-Id: <20181202212520.16650-2-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181202212520.16650-1-otavio@ossystems.com.br>
References: <20181202212520.16650-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_132548_589387_74541C4D 
X-CRM114-Status: GOOD (  14.33  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Otavio Salvador <otavio@ossystems.com.br>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Fabio Estevam <festevam@gmail.com>

Currently the memory size described in dts is 2GB, which is incorrect.

There are 512MB and 1GB versions of imx7d-pico boards, so remove
the hardcoded memory size and let the bootloader pass the correct
value to the kernel.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/imx7d-pico.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
index 934a019f341e..0df68e53e9fa 100644
--- a/arch/arm/boot/dts/imx7d-pico.dtsi
+++ b/arch/arm/boot/dts/imx7d-pico.dtsi
@@ -48,9 +48,10 @@
 	model = "Technexion Pico i.MX7D Board";
 	compatible = "technexion,imx7d-pico", "fsl,imx7d";
 
+	/* Will be filled by the bootloader */
 	memory@80000000 {
 		device_type = "memory";
-		reg = <0x80000000 0x80000000>;
+		reg = <0x80000000 0>;
 	};
 
 	reg_ap6212: regulator-ap6212 {
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
