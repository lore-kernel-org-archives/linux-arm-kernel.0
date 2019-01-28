Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE22C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:35:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0AD720881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n+iOXpfi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f5AyREJ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0AD720881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=RnjAuHo2RTak2eSlSspCSWiUhdvPUMkjYHbqBFZukJU=; b=n+iOXpfi4MzqwEcB4U6NfqWSbv
	uZKoNUn++DJjvDhu9qm/+TC6fWWVfuVQhj/ZNbQuZeZokg8J+fmZRRNFhMK+J10N34xEB3YRRBZzW
	Z4Nzqz6Ssbza7WCmrQTQAbBTLgBJZxuKByjMwo4PYkt/lGsf9il/yuDKj7LsbuksuycG1rDwenaNS
	C+tPOLaawkPq5Xyjzma9w8gCrnas/AUJTyaKJmP5wISRgqOR1DJ5VkE+Xx7eF9TE7uD7E4koLxpcC
	D+QUkEQUc6YL/TtspcPYMRnMWkAlwK0sUjYceIhmfzgEHptLh7hjyQ+VN4N2RjPHEwC6ZwiCevdBu
	qWz1IhiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goBl0-0000MK-Qm; Mon, 28 Jan 2019 18:35:42 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBiv-0005lq-RI
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 18:33:38 +0000
Received: by mail-wr1-x444.google.com with SMTP id r10so19195032wrs.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 10:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bXD61WOsWcnEz5wNZP2XyoOaf7zm1bNwGyi1ZRGejfM=;
 b=f5AyREJ63jdfBtSQujWJw4CHJOH9YzluWQ/QaRbKqB+e9lrZDbflqahEW+dvmoShOK
 Q8Vcvd59ZbiwSqptctIKZPV7OCvlALFFu4kV+rd6fRuh5QErIT7DMEFj+pG0ucZDjCyA
 oZK2+7CbBhGiSbBza1Jk/fbW8TMDyu4ejnW+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=bXD61WOsWcnEz5wNZP2XyoOaf7zm1bNwGyi1ZRGejfM=;
 b=t/K1mjulDIejWJacDSasMpKJSI+pcRDQ05cXQfYCiJNXAyrWObxZz8S+n8HW8N7iuU
 in2iX+RD4eNrwB+fYSHxFCYLVAr7YtT9cDRwdym2QTNBE8V/jTAbHRAk07N8z7sdlC2a
 Dr3yxxz9nw6NwFXMOsDrE6OF7XHK4Aa9c7sHlY9kKCtONjaz3Fl55MTaG5OkpVEYJVyC
 Vb3pbr6QHj/wpYNmFsdCQ0JJb/sABBvpFqosKCXwZf4CSUUzViqw/+svDjYDI9G+03rT
 b3M5UpTVe7bHt0dgZkx5Dko4wiEisS+mWRGoq9xX6l/Yla5rc2oH4yTEVNth6YDNL+vO
 dmdA==
X-Gm-Message-State: AJcUukd+Pvgy2cFTtVd6zEmzXSdRsSf6y9ohinKJMEY6jwDOXHmz0tm6
 P05c8QU4L+zylHzBMqliQTbWbw==
X-Google-Smtp-Source: ALg8bN7IUUDiO2kIbBZLQO9YLuKtRgNNn4xP5EB+tVQtTQAJGM2141LERPLElq87BAVY0DZKOPMBWQ==
X-Received: by 2002:adf:db51:: with SMTP id f17mr21594735wrj.90.1548700412437; 
 Mon, 28 Jan 2019 10:33:32 -0800 (PST)
Received: from localhost.localdomain (233.red-81-47-145.staticip.rima-tde.net.
 [81.47.145.233])
 by smtp.gmail.com with ESMTPSA id l19sm270082wme.21.2019.01.28.10.33.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 28 Jan 2019 10:33:31 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
 bjorn.andersson@linaro.org, andy.gross@linaro.org, david.brown@linaro.org,
 jassisinghbrar@gmail.com, mark.rutland@arm.com, mturquette@baylibre.com,
 robh+dt@kernel.org, will.deacon@arm.com, arnd@arndb.de,
 horms+renesas@verge.net.au, heiko@sntech.de, sibis@codeaurora.org,
 enric.balletbo@collabora.com, jagan@amarulasolutions.com, olof@lixom.net
Subject: [PATCH v2 09/14] arm64: dts: qcom: msm8916: Add the clocks for the
 APCS mux/divider
Date: Mon, 28 Jan 2019 19:32:56 +0100
Message-Id: <1548700381-22376-10-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_103334_300263_47F44CC2 
X-CRM114-Status: GOOD (  14.21  )
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
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 khasim.mohammed@linaro.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, linux-clk@vger.kernel.org, vkoul@kernel.org,
 niklas.cassel@linaro.org, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Specify the cloks that feed the APCS mux/dirivider instead of using
default hardcoded values in the source code.

The driver still supports the previous bindings; however with this
update it we allow the msm8916 to access the parent clock names
required by the driver operation using the device tree node.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index c5348c3..729c117 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -425,7 +425,8 @@
 			compatible = "qcom,msm8916-apcs-kpss-global", "syscon";
 			reg = <0xb011000 0x1000>;
 			#mbox-cells = <1>;
-			clocks = <&a53pll>;
+			clocks = <&gcc GPLL0_VOTE>, <&a53pll>;
+			clock-names = "aux", "pll";
 			#clock-cells = <0>;
 		};
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
