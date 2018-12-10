Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC296C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:45:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77F0D2081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e6TUQobG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="SQz0IQv0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F0D2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sm+S3FNq+J/zqjjc9VBzn+2hJbQID64EEu03vXNx4ls=; b=e6TUQobGDE7T1n
	0IQiRq/ams6X6+k7sKnFQn04cM5rgZ2TZoEyj3q0G61zbtn15P8dAMTqLTRvRsUXLSZXn1Spu5MH9
	MTe2/sJ+aGbeLl33N2G5joObzcjU7e7nxNEswddDdTEh38jVU0tw9NM2TLwot1JTp/B7azeWhkeVJ
	ddj6HHux5gAeTEvRRhaTCcmxQxpM2k2LMRo5Wy3K2vSXgCM2WnT8ST/PziirQAMMGjYbNgXo7M60+
	CuaH90mOEHROMviHXPpMuKztz5KzaMOigHbWWP0SdZHrAG4peglgJSxYjOXPRmJRsw1CCBL33zn/f
	btKvh4j9AgK8wbJy28bg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWQY5-0004yb-Hp; Mon, 10 Dec 2018 18:44:57 +0000
Received: from plaes.org ([188.166.43.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWQWY-0003cU-O2
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 18:43:35 +0000
Received: from localhost (unknown [213.204.46.240])
 by plaes.org (Postfix) with ESMTPSA id 94FCA41911;
 Mon, 10 Dec 2018 18:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
 t=1544467347; bh=snlyZLidIJEaCnhVA6nQ3LGjhvn8FydspTFdTImmP0M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SQz0IQv0kp3gM2C/gvHmVEeCq10zBLBUhrgzqkVmAFLNJYYuEgy2WCJXC5z86/37w
 HBu/YOxmKcktbgqsM59G28edueIEoA5rIv/olUx1lUsaovMgJiQRoAtAeNPzHu3pmY
 uYajVcooyH9AGKHaszB8Qn07e6zMTLNQk/UTipuF46Chs7fHsnV7+uhF1xWXEAfGWi
 Km1yXg4FH9AAYMdMOgUKafVaw+PotE0tutJoPhV4mzluftUncY84eGiDBVBjRnMvjR
 oMP4++DvG8kzsAq0Ik1wQISAlT5EKPeLZ8eQJLKiVkH8cTw5AsAKeyMK1+FufdXxKi
 Sd+NjNByjpwnA==
From: Priit Laes <plaes@plaes.org>
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Olliver Schinagl <oliver@schinagl.nl>,
 linux-sunxi <linux-sunxi@googlegroups.com>
Subject: [PATCH 5/8] dt-bindings: mfd: axp20x: Add software based soft_start
 for AXP209 LDO3
Date: Mon, 10 Dec 2018 20:42:16 +0200
Message-Id: <25e67fe9b5397aa5f11bdd7026e4ae6be51dd18b.1544466940.git-series.plaes@plaes.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
References: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_104323_208147_CBADC0A1 
X-CRM114-Status: GOOD (  10.81  )
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

In the past, there have been words on various lists that if LDO3 is
disabled in u-boot, but enabled in the DTS, the axp209 driver would
fail to continue/hang. Several enable/disable patches have been
issues to devicetree's in both the kernel and u-boot to address
this issue.

What really happened however, was that the AXP209 shuts down without
a notice and without setting an interrupt. This is caused when LDO3
gets overloaded, for example with large capacitors on the LDO3 output.

Normally, we would expect that AXP209 would source 200 mA as per
datasheet and set and trigger an interrupt when being overloaded.
For some reason however, this does not happen.

As a work-around, implement software-based 'regulator-soft-start'
property for AXP209 LDO3 regulator, which is used to first bring up
the LDO3 to the lowest possible voltage and then enable the LDO.

After that, we can set the requested voltage as usual.

Combining this setting with the regulator-ramp-delay allows LDO3 to
come up slowly and staggered, potentially reducing overall inrush current.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
---
 Documentation/devicetree/bindings/mfd/axp20x.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
index c626605..2af4ff9 100644
--- a/Documentation/devicetree/bindings/mfd/axp20x.txt
+++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
@@ -37,6 +37,9 @@ more information:
 - regulator-ramp-delay: sets the ramp up delay in uV/us
 			AXP20x/DCDC2: 1600, 800
 			AXP20x/LDO3:  1600, 800
+- regulator-soft-start:	enable the output at the lowest possible voltage and
+			only then set the desired voltage
+			AXP20x/LDO3: software-based implementation
 
 Optional properties:
 - x-powers,dcdc-freq: defines the work frequency of DC-DC in KHz
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
