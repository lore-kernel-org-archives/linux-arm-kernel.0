Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F02C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:17:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34DDF20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mDmTUOTf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="oHMqxd0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34DDF20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8Eq/2XQ6fbibIQLVYEY2YIH7X2oQoZ/ukikKMqQjWaE=; b=mDmTUOTf0zUTp/
	GbU8W5kZq1li5c5ITmGclT8Kxyof4ogL0g2dItK8cfEamDWgyZQ45b1dL0oUWvU8jQTlfmYi13L/0
	iID5VX6F0UDzqOqMkYdza5juIvVvz19V/9fcUKi/tbqg1P1zidG6kxRpbPtzSwF/rapY4nkP8KP3N
	/7lz7PJA3+4tKAtn4oow5J0deDyQfLlvk8uNRkI/kdZYsoKKdEDUMMcCFKYpzs29Jt8HhyAeG3VM/
	WknHxuvNcCMQ6feuUYFXFKw76ebv9jRPwi3EdbNSREXKMsWFCw2Q2QAxlhBxl95x17SMquEjSMhp7
	E389clhFvXbRWZi8zJDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWjnE-0002yK-Aw; Tue, 11 Dec 2018 15:17:52 +0000
Received: from plaes.org ([188.166.43.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWjnA-0002kj-53
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 15:17:49 +0000
Received: from localhost (unknown [213.204.46.240])
 by plaes.org (Postfix) with ESMTPSA id E114941803;
 Tue, 11 Dec 2018 15:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
 t=1544541442; bh=rL1R6deG8R4m86FOSDKOCU7rxrxi6SE5YJnbhqg7w48=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oHMqxd0F9qGE6lgVaPX/rL2H9UKd/k6bbS7ymcHjc1n7JVX3kqCHbGmzlW83zr657
 dkrm6dF64Vlo4XbOQsiG36/hVic4zad+njeQUjQiAUGuvyJWPquVTrpZhZEICPQCAg
 6aSKkGTjrhrlyUNT504HuGdfWQmyyCLZFchBlgJMPNf/Cw2TbqKelmNoeBOU3Ej8ZA
 PE3LSLfW5Ow/1p/1Txn6QpijEAUw5qnaMO2MFovGFwIfSeEsS2InhdRqGdIWpd6e4i
 wf7wsr3aIua+RmUic2vuC4sI3zDxG4ZKrMO8Qnj0oxawQ21LE9KmcewBRQwVjm0Lj+
 IhqirIZyBLPlw==
From: Priit Laes <plaes@plaes.org>
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Olliver Schinagl <oliver@schinagl.nl>,
 linux-sunxi <linux-sunxi@googlegroups.com>
Subject: [PATCH v2 6/8] regulator: dts: enable soft-start and ramp delay for
 the OLinuXino Lime2
Date: Tue, 11 Dec 2018 17:17:10 +0200
Message-Id: <b76e1964fee095164ed9313e9f57d4d4318c083f.1544512919.git-series.plaes@plaes.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.923997dd7d7396bb4d71f8967698b58ca956b929.1544512919.git-series.plaes@plaes.org>
References: <cover.923997dd7d7396bb4d71f8967698b58ca956b929.1544512919.git-series.plaes@plaes.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_071748_429312_D8D44CA4 
X-CRM114-Status: UNSURE (   8.95  )
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

The OLinuXino Lime2 has a big capacitor on its LDO3 output. It is
actually too large, causing the PMIC to shutdown when toggling the LDO3.

By enabling soft-start and ramp delay we increase the time for the
capacitor to charge lowering the current drain on the power regulator.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index 55c9086..4e1c590 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -232,6 +232,8 @@
 	regulator-min-microvolt = <2800000>;
 	regulator-max-microvolt = <2800000>;
 	regulator-name = "vddio-csi0";
+	regulator-soft-start;
+	regulator-ramp-delay = <1600>;
 };
 
 &reg_ldo4 {
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
