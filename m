Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DF2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:22:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C27C120838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m8Pha7kz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="H9H9T2Wq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C27C120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A/CG88VN6Q+H0tquZTIR1IF8RQBgEzO+kWIYpU4nyEc=; b=m8Pha7kzLu/CGV
	AO4vEo/GtCIA0r/St8A3F3HyPcqvv6h66L4Yn9fYHh+7kwq9dmDufYuivareasbWXrTrMa9iA99Cd
	9HZiVD/FSW38OTY05k7dDQETrsofo2KciLNBoY20CMkjsuOkLVCUtSWw1b8SaxVRc8flq36vsrlve
	cazacUMseX19BAcrqtXD0/3FoofR6UAJZG5bPNTGXgIl4J/6Xayqc37fAaff09nOD9wWc8H25cHus
	MWZ3q9g6UNhPKlZK7qM7qc4JYcm1t8pLUSq0Db+1dYtE96FELYl3h01kzHpAnYemofG7kTG8/vAfC
	TL46o/GIgKPNmcEiM+wg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwigc-00069R-CW; Thu, 21 Feb 2019 07:22:26 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwigE-0005jJ-LU
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 07:22:04 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c6e51a20000>; Wed, 20 Feb 2019 23:22:10 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Wed, 20 Feb 2019 23:22:02 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Wed, 20 Feb 2019 23:22:02 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 21 Feb
 2019 07:22:02 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 21 Feb
 2019 07:22:02 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Feb 2019 07:22:01 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw01.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c6e51980000>; Wed, 20 Feb 2019 23:22:01 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Thomas
 Gleixner" <tglx@linutronix.de>
Subject: [PATCH V7 3/8] soc/tegra: default select TEGRA_TIMER for Tegra210
Date: Thu, 21 Feb 2019 15:21:45 +0800
Message-ID: <20190221072150.4395-4-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221072150.4395-1-josephl@nvidia.com>
References: <20190221072150.4395-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1550733730; bh=puuvg2631Nt+Oa9pn1c8k94YNAeE1c9YhtHedKj6rHc=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=H9H9T2WqGJWFiQphdou5Z4utIZ1XbQGJQGtSzRDJpFotMmjBan8xzeR0g4FJfTqBq
 K/jy8J0oX2aannuaLYimFZEDL1uHuEt7KQtBjVc7vZSaQPzDtWU+TQHYmeXPgq4j/j
 DzGwfeO2KsivlkkJyarvJKPe69XWxk0zZ7Wy7VJOjAGbpCTW4kdkZaR0VZcinEHuyX
 nJ053TIc5VF4k1OapXnW4mrkuXJaZUoBvDKeeltXvCc5seHC1iTb4dZZUVBWAXOK93
 2xx95/T9Cz5eg6amve6DmLPvZndMmdyr081oUdutFTJjXfJn+/1g4kstA68pztnvgC
 Xhwind6V7MtXA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_232202_938099_AF5AADA7 
X-CRM114-Status: UNSURE (   7.24  )
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
Cc: linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The tegra timer is necessary for Tegra210 to support CPU idle power-down
state. So select it by default.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
---
v7:
 * no change
v6:
 * add ack tag from Jon.
v5:
 * add ack tag from Thierry.
v4:
 * new added in this version
---
 drivers/soc/tegra/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index fe4481676da6..a0b03443d8c1 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -76,6 +76,7 @@ config ARCH_TEGRA_210_SOC
 	select PINCTRL_TEGRA210
 	select SOC_TEGRA_FLOWCTRL
 	select SOC_TEGRA_PMC
+	select TEGRA_TIMER
 	help
 	  Enable support for the NVIDIA Tegra210 SoC. Also known as Tegra X1,
 	  the Tegra210 has four Cortex-A57 cores paired with four Cortex-A53
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
