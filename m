Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F98C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 07:17:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52C6B205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 07:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lu5BFEbF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WtkZUD8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C6B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QpQZ5CcwTwn/29RwxyuOpqWGMP08mfbnqHcjZMvmroY=; b=lu5BFEbFGBZKMq
	lj3+62Q1F0rkaFS8HjDZ8e8nrDItUdg/TMnW2LVxkpRCGJ77JrXQtdkHp/CwqKoy76vfKzNq4BVps
	Bbj1hacm0nLhB0+ISxL1yaNtObO9V/hy+M0WP5983fJsCdDzd0iCxtBpv71v5sof+TRH0gmJa/Prv
	xd8YmpySALFvfj417EbLePZPPmcipVEJWeG7aSY1X6B2bCkjhCGrj4m6cvOcS9qej5XvA1zRFnIEG
	wgXbNhNmtVeEU0SkPLXbBDuhoeNYgqLmGInODt8AolXYxFlR0h5mdOLCTUrLBQuE8JP7LVz3M9ggW
	6ZOVDOgocbymXzDI5E0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfJjY-0006eo-SN; Fri, 04 Jan 2019 07:17:32 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfJjE-0006L3-2I
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 07:17:13 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c2f08620001>; Thu, 03 Jan 2019 23:16:50 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Thu, 03 Jan 2019 23:17:11 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Thu, 03 Jan 2019 23:17:11 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 4 Jan
 2019 07:17:11 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Fri, 4 Jan 2019 07:17:11 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c2f08760000>; Thu, 03 Jan 2019 23:17:11 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>
Subject: [PATCH] soc/tegra: fuse: fix typo in tegra210_init_speedo_data
Date: Fri, 4 Jan 2019 15:16:46 +0800
Message-ID: <20190104071646.15828-3-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104071646.15828-1-josephl@nvidia.com>
References: <20190104071646.15828-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1546586211; bh=UtOtyQOKtM4ug8gKTen24rqMBCViaDO0MO+/iqzuU30=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=WtkZUD8A6sYM3hbUVaHNPjysFVPzY3QSTCpIFpgJC68abJ7WZ7foixgZBAi9x+TaI
 R0qEVtMINba9Wtuzn24xH/ykCrjl1bs4dlKhvXCzh6m4De/RM4+aefEEn0uigMtDTi
 OZicM3sDh27bqSJCiSUbJMqcyHMf7/2iAFWFDXEJVxuQVUEQys/Fv7dqO1i41aaxkl
 G/f9TZlLBOby1+ZeRIYcpEdp3MngOswdR7N9s7KF0Di88cC+x3N5pwDlL8ubtCCg+h
 XUg1hx6Ie+8yEoafLjb+UCSuluhYvMpO1kjNG6xoJp0hJnlJTM9616dT5Xus5jHlAj
 GNNijMXdCxZLA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_231712_234302_48DBEC41 
X-CRM114-Status: UNSURE (   8.76  )
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
Cc: linux-tegra@vger.kernel.org, Mark Zhang <markz@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Fix typo when reading SoC speedo value from fuse SoC speedo register.

Reported-by: Mark Zhang <markz@nvidia.com>
Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 drivers/soc/tegra/fuse/speedo-tegra210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/fuse/speedo-tegra210.c b/drivers/soc/tegra/fuse/speedo-tegra210.c
index 5373f4c16b54..8ed35d9851f8 100644
--- a/drivers/soc/tegra/fuse/speedo-tegra210.c
+++ b/drivers/soc/tegra/fuse/speedo-tegra210.c
@@ -131,7 +131,7 @@ void __init tegra210_init_speedo_data(struct tegra_sku_info *sku_info)
 
 	soc_speedo[0] = tegra_fuse_read_early(FUSE_SOC_SPEEDO_0);
 	soc_speedo[1] = tegra_fuse_read_early(FUSE_SOC_SPEEDO_1);
-	soc_speedo[2] = tegra_fuse_read_early(FUSE_CPU_SPEEDO_2);
+	soc_speedo[2] = tegra_fuse_read_early(FUSE_SOC_SPEEDO_2);
 
 	cpu_iddq = tegra_fuse_read_early(FUSE_CPU_IDDQ) * 4;
 	soc_iddq = tegra_fuse_read_early(FUSE_SOC_IDDQ) * 4;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
