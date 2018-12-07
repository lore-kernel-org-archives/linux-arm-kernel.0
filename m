Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00F3C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:52:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FD9220838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qzShItUK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CDG64jxc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD9220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=/F0AD5ce8tudcMfDjEpuN4g9sCInbeP87QnTK7dEafU=; b=qzShItUK5s7CGUjILvvoVBoilu
	kj1rrfxaw63v7nR52JqcYWwGP4vnS6pK93GoIkjffGwhX1E6RA59aS89D0uMaLtPjLxyGNl4q+H4f
	dVZ1QZJsiJAqpdODe2x9Zx1btPFAHheubosOUdANUFYV56Ybxvwg5yhmdMAylXVEAC+atGfiUDdpC
	VsAwB8xk1OqOm+7sI/SnXZ4kdaKzsattPdUuDg+wUYD3IrftYe5kBMWiXc/b00yAeOIkJFvEBul8Z
	om9R7e6QGTAQ+4VKtxuLhEJIUxwOvHW+9zaRAceb8f2qHJJ1i2RAdheI2AjFeBL6GJa4RbYouVzHC
	n2TBzplw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVKIy-0001kl-Kk; Fri, 07 Dec 2018 17:52:48 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVKIh-0001Gs-Q8
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 17:52:33 +0000
Received: by mail-pf1-x441.google.com with SMTP id h3so2288565pfg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 09:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ZLG0p6pOlEKJqG/ydnT1Alp81sx/m3rHMuhpQtuwbbQ=;
 b=CDG64jxcm0aKiEOo/CvP1uys/yXY2smXYvbDa0wDPtM8KyZzjnrpE98lu/weu2FH6H
 MwV/wzmSJuWzFMvVdd89RVDLduEi+Rlt7hzCAxh4V2PFzY3dnAoM6tIK5ZU+tJQAjGYV
 EzMakTWhCKQ7hwc9EM1KhNOp/rB1+UwEUF9fY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ZLG0p6pOlEKJqG/ydnT1Alp81sx/m3rHMuhpQtuwbbQ=;
 b=kmzJqIOqIxgu+9E7yFXXwKSgdUf3FBAfGHQrWRdl6bzA+hkBBKXpsN1F8ZR1/ZUGCp
 Nj13frGmg442w7fU/lA9XCSatpvKJM+22emQJTw4B4Xgb5DtYNmvDY/DDuAhht8G4Dzr
 b1jdPCcx6f9xg/Tbo55/oK7rkc3CDarAukEkwOFkhS1mIvK6xqgyip9jSgiHn0ugUomF
 nniYPI5OxZlgEJ9nZLoGY1nhc9d9iH8dmVsFRpG22gLfOTfydKGFMH7gvcQfSUuT232z
 nFRl86hEPSWmrzCDifD/7ftDFGzwHMcw9O3bm9qXfnToxoZ6nrkVmi8BBplry5YZyhlQ
 NXjQ==
X-Gm-Message-State: AA+aEWZjz1+pYAGBU88+dvsxmVv5hFwde6hX1BOh/B0SXKqLVlxgeZIX
 6Co0vl0eSllnqdnhP6Zzsjct
X-Google-Smtp-Source: AFSGD/VzMNVLNw2VZZmWenDDUu43Zs75mxhPnrEjxhbOhafCsKCgmkJ2hvoGrzoXDAy7oNYg7sPrMg==
X-Received: by 2002:aa7:824f:: with SMTP id e15mr2487484pfn.192.1544205141034; 
 Fri, 07 Dec 2018 09:52:21 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7207:e9c8:7189:c4b2:429f:42db])
 by smtp.gmail.com with ESMTPSA id k191sm4611387pgd.9.2018.12.07.09.52.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Dec 2018 09:52:20 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
 martin.petersen@oracle.com, liwei213@huawei.com, robh+dt@kernel.org
Subject: [PATCH 2/3] arm64: dts: hisilicon: hi3670: Add UFS controller support
Date: Fri,  7 Dec 2018 23:21:50 +0530
Message-Id: <20181207175151.8969-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207175151.8969-1-manivannan.sadhasivam@linaro.org>
References: <20181207175151.8969-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_095231_887974_3FF62F00 
X-CRM114-Status: GOOD (  11.72  )
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
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, john.stultz@linaro.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add UFS controller support for HiSilicon HI3670 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index 6ccdf5040ffd..285219dd657f 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -654,6 +654,24 @@
 			clock-names = "apb_pclk";
 		};
 
+		/* UFS */
+		ufs: ufs@ff3c0000 {
+			compatible = "hisilicon,hi3670-ufs", "jedec,ufs-2.1";
+			/* 0: HCI standard */
+			/* 1: UFS SYS CTRL */
+			reg = <0x0 0xff3c0000 0x0 0x1000>,
+				<0x0 0xff3e0000 0x0 0x1000>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3670_CLK_GATE_UFSIO_REF>,
+				<&crg_ctrl HI3670_CLK_GATE_UFS_SUBSYS>;
+			clock-names = "ref_clk", "phy_clk";
+			freq-table-hz = <0 0>, <0 0>;
+			/* offset: 0x84; bit: 12 */
+			resets = <&crg_rst 0x84 12>;
+			reset-names = "rst";
+		};
+
 		/* SD */
 		dwmmc1: dwmmc1@ff37f000 {
 			compatible = "hisilicon,hi3670-dw-mshc";
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
