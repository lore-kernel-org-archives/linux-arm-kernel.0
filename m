Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2712C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:30:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F8E32080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N8++mj21";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+TQ4Gn6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F8E32080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RC+2M7qZYJb+ESts/+itxLc4HbOfhgjSVZPkJAfhgYQ=; b=N8++mj213GFlrj
	imNTdjm4DjKGy0Ht/GxP2gJ9ORK9WjmXPx/TUBGZ+M7usbZPPGBC1XQO0i/WDFGHmK0p7LNjSHcXV
	34LtbdKSOSVUWqJyc9td9bnHkEomeJAhICT6XZmnCcr/i5IRB0AlPCY1+RvcT7hTtG7I1TO80+WY0
	Z7tkxC/u2hBToe56DKIwnNT+jnZ/N0q35XrLwtPEc8CCEBV+xH2rSnjwnFGplOQPGAp6b0jEdZwP+
	QZErfn6reW9UHQUDdxHjUAbRa0PqvikAsmGpvLoljhgs1fuwIdDd9mKzAkmDBozgQvN/h8oy2eYfR
	Ts/Xli2WB9d6qrULtqAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gru3f-0000HW-5m; Fri, 08 Feb 2019 00:30:19 +0000
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gru3L-0007l9-0W
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 00:30:00 +0000
Received: by mail-pg1-x529.google.com with SMTP id s198so772449pgs.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 16:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uW/mc9bOKLDqIolIzjRAHEjOwO1/pc5BGZ9n7AiIB/k=;
 b=r+TQ4Gn6CBB2kcCKMo8Uqga7g3wHGv3ojbmKsPWXFoSlpMQMixy5Aye+pNvlgY2ixZ
 1Vvqtpi5QchsXZU+KpRVl+bJMXxXr47+/UN6epDiAFD+S0ywrNzDamDSzohAPxqyCODn
 aMbjHxfBmyffwakfdSVW+ii0T1j0ka0EPa1HKDdg3ZEnc9EmKKtTAiLhwI8doovx6DD8
 CifsIN4HoRLTMKxtNhJCVWYpMYWd2NMElgxLpdFE6U0e1Ruh+iCU6yiHk4Qkjsh9KFxq
 s0PQbnuzajNC3nRrmpy4KX1aDeeeXmFLu6UeOLB/WnYX3Wca7VwVTblo5rJUBQG3ebVB
 WWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uW/mc9bOKLDqIolIzjRAHEjOwO1/pc5BGZ9n7AiIB/k=;
 b=LlFmWCnswiNmWeez8jVaq5cVZVmWqC/FKyGbATzCywSbDh38Tog8lezomIJY2vQnFt
 eYBRzcrD4duGclDvDEZ6tgsaSBxMNTCL9yWV4w3H74pgCKyb4+Bo+dR6aUZLysh298SN
 erRXCkiEhZMR2GKtZdzsJ8nxzj8GjCX0UA+syc6Q2EXaYZEu7jmAXEn/5+Ucew0Sm8mN
 jOc9xnFQnHBuwosJWV4NDhG1Qr1hSY019J85EUJzf2/siRaVjfpTKIEabfEHx9jXXGFl
 vhV2OC1UFrkLUS2j1DtwGCzkF53DBP0+VTROREAsdOH8TLe+Jr+LwPREGgf6kohoWF64
 9hEQ==
X-Gm-Message-State: AHQUAuZXn7M1JNbHdzmrhi9nyaqBRZ2CVWU/dn0EjHgvRK9KvJmDgWdM
 u6vY0Ex7DRtPBcikZKFjYoM=
X-Google-Smtp-Source: AHgI3IauG3AAMgvMTpqW5IOS494fZrzA6KIlc5MiaatGOwVfHh/ws3S4MsGmyV6yJIFvjR7PaMIFAA==
X-Received: by 2002:a63:ef50:: with SMTP id c16mr8662258pgk.3.1549585797269;
 Thu, 07 Feb 2019 16:29:57 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id p81sm380835pfa.107.2019.02.07.16.29.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 16:29:56 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: [RFC v2 1/5] arm64: dts: imx8mq: Mark iomuxc_gpr as i.MX6Q compatible
Date: Thu,  7 Feb 2019 16:29:37 -0800
Message-Id: <20190208002941.30343-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208002941.30343-1-andrew.smirnov@gmail.com>
References: <20190208002941.30343-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_162959_048264_757FCA43 
X-CRM114-Status: GOOD (  12.77  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-imx@nxp.com, Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Chris Healy <cphealy@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Mark iomuxc_gpr as compatible with "fsl,imx6q-iomuxc-gpr" in order for
to allow i.MX6 PCIe driver to use it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 892063a7c26c..f6c37bf9cbce 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -230,7 +230,7 @@
 			};
 
 			iomuxc_gpr: syscon@30340000 {
-				compatible = "fsl,imx8mq-iomuxc-gpr", "syscon";
+				compatible = "fsl,imx8mq-iomuxc-gpr", "fsl,imx6q-iomuxc-gpr", "syscon";
 				reg = <0x30340000 0x10000>;
 			};
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
