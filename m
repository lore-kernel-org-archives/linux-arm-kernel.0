Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1356FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:03:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D99FF2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xjoj3Fwj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hR2o5iC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99FF2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SpL8v5JvD0xrNlxVX+wj9FZDLsMXFwcgE212CSOC9jA=; b=Xjoj3Fwj2/RoP6
	YJ5wfjO9FXlx+wFSSov/cj2T1FJ6dQMyYYQJqwT11GNIDvl8z/s9/Ozaaj/1Iet7zm5GSHwqFUalU
	tYy8QfwJU70FluWdOGAKKjAyryicU5U5IIibfdRN8iN29MAYgm8WCrKE4u3m593v8iai6OXg1k9dT
	owHTp73hKPs6jtCY3m057OB8XPH27cyreRJTrdGX2jZhxeTyxp8PETRk5K+/z6wmQ7wNFIdow0rST
	RLpYjFNxg+PHf1XAe3qnIYe+XSQLqKAmCclTVJtiK+t36Lquew6sbYPP1ziTxpYfqUrzkX7U4zZ8F
	KG/LCUyaLBtFcziAe3nw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVg0t-0007sS-KE; Sat, 08 Dec 2018 17:03:35 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVg03-0006jU-Ni
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 17:02:47 +0000
Received: by mail-wm1-x344.google.com with SMTP id r11-v6so7066002wmb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 08 Dec 2018 09:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KvtupwCwXR8Q8slD54MYCwBpuj1TGFpcxOPBLUHvICE=;
 b=hR2o5iC4aEhsnkIzPj4OIYjU9LTPsVxuLVQpifnK1slHocCHFkPJoQYyhmDXiJN/WO
 DDUCxy4uwTWPTq0Pif7GpdgFp9IvhS5tdKk4aBvyet7YuRVtnxpgA0c1ZLk2R6Wk4Drx
 eU2iuOUnSXw/jy29fLH6NNdWO3VLMTJ2dbODs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KvtupwCwXR8Q8slD54MYCwBpuj1TGFpcxOPBLUHvICE=;
 b=jj9FkpKy04BAsrnxuZpgqjmfIOwzhtAC2U7lFoFj6iRY8dhLhtdKl7zKRH/xaTCwj+
 xL1eIJ7MSRouA0LL+2HMpIB4MzmapcGOl+xA0x+bfPl7vWrfOuVc2Ntm6Sqa7EE5Khn7
 k3A7wEHiw2NTGtzhZ2wmFoOGCtydjspbeL7N+4wZTaYWxgERjy/Caq+2tSJOTp0dEHHt
 mJ+tHiOYEbgYJutNublAnrUH1woYExytxIGigQIci2TVpF65eiaRXZ5mB/3VRmX3tft/
 f6N/68LWp7XXNVb08KGs0uur/aqjUF674fSXGd5lWocudmc/AXQ61HnPLa1y3KQsQnId
 oyNg==
X-Gm-Message-State: AA+aEWZvdw1brGhiq7h5m53eAbuDoB5hF5SvgR8bsGNg90KesC5x/Nfp
 jZRFRPB0rRTJR4+dtiRpXpbuXA==
X-Google-Smtp-Source: AFSGD/Xgi4xzic6oIrnwzfikvQQ+V4lq3KezNAbwgIju8yUtz8ERmC+RGnmrE9j5WWRhZVmJ59cqnw==
X-Received: by 2002:a1c:9803:: with SMTP id a3mr5822200wme.69.1544288552242;
 Sat, 08 Dec 2018 09:02:32 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
 by smtp.googlemail.com with ESMTPSA id l20sm17411344wrb.93.2018.12.08.09.02.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 08 Dec 2018 09:02:31 -0800 (PST)
From: Georgi Djakov <georgi.djakov@linaro.org>
To: gregkh@linuxfoundation.org, andy.gross@linaro.org, olof@lixom.net,
 arnd@arndb.de, linux-pm@vger.kernel.org
Subject: [PATCH v12 6/7] arm64: dts: sdm845: Add interconnect provider DT nodes
Date: Sat,  8 Dec 2018 19:02:15 +0200
Message-Id: <20181208170216.32555-7-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208170216.32555-1-georgi.djakov@linaro.org>
References: <20181208170216.32555-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_090244_231358_88953777 
X-CRM114-Status: GOOD (  10.95  )
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
Cc: mark.rutland@arm.com, sanjayc@nvidia.com, maxime.ripard@bootlin.com,
 mturquette@baylibre.com, daidavid1@codeaurora.org, bjorn.andersson@linaro.org,
 skannan@codeaurora.org, abailon@baylibre.com, lorenzo.pieralisi@arm.com,
 vincent.guittot@linaro.org, seansw@qti.qualcomm.com, khilman@baylibre.com,
 evgreen@chromium.org, ksitaraman@nvidia.com, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, robh+dt@kernel.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net, dianders@chromium.org,
 amit.kucheria@linaro.org, linux-kernel@vger.kernel.org,
 thierry.reding@gmail.com, georgi.djakov@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: David Dai <daidavid1@codeaurora.org>

Add RSC (Resource State Coordinator) provider
dictating network-on-chip interconnect bus performance
found on SDM845-based platforms.

Signed-off-by: David Dai <daidavid1@codeaurora.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index b72bdb0a31a5..b3cd256a154e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1324,6 +1324,11 @@
 				compatible = "qcom,sdm845-rpmh-clk";
 				#clock-cells = <1>;
 			};
+
+			rsc_hlos: interconnect {
+				compatible = "qcom,sdm845-rsc-hlos";
+				#interconnect-cells = <1>;
+			};
 		};
 
 		intc: interrupt-controller@17a00000 {

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
