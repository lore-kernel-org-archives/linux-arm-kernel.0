Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28207C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:17:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB06320989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="twgAV6Wo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="BBGyKQJJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB06320989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9N1VWBVIPNDWozi01zoJ6Jp8iprbo0/2/3xAKiGEXYk=; b=twgAV6Wo+NR/15
	WzhKhErJt7s627KRshFEG/RAcm+hlOgfj5xYDozlUSNETC9S8rRfT3qpSRKobT9pywAfdYvGIz1uI
	QlH6tCkJXnuBfGNag5WwoethhNqUSJtwpnRurbw2xs78XEC2INwlLNSuQug4oaIuVoLEFTUofbK6z
	hKSnZ7huh11BCJODgnCh/sCajXdoo2ZcOgYzxROZ+z1HxWI2l1bOnIqcSKzBcWT/lxTLLLGhHSiPe
	jERIJPeBS+L95nuSnWCiHqVELwItgr6rjm1G2RIfRJEbMtLOVDMK5ID/iU+AwHGdt+Qg45iIK/Ehe
	2W5GmZ/XZhCdpgNtjEFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWjn1-0002kk-AD; Tue, 11 Dec 2018 15:17:39 +0000
Received: from plaes.org ([188.166.43.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWjmx-0002kS-CQ
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 15:17:36 +0000
Received: from localhost (unknown [213.204.46.240])
 by plaes.org (Postfix) with ESMTPSA id 4417641030;
 Tue, 11 Dec 2018 15:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
 t=1544541440; bh=WJHmPRGpzdjRM9E54gWuAmfTil1kkRXpmiRybmesfIc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BBGyKQJJTkZWy/KhWygCZi4ie5tSYgxViGAMmN3Kg8wkjf/dXw7Pm2xOURzsNWDru
 lZXlq/JcNiCuGI/mdMkM+kU8AvlmtkDhBpbsQekm3o5ARB+2x4V3iLY4zTn3KeinYq
 AL6SafQU5E+gnHqEd6AdufbmprlU/P8IdOgwmVn9h2bDZlIL65fGOncfTPsi5qIfMx
 frQX7xxO6fVOVaQOePeWone+OgYWAZdSdo/EEKFsSzX794INLs64u0HJH/27Ujz6WG
 d8+MUWMf9VPjSA+s44KjoJ+veCXwXmLMjVfexwV2NRwcPVrS44y0rtFULt9bEvH8Uy
 W7U+dCM+gqUgw==
From: Priit Laes <plaes@plaes.org>
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Olliver Schinagl <oliver@schinagl.nl>,
 linux-sunxi <linux-sunxi@googlegroups.com>
Subject: [PATCH v2 3/8] dt-bindings: mfd: axp20x: add support for
 regulator-ramp-delay for AXP209
Date: Tue, 11 Dec 2018 17:17:07 +0200
Message-Id: <78eafc64831c50005fe5d186c174440d48a865e3.1544512919.git-series.plaes@plaes.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.923997dd7d7396bb4d71f8967698b58ca956b929.1544512919.git-series.plaes@plaes.org>
References: <cover.923997dd7d7396bb4d71f8967698b58ca956b929.1544512919.git-series.plaes@plaes.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_071735_628899_CD3A4A1E 
X-CRM114-Status: UNSURE (   8.99  )
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
