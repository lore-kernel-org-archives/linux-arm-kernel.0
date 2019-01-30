Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86738C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:05:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58F0E2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lQ45WqND";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ADzsbmaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F0E2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=hdcr2yOYH9eho68LkrqEiMKYMRu0qXlEruDvCtGiHUE=; b=lQ45WqNDEb1WSR
	1T+H28dVIUw0XUgoQSnB9VkkeWNzAqveq6Zlkd3sHeMmlvRt97IjC0/4R6TY9U9R8kGQ/v8Qy9fqz
	9ItkNgYoWeDMm1pGw+PmILJoJmTTa4j+Nlp6AGehLXjIsVBIxQ7oGZcQz9bAqo1NErbNXy79uCl2q
	EaGqPhCBm9iAljoRMneOJRhFJKmL0My0nxrilTKf7AyeCFEXngCcM10Cx3yUR5WHMyc3aIobQXgcF
	GhRPPK22+JM3GnQgia+AFYbxlupX8M5/Girgk7Yr3bu5x43DY5YUUrOXASuUb9LtppbSV6NjI2sQh
	48+AgZf5GpSMwOyUPRcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goocO-0003UI-8d; Wed, 30 Jan 2019 12:05:24 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goocL-0003TX-Dk
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 12:05:23 +0000
Received: by mail-wm1-x341.google.com with SMTP id m22so21445476wml.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 04:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cWSS5nnCPs5p2svlakUkLqZgTbA0q6pX0Av9o7O4JkE=;
 b=ADzsbmaD03mLmBjETe6VghZZfc63Q6awsxb8bgsMZIr3lRgayQPTAoqTVajTjeOe2D
 j+8LH59iahFrA8Cis/iynWHGoOBjqLXLcht55pl+4x+dLpGEoya1eGLPVGkaluZhp/KU
 CauSkl2J+ZJUEAWavXbnFwAWPDTyRcNHbdSsqx3G2dj6n17ZUk+ITsQsq7C15E7m1Hog
 cZ/hmzJjG8ufFI/QrA2K6ImXhXlqdTEp145ehRIwsgW7LPcbLTj2B+x2zYpR74DhOq0O
 t2r1ekTsjEQJNv8wSX38Iu57tXdvOGPITNA3WzMdEWGKUoeRvEBdLoE3Zc+A6jnG1a6Z
 2i6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cWSS5nnCPs5p2svlakUkLqZgTbA0q6pX0Av9o7O4JkE=;
 b=ZfuP7QHLcS4oDFa6r13ijdmdC3b0f94wGGnb+Jbnv91ENyHjKUOY6TVBfOMebgwyIO
 JW7iI8Bw8+WTYmzXETJdmZaPx2mKMlEeOtDJIET+K6ymmDyNT51TUiayYAM1xOw3J3TP
 prrYliZC280PgMk7jvQAlrMXLa1hBw1XKXUThRl2BjWbZaIq6uOzNNzfGQXO25cLAkq2
 iEFe3XbuQm2dNkw6+GYCoXqu8A3guTlyu64hWD4lJDh5mAVDyZmMFZbxTK/2nlMATzHj
 65A5UXS1Bssw2ICdqBfTqevlfsUHUtDFuKWShN/Jels/njOK3SJRHFODPpAwHAF6HZ/K
 e9og==
X-Gm-Message-State: AJcUukdIEzKIhVx1bcSi2GVo166DTyqOWqmmxJBzEqUMo7pLd53Wxbbk
 sFbXB8SxXQhsdiUs6Im3DPF15Q==
X-Google-Smtp-Source: ALg8bN7lHocm9fwdy0BeCMudY0MHG5nnGwtEyMUNoX+W2zQGR1VxVqSJUZt3LkmvzoYYaiw1su0vYw==
X-Received: by 2002:a1c:5984:: with SMTP id n126mr24256973wmb.62.1548849917011; 
 Wed, 30 Jan 2019 04:05:17 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6])
 by smtp.gmail.com with ESMTPSA id f15sm642954wrt.10.2019.01.30.04.05.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 04:05:16 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, l.stach@pengutronix.de, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/3] imx8mq: Add QuadSPI controller
Date: Wed, 30 Jan 2019 12:05:08 +0000
Message-Id: <20190130120511.11555-1-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_040521_513877_87E9A090 
X-CRM114-Status: UNSURE (   7.73  )
X-CRM114-Notice: Please train this message.
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
Cc: Carlo Caione <ccaione@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enable the QuadSPI controller in the DTS and document it.

Carlo Caione (3):
  arm64: dts: imx8mq: Add QuadSPI controller
  arm64: dts: imx8mq-evk: Enable the QuadSPI controller
  dt-bindings: spi: Document imx8mq binding

 .../devicetree/bindings/spi/spi-fsl-qspi.txt  |  2 ++
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 26 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 17 +++++++++++-
 3 files changed, 44 insertions(+), 1 deletion(-)

-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
