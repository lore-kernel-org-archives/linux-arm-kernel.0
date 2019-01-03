Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D831C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:24:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18FD7208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JiL9cE9z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vct3TbRD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FD7208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=x0Q5GW1vFmfkyLl2ju1TaO7Vwo8e9YEPZ50pPfVLqe4=; b=JiL
	9cE9zQN6JBj2Z6rYcQSgWJMRptWCDiC254Uc0aE6sW+VFWKpO3c/syo/2g0azR0f9mQrB/P1yQ11c
	Zw5TKX7wWxhGI/Te2+m6KSl3caKb0BRxXvkOn7iwQogcg7/DkU6TGF/coMxjiPS0tzku7Xq9XH485
	j4L1y2CIsvUBEFtR6urySDntvtfEFu6X7bYFId91olstI4gTSaq9uH7u8+huVFg6okU61zAqA38bp
	mUFMmzsMQz/ERk7hYXKmQFWdbeBBEY4HPe+cuEBGott1wm+/XAKI3ODHn3K+ozE9J0xQS96or9I8U
	RCwa0lS8+piu/SwWbvzW8oYmNulH+xg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf8bI-0006cg-RT; Thu, 03 Jan 2019 19:24:16 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf8bF-0006cH-08
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 19:24:14 +0000
Received: by mail-pf1-x444.google.com with SMTP id u6so17103035pfh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 11:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=WE0zw+tXRmMImNTsNS2inSEnAMFg2bLezjCGkdLaiFc=;
 b=Vct3TbRDFdQzVGvvFQkqoY496Jue38ZwHLQjzVcoMrkwNr2JMRXDGoJaETa6wpipoE
 8Nghcw920M2cy0589otpMSAtMbWpTj2Ki6c9c+73dq3KqcGvud+0xXT8O+DyCNbZF57Q
 QkNYevHr4Ml6iqG/3l+J2NZOvwkCzQNJG+3sM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=WE0zw+tXRmMImNTsNS2inSEnAMFg2bLezjCGkdLaiFc=;
 b=kK5OQ6ewgRK00ReLrlzOE6NNiasJeV92ZtwKrqMLPUrDGX1J/g0iAc2Yx0WW9NzkWc
 pjbFB7ArD27V4h525Qbdoh7bqe6M/7M2A5iTy4l6rj+1vBTK6bbLs/saJa8KcWMtP7qS
 Upor8zD4DFxJBLykL+FVclRjnhudgIgpDBdK5Jr57tTt6GaYcOioB4t9S/Xqo2Do1I6X
 NGN1vDF99YNjR8KfrE3qgLpCqZWTUp4JzAa5uiwUMak86WtN/9pD266ElpNeDa5W1yvH
 MSccD6wyp8egu2ZmhQV6IxT9CjnTwJt2dqH20NosIYRH75ac8IvHRTIfDW7UGPbBj07S
 4XGQ==
X-Gm-Message-State: AA+aEWb3UjsAcrAUHXdNDR1Q67f0U2HsRX7xIGiKNovQJ1mY3obmDoq9
 Jwko77nyhjyITaaytURu83syzw==
X-Google-Smtp-Source: AFSGD/XV25lmWKp7kPG1wmCi4JG+1Fn2BhvKl7appWWVNWLBtGxLytDETjHThSZkhkXgr4VpVI5Vfg==
X-Received: by 2002:a62:1289:: with SMTP id 9mr50013199pfs.102.1546543451758; 
 Thu, 03 Jan 2019 11:24:11 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
 by smtp.gmail.com with ESMTPSA id
 n21sm80807415pfg.84.2019.01.03.11.24.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 03 Jan 2019 11:24:10 -0800 (PST)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: hikey: Add DMA entries for Bluetooth UART
Date: Thu,  3 Jan 2019 11:24:07 -0800
Message-Id: <1546543447-825-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_112413_052376_E0FBAF07 
X-CRM114-Status: GOOD (  13.66  )
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
Change-Id: I85d36cc492a5f392cde214b144b19469e951585a
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
