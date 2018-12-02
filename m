Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39010C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:24:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A5320834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GpAClg05";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZsJd0ab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A5320834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=SlYirIHhHMaJW6Nu96NFw2cbRZtEA47PxqZP6wepkjo=; b=GpA
	Clg05TAhssYCmLf6KAaRZnbvXTpud/FdoAdumrKm5wd2gHTB+ZkInPFbnlt/g4BjczJC5NI2zNof3
	+q9CBTl1TOl3BwMalHb/5C8rpfQ/eT7v8IydgxCqqIa/fVfTZxM6vk8fLEZwiLhJnG4+3O+IRl7bn
	BaKRyl2azRM+h4Ix09ob9qYcfVESJu7Mg5IzKQp9Q9jOI1mbgdXDzdXPtH50mhl9a+NV9+HzmWJTD
	zsg7jUaeAlZ0fgaCwA07ZNP6qBhvzEIz3KAJeNMxERZjLz37e14wmjfdlI0ppckvbnhERsKqGfzxx
	f7yI3ySqMM083yPlr209XlCfPqUzFJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTZDW-000261-Gc; Sun, 02 Dec 2018 21:23:54 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZDK-0001tS-9G
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 21:23:43 +0000
Received: by mail-wr1-x443.google.com with SMTP id r10so10112769wrs.10
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 13:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=y4Pigh91c3qMXMgWaohLTWbgGJ76Vl21itHuMEWGe2Y=;
 b=SZsJd0abWfXSSoJwmX9Qgu7FaiLkulvVrqRj652ySMDdDzG2ea9+jxsPA5ZVeonFph
 je79w+GNz2mqZz4NXHXj9YH7csrodLbBvHksMcm2TZlVrVZiucpklaOZrY/6aJ+rCdKp
 PeXBUSHHAfHxrNM+9i4HQA1DXupT4nekNRa/rK1Yn3Iy8ZqUU13R6fNc9q3C7BPsKIVy
 5Wheif6BivE/iATa0s5K3nF71SikMN2Oc0A/RsdQ1hVPd/PzMaBCbGENqsiK2txpkpHB
 U/NAnP2G5Ms/n8BGd5BOz7fvcqmQ+LFjehfsN2t4xnzn66Ve9m07FnpWgzIVBtopd6w5
 gImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=y4Pigh91c3qMXMgWaohLTWbgGJ76Vl21itHuMEWGe2Y=;
 b=qQ5ItBNrQ1p8A5Ndu5WMh8cMTQSmYMCUiciZysv7Z3QEjO4P0RFCTvqf1X251Kr5vY
 lx2C0ruOEkGirXCQXeEFGQdJNdZgOo5eYkwD3DpSToWIRXury79c7tYi6KsXGA4i3JFw
 MTLzLeTUV1GipQK5IcnojoVYJvysG+Ov+vvcXSpr0bFWLZs6Y+Y21wnPheAHsg1z16RN
 aotxrgIoV3xne1fBjveSgQ2Bzk8RD8UO2oNoAEsmGyk64syu2gP3QTSL+ZO5vvxSsX2o
 S9M6P3rSvj1hkqL2UtLdEpDwXKjCwbONgGvxldqd/4Xb4ji3LCo+TU95SkNEwUsUFTRn
 3zEg==
X-Gm-Message-State: AA+aEWZ8E1RPT2ANP3IpB30woiCxVYpCOuXvX6HV9Ydulqqne1IxMtgR
 y2qHrADaRjt9rjXXdLfv2lc=
X-Google-Smtp-Source: AFSGD/URshyVaqMcmEPLl6bVYviO3uoCEO0X9JpSRaRjTrOeIUeSH84v5c29LQm0fjrHKfieStuxVQ==
X-Received: by 2002:adf:e284:: with SMTP id v4mr7253944wri.26.1543785810325;
 Sun, 02 Dec 2018 13:23:30 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
 by smtp.gmail.com with ESMTPSA id d2sm9551043wrs.97.2018.12.02.13.23.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 02 Dec 2018 13:23:29 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-sunxi@googlegroups.com
Subject: [RFC PATCH 00/10] Add support for DMA and audio codec of F1C100s
Date: Mon,  3 Dec 2018 00:23:07 +0300
Message-Id: <cover.1543782328.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_132342_377328_C48DF5C3 
X-CRM114-Status: GOOD (  12.25  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Mesih Kilinc <mesihkilinc@gmail.com>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This is RFC patchset for Allwinner suniv F1C100s to support DMA and
audio codec.

Allwinner F1C100s has a audio codec that has necessary digital and
analog parts. It has r-l headphone output and microphone, line, r-l
FM inputs. ADC can capture any inputs and also output channels via mux.
Any input channels or DAC samples can feed output channels. 

Add support for this audio codec.

F1C100s utilizes DMA channels to send and receive ADC-DAC samples. So
DMA support needed. Patch 1~5 adds support for DMA. Suniv F1C100s has 
very similar DMA to sun4i. But there is some dissimilarities also. 
Suniv features a DMA reset bit in clock  control unit. It has smaller 
number of DMA channels. Several registers has different addresses. 
It's max burst size is 4 instead of 8. Also DMA endpoint numbers are 
different.

Patch 6 adds DMA max burst option to sun4i-codec.

Patch 7~8 Add support for suniv F1C100s audio codec.

Patch 9 adds audio codec to suniv-f1c100s.dtsi

Patch 10 adds audio codec support to Lichee Pi Nano board.
 
Thanks!

Mesih Kilinc (10):
  dma-engine: sun4i: Add a quirk to support different chips
  dma-engine: sun4i: Add has_reset option to quirk
  dt-bindings: dmaengine: Add Allwinner suniv F1C100s DMA
  dma-engine: sun4i: Add support for Allwinner suniv F1C100s
  ARM: dts: suniv: f1c100s: Add support for DMA
  ASoC: sun4i-codec: Add DMA Max Burst field
  dt-bindigs: sound: Add Allwinner suniv F1C100s Audio Codec
  ASoC: sun4i-codec: Add support for Allwinner suniv F1C100s
  ARM: dts: suniv: f1c100s: Add support for Audio Codec
  ARM: dts: suniv: f1c100s: Activate Audio Codec for Lichee Pi Nano

 .../devicetree/bindings/dma/sun4i-dma.txt          |   4 +-
 .../devicetree/bindings/sound/sun4i-codec.txt      |   5 +
 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts  |   8 +
 arch/arm/boot/dts/suniv-f1c100s.dtsi               |  25 ++
 drivers/dma/Kconfig                                |   4 +-
 drivers/dma/sun4i-dma.c                            | 221 ++++++++++--
 sound/soc/sunxi/sun4i-codec.c                      | 371 ++++++++++++++++++++-
 7 files changed, 601 insertions(+), 37 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
