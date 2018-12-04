Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBC2C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:56:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1D102146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HRwS7zlR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CYrkJ2Zz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="NypVPskb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D102146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TDzGog0E6KmWHRiqlFGSazmdSZYDRKzd78VhE6tFhAo=; b=HRwS7zlR9LlY9D
	f4WJRIO66XYAOEoWKrTZc2q2NhLK2JGfYxgXmj38BlgCr5HZnDxxU8c/hgaH7C94A8lirLJ3za5VZ
	D2ZyxolzDYwWGG/2IfRGaQ86W+xRiQd6wbTvZsY36SBw9gZKSQEHanjntrFm+L7mr/CDZwa1G+UKV
	akC64dkMw6Tk01rehhIT4eMLFO5iNtyN4r2RBIlgSRsnHpL3kDKIGiRbA2kA+BdDJVZW3kSIYfEfg
	jIJbU7FuXzB66KvEJKWjjzY3htVSOEJiBZAdvesjcjAWFvI33P3fhXnVdol6tdPu4+P/pGABzCwmr
	ZFHKG7ynRDY+NQPU8zsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU7Qx-00019N-T1; Tue, 04 Dec 2018 09:56:03 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU7QM-0000Sp-Pp
 for linux-arm-kernel@bombadil.infradead.org; Tue, 04 Dec 2018 09:55:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Hydh+fdd1CB8y+XWjmPQC692LZY2Bym/yEIWKRQQvhU=; b=CYrkJ2ZzIrO5dQN7SjTeLZv2fo
 oKIik1yY13KceZW/fR6OEECHaWSE/c2oQMMDLdVFJkbmIUS1DcXeEqAPotRd6In0+1PgbUMaLszjW
 JvLpj4/mC562A8oEv8U8aCkU5ZBrIgNZVK8CpAw02FUzy9tIPu553rexCRSKvza827k94z8PPIDbv
 ToUwYG6AaPZwCKdiKdDQAIsFk622asA+LPZzsI79hNzgdz3l/an71oHeUFCaQWzTkQRoerSScpvq2
 lWW8dLSaTJRVgC5eA9zr/ghULw35acoE3uMlYgh5JG5x51ACGo+n+SovHh3gEH6kY7cYo7shzIUR7
 7emKdLGQ==;
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU6zD-0008RH-Ic
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 09:27:24 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c06486c0000>; Tue, 04 Dec 2018 01:27:08 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 04 Dec 2018 01:27:09 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 04 Dec 2018 01:27:09 -0800
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Dec
 2018 09:27:08 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Dec
 2018 09:27:08 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Tue, 4 Dec 2018 09:27:08 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c0648690026>; Tue, 04 Dec 2018 01:27:06 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver
 <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH 14/19] arm64: dts: tegra210: add CPU clocks
Date: Tue, 4 Dec 2018 17:25:43 +0800
Message-ID: <20181204092548.3038-15-josephl@nvidia.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204092548.3038-1-josephl@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1543915628; bh=Hydh+fdd1CB8y+XWjmPQC692LZY2Bym/yEIWKRQQvhU=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=NypVPskbmtm1UyCrBj6pPfQZRIzyXvw/+ixFcj9OG0mpHsKvkxSsHeLiFHk3U4mbX
 7MqCZRELvz/pkIW2IYJHtSn0HmOlErjOjZyLVxErA5/+zY3C/BmVP8Q3TtodbCLnso
 mZmNMxXxJs5x/czg+OMG6GsUp1cKEG1y6QuHxFbUwIqnn58P7bChG2RFbwC6Aeajgm
 h0+cAkEAer25sb0KQZTtnRKdH5dv54ZQXVIphb6F4dhSL4OFJ24A+p1MBYDpTXMTtk
 JySlhQDbQ5s9ASIr665atJTQ2GznUJ8WmNCDcjpIzvoAnJyzeXOo4jgnLopda3X+b4
 f92qup9P8TOQA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_042723_729582_0BDA556F 
X-CRM114-Status: GOOD (  11.26  )
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

Add CPU clocks for Tegra210.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index a6db62157442..e2baf52fe1af 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1304,6 +1304,12 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a57";
 			reg = <0>;
+			clocks = <&tegra_car TEGRA210_CLK_CCLK_G>,
+				 <&tegra_car TEGRA210_CLK_PLL_X>,
+				 <&tegra_car TEGRA210_CLK_PLL_P_OUT4>,
+				 <&dfll>;
+			clock-names = "cpu_g", "pll_x", "pll_p", "dfll";
+			clock-latency = <300000>;
 		};
 
 		cpu@1 {
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
