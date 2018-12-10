Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB04C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:43:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 494862081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="crL7thuu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="VrM8NZ6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494862081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9N1VWBVIPNDWozi01zoJ6Jp8iprbo0/2/3xAKiGEXYk=; b=crL7thuuijZ+Js
	m/auCcB3poVkCJeZWr3olXyCI3xeiFf2XVV0SmTb+aO877BPZ4PBnPZvryhlN/d/HACSK9IwavDiL
	HylkEY1a7ownem+w5UOhJGkr1P5sgvp7ql5+X9ZSLKmXWcU9RcF/swh8YRJKDpwRxiF6zFxY8S13k
	BSlKfpYfVxHywXhLVBCPYDSxi4U8J8nb4iantCn4JvGWbQ1cv0g47sRXU8iRy7fCgNMA9pctnYBX1
	3FzUn45cUdXk7dawhCvriXyAeBCp/UYya2eEZyZPUE5WwBMcIbjEHKvFBfvs/kr97am3Nq5AXJWCH
	kEXnUF1UrQ8iCO/TWxEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWQWI-0003Ru-MJ; Mon, 10 Dec 2018 18:43:06 +0000
Received: from plaes.org ([188.166.43.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWQVs-00031Q-1i
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 18:42:42 +0000
Received: from localhost (unknown [213.204.46.240])
 by plaes.org (Postfix) with ESMTPSA id 730F2418A8;
 Mon, 10 Dec 2018 18:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
 t=1544467346; bh=WJHmPRGpzdjRM9E54gWuAmfTil1kkRXpmiRybmesfIc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VrM8NZ6yzq2c2812K0TUVY3+m0ogRnsglxCeCOA4rUW5t2vx72RGUlJy9lO0pDpRo
 f85Rkc+rCLxkhXQLDiVZ9wmFqORHJqsalffvRj+oUJtK5MuybhOt2g/GN/TIB0LRtU
 fPjD4dT/YZKLHUEtnUEr7nyUy3dIg+H+TlDUDvtw7XlOnS3QA50IDnqkDqQqI3CegB
 FujHyNkqfaLjZVeLHOSVJVcUaPi7MB+Lx3+VtDhpZfaWff6Hecz9B4SfOnCTz+qmGD
 HRBSn8UR0HY+2mXlJnRpadqXggcqOFtmO5r6LVPzoHluP9Y896sLJrLziTR3gFfG5T
 9QkhHHi3iL3FQ==
From: Priit Laes <plaes@plaes.org>
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Olliver Schinagl <oliver@schinagl.nl>,
 linux-sunxi <linux-sunxi@googlegroups.com>
Subject: [PATCH 3/8] dt-bindings: mfd: axp20x: add support for
 regulator-ramp-delay for AXP209
Date: Mon, 10 Dec 2018 20:42:14 +0200
Message-Id: <78eafc64831c50005fe5d186c174440d48a865e3.1544466940.git-series.plaes@plaes.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
References: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_104240_244490_3B76A219 
X-CRM114-Status: UNSURE (   9.36  )
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
Cc: Priit Laes <plaes@plaes.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Olliver Schinagl <oliver@schinagl.nl>

The AXP209 supports ramping up voltages on several regulators such as
DCDC2 and LDO3, therefore we can use the standard 'regulator-ramp-delay'
property for those 2 regulators.

Note that the voltage ramp only works when the regulator is already
enabled. E.g. when going from say 0.7 V to 3.6 V.

When turning on the regulator, no voltage ramp is performed in hardware.

What this means, is that if the bootloader brings up the voltage at 0.7 V,
the ramp delay property is properly applied. If however, the bootloader
leaves the power off, no ramp delay is applied when the power is
enabled by the regulator framework.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/mfd/axp20x.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
index 188f037..c626605 100644
--- a/Documentation/devicetree/bindings/mfd/axp20x.txt
+++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
@@ -32,6 +32,12 @@ Required properties:
 - interrupt-controller: The PMIC has its own internal IRQs
 - #interrupt-cells: Should be set to 1
 
+Supported common regulator properties, see ../regulator/regulator.txt for
+more information:
+- regulator-ramp-delay: sets the ramp up delay in uV/us
+			AXP20x/DCDC2: 1600, 800
+			AXP20x/LDO3:  1600, 800
+
 Optional properties:
 - x-powers,dcdc-freq: defines the work frequency of DC-DC in KHz
 		      AXP152/20X: range:  750-1875, Default: 1.5 MHz
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
