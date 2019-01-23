Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B91C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:30:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24431218A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XqpDtVOg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EDG929pc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24431218A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=K9H0gsI4JVbpHdLIminI4fOneAHYut/wRmEhvDdnddQ=; b=Xqp
	DtVOg4MyoUI6ADwrKNS9aFTY9Vb4gP1cDISe+PyE89rWKgsQ+QQunXzirEDsI36C8IEHwtaZZTivm
	xWU/zPyLwXn6AWAUhPap9VFb1c1GqaMnvYjrdz9+VmE9QutXW1WMJxKlRmb02P4jwm+MKVh/vAMk/
	9QVQ8PAEQas4bb59Un4zJHE9gZki0SmqJMxNfHX5dGpZh+v0d9fqS42yYN1aT5BcbVI28pzmErzDG
	zM36s1Pk8vrW08lyRzxLLLOiLp6z9DDOJFJKMVUW4qwB4VxcxPjMqKGS3nfr80y75sGmCCr8radAc
	sv5tdB0p1OhIMbXMVeN0Y1dD6322sKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmPAb-000496-L0; Wed, 23 Jan 2019 20:30:45 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmPAX-00048i-P8
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 20:30:43 +0000
Received: by mail-pg1-x543.google.com with SMTP id w7so1567605pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 12:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=dQeGla4uY96qKmBJkDGL86JxP6wLAR5iTrjDEvM77oE=;
 b=EDG929pc2kX8wjhSzZnhcljnQKqDMWS2JVqUtTET/Ciis0H+v4kl+vTgQTaN+HhAhc
 +gzPy+0f20kamcWvxn8TbcaQvFwIvT2Up/6HjEBbUVdcsHC4KmLX4tr+IynGbGQKUcXX
 OGXqJ6a9y9XZn2n+6Hla3zwe6vQGcHVhNfeto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=dQeGla4uY96qKmBJkDGL86JxP6wLAR5iTrjDEvM77oE=;
 b=H/2GnAcMBO5wbbrobhJJ8LyaVAffV/oZqDlECQrPQ2oOP06erpIQ4aVyA1iGJp4M/c
 GqRTvr/vxD6eo0vNurXHD8KNMG5BYA1ZzGsn+eXMRlr5dA//lHwGbgxs4+dTputgrRym
 lXV3fB89tzpBPrEg7wki3CgFmRznoCl/ooKauYDldhAnyj8Wkb0GsuohZ7A2Sz8yw7pM
 6b1Fc/ewQj8R1jApDYU5VmFi3rlWJ+6cC1DFrtjJPF2bH/E8/4chX+zrru9S7nWkS/bo
 VmkIz8+wvTB5vxI/OICazy5o2VITgrPLVOJlz6zUZiHVgKq5JIqOCk6LV0y6tmjmzjf1
 iUYQ==
X-Gm-Message-State: AJcUukcQ6dTAgUstQF1iKu3dGpee9tsmlgoiEWjdULR/Kh+mVe3bp5kn
 SFUthhaUxDTgsgqAOO2Zp6Q0gw==
X-Google-Smtp-Source: ALg8bN4D/kS9dfTmOaoCBMGZpc6PzYx617Qf74y0eMzFMdO4fA7DAdxjqYBygDQ91hm8+9zHgZgAiQ==
X-Received: by 2002:a63:5f89:: with SMTP id t131mr3431308pgb.26.1548275440685; 
 Wed, 23 Jan 2019 12:30:40 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
 by smtp.gmail.com with ESMTPSA id
 e86sm29132416pfb.6.2019.01.23.12.30.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 23 Jan 2019 12:30:39 -0800 (PST)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH][RESEND] arm64: dts: hikey: Add DMA entries for Bluetooth UART
Date: Wed, 23 Jan 2019 12:30:37 -0800
Message-Id: <1548275437-6022-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_123041_827149_5A7649DE 
X-CRM114-Status: GOOD (  13.19  )
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
 Ryan Grachek <ryan@edited.us>, Wei Xu <xuwei5@hisilicon.com>,
 Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add dma0 references for bluetooth uart to enable dma
for bt transfers.

Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Ryan Grachek <ryan@edited.us>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index aec9e37..fa15a08 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -319,6 +319,8 @@
 			clock-names = "uartclk", "apb_pclk";
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart1_pmx_func &uart1_cfg_func1 &uart1_cfg_func2>;
+			dmas = <&dma0 8 &dma0 9>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
