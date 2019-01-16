Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0121C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:11:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 818BB20675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ju1rrmQI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QA8zw9++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818BB20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=T16GeWZOiT73dXbLepk/lOj44kq2Yenuf818jj9KINc=; b=ju1rrmQIjQxTw8Bx8fdiX+xKmF
	RQAp2eiuq6jP+ps7B4MvU8ZCNKW9MPyezfPA9bTCLCN53Ehm294BJzutDhnEx6YLYk2D5ABtE7VZb
	aTRZ4lHNcPQJcUvE93EipftU/QwUgkF5WVt8d/XWqV9yd8K0emozqETTOQLKrTMbX3TKDbVa0uPaR
	io1xFhup/8tsiq1X1Y8scF0YVssiW1KY9reBM1rP/RYHz0LfegNdZjYZFZe+jm05M82jz+xuNvu9Y
	saGImijl4ILYrsSL3OlEkl/1QKHKc04NIR9BVbkan2GUfjjVa2PdvKmfyWx2ZkeKxV2xTGF6qxga+
	y+dmxvTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjoij-0000fE-NA; Wed, 16 Jan 2019 17:11:17 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjoiP-0000NC-5J
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 17:10:59 +0000
Received: by mail-pg1-x543.google.com with SMTP id s198so3103723pgs.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 09:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=zv1p7S/mFrTg6FG0oPOD5Dt1Uya0EvieWRYCNbiH1Ds=;
 b=QA8zw9++8TaSkJyOW1+1y02JDAdzqu0K+B7mT7N+0Ct1Rt+8j+7NPvxiy+7Q/e5C5g
 IGNE6QHPW8is1aNGtcopNzRrWUsIeKkCB2OftthzCuf3eM4LRDyLMrdlW4dzHFcEhvgI
 JlgIpAGv4xtOWdySiMiyjPUYbdRXp9aHgRVqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=zv1p7S/mFrTg6FG0oPOD5Dt1Uya0EvieWRYCNbiH1Ds=;
 b=tOZOavhhqIWaRbz7H2mB4uVi52/cRNK5WgOS7Yh0++C6wJtrw9BXsa6m0vb+N0yjmM
 wr2739HffeAcc9ovn7dIGGDasikgWvBK4IE3dxpx89vAG5KUszjUPl68MJZFArlbPZKj
 C/jsNSttN/d151vOCIl5fPHTMx/lg3b5UfOMbJcg0Bz6iKNfnDv0XiDzg5Up56Y7+9Fv
 tN88KOhMGtszW5qdb31dmh+HpIYYHFecN8VosC/+yqCHR43mH5DggyWLsUe7tHsnr4Di
 9VRABXxoPO8TFU8KbQawQjBPjepXmIYvnFv99YovOpIQ3wqoVirnUQ6uM3q/XKUSzb0S
 J2Gg==
X-Gm-Message-State: AJcUukeyRc+7k6GSXyC0C25zbjV3x3qE20cCl85BOPjb7utUL1ic+THX
 OaoELXmFbd7FF2GD6lNMo5jTUQ==
X-Google-Smtp-Source: ALg8bN6yZzVWGRK5hPXdskoOAhCVDv/SGYjZR1jxNnlHFv0GS046diATiQm+voyIP4EEX8oRjCsjfQ==
X-Received: by 2002:a63:2ac9:: with SMTP id q192mr9843070pgq.58.1547658656302; 
 Wed, 16 Jan 2019 09:10:56 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
 by smtp.gmail.com with ESMTPSA id
 h129sm17914023pfb.110.2019.01.16.09.10.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 16 Jan 2019 09:10:55 -0800 (PST)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 8/8 v4] arm64: dts: hi3660: Fixup unofficial dma-min-chan to
 dma-channel-mask
Date: Wed, 16 Jan 2019 09:10:29 -0800
Message-Id: <1547658629-25378-9-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547658629-25378-1-git-send-email-john.stultz@linaro.org>
References: <1547658629-25378-1-git-send-email-john.stultz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_091057_268479_57DD61F2 
X-CRM114-Status: GOOD (  14.11  )
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
