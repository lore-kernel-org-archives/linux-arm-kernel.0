Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679C0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 07:30:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2971B208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 07:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Oy6+GpWh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EJZ0d7pU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2971B208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=/F0AD5ce8tudcMfDjEpuN4g9sCInbeP87QnTK7dEafU=; b=Oy6+GpWhZL5rGWIo/QJPBhQG65
	cX2I0H7Q8FonBA8Hu9oeirTfNu7tZ4dIlN7caOyleNFUMyAqrFXB+d10+1hJRhuKzbixV/u7eJoj4
	rdqNUuM8O8X19CUDXsiYmQ6ScNGhQ3980GiT5xehNklL5A/oIN0HzMHqnhuqq9Pomv1cKzaWPGOvG
	JkcY6O7Q0fF4q9tL+99JuDEs0jzwDUX7/3G64Ftl2CtkMdXBGQXu5H8twyBt8H4RH6NeXKBWoBwjZ
	PT+g8so+ZL2QAo9YGZ+yNq9CkWzK6kSo6mmuVoNAD/rFQfMQcTgXClO9OfE0rNeFpnHse62tMfrZ1
	WtSo3YEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfgP7-0005OG-US; Sat, 05 Jan 2019 07:29:57 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfgOh-0004vA-Ep
 for linux-arm-kernel@lists.infradead.org; Sat, 05 Jan 2019 07:29:34 +0000
Received: by mail-pg1-x543.google.com with SMTP id c25so18440218pgb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 23:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ZLG0p6pOlEKJqG/ydnT1Alp81sx/m3rHMuhpQtuwbbQ=;
 b=EJZ0d7pU3z4gJ3luqtxOqm0cnFR6Y/svP6seHeGrN6D5WenFUCJxOKk0VJGRiqC0bB
 p7pssvPaglrTPqs6h3o7FM6BRLrQL5yM5PbDTgzI7TjyZIi+DUdkIhUxxvHiXXiWOez0
 tmtExd9B9GDOVDttEHfFoS2oGg2IIVmEIGfFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ZLG0p6pOlEKJqG/ydnT1Alp81sx/m3rHMuhpQtuwbbQ=;
 b=CUpvIQ2QpbUnNsx/EGI9kB/ilSp9kgosQY5f1zzIHCdwcKiOd7fjdHqv+7frYJeXpp
 nmBzssLpySi6zvmxQgHE6jnL5S2Q8Nsg08ZUMMZ6sOudwI1Zi3i/om8B/UXHrVfb/XVI
 PA6hg2Yz3OEOjR+3qVAWX40Z7A+nsJ0hwLxgie21PkhBvDtgLZ9j9XdVXS8mkPP3CQmR
 YS6z0X8iF0ipRKLqizp0u/lAS+Efg5XBynjkaso3L39M5p9t1yE6zC9Y61YnbyaG3Anf
 2Ou5Gr4hTLgpBw/UteclT166q/sBfncQF2xcVAqfiHROx+mBFW1Acg8dtYFlLVo4/9Ii
 rUjQ==
X-Gm-Message-State: AJcUukf9Dx4RP3oN8Hlg4ZzVABZqMoc5xs05U5PqnqPbzLZpGpBmbc1t
 yyJjohvQhdQl+Q1MAGd+s9AT
X-Google-Smtp-Source: ALg8bN50gCEXbBa9oALpY2+83PONnRD9xIfyJUuHRcn8QixT5tbYVu/aCEF9gRtHJ+dXNUQY3SYgsg==
X-Received: by 2002:a63:5723:: with SMTP id l35mr22381883pgb.228.1546673370470; 
 Fri, 04 Jan 2019 23:29:30 -0800 (PST)
Received: from localhost.localdomain ([2405:204:72cb:a88d:406c:3ac8:e78f:4779])
 by smtp.gmail.com with ESMTPSA id k24sm90677367pfj.13.2019.01.04.23.29.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 04 Jan 2019 23:29:29 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
 martin.petersen@oracle.com, liwei213@huawei.com, robh+dt@kernel.org
Subject: [PATCH v2 2/3] arm64: dts: hisilicon: hi3670: Add UFS controller
 support
Date: Sat,  5 Jan 2019 12:58:58 +0530
Message-Id: <20190105072859.9134-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190105072859.9134-1-manivannan.sadhasivam@linaro.org>
References: <20190105072859.9134-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_232932_066044_D5673793 
X-CRM114-Status: GOOD (  11.05  )
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
