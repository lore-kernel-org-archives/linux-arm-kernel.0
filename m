Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961B3C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:25:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63819218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QweTYWGQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dGm2Ozq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63819218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=T16GeWZOiT73dXbLepk/lOj44kq2Yenuf818jj9KINc=; b=QweTYWGQn8juImknC5POI1uHHK
	rpomNW+CbTo+3GtNZgcSZuLR0zXhFt2ZFl9CtiVf5NBjikZgq+540kGowvo251mzP1rB3972fxN5H
	T/SvKYZCheEMqju9Q7iKcioERf2T+tcBcw9Dy5QcOCSO3l/4QtToB3PXoIByApETu129IiadE8PhZ
	9kw6BPCm3NFmpyfe2ic3BVcrEzcbaI/pAIDr2R1U/qXLhdxbAl7MB2DHvzBqQsEWWOnLf9kxdJUsR
	SxkntLJfcAFMfRB1ZJRtzBWUlnAZX56uNwLwAC0rz8AANzXzea0pkyx6vWnky+x+DzjJjHGy8jYWu
	8IH7wNhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmlYj-0006Vj-7M; Thu, 24 Jan 2019 20:25:09 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmlYH-0005u2-AJ
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 20:24:46 +0000
Received: by mail-pg1-x541.google.com with SMTP id j10so3169887pga.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 12:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=zv1p7S/mFrTg6FG0oPOD5Dt1Uya0EvieWRYCNbiH1Ds=;
 b=dGm2Ozq5crp8+eZBR16Xeq//kci+lmx85Knj9jwZD4b+AHP0VpEYFz0Takk7S5Iaqy
 Wfq+Kpf2etqcgQ16ATmrRPKcvbtm3KUm88Gvh3qP9JL+N7OeSefxoPObqKJziK+HvHoT
 qhcVqvcIfwfAAdLAO1uHUSBFmdIEQAEXYuYNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=zv1p7S/mFrTg6FG0oPOD5Dt1Uya0EvieWRYCNbiH1Ds=;
 b=f4Dzj/U+gd1+5MYE2fv9Rf0CrNyF6EDOFPVIxT8ic/EskhjGWKz46XZIpmke7mkw+6
 77f6u6hgdebAfDoNYAgsvrOVGKWfHfMwWJhgNPbYLhzagOvByTyzMliQOnFIGvINQnCJ
 kpxWcf+8toAn9l0giL92GUXQy+Bp62zIeyOuHM4Si8U85k8tE95wcsEWrDKtryO8uHrq
 CmApz8vaImbXs+ysCA4K6H+d5gKe1a/pD/xWK6tbHXxWYQ3l/xgbg0WDJaO5U5tFnH1v
 1bYC2VeKh9lHt5aNcH1MS/fAUokpBZq4y6sgzhNF6MdoT3pOKfsCYd8aCV5Gb15zGHhd
 umpQ==
X-Gm-Message-State: AJcUukcUdLl4PqN0OSOnhMouduQ8XVS2kCzayrGsWmYIc2sbc1I1vlYl
 7XWLS62X4q4lVkzbwPkzXZyUuQ==
X-Google-Smtp-Source: ALg8bN4BK6Qul4gBOxPwsPa1bw2asGXGLk8N0wxFWhdu3ikDvvh2cqu12xyZ67ramgXwQ6tNjk7GZg==
X-Received: by 2002:a63:63c2:: with SMTP id x185mr7236745pgb.374.1548361480562; 
 Thu, 24 Jan 2019 12:24:40 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
 by smtp.gmail.com with ESMTPSA id
 c72sm45263309pfb.107.2019.01.24.12.24.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 24 Jan 2019 12:24:39 -0800 (PST)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 8/8 v5] arm64: dts: hi3660: Fixup unofficial dma-min-chan to
 dma-channel-mask
Date: Thu, 24 Jan 2019 12:24:23 -0800
Message-Id: <1548361463-28372-9-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
References: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_122441_762647_15ECA079 
X-CRM114-Status: GOOD (  14.76  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Ryan Grachek <ryan@edited.us>, Zhuangluan Su <suzhuangluan@hisilicon.com>,
 Tanglei Han <hantanglei@huawei.com>, Wei Xu <xuwei5@hisilicon.com>,
 Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

A undocumented and unimplemented binding got into the hi3660
dtsi, and this switches that binding to the now documented one.

Cc: Tanglei Han <hantanglei@huawei.com>
Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
Cc: Ryan Grachek <ryan@edited.us>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v3: Renamed to hisi-dma-avail-chan
v4: Renamed to dma-channel-mask
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 77a7135..8e48f42 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -560,7 +560,7 @@
 			#dma-cells = <1>;
 			dma-channels = <16>;
 			dma-requests = <32>;
-			dma-min-chan = <1>;
+			dma-channel-mask = <0xfffe>;
 			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_DMAC>;
 			dma-no-cci;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
