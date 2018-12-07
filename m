Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A94C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:30:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E7C20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WuUoN3b8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e++UA0uH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E7C20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SpL8v5JvD0xrNlxVX+wj9FZDLsMXFwcgE212CSOC9jA=; b=WuUoN3b8zBQV+e
	Z5lNyoUvDvNRh3Ke+hWtP0v1A/5sGtFiG1j8IpvIbjvCv3mNW4YjooL49WHjYTcN/osXoHwelJDNZ
	K1aX38U57zJC9M0mPstFRr2akxZkdhX1IfzPfsk7JNOfhAYvUgNuIWcvw+o5IxCQQEF83Z/jJdNmJ
	nHt2AizA5+6bJ2L8VPSC+++FY6kO5qm24l5opZ+5zRr+PmAw/LJRLoVCVzyB5oLnzyb6gmBNvSUIS
	SbfN76gTou3XbKZOLBKot9RG82esc7OBHGzYMG8mSJQNQ9DVNmzXBdzHdUWcpKjK0zv4BP70LT3FH
	paAfFj9TlNSbtZxuxSKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVI5b-00075f-Sk; Fri, 07 Dec 2018 15:30:51 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVI4X-0004qT-DS
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 15:29:50 +0000
Received: by mail-wr1-x444.google.com with SMTP id t27so4181246wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 07:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KvtupwCwXR8Q8slD54MYCwBpuj1TGFpcxOPBLUHvICE=;
 b=e++UA0uHQ+6kLE3FaVwB/Z/N+4Y9y2pbkIaEj9J915heUrdAw+qXrIT07nbF363x44
 UCMXcfvWRpmSW/Hvao1JtGXn+g2FcPwJ9WKqHV+S/PktliZ+gLTV0W7IKOkwyEFtiRuN
 yAU8GFYDaSQVhSpj0GfdR1Y/t6RtGDbtt8SUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KvtupwCwXR8Q8slD54MYCwBpuj1TGFpcxOPBLUHvICE=;
 b=dnxeETTIDFuSK8v0EUY7WPbrHAj518fLQ4DND56CRUYK3mQtwxtC/NclN3l4plOLfu
 Uo+b22CQ5zjj0AgF/w3jMOIIiijnylXMDDXnIX3ABTdy9OpIkiKMDbYmDMkB11KYqoXL
 S9+Bh7a9uEUXqyR1vQX0akA3BhRmU0zibbytLz2aMlozmZDUFKL0dWSZQZukvr01VA+7
 +eATVtOvfdpmmFSPDsX+hO1TFdO4p6fBNYgCebDxvw/FXxHCSDXGjogxTv/m1PhTcc6G
 LO+JlrRbGrDde9b5jd3d8xrk0QwbkwtDbUwdkjxltEvn5JVEp98ti3zTE9/HlJf9mEKr
 fa1A==
X-Gm-Message-State: AA+aEWbptknLftrzpjbGoPjYGh6lho8vaZrUprq6g1bJtpfCEoS0mkHt
 TRJ87S4BgePmaGCw4ToGO6n886rfO2Dp8Q==
X-Google-Smtp-Source: AFSGD/We2VLPrj12mDcerSGlNDu1Om9qxx1f9i2gEMMukYCrDczxKw7EChcfnXYsxukeA3yeka/CBA==
X-Received: by 2002:a5d:448f:: with SMTP id j15mr2071427wrq.108.1544196573739; 
 Fri, 07 Dec 2018 07:29:33 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
 by smtp.googlemail.com with ESMTPSA id y145sm2728721wmd.30.2018.12.07.07.29.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 07 Dec 2018 07:29:32 -0800 (PST)
From: Georgi Djakov <georgi.djakov@linaro.org>
To: gregkh@linuxfoundation.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v11 6/8] arm64: dts: sdm845: Add interconnect provider DT nodes
Date: Fri,  7 Dec 2018 17:29:15 +0200
Message-Id: <20181207152917.4862-7-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181207152917.4862-1-georgi.djakov@linaro.org>
References: <20181207152917.4862-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_072946_007776_66CDB62B 
X-CRM114-Status: GOOD (  10.39  )
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
 arnd@arndb.de, linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 rjw@rjwysocki.net, dianders@chromium.org, amit.kucheria@linaro.org,
 linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
 georgi.djakov@linaro.org
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
