Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C8FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:04:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 709472147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HkHKJfhd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mathembedded-com.20150623.gappssmtp.com header.i=@mathembedded-com.20150623.gappssmtp.com header.b="EFQUjzCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709472147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mathembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=2D5xSdZIG1+7PyxDALQpDTcBW4czCNU6INsjGi68wCU=; b=HkHKJfhdkKp1P5
	RZ3ozUebkOjMaaTtKXfHQzq2EJpRnu0i9hL0Gl8TBCvkc6uBHTxqgYz8mQ7iup7Uwt/+arvbLss8I
	MnlwBOtw+ma9HQ7s/n5VXFseTvNpXCYeG07kE2cxXtTNjuQzuUVMbdadmQajYRJDjW12OCmnw6Lcw
	wbNDFQroi93A0z25Ep/Nul07WRdZG1FwPt2tpzZspLFdsx2BxJczQo3yucEM4SubpQuvWkCj9IWPE
	4KIvgWSg+Kd+PWuaRD/P9Y2HNxwJv3kw4Ox74UBnF9cuXImjK7SYUNzmJuZIL5TMnoPY6ezUjb0ys
	nCnO8HahvNNb/mtz8Glg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw54S-0005l3-2h; Tue, 19 Feb 2019 13:04:24 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw53n-0004wG-AJ
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 13:03:50 +0000
Received: by mail-wr1-x442.google.com with SMTP id c8so21876889wrs.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 05:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mathembedded-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:subject:date:message-id;
 bh=+gQlFZa1wdF25zlNKhW2637JpdXuTp6UB6jqREyKiOE=;
 b=EFQUjzCzBaBnTbOTiQ3kB5vpOPa0wz23b3f1dRZs3GghvdENheV6nccoLJlACL25ot
 mtqlH2y1e7JwhrCFYlvqWM7b9NHBTSGRq9Se7XfVKI4cr8drR1ofcOFX9JM/7bCVU39A
 9egW65Y0qtgqVSaPK5dAHZv8nfVJz0nnelTrE6TI66mscmhn9bmohS8rxHkS6RZpLTcg
 RPQczq/KKngZp/K9rncicCiob+4wi8skSjyi5gbwIg/t9uRI+SAwbQ46mVvpnoeeeytM
 ObeHUA7ZHt2jPgBBnD7VJ+zP1hLl4ml4CLdM83cwXjf80SG868WBO6+tEUE46Alc7u+/
 8nNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id;
 bh=+gQlFZa1wdF25zlNKhW2637JpdXuTp6UB6jqREyKiOE=;
 b=rrTfmJ/FOBErn7FphdzJgXJvj3rLPAWRfwoVNVjDj0fFOQXgg/WhOvMe36ZMhYAzuc
 rnRKS+4hOhGqto7owW7wFj/EeY14Wi9mXKzZInAAB+3cg++tpWB+6+NDsrhQltkvabcN
 3D7OFswE7SMQrJOgFSVhnLobA8sYeBgnq5QQfuMwHjGQlI+DUTJx0IuJnhGKV/IhkMKx
 Ovmsch+zJoG5VG94A60jStDyPy7m4ww7PydvQkeBS4zTf+sY93u6CmtrcwWqitugzi6k
 7nXzOOWxO2KeRntD5vv/lPPRWwWpVBmVRgGA8mspi80KTrWIRf5VCG1iVKkwL+eKZ8X+
 na3A==
X-Gm-Message-State: AHQUAuZO7BXqT1kiatlglVUuw1TKGRM0umYqdeMqSLGl8R/pT05L2WkM
 OchzMwH13lZVl6IswtaILuJDHA==
X-Google-Smtp-Source: AHgI3IbS2Q5qLE/JWW7pqezyvz51nUcoMMmlGLa1pZ6hh0XdR81xHuRLW5leWVQ+QtjI+ftSrYD3qQ==
X-Received: by 2002:a5d:6107:: with SMTP id v7mr21664141wrt.78.1550581420366; 
 Tue, 19 Feb 2019 05:03:40 -0800 (PST)
Received: from diamond.mathembedded.com
 (host86-137-106-133.range86-137.btcentralplus.com. [86.137.106.133])
 by smtp.gmail.com with ESMTPSA id y22sm61899811wrd.45.2019.02.19.05.03.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 19 Feb 2019 05:03:39 -0800 (PST)
From: Stuart Menefy <stuart.menefy@mathembedded.com>
X-Google-Original-From: Stuart Menefy <stuart@menefy.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Russell King <linux@armlinux.org.uk>, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Devicetree updates for Exynos 5260
Date: Tue, 19 Feb 2019 13:03:33 +0000
Message-Id: <20190219130337.21353-1-stuart@menefy.org>
X-Mailer: git-send-email 2.13.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_050343_416063_CCA85479 
X-CRM114-Status: GOOD (  14.74  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

These four patches are stand alone updates for the Exynos 5260 device
tree, which do not depend on any other code changes. They either
fix issues or add functionality which is already available
on other Exynos devices. They were previously posted as version 1
of the larger patch series "Resuscitate Exynos 5260 support"
https://www.spinics.net/lists/linux-samsung-soc/#65035
which was only posted to the samsung-soc mailing list.

Changes since v1:
- Removed from larger patch set for easier review
- Applied reviewer comments to patch 2/4 "Add high speed I2C ports
  for exynos5260"
- Expanded patch comments

Stuart Menefy (4):
  ARM: dts: exynos: Use bustop PLL as the source for MMC clocks on
    Exynos5260
  ARM: dts: exynos: Add high speed I2C ports for exynos5260
  ARM: dts: exynos: Add interrupts for dedicated EINTs on Exynos5260
  ARM: dts: exynos: Fix interrupt for shared EINTs on Exynos5260

 arch/arm/boot/dts/exynos5260-pinctrl.dtsi | 16 ++++++
 arch/arm/boot/dts/exynos5260.dtsi         | 82 ++++++++++++++++++++++++++++++-
 2 files changed, 97 insertions(+), 1 deletion(-)

-- 
2.13.6


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
