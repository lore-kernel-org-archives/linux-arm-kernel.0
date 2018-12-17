Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7C0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:50:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 571F52086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b063x8jQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="djAqVDeH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571F52086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=5lfl4alla6x0203fSXdXWcok4dD2namFFvaHFf1RdFQ=; b=b063x8jQMTthu64dD8xCtg5Q3m
	RH6nt1NwBRvb40TjPN+WnWE5+vV5kLxvJ+Zp43MWZ8LR9l8W71geG43RoQtLmeOY9s1J1kTTwnj1V
	FqPGVlVmw45WcOYmfRCZHEau1taP4eDkYy1gpdbfOznDCTEEcd6q6AINmbjBp/om7341elOdKM3t/
	JRs4ZXgV3t4ryvTt791prZ87FfKw7i4APC9V276Oh88NK0vL5APR8VnMHRt+g9ZP5HAkks7yjd6bf
	NnX0Xl8cypmDd637S+6//7GMnh3dVca/JX/lc/FXaAzQ3EGJ0gbGF3uuJgb9v7Uq7ea3umh5g6u3s
	aeWgUd8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYpXD-0000Y4-AD; Mon, 17 Dec 2018 09:49:59 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYpUO-00060f-D8
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 09:47:11 +0000
Received: by mail-wm1-x341.google.com with SMTP id c126so11867195wmh.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 01:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=kTA3U9ScqlvZ998ocosntNRdd+QbUhit3GNzARqwjzg=;
 b=djAqVDeH7UHgLmI/fEsam8Ncl44t1Emw5MTX1v5R5vyJdCn07rwL9uuPBLz+HB6Wqg
 qxG6HOhDt7GadmSwpB2vkA9Js6rjuMHApzlPoEUr6bvbLhYSM87tUx6EX4uqJZEbwr6D
 RW6V68mmJyEp0GDqut9HT34xRxetOCvR/G6eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=kTA3U9ScqlvZ998ocosntNRdd+QbUhit3GNzARqwjzg=;
 b=cw5kuL6EEjtDz72EK9o/aFCaxEnvfBf/KP16XWsa58SVtJ6Z+cEQnDj5CpSY/tT5BE
 4ARWwn9wberXEqLsAyZWW1qfhyhAwnXWwzNJQtldS3NFAy8brTT6c6WmjlBoIeWi+3jk
 rxLX9U7Q197AYNXOaVHHZzrmYW8Tp6c+1pLr/Qg+BkWdUlt15Rz4MXoIQvdTE/KM75/v
 tLwPFTjcsIysOhS81Vs/nYx7zN96gSet0HMCk5jkh3fS9F3FmRBVOdi7A4Tb/VjKgCy1
 M5lMe/5J4XKghtU0f6Rv2Y+Pm6BGL108K59IvmPsnqj2JLLwene6rTL8jdVzlHXMYRzb
 fXog==
X-Gm-Message-State: AA+aEWbZ/IL6ewtPkwCK4jpp2RPRfKGXyE+jwdQrs7F7xvUhrc2YQ0eS
 lvEIuQhUPwsP5KSwGXC/BgO8jA==
X-Google-Smtp-Source: AFSGD/V4BGQMKM78e8WXM5uLM1kGzoHYfpgHOemT72KntElTnAau5TXeSCLqPSjtmv+oX5csPxZ9WQ==
X-Received: by 2002:a1c:a401:: with SMTP id n1mr11715639wme.114.1545040017092; 
 Mon, 17 Dec 2018 01:46:57 -0800 (PST)
Received: from localhost.localdomain (58.red-81-47-145.staticip.rima-tde.net.
 [81.47.145.58])
 by smtp.gmail.com with ESMTPSA id h12sm28878113wma.48.2018.12.17.01.46.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 17 Dec 2018 01:46:56 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
 andy.gross@linaro.org, david.brown@linaro.org, sboyd@kernel.org,
 will.deacon@arm.com, mturquette@baylibre.com, jassisinghbrar@gmail.com
Subject: [PATCH 11/13] arm64: dts: qcom: qcs404: Add the clocks for APCS
 mux/divider
Date: Mon, 17 Dec 2018 10:46:28 +0100
Message-Id: <1545039990-19984-12-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_014705_955494_5131A4FF 
X-CRM114-Status: GOOD (  12.29  )
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
Cc: devicetree@vger.kernel.org, heiko@sntech.de, arnd@arndb.de, olof@lixom.net,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, bjorn.andersson@linaro.org,
 enric.balletbo@collabora.com, vkoul@kernel.org, sibis@codeaurora.org,
 niklas.cassel@linaro.org, horms+renesas@verge.net.au, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org, jagan@amarulasolutions.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Specify the clocks that feed the APCS mux/divider instead of using
default hardcoded values in the source code.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index ec3f6c7..2d9e70e 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -373,6 +373,9 @@
 			compatible = "qcom,qcs404-apcs-apps-global", "syscon";
 			reg = <0x0b011000 0x1000>;
 			#mbox-cells = <1>;
+			clocks = <&gcc GCC_GPLL0_AO_OUT_MAIN>, <&apcs_hfpll>;
+			clock-names = "aux", "pll";
+			#clock-cells = <0>;
 		};
 
 		apcs_hfpll: clock-controller@0b016000 {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
