Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB946C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:50:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB604206DD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eVf8rt6k";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JNb4B/fp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB604206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=qwBsw+4SfgEoC1eNBzNxuHQHdDh/mqvmcKrcwMCA60k=; b=eVf
	8rt6k7rPMhzBwEi/DB47uS9zZ9OXhh15Fnjw4me8Jw4KISIu8mr3zEPVHLHn+ffO/f8ZvLGDkowM7
	rK4s0MLjmfV1i6b8bmbDSZojYGkR/BLW/fZk1sIXE0WcAZReteDf9dOxC2TM2aATM4Paxsb//59Be
	MjmSoBgVdflUWkf477GRsrFzhrk1q5ANqFWiCFEehfpsYx3KpQsTy1oID/9+pJe6mxbPga9g8lb1S
	iiYUhoiAxpChsYUzhOCjKaDwaDUTESk+Q57d9k/kj59PaNqM7NjhYyuWOa7JbgHigoET+TS+ViFyZ
	zqroCx6tR4cyrL8vLVzoeo4g4vFDfdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guWO5-0001ec-Vx; Fri, 15 Feb 2019 05:50:13 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guWO1-0001bi-Rk
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 05:50:11 +0000
Received: by mail-pg1-x544.google.com with SMTP id y4so4259717pgc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 21:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=sA+Vvw2lTBR5S/ltw5LqkxhREnc4rL79BcJlCx913Ig=;
 b=JNb4B/fpHLj62Zeod3pjootybp0V8HQEoT/qq4aowBL+QWEDF4twDiYatyOanqFQNn
 2NnB56bN1ltY2kXMdGvM5VRXVfjt3XPnrEThQg8MaNWC1ItF+7jwlDbKDQS4g3nm78Ai
 m6UmRWfPXtMhaDxpi2RkSyi49V84c2W7VnIDywMKjhbkV9xZjOVcjTyPbemeHfr8v3PJ
 qIYPFUpyVCQIMxpGVL9eIjoYEX7z6wPVhccbwmZZNjNH5DVW+O0DGJHurHXawOUpGocc
 6mHqyFBA69+zcGT/IZLz4ljc4oharL11p1J95+BloeUJeIckhyWb8zrUI1LTBmapiAeE
 gXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=sA+Vvw2lTBR5S/ltw5LqkxhREnc4rL79BcJlCx913Ig=;
 b=izI4DwA9H/zXg7Pse4Fx6TkZhX96wz4Pula59weae6vTtOO+xoWTdrcbU5i5VkbJ8q
 hW7ePHyv9genirRef4MIveueqRB++hOAaJuPf3r2GIKmg2YYmNQgAHY/A+7ILMeexBje
 iPhizbVx5EPTWmmi0RCU77ZDRAS3O6qc58AJ4WuVOUC58BJWUJYG2fzUycmLpwDy1iV7
 LqtI6Xom+QIc0qHyDI7P6TW3mwde9t8FWZ7wXUMBeIrIXIy4CC+JGiAFMLioICLpLEXk
 RLteVOpuT75GS0+6STXR981KqOAsnFsFdGM6Mr0f7531VRZFMowSm3CZR01DKZqXshtZ
 /U0w==
X-Gm-Message-State: AHQUAubX+7FQ/e5Ikw2BbYrLF2oVVGO12YI4zcKX/v0A+QqLMnheVjBC
 cXQuZouORsUGbHeuR4Nz1Xx3
X-Google-Smtp-Source: AHgI3IYnhhtSWSqEIIt7sbopij2F37mKuELKqF4CkPI8oU4iCud9g9++vtwPp4r7sf0/1L9ck9QhQw==
X-Received: by 2002:a62:2702:: with SMTP id n2mr8266930pfn.29.1550209808703;
 Thu, 14 Feb 2019 21:50:08 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:98a:c91:14c4:f458:9909:7fad])
 by smtp.gmail.com with ESMTPSA id
 c18sm6160810pfc.63.2019.02.14.21.50.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 21:50:07 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: p.zabel@pengutronix.de,
	xuwei5@hisilicon.com,
	robh+dt@kernel.org
Subject: [PATCH v2 0/2] Add Reset controller support for HI3670 SoC
Date: Fri, 15 Feb 2019 11:19:53 +0530
Message-Id: <20190215054955.788-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_215009_902443_FE2EBD8E 
X-CRM114-Status: GOOD (  11.08  )
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
Cc: devicetree@vger.kernel.org, guodong.xu@linaro.org,
 linux-kernel@vger.kernel.org, john.stultz@linaro.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

This patchset adds Reset controller support for HiSilicon HI3670 SoC.
HI3670 SoC is architecturally same as HI3660 SoC, hence the same driver
is reused.

This patchset has been tested on HiKey970 board.

Thanks,
Mani

Changes in v2:

* Used the DT compatible fallback approach instead of adding a new one
  for HI3670

Manivannan Sadhasivam (2):
  dt-bindings: reset: Add HI3670 reset controller binding
  arm64: dts: hisilicon: hi3670: Add reset controller support

 .../devicetree/bindings/reset/hisilicon,hi3660-reset.txt   | 7 ++++---
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi                  | 6 ++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
