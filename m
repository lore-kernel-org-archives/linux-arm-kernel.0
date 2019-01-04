Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00EEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:57:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A809F208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aiCKk6bf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BhfGSs8Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A809F208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=rBGRe2I8dWphBRvxq8tqofJcAhCnusR28cE1IqNAtL4=; b=aiCKk6bfz0z7VN3t4VBIVdi99c
	gvC41/Qbu9qu1xl0F+TnJNa76SbxmUigVOvztRyB3s9boMuDAsiVAOfRYxPRbMjUWqO/vbmKz/YO0
	20S2H+wxob471O6GyNglvWpHuNPvf+r3CP4qnDDkqb9J6zyQYsxHO21C5XS9xZ9VbWgH+fHbhnFRg
	uvUVVdSSfQAIEZ6ev+4qIYgx6ODDC9xQjCm33jKOgAa2+e7w1GMPzRhMRRTvfYHckji8iplbeUhnI
	wc8nUvSpf4mIFnqCgIj6j0Lfb6HPpj34AZepCpnUIzb06bLDa0gumnl6ywwfu/LG/j2VKFKUH3wZb
	NIoCU7uw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfWWq-0007nK-Ms; Fri, 04 Jan 2019 20:57:16 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfWWL-0007GA-Mb
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 20:56:48 +0000
Received: by mail-pf1-x441.google.com with SMTP id 64so18815386pfr.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 12:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7aRBKK8TkteZislwEu46QTtOuuKaw2a3j4FrskRJKXE=;
 b=BhfGSs8Q+JnK1/4i/SeXnylWTDcT0KNKJ/9Mb53e/1HtR0+yVg/hx++HaE96mhbFc7
 ZxXXnu1lY1XZilaLLBT+tRuOpGPmSxHQbPacJvd6ZkeAuXHELoJObsO+qEx8SXDrz5rV
 kunU2X0zlb2b0154uW0b821jyhSiMKNH5BVgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7aRBKK8TkteZislwEu46QTtOuuKaw2a3j4FrskRJKXE=;
 b=nYekeg0ZX9Ku7pze21QfLoJp9SFKXLJsCDGGKLk08jbdCObZSGw8kB1m1TUaorSLlV
 407udBlQFwhahZNdI4NPXYyI0wMimlHcXLBW9E9FUCmeRdoBr5OGcxOz06qE9ZFGdy5r
 vetX/7xrHsvwAZ1+sJlAAnerNuIms9jSJun3bC+B6BZhZOCZ3esNkjOPjbvdcaQ8vv1Y
 0KFRqhGM4RnYCZYJ/cqNfmrxiDcZ9p01TqwdeBWLogbYwRK2xcEcuVB5vwOjJzWvzClH
 sq8Z1zcP3SWIV5nuATMd4YaAIWpm0E7QhQbpeUsGn24vjuPczyrdi+MSY1mq3ZUfLtxb
 igtQ==
X-Gm-Message-State: AJcUuke1YtH/BYf9oeBdbn9Hy4pOKOjPMLy4gvxTeMcOpDCHHs9TSniD
 SqEq+V4GpYls9rUQyZSyCgnn7w==
X-Google-Smtp-Source: ALg8bN5DnREXTuhCejvjjJPX366oyQdEEZmAmGnw9cIxn64NWdFHd7pf1cXJD1YywBkIGWEPbzUuCw==
X-Received: by 2002:a62:6cc9:: with SMTP id
 h192mr40561294pfc.223.1546635404934; 
 Fri, 04 Jan 2019 12:56:44 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
 by smtp.gmail.com with ESMTPSA id
 l3sm98058334pga.92.2019.01.04.12.56.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 04 Jan 2019 12:56:44 -0800 (PST)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 8/8 v2] arm64: dts: hi3660: Fixup unofficial dma-min-chan to
 dma-avail-chan
Date: Fri,  4 Jan 2019 12:56:28 -0800
Message-Id: <1546635388-13795-9-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_125645_873842_D8E1AFFE 
X-CRM114-Status: GOOD (  14.42  )
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

A undocumented and unimplemented binding got into the hi3660 dtsi,
and this switches that binding to the now documented one.

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
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index df4e96d..654da63 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -562,7 +562,7 @@
 			#dma-cells = <1>;
 			dma-channels = <16>;
 			dma-requests = <32>;
-			dma-min-chan = <1>;
+			dma-avail-chan = <0xfffe>;
 			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_DMAC>;
 			dma-no-cci;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
