Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5041BC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:34:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0160B208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zf+n9s3b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q+WAK4u2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0160B208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=nWK4hn07vfNZdonyYEi9CSFsDxFvjubPZNXvXJoFNyY=; b=Zf+n9s3bzhNirMnB/0qanLLX5k
	NEtaSezFbfA7Fw3Q8vWHd8PdGgJCWrH8priVKIQuyHTiSeAf6v7ElhyALJse5PGyl2BFi+cbJ6np+
	2QmTDh91oUBDBG+qu/71HdOMX4FTyXsvWpJDIXvdRh92UNtLBcAHSt+OEHTvbnE04+9PP4iXRazhT
	3iabAECcj/Qkwq1RQvxRIyfOHFu9RX7/glYU0/Dva7H+eDhBlOV0Gg6+PtQGxiMRRh/0wDBG0mRpv
	OY2vrwFJ3ggfLhTYNmgAGEIqJKynOtc/TiT09fNeA99QB1mAuGwcAHtS+lehVMsfaAY6M2SZszEVa
	2oZZ3bDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gheEA-00071M-QR; Thu, 10 Jan 2019 17:34:46 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gheDs-0006l9-Sp
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 17:34:32 +0000
Received: by mail-pf1-x444.google.com with SMTP id z9so5628295pfi.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 09:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cmarbxwYg7HNoDTmchA0P0EFmwoGgD4g+3dBXR4lJyQ=;
 b=Q+WAK4u2sbyObQm/Ez2TxH+W+8fap0fCd+IsfJUIyFepCOkdFBVbxas3hfiwHd7fR0
 LFFEZ96yuVyQE96noa3qbc/FxnhWnk6B76LyErUvkQY/aML86SvSiTkv6dzuudDYFBBq
 VYr+lM6NGifueQ+na4tm4ldvuF6xnHSQd1zOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=cmarbxwYg7HNoDTmchA0P0EFmwoGgD4g+3dBXR4lJyQ=;
 b=PrCW+pJFroRwg/iksCWGfexxnRySsSJn9W5oY5fQ5goCa3/r22INomO3E7BQzPckVb
 /aA0TBQjcLpYrmD5e/UdCG3HuoFbsPlPZdnydJmd9H/0drkPWyb0MIjpJ8/lEoxDET5y
 IIP61504Y2TygtIctbYtrfaBnkGzQ2V1JBXP26PtEtC9A28l09AvdDWGK+2QgNzOvFy+
 QDcWWvipKTQXRotlzdJ7Cqv9ut/rR3mIzzsnr41+H2+FvlGQ7LSg0lWYWO2mgGnG5YTn
 EkQVSJwA+PwzEtGqy8oH42rq95nJhauNZj5Tm5MZXgZaCpqSKAlue9HdlppVFMh+kjnv
 yKlA==
X-Gm-Message-State: AJcUukcW4q6S3c2LEks+H1PV/bQmMe0C63y+nKlkbbt23yI1H6ALDn1v
 HL0q/SWOFc1UlZC16KVGpXk8vgr7D0UEXg==
X-Google-Smtp-Source: ALg8bN7jM1miZVLKVI4ica31RWzk6lss0oL87SAW4AXMcr/zMoA1fw86+xhkL8YjSp4vkQd8KyHDQA==
X-Received: by 2002:a62:399b:: with SMTP id u27mr11482003pfj.181.1547141668168; 
 Thu, 10 Jan 2019 09:34:28 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
 by smtp.gmail.com with ESMTPSA id
 k15sm125977409pfb.147.2019.01.10.09.34.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 10 Jan 2019 09:34:27 -0800 (PST)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 8/8 v3] arm64: dts: hi3660: Fixup unofficial dma-min-chan to
 hisi-dma-avail-chan
Date: Thu, 10 Jan 2019 09:34:12 -0800
Message-Id: <1547141652-8660-9-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547141652-8660-1-git-send-email-john.stultz@linaro.org>
References: <1547141652-8660-1-git-send-email-john.stultz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_093429_082625_81787895 
X-CRM114-Status: GOOD (  15.39  )
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
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 77a7135..472c370a3d 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -560,7 +560,7 @@
 			#dma-cells = <1>;
 			dma-channels = <16>;
 			dma-requests = <32>;
-			dma-min-chan = <1>;
+			hisi-dma-avail-chan = <0xfffe>;
 			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_DMAC>;
 			dma-no-cci;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
