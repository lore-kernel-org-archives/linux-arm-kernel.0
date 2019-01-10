Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F34C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:34:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20BBB214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ScapxXre";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iuy9V6jq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20BBB214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=yj7/vriC9AdyZnezfAsdZhRHsHV0HvcsNCXNAOUPy5M=; b=ScapxXre+OmMYDCDmUEaPl880m
	APbA111KKaRklF4n7/tA5Cem0DxoU7Ra4oNDnS2BJpt1HM6ThKA7hRClUv3MO6ocLO/bi4iPb6xeY
	9NvVetOaIFB9rJKNdww/0vYaltdxioLdfdgTS8sXeOHjWJ3aorkt4Dxwn8lqUG4odloE91pNVmUd6
	L/GAkl5u9U7t7T+ZZXd7JiGNawLOoA0nOqSSwBOX1kRdWixMCnuo6iGaiwnZGYZje6rPwckFZjLdE
	f8RODvJlHWciVstCTFgmOL+dUQjvJi2ouNSamEYdS62LkJSfyOKskOCbzNxaNwLKnbV178rde8kcC
	zQelPRqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gheDy-0006pl-49; Thu, 10 Jan 2019 17:34:34 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gheDr-0006j6-II
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 17:34:31 +0000
Received: by mail-pl1-x644.google.com with SMTP id u6so5470975plm.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 09:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BJPwKdPemEfYMv75wEmswxneBbTlFKZrByoYlXp3bSs=;
 b=iuy9V6jqxAJvqy6tSRvIkhHDKg8AXbR5U4GoOHS7AYuJ1eQsjPeBl4HoCL+CJbK8js
 YmeTND5LSvjqetT9V/BjRuIcOw7EE85aB+fz0Br7Bpbw0ga8wRqG+Gtk9Dn13KEepPQt
 8OdyWhubbn3WBx+yHycjEcSI0/RspL/JCEcUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BJPwKdPemEfYMv75wEmswxneBbTlFKZrByoYlXp3bSs=;
 b=MEYlDijmKGNRh10VI4akTRSmNi1j1YjMTEE0mSCNUo/sOU5AL0l26HZpJHi9QM4Mv+
 z6kwl6jJP4zGa4J2trqzMLokVwW5nH7Yp+7irRNeS8Oubk3yucHPtsippIneAFq3V0Wc
 Ga39o5bz9Fjbj3ELsjhFO3uJEfiaBkL53Yl5D164HVc71BqjamA+nziwO+mZ0l7DEDgT
 xcOLeNkNHV6QEVjeoBOMTXPRblWFM9INZSGVVhDm2hBnM7mIuMt7N0f3zL+VEm6iTnQb
 Aoo93fWH6P/D/bDAV2anUx5DTfmngOVLjunBX1Wq7RWuJO7+o989+lfCq1jYeg0oFe8k
 xGAQ==
X-Gm-Message-State: AJcUukfYoAwbYbX2ic/vFO5DdMW0yjhBS45WtIs5mYTlQj8XNHKhabf9
 LV5SWdent1iA7JPymeiVlBCIvw==
X-Google-Smtp-Source: ALg8bN48czPk4P5inKX4Efd+Xi+gXZtHTbv+vius5pKpS0Z5BoHbBlmB83+2n1+SsSrPUACT2FXgcQ==
X-Received: by 2002:a17:902:1101:: with SMTP id
 d1mr11079391pla.136.1547141666568; 
 Thu, 10 Jan 2019 09:34:26 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
 by smtp.gmail.com with ESMTPSA id
 k15sm125977409pfb.147.2019.01.10.09.34.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 10 Jan 2019 09:34:25 -0800 (PST)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/8 v3] arm64: dts: hi3660: Add hisi asp dma device
Date: Thu, 10 Jan 2019 09:34:11 -0800
Message-Id: <1547141652-8660-8-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547141652-8660-1-git-send-email-john.stultz@linaro.org>
References: <1547141652-8660-1-git-send-email-john.stultz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_093428_010530_4486668B 
X-CRM114-Status: GOOD (  14.45  )
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
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
Signed-off-by: Tanglei Han <hantanglei@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2: Removed undocumented bindings
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 4c8d682..77a7135 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -567,6 +567,16 @@
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
