Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C47C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:25:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53E44218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="brouYnBU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GBVgzAGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E44218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=yj7/vriC9AdyZnezfAsdZhRHsHV0HvcsNCXNAOUPy5M=; b=brouYnBUVEkiWDI91oeWsAbnsS
	lEYFzAmRh/r/gThPOfU5K1l/tUaj9C3s9X/5u8DnTzSDJyKRNkPo7JoSSxp2ZUa3d2n1Ai/HkARCl
	FAfQHmeu0Vn/DpUYDeLUsUAtK6Rq664xyA5nwk8HDn755FIYOBwTxzKNmQsRLzNRj5F7wd63Xu38m
	9l3M5QSBTLNtklE/ra6VdjDB+zt6H/KlC9Mc6BDVgbOErTiR+VurvUlCwXP7TdejI7jZe+VRNukG8
	5fLqYiSLPAx/qrR+0WobTB6F2KRyBF67gGNgif/0IKOxN2bc30FI1N1Z+Jpf7u7ge57Qxb/t0rvk6
	qdk0hWJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmlZ0-0007jv-0v; Thu, 24 Jan 2019 20:25:26 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmlYF-0005rs-MX
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 20:24:46 +0000
Received: by mail-pf1-x441.google.com with SMTP id i12so3556462pfo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 12:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BJPwKdPemEfYMv75wEmswxneBbTlFKZrByoYlXp3bSs=;
 b=GBVgzAGeXK+Rhr1uP35wQOeRalFHWCi6YOovZ9EHhbjKLg4yxkKXqnqtApf0Y5S3H9
 b4H4CAPIayf6QvJmzrs55RsV5o8EGOhnulQipxJQbllKeAijXxj1I8a68SNWkSFK/gRT
 R8QtLPrvRqGYp6FmqxxigMenl9z2kGBksziag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BJPwKdPemEfYMv75wEmswxneBbTlFKZrByoYlXp3bSs=;
 b=ugXk+ZO/yHf+BNM2J4iNwDROC3ddwCVCX1BOnZeHMeNrA8y5Pgh6n96s9oRUlc1gs1
 ZShT8i22+Ap7rUpBeEE3rhJAdN8I0nZWIfskwMAebQDvX6tBl0/60JV/70PUaLKqLc1W
 +YX7yED+WubRBwVOkAN73y6poxGpJ5t863hHK8a0OBFdL9NvM0IBMgNzZUp8NZCWNKat
 lyaFyNsh0AlXua5mbn5Tep6Pa3/7fShlEIP4ZFXDO8ZVz9d+6kvlG9z7WGelvXxiWWjR
 ZBijS+GRaWroy09OjsnUs9HT9HHPMkbFHE2x+Io/QFoQ0Mb9eqAu9kXlb8IvkgL2dPXz
 BTAg==
X-Gm-Message-State: AJcUukeNhbgYtNhpbV+UY4Jp07KPrOrhtpa67ppDXRoe984Fi83qBqJf
 tUvkzdjQOMnhX3kPDNKRu+chVw==
X-Google-Smtp-Source: ALg8bN6A6yCdAMBKYtld1GZx43O5sg0gUviTrnslHfiYH9eOjxyBo3E/puHb2tby2efvI4cQdIGP+w==
X-Received: by 2002:a63:6ac5:: with SMTP id f188mr7369721pgc.165.1548361478990; 
 Thu, 24 Jan 2019 12:24:38 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
 by smtp.gmail.com with ESMTPSA id
 c72sm45263309pfb.107.2019.01.24.12.24.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 24 Jan 2019 12:24:38 -0800 (PST)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/8 v5] arm64: dts: hi3660: Add hisi asp dma device
Date: Thu, 24 Jan 2019 12:24:22 -0800
Message-Id: <1548361463-28372-8-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
References: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_122440_229785_29084097 
X-CRM114-Status: GOOD (  14.10  )
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
