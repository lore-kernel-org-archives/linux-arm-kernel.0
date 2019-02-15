Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67EEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:50:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4A36206DD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F5eWfU2u";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DGBCzkC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A36206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=VSp6KHjpeauVcjDe7+YG5sJbgbUbODUltBJj+i3B2vo=; b=F5eWfU2uzsJKaxbSJpJvBfXu3y
	y7WpvduWWB5b5CrsI3I1tY05+eW1IH6Id6MwoepOL1aQuEhLoroi0y/S70fopIHAcoeHIZ0TmRHSn
	4KP7rXxUohO4et4W2y2dNC+h5hKDmGo1MYlzvT+a5+8pt97+34EN4sYyZNKJhXqbYMW1waimDnlSA
	v5ueeJFqP1E1aNnCmlVahk+oTc5jkw4SNKR6CCvkuqh2wDrrEZfPI6nNck6IHuGr/In74jlF6w7Y5
	cV6sr5IKz6zFLCxHPRJajkflXvY/u84XmlTp53fEvzDKZZYsYITCTHmWRFUVrBThiLleBbDLrQFeg
	OfPln1cQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guWOW-0002b8-SC; Fri, 15 Feb 2019 05:50:40 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guWOC-0001pl-Cc
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 05:50:22 +0000
Received: by mail-pf1-x443.google.com with SMTP id z15so4315643pfa.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 21:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+28ah16ssp2zUlQ08ousTOH5MdUsrEXHyb5TznP/Xc0=;
 b=DGBCzkC0cmXtmaogSMqWCCj1CQSsyzp/9IPw9txdvx0boTDHpDgJdxlTaaeLznzIvz
 X6Nrqjvq9INr+lU0ku2eHwR+QQLsD/cp+TmmlOQmQsZ4Fz3QDg7SD4T2RFgAopBa23Fw
 ml/Ml6Hk8dyV0TkQfocLIjVj59dfANuucfiLqc0mjqBsT/4P8mUWOCKK1DtN5At3WEEP
 tkAb5V467FaYtxkwV9YrqlawLNC3XmwxK8mkLMZjS0xB/TeryNKE/S/xyBvrWZ9cwZVA
 er1BfYFf3BxXDPRkk+NotXddoLgOWSNgH4VIZpCvN5l+GDyo4gO4NcHh7nthfuWq5mah
 cU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+28ah16ssp2zUlQ08ousTOH5MdUsrEXHyb5TznP/Xc0=;
 b=foaigVInE8BuOb/x8NMIM6F1ROUpS00ZVOjX0apVB1ZbIaqEfbTheR+CtaRySJD6cQ
 VSISxfvLXxa3qFerQXPbqa8o8TVIMkYH1lwZOCe2GmpH9qfrEoE9fOTCnjTj+IG3u/Gg
 yDd1BwTPx06/+T20VrduWzKNkucEDHqiUdj3AwzRPBfE+exP/4fmzRf0rALHxOJ0Zeo+
 4I/78tRk9Q7i7TAxf02KjugswHoD1fsBz1oE3YOULeJkGeEjk/bCEHCVKiFSsGTDxEaG
 3cJcyednZD2oAmdf0tmD4B4NeTmEXPBkYDoOl08dePWC544p3s/GhvIrqC4BEdW4Gnh3
 5KRA==
X-Gm-Message-State: AHQUAuZrRMax5mbUUP1MjXyXMBuxPv0XiJOHKVqFyPDJg1xp4U4OxOY7
 OUeW43FNbpZlnsiWNG0/P8aP
X-Google-Smtp-Source: AHgI3IZAaKvBbSAzW7L+1qiChviVMumolz0prwc44USYG31JQ2InwoQD4JzHgnDC7Xd37e/C2zwq5w==
X-Received: by 2002:aa7:819a:: with SMTP id g26mr8029156pfi.187.1550209819674; 
 Thu, 14 Feb 2019 21:50:19 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:98a:c91:14c4:f458:9909:7fad])
 by smtp.gmail.com with ESMTPSA id
 c18sm6160810pfc.63.2019.02.14.21.50.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 21:50:18 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: p.zabel@pengutronix.de,
	xuwei5@hisilicon.com,
	robh+dt@kernel.org
Subject: [PATCH v2 2/2] arm64: dts: hisilicon: hi3670: Add reset controller
 support
Date: Fri, 15 Feb 2019 11:19:55 +0530
Message-Id: <20190215054955.788-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190215054955.788-1-manivannan.sadhasivam@linaro.org>
References: <20190215054955.788-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_215020_664772_BE97ADC2 
X-CRM114-Status: GOOD (  11.62  )
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

Add reset controller support for HiSilicon HI3670 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index a5bd6d80b226..2af88c429c97 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -151,6 +151,12 @@
 			#clock-cells = <1>;
 		};
 
+		crg_rst: crg_rst_controller {
+			compatible = "hisilicon,hi3670-reset", "hisilicon,hi3660-reset";
+			#reset-cells = <2>;
+			hisi,rst-syscon = <&crg_ctrl>;
+		};
+
 		pctrl: pctrl@e8a09000 {
 			compatible = "hisilicon,hi3670-pctrl", "syscon";
 			reg = <0x0 0xe8a09000 0x0 0x1000>;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
