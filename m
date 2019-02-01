Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA77C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:18:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFEAE21726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MVYRKMhN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="UbNTxnwG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFEAE21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+f67qKgHRxjk8VceLPmoRXwHPgiKkkOfVuFrNZtQRcc=; b=MVYRKMhNFVXme9
	ip2in1z/7zwkj26ITuB8ltMzKtPnR6pXCpBmdmgGY+P4/6Hx1F7IqZm4+ub3B9HJ1YTX2D1HihAq5
	GNY4IwCIJDloz2OIp4swXfBmu1crKyBdDWHtUfRDC/ABJdxHaZB31yabBVAXcr28z4SdFps6Qf1MZ
	PZC8mTwmvgHVj2cz4ZUR/ZfZSCBA+XhF0kgVJcf68q4qXXfkLVhm6quEZnBukfEseaNKz6FRxjmN3
	d6OOtqo8UPxgakzEntHjmB91KWwFZxjGkynVRG3FRbzWW86B46xDUuNy1m5CljrHsdL5rJOnVaAXa
	9vx302J/A366YXpQsLEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpbWM-0000Gu-Fd; Fri, 01 Feb 2019 16:18:26 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpbVA-0007VV-QZ
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 16:17:27 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c54710a0002>; Fri, 01 Feb 2019 08:17:14 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Fri, 01 Feb 2019 08:17:12 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Fri, 01 Feb 2019 08:17:12 -0800
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 16:17:11 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 16:17:11 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw01.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c5471060001>; Fri, 01 Feb 2019 08:17:11 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas
 Gleixner <tglx@linutronix.de>
Subject: [PATCH V6 5/7] arm64: dts: tegra210: add CPU idle states properties
Date: Sat, 2 Feb 2019 00:16:52 +0800
Message-ID: <20190201161654.18315-6-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201161654.18315-1-josephl@nvidia.com>
References: <20190201161654.18315-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1549037834; bh=flTY705hJAZY/7hKXgSgMMFWBb1O9aTKyqClGqqGHYY=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=UbNTxnwGXTZA5J3y+fvaqE9F3cRib+69qRbCgHhR+/8LU9MULx/JHWNkR+1JV+FRp
 u7xdpcLlZTqoy9FaqCg1fKtxTvApLMnHL3rUDvKX+gwUESFBTxfuAq6DLjo1CdcqnC
 59xc37NQ18BuHWlKbQM7W9qlrKfk8thd2prIxiDQUi36QLtLZ3ZtbKpzLKFoncAfL9
 a85VTfxMKX97IHALDplLXkKrSaNHozola3Jz6+5wh51GAJJgFjTpKkdmn2p+btshfS
 em1jivzzE6GM0GO3WEurNOxIAfbt23PNSGgzJgdFGJijw04d2SJEEpoLHK9+f8YaXO
 +zOA+hisTaN9w==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_081713_079303_309AAF74 
X-CRM114-Status: UNSURE (   8.13  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add idle states properties for generic ARM CPU idle driver. This
includes a C7 state which is the power down state of CPU cores.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
---
v6:
 * add ack tag from Jon.
v5:
 * no change
v4:
 * no change
v3:
 * no change
v2:
 * add entry-latency-us and exit-latency-us properties

Note:
This dt patch depends on the DT changes in below series.
http://patchwork.ozlabs.org/project/linux-tegra/list/?series=84380
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 2b387364afc3..75534692604c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1318,24 +1318,43 @@
 				 <&dfll>;
 			clock-names = "cpu_g", "pll_x", "pll_p", "dfll";
 			clock-latency = <300000>;
+			cpu-idle-states = <&C7>;
 		};
 
 		cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a57";
 			reg = <1>;
+			cpu-idle-states = <&C7>;
 		};
 
 		cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a57";
 			reg = <2>;
+			cpu-idle-states = <&C7>;
 		};
 
 		cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a57";
 			reg = <3>;
+			cpu-idle-states = <&C7>;
+		};
+
+		idle-states {
+			entry-method = "psci";
+
+			C7: c7 {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x40000007>;
+				entry-latency-us = <250>;
+				exit-latency-us = <100>;
+				min-residency-us = <1000>;
+				wakeup-latency-us = <130>;
+				idle-state-name = "c7-cpu-powergated";
+				status = "disabled";
+			};
 		};
 	};
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
