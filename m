Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B5AC282DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:40:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 520F320855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ptV/QLsP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gq03+voe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520F320855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=tjIwAbOyjbYNJodG4u9bhW7DiK/+VEIzZTi5CC+OxWc=; b=ptV/QLsP2n3ch7HFueuTKwC4k+
	8N5U37NJupo9Jh8mNNOTHpoXk4VojUpP61byxOYyA06qNNpZCEX2v2A5NiR/ouupgqDjG/jutKYg5
	Q78DJSLt9n844g3lnJEq/P7Ip5L3sKmPBROkb1sHvlA4nlpneycnwAv0Ck5N8B/90n8zqm0lKq1V5
	5oH+FV3uBUy5TFnU+bUAdQysUwwOQFk3B5B+Nd9oc/eyr4aL1YIzGDF7OPBo9zqwpkbFAaK4hOw2Q
	293H5QpuEfR61lToCq/AThe+T2+Ez1dQkqbCEIS6tcAR9dQAjkqXZEqbgK2EWJJBrrXoi91sSJodM
	3N15t3oA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glUCI-0002xP-5U; Mon, 21 Jan 2019 07:40:42 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glUBL-0000vd-GH
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 07:39:47 +0000
Received: by mail-pl1-x643.google.com with SMTP id e11so9384875plt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 20 Jan 2019 23:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :in-reply-to:references;
 bh=WBoPfqiD62qTyJHnIBLq11r66Gu0wg7pVtNBOKSgwDA=;
 b=Gq03+voeUhoaNn1/WdFxKHlzxB7lgh+usqPpa0k3YSSAvc268qEWfw3w701UgteYEX
 hw0FGqP7PBlt/PdldjvEV+eeasLrF5OnvbajQ1IKtIL6XUfQq6EVX2/WOIApBsQO723B
 VeDTEqdS9cPQWabO+jhVVaFliQuxwZWcCKeKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:in-reply-to:references;
 bh=WBoPfqiD62qTyJHnIBLq11r66Gu0wg7pVtNBOKSgwDA=;
 b=dEDnmPkbe2afewYzCFTApgJt6nekZVpBFcGcJcBqUgVAd1QXVGaz1eGSxP1fJ+pfCD
 q5vs0clqoZlB+3HJFZXXTbYi7WlE4SJ20W2yzrnWZesvfuMAYBCIAcdFz23Wz5doTo8q
 2SqY8xoYlFi/6ZJywa/RzBqKbGaIp1Vi1xwA6guyTjM1IK/zeLii/j/0hMknaf+f75X6
 Hbo6LN5AdSA/GeO+ogPatzPRwsfvul+79TmwoIXFoFmHn0kZxhFan15Iu1pnEts+G7JH
 vuxSWbs29l2wkSWIzOjMtKw0Ue1mmusaTP1gzfWmBUvy9QIlvbfTpFnzRcgMvFf4zgxv
 hQhQ==
X-Gm-Message-State: AJcUukcL8/op9Gd7gJ02mTyk1CP/uZL1U2dPIe8lTrnv/oaOQ4r/+Fiw
 HuS56J6ibUWC96yh80klmWL3OX/L5l0YKA==
X-Google-Smtp-Source: ALg8bN6Nfvze4fYHv/A8yGMcDY1+zsxKPpIb1rosgM7lsw5yc9e8aGDCxHXbpFgdNRnAmdU33X95yQ==
X-Received: by 2002:a17:902:7b91:: with SMTP id
 w17mr29154224pll.111.1548056382729; 
 Sun, 20 Jan 2019 23:39:42 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
 by smtp.gmail.com with ESMTPSA id h19sm15583083pfn.114.2019.01.20.23.39.38
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 20 Jan 2019 23:39:42 -0800 (PST)
From: Baolin Wang <baolin.wang@linaro.org>
To: robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net,
 orsonzhai@gmail.com, zhang.lyra@gmail.com
Subject: [PATCH 4/4] arm64: dts: sprd: Add SC27XX fuel gauge device
Date: Mon, 21 Jan 2019 15:38:31 +0800
Message-Id: <4f66af3b47ba241380f8092e08879aca6d7c35b3.1548052878.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1548052878.git.baolin.wang@linaro.org>
References: <cover.1548052878.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1548052878.git.baolin.wang@linaro.org>
References: <cover.1548052878.git.baolin.wang@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_233943_996724_45E4F41E 
X-CRM114-Status: UNSURE (   8.61  )
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
Cc: devicetree@vger.kernel.org, arm@kernel.org, baolin.wang@linaro.org,
 linux-kernel@vger.kernel.org, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add Spreadtrum SC27XX fuel gauge device node to calculate the
battery capacity.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/sc2731.dtsi |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index b52eaf0..1110d13 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -70,6 +70,11 @@
 			#size-cells = <1>;
 			hwlocks = <&hwlock 12>;
 
+			fgu_calib: calib@6 {
+				reg = <0x6 0x2>;
+				bits = <0 9>;
+			};
+
 			adc_big_scale: calib@24 {
 				reg = <0x24 0x2>;
 			};
@@ -90,6 +95,19 @@
 			nvmem-cells = <&adc_big_scale>, <&adc_small_scale>;
 		};
 
+		fgu@a00 {
+			compatible = "sprd,sc27xx-fgu", "sprd,sc2731-fgu";
+			reg = <0xa00>;
+			bat-detect-gpio = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
+			io-channels = <&pmic_adc 3>, <&pmic_adc 6>;
+			io-channel-names = "bat-temp", "charge-vol";
+			monitored-battery = <&bat>;
+			nvmem-cell-names = "fgu_calib";
+			nvmem-cells = <&fgu_calib>;
+			interrupt-parent = <&sc2731_pmic>;
+			interrupts = <4>;
+		};
+
 		vibrator@ec8 {
 			compatible = "sprd,sc27xx-vibrator", "sprd,sc2731-vibrator";
 			reg = <0xec8>;
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
