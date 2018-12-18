Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DE2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:17:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24A6A217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jmDd/bSm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FydNWkj6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A6A217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fQTJS4/3aeUnOZtLplcJekbp/n0O4kp6HCqL7ZPI3gM=; b=jmDd/bSmXIlde3
	O/qeDwiigkYzDQmKrgUUTxi0sNeuYlekp855TaSx4mzoRJ3xkHuCGojbIGvKrp8b+jbC6YhfTo+mP
	z6BNHt7FoQVOPzTHrpK0iJl8gkmkyrp3lz7xyuvReUH8OWD9ejh0TLYnRaL6hKgHgP95vNfXMefOD
	DnZPSW8Bqu7vdS+NsvRrbZhY64Rqw3jsRAz8qNQq0TXI0H1jllmpbnKYaJIxI5CZZMiew19IwGt1L
	EM2xQwRyjMF0e1mD5Gl8Rn4UiaFmNK7+QGLqfu0WXKKlYi0xlPVIN7nwi+JCn/FRfd/FSVqRZDJT1
	z0lRoPZF7ZROQ4BjPa7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZBUy-0001Dq-EQ; Tue, 18 Dec 2018 09:17:08 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZBRV-000528-4w
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 09:13:38 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c18ba310001>; Tue, 18 Dec 2018 01:13:21 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 18 Dec 2018 01:13:26 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 18 Dec 2018 01:13:26 -0800
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 09:13:26 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Tue, 18 Dec 2018 09:13:26 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c18ba340004>; Tue, 18 Dec 2018 01:13:25 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver
 <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 18/20] arm64: dts: tegra210-smaug: add CPU power rail
 regulator
Date: Tue, 18 Dec 2018 17:12:30 +0800
Message-ID: <20181218091232.23532-19-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218091232.23532-1-josephl@nvidia.com>
References: <20181218091232.23532-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1545124401; bh=MrwnhJKBurbq+OiS5dn/CuOrOd2966m7h/ih1Hh5t6o=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=FydNWkj68l/usdJhWc3gzH36VRrp//5dnOnIWXMSReZipvWhKirVxcoqomW/nFn02
 CHsSfz8K/e3+SYv3+PeteAV3XsfzxNO/HQcTIHbRcXsd+yrs011vGidTIuGABh/mvE
 QPZwAe6lrMQk8H53NuXW01G0VLLErq6+//xjeUbytPn/ThnVxG5ZlppeszT1P49cw5
 6QKTjidUJN6LkG6bzhiJ9W/pm/aGnuhct1aXFw0F9Yj1u8eTMwg1JWTK+MBYW57E0V
 x0Nj39Eg7FHRuxjxyPcxZH/7wXGNP6AtAZZbvjrhWbqChec7no1OgajvzCQC5Y/Mtt
 Vd5132+XrhFeg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_011333_518624_98C8159A 
X-CRM114-Status: UNSURE (   7.59  )
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
Cc: linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add CPU power rail regulator for Smaug board.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
---
*V3:
 - no change
*V2:
 - add ack tag
---
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
index 43cae4798870..79cfcd5b7e62 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
@@ -1340,6 +1340,25 @@
 		status = "okay";
 		clock-frequency = <1000000>;
 
+		max77621_cpu: max77621@1b {
+			compatible = "maxim,max77621";
+			reg = <0x1b>;
+			interrupt-parent = <&gpio>;
+			interrupts = <TEGRA_GPIO(Y, 1) IRQ_TYPE_LEVEL_LOW>;
+			regulator-always-on;
+			regulator-boot-on;
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <1231250>;
+			regulator-name = "PPVAR_CPU";
+			regulator-ramp-delay = <12500>;
+			maxim,dvs-default-state = <1>;
+			maxim,enable-active-discharge;
+			maxim,enable-bias-control;
+			maxim,enable-etr;
+			maxim,enable-gpio = <&max77620 5 0>;
+			maxim,externally-enable;
+		};
+
 		max77620: max77620@3c {
 			compatible = "maxim,max77620";
 			reg = <0x3c>;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
