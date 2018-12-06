Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012DEC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:52:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5EF320868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fWqQx7YP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mny6U4mm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9mB6N0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5EF320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UHqRiPx/YVg5K+uFYY/m0dpBvEG2aOwJwsfTw8UsrpA=; b=fWqQx7YP8UeyFo
	46izR98fj5c0TG0u+tXTQsvcCUIiHsdCj5p9yOwgdDYPJQNNDMmc+64/33m+iz55XJ+XSd4fFrv3z
	0t3nOEVQ3yiIDCD0QJKzkzF5pfh1k+Ueu5OP0IP3wg/V4OAIj4wi9uk19JzWpmySCE7jXBZbMSrSM
	FIPlgGk351umEfNFnvtczD4s9oudRWYsK54cpRpHr/efElZbCaUhP4wXudeDP+Hs780pETDxfT+50
	nr7X+DvS3OOREkplxPIPzT3UxxujaIs+vWbw7hOAQE/A+m7FtbjKPQZPrjAWgoZSPDzNjF+vW86eE
	gzWwq4CvaPyDVaIsCO6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUwtS-00069x-0Y; Thu, 06 Dec 2018 16:52:54 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUwrR-00041k-GI
 for linux-arm-kernel@bombadil.infradead.org; Thu, 06 Dec 2018 16:50:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ktkf0wfGPD8Zsf/7y3XKZNmXCBXw0+MwHpUM0rqkOt8=; b=mny6U4mmd8zqTkwyvRIKn5TSHP
 YjevLFOhGanVdeGMorNPOjRhNrxnrg/HGY0vyRdF3QUYH538H5u8mycIHVXTfBI13J8PSEb2Jvbl9
 za4joN3e99s3nm42FFw5t1/A8SucSApvkD9TDbkPXrVqdld/p266V+MJHKn9eRd1GTdWBsai03375
 BCQVcDN5k9c9YQYF9/7XX1chMwsGZDTXfHuU+5mqTg4G8PLnSuewjOf6LVbofTpd8PUsd7LAOBFml
 9PF1FuN4nQuTWUWI10kjYn1N3A1Y6vXHAYyXud7UqsotI3bQ89T4KSZxHCIk8abhF5CdxwiQL+gdW
 St/7gJ/Q==;
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUwrL-0000Me-RK
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 16:50:47 +0000
Received: by mail-ed1-x543.google.com with SMTP id f9so1312640eds.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 08:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ktkf0wfGPD8Zsf/7y3XKZNmXCBXw0+MwHpUM0rqkOt8=;
 b=T9mB6N0BrRMGkbA2fj0mj/dr/vrj+xHu+8MvsG5FL8kV8A8J55E6zNMtEnYjd1X99A
 TDhsEHenc8ZiCa79XvVdXZUvf0Vhtm33cSDrVG0t0U4OK1dbImw2YqwnYya5lZ2rQi0q
 7U+9vHc4xTexIQVdBAGeYyw/Y9p3n9wQFGGkXR71+GVz9ZfifeDYUU0KijxwwOLYX9po
 B1bpupIESLdkGLdOXn+gj6t/XF3e6Y7CDYx77/Qn4GgphJiF3v8zuLowTIED2cnEW2y4
 HdQ8WMEtgNcDsX/bKFfBbKyx4ny0iFDGQ5Arga9uT7QVEutek+wCU+aw4gXZmGOv/8Wq
 0PnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ktkf0wfGPD8Zsf/7y3XKZNmXCBXw0+MwHpUM0rqkOt8=;
 b=iWdMk2WyV9h0wDBhzKlugL1I8Jo0hLgEJ0/iqTVKSNuwAOO+2gf0K41nRXHEn9NGTt
 blnO8RHt9uCKjyiZD8RvBmqpoCl0DAwTH5gfsmDtda+4v+ZHK7jaODtCPfVa7gYC1RNY
 5U29O9ePji9LPbQhvrUmarjOsXi0SCZY+43JzLnYpRNKKSZW2S/U3aIXOF+W+akk6VsT
 2fF4P9QdX+/K2JmtKrkuG4ezK84kUYHOKsOfQpV54q2P4nqrP8MZ62cOF+2sBBguZyzh
 UT+1xV98oaCEq8y4uC5P4resmWVKc6B66EhdBaftkf0y1Di5ndxu3J16sOB3TTTSO6zJ
 r1Jg==
X-Gm-Message-State: AA+aEWbjqZGZEDgddwuz/i3ym3IhjKDImCkXa0p1rxjn5RybSvo7fA5/
 t9xF+Scul2GWTW24hehMXjg=
X-Google-Smtp-Source: AFSGD/VO/YhwceDWrhbVGiUi2ZCMWqBiT3UZFOXm+2Gl4roKSNi4kW+lNPwIU1eVOmU8gYhlkMuBCA==
X-Received: by 2002:a50:c2d9:: with SMTP id u25mr25768588edf.280.1544115031672; 
 Thu, 06 Dec 2018 08:50:31 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id p16-v6sm166723eju.73.2018.12.06.08.50.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 08:50:31 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 6/7] arm64: tegra: Add CEC controller on Tegra194
Date: Thu,  6 Dec 2018 17:50:21 +0100
Message-Id: <20181206165022.23845-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206165022.23845-1-thierry.reding@gmail.com>
References: <20181206165022.23845-1-thierry.reding@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_115043_890687_8F77CC6E 
X-CRM114-Status: GOOD (  12.48  )
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
Cc: linux-tegra@vger.kernel.org, Sameer Pujar <spujar@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The CEC controller found on Tegra194 can be used to control consumer
devices using the HDMI CEC pin.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 59baa631b422..31add2e2ac1b 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -357,6 +357,15 @@
 			interrupt-parent = <&gic>;
 		};
 
+		cec@3960000 {
+			compatible = "nvidia,tegra194-cec";
+			reg = <0x03960000 0x10000>;
+			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&bpmp TEGRA194_CLK_CEC>;
+			clock-names = "cec";
+			status = "disabled";
+		};
+
 		hsp_top0: hsp@3c00000 {
 			compatible = "nvidia,tegra186-hsp";
 			reg = <0x03c00000 0xa0000>;
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
