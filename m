Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AEEC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:57:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80D0020657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LFQ2RTAN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FplvEqJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D0020657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=uW8g8HWhcl5OI6S8Hed2V5wRGPmiROnP42ojtDoAZlM=; b=LFQ2RTANMhfOikK9bZmhPX9fZu
	+aZI+hTv32yzZrJn8uD+sR8/7UZ66igJCyTeFckY7+VUPYVmpbx05LOJ0b7tSQ/D0PELvVluVXWUH
	t4sclMAgJDSUEtkwiuGO50lJ0Ps/Zrx38qvvgESkAw15q/e2UhNytu5Z+BC1rtnb//zljzC2H2VY0
	j5oBLJ1KV5JjttuJnO4IDW2yRwsqaDc7N46QXPhe/lsWRr0UQmN7tZKeHfBNCyTHutpPUJR9Cen8t
	wA40x3S4EbmIV92cohGNecrnZDTchVxpjJWFUJj7rW7rTV7gSmeUPCsVK+4GXntfLcmyeYcNGB3cM
	sMpL0LDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfWWc-0007XQ-J6; Fri, 04 Jan 2019 20:57:02 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfWWK-0007EI-Pm
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 20:56:48 +0000
Received: by mail-pl1-x641.google.com with SMTP id y1so17911800plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 12:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=x8FLQ+g/7eCfd1VnKMng4eZMRIm7A0veiMcyJNgJ9zM=;
 b=FplvEqJn0/GhoTUK07SiH49OQp68tTWAGSKbl7VAyGPJk7zanN45ArCR3O3leEDbrv
 WCcNlwlqYl0bQO3X/K/DTgXkIcOr8uu03Sa3QPooUhaoLOQnBBKKBXjE+F+Q57s6TQj9
 xHhgQoiP0kjYyMcc8y62SRf+HvNniKIA0zabE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=x8FLQ+g/7eCfd1VnKMng4eZMRIm7A0veiMcyJNgJ9zM=;
 b=iKp8qquVGXfgLAgv8TaKiws760jdpHuTZOCLVLKw7hH1Iu/aVTZ6rh2ZIb/n+QF8CN
 CDAIa/vmN69NKTUuy4cVza0CAQW4cA68pgf1uRIOuObFb+J2b2ZYjsmXEkuFQ4ocs39Q
 WQQdWSQIe7XRJxmXjXT6ib2EjNKQqK1DfW3BgPviB9pU/3zjVIltTeEYbs5JCXDrJxc5
 d612+pSQ5HDUaKvJwPvbrR5wCZnQtath/IVHK+muSVi63P1IceG5js7mhexWBGdUiwDe
 PTurhnNt9i+DX/jgjL2YU5ziof+vuLylL6RbBEqVgiXvmak2dqnovPW78hS1xNYlhdow
 gbkA==
X-Gm-Message-State: AJcUukejfseuHAAqFnqVirxUKve4XO9GViRChPTWo5VCqXYr52HRbQc+
 s/iCAHm3uD0OgMgIM9wykEkqow==
X-Google-Smtp-Source: ALg8bN7ybpmqlKyfxFKQLyfVL7T+0oXkm3rFJgCaTiIMKOKiHEBeeKw0/TfjDCeMGdQXg6oV1C0Wmw==
X-Received: by 2002:a17:902:6113:: with SMTP id
 t19mr50809853plj.248.1546635403461; 
 Fri, 04 Jan 2019 12:56:43 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
 by smtp.gmail.com with ESMTPSA id
 l3sm98058334pga.92.2019.01.04.12.56.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 04 Jan 2019 12:56:42 -0800 (PST)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/8 v2] arm64: dts: hi3660: Add hisi asp dma device
Date: Fri,  4 Jan 2019 12:56:27 -0800
Message-Id: <1546635388-13795-8-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_125645_163247_EF467443 
X-CRM114-Status: GOOD (  13.86  )
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
 Youlin Wang <wwx575822@notesmail.huawei.com>, Ryan Grachek <ryan@edited.us>,
 Zhuangluan Su <suzhuangluan@hisilicon.com>,
 Tanglei Han <hantanglei@huawei.com>, Wei Xu <xuwei5@hisilicon.com>,
 Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Youlin Wang <wwx575822@notesmail.huawei.com>

Add asp-dma device to hi3660 dts

Cc: Tanglei Han <hantanglei@huawei.com>
Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
Cc: Ryan Grachek <ryan@edited.us>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
Signed-off-by: Tanglei Han <hantanglei@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2: Removed undocumented bindings
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index aaa2b04..df4e96d 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -569,6 +569,16 @@
 			dma-type = "hi3660_dma";
 		};
 
+		asp_dmac: dma-controller@e804b000 {
+			compatible = "hisilicon,hisi-pcm-asp-dma-1.0";
+			reg = <0x0 0xe804b000 0x0 0x1000>;
+			#dma-cells = <1>;
+			dma-channels = <16>;
+			dma-requests = <32>;
+			interrupts = <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "asp_dma_irq";
+		};
+
 		rtc0: rtc@fff04000 {
 			compatible = "arm,pl031", "arm,primecell";
 			reg = <0x0 0Xfff04000 0x0 0x1000>;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
