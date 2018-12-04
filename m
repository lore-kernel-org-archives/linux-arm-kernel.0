Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AD4C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:28:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA0F20645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nwieLQKf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FOn/aDwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA0F20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J/Yvcl2VB8LZyrFu1tSb00uLERcD8FXy1LHqP5Thh6w=; b=nwieLQKfhfd800
	3YxgSFTrMayhKbgUi+tXz8QQoedSSUZWcF7RaY8rfybb4tfp8Hcq53lStP9zP2bv8U/DbEt5iglST
	hCQYd6lklcP7HMhM6UFgWwF8RjsLFLMpMMw7e+xzWPFDkTzkJHjsOSZmpBz0yxGAPS9iDeqZlzDHb
	QwVOPoDDZDkDY8bhESvcksxqA/T0i8LkAbAItWS/9AvhgYavEpLhc2BAEJcDI4fmsgJsYdHdVbZ+R
	7MwVF9xjm8mJ4wXeP/JeydCopQrwHml9a4ZgInPiPG1CQj7KwpRHhpthYhRNF6nyQu7J/U7iESkmQ
	XYFiFyKYElMVPB1Uk+Nw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU70N-0001ix-2I; Tue, 04 Dec 2018 09:28:35 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU6yu-0008PS-B7
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 09:27:35 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c06485c0000>; Tue, 04 Dec 2018 01:26:53 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Tue, 04 Dec 2018 01:26:53 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Tue, 04 Dec 2018 01:26:53 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Dec
 2018 09:26:53 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Dec
 2018 09:26:53 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Tue, 4 Dec 2018 09:26:53 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c06485b0001>; Tue, 04 Dec 2018 01:26:52 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver
 <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH 08/19] clk: tegra: dfll: round down voltages based on alignment
Date: Tue, 4 Dec 2018 17:25:37 +0800
Message-ID: <20181204092548.3038-9-josephl@nvidia.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204092548.3038-1-josephl@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1543915613; bh=76SiM3Sn+CKXxnGOoZ1qarCkO2okk2A7hMW12Zz3zNE=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=FOn/aDweCHSUq4A7eXN0Yk2jGGZuW62H+EQFkH+DDwDH5uBaAQG79+zraSc/jGvID
 QBN/uHeV4cV4PrFnnD1zSP+X1M4kpSFWmK1Ztx3HNbi08v1pYp/f++9jUfT063RO3C
 IjkLf/ZMCbsp55yBjb+IMQPzIAcEt3tHJqC59qhCpkk5FMQAYwPLF19scRQb3X9LGo
 EkWfxNFuXx6lZAyiUdbpghNAk/AobUyl6Cf1yhqf018/sv1NYIPuOyAMV0t5zq4Njn
 MUQ4xTcT8qyComwN/Rca5/DxBwWPJ5m3fIoXomiIZ4O6u1y4U8tqQBM/yddob/PCO0
 BjeIXETy4Ta0g==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_012705_168335_6535935A 
X-CRM114-Status: GOOD (  11.50  )
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

When generating the OPP table, the voltages are round down with the
alignment from the regulator. The alignment should be applied for
voltages look up as well.

Based on the work of Penny Chiu <pchiu@nvidia.com>.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 drivers/clk/tegra/clk-dfll.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
index c294a2989f31..4a943c136d4d 100644
--- a/drivers/clk/tegra/clk-dfll.c
+++ b/drivers/clk/tegra/clk-dfll.c
@@ -804,17 +804,17 @@ static void dfll_init_out_if(struct tegra_dfll *td)
 static int find_lut_index_for_rate(struct tegra_dfll *td, unsigned long rate)
 {
 	struct dev_pm_opp *opp;
-	int i, uv;
+	int i, align_volt;
 
 	opp = dev_pm_opp_find_freq_ceil(td->soc->dev, &rate);
 	if (IS_ERR(opp))
 		return PTR_ERR(opp);
 
-	uv = dev_pm_opp_get_voltage(opp);
+	align_volt = dev_pm_opp_get_voltage(opp) / td->soc->alignment.step_uv;
 	dev_pm_opp_put(opp);
 
 	for (i = td->lut_bottom; i < td->lut_size; i++) {
-		if (regulator_list_voltage(td->vdd_reg, td->lut[i]) == uv)
+		if ((td->lut_uv[i] / td->soc->alignment.step_uv) >= align_volt)
 			return i;
 	}
 
@@ -1532,15 +1532,17 @@ static int dfll_init(struct tegra_dfll *td)
  */
 static int find_vdd_map_entry_exact(struct tegra_dfll *td, int uV)
 {
-	int i, n_voltages, reg_uV;
+	int i, n_voltages, reg_volt, align_volt;
 
+	align_volt = uV / td->soc->alignment.step_uv;
 	n_voltages = regulator_count_voltages(td->vdd_reg);
 	for (i = 0; i < n_voltages; i++) {
-		reg_uV = regulator_list_voltage(td->vdd_reg, i);
-		if (reg_uV < 0)
+		reg_volt = regulator_list_voltage(td->vdd_reg, i) /
+				td->soc->alignment.step_uv;
+		if (reg_volt < 0)
 			break;
 
-		if (uV == reg_uV)
+		if (align_volt == reg_volt)
 			return i;
 	}
 
@@ -1554,15 +1556,17 @@ static int find_vdd_map_entry_exact(struct tegra_dfll *td, int uV)
  * */
 static int find_vdd_map_entry_min(struct tegra_dfll *td, int uV)
 {
-	int i, n_voltages, reg_uV;
+	int i, n_voltages, reg_volt, align_volt;
 
+	align_volt = uV / td->soc->alignment.step_uv;
 	n_voltages = regulator_count_voltages(td->vdd_reg);
 	for (i = 0; i < n_voltages; i++) {
-		reg_uV = regulator_list_voltage(td->vdd_reg, i);
-		if (reg_uV < 0)
+		reg_volt = regulator_list_voltage(td->vdd_reg, i) /
+				td->soc->alignment.step_uv;
+		if (reg_volt < 0)
 			break;
 
-		if (uV <= reg_uV)
+		if (align_volt <= reg_volt)
 			return i;
 	}
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
