Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C42C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:24:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 743A52184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EesGQuB/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQ1sy56j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743A52184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Sow1mFDXCG85W1r1gvnbrp0Ntdx/D3BEY+DGOQBwpbE=; b=EesGQuB/6UWnNy
	oLSzwHNy6yqmFeq+qzytH8QzZAZJOvPr+edkMDvddwPPHMUqoP3O/2pIRCvCcna7BJGdAYpEtFvU5
	OfRtC/DTWF8EY9nCd+VPxe8qBOobVIh/AN8SIUyrv3bMQkzw1ywQfd1yz+JZFe8CXJHkETOI8tc3E
	gmacQtkcHhOL/2wqOOaj6ioFuScae1HuveyGPrg/4CiELExXkBSx7Lf8ok7XI6fGSMJ9rAwcrlK1L
	myzvND6cLWnBGJE2oYOZWC7TwkqGD3r53qJInskDHsd2c7Jz6GY4yhIyZjV+LCaxKQcF8moXyQg41
	h1gJUNIJcVUdGkqYKVVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmyei-0005s6-8o; Fri, 25 Jan 2019 10:24:12 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmydb-0004uQ-Nm
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 10:23:15 +0000
Received: by mail-wr1-x441.google.com with SMTP id p4so9675492wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 02:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wzTP7aYEzzBzNzl8LpUXT9ck8Wghlqf72UhfadVa370=;
 b=WQ1sy56jyUa3/3jm2HDBhQYy8KTJ61A4iKxL3kh7bz4R8xI53ej5iHtbV9gKsQzaid
 M5TAs3rzIaCk6BLa4vZNcP8cebiIMIbPnLR2q+ImMmWMibWOAv1JTFsXJqEpmQx8de7Y
 wAYvgK+yGWTgoJ8R1oY43GSTwk0I/AWPMU5M3+dtvoKefGtlaP6SWqYIrut87ONcYOWY
 oZLT5fc/OyKsuz5WZn8/t8H9+ohpQaD3yFumHMlE7uTjAe7FKuQUjFalnpXi721r00mR
 T0SKA+5O1/Za2qxXjjtFWieOe1bE9DEGaPQvivOcfPEB4Wttl1gS941UIeraQOehG1EM
 I7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wzTP7aYEzzBzNzl8LpUXT9ck8Wghlqf72UhfadVa370=;
 b=LIw/cO7xXeJesYrPQRblsayWqPOofIICaFJbAZak80ZVpXRr041TtpfCQMHDjgvgdW
 R1RmwApw4uSzrvDFkLa3N0XCQsbsZbK7Hn0aWkKUpOuu/IT5dAj4kFYWJAlXCDWhekyt
 vWSWa/nZWBpK5rCDAjDZI1+Sz8gAZ8VjPU42z8wA/0dbCERI2uKEYjnIR5QCXhnSD7Yk
 BgBnH0JyUx2LCA8A85+vXWyZ0WJA8rWLKvUcSKtuHq0TVBB9lqM3kM1AxAFtZpaj+wly
 rEGpA8hr+6HOimbd7l5HQcjaK2zhVMc1Y/BpctTRxGm8whbKwCDZ/HerciC73bVvlowC
 MuUA==
X-Gm-Message-State: AJcUukdkT8lH1fJ7M18TRN83BD8ThpM85epp1nDk73MIRgQtfk7L8Gim
 9Y87qHhXgCYt/SGxDGOFX8MY92KWymI=
X-Google-Smtp-Source: ALg8bN558qA/p6dGFGCY9ZvhmGkUwWbSzQYHzCEoz11I6GOXXb9Lir/A5cXc+g464ocVwMXkaZqvow==
X-Received: by 2002:adf:ba05:: with SMTP id o5mr10514490wrg.325.1548411781660; 
 Fri, 25 Jan 2019 02:23:01 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id w18sm103621359wru.54.2019.01.25.02.23.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 25 Jan 2019 02:23:00 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 4/7] soc/tegra: pmc: Pass struct tegra_pmc * where possible
Date: Fri, 25 Jan 2019 11:22:52 +0100
Message-Id: <20190125102255.6862-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190125102255.6862-1-thierry.reding@gmail.com>
References: <20190125102255.6862-1-thierry.reding@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_022304_512584_31208C8C 
X-CRM114-Status: GOOD (  18.26  )
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
Cc: linux-tegra@vger.kernel.org, Joseph Lo <josephl@nvidia.com>,
 Stephen Warren <swarren@nvidia.com>, linux-arm-kernel@lists.infradead.org,
 Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Instead of using the global pmc variable, pass around a pointer where
possible. Also, replace most occurrences of pr_*() functions by their
equivalent dev_*() functions, reusing the pmc->dev pointer.

It's not possible to get completely rid of the global variable because
some of the public API that this driver exposes still relies on it.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 267 +++++++++++++++++++++++-----------------
 1 file changed, 152 insertions(+), 115 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index fa0e1ac6d501..32dd619c098e 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -344,30 +344,36 @@ to_powergate(struct generic_pm_domain *domain)
 	return container_of(domain, struct tegra_powergate, genpd);
 }
 
-static u32 tegra_pmc_readl(unsigned long offset)
+static u32 tegra_pmc_readl(struct tegra_pmc *pmc, unsigned long offset)
 {
 	return readl(pmc->base + offset);
 }
 
-static void tegra_pmc_writel(u32 value, unsigned long offset)
+static void tegra_pmc_writel(struct tegra_pmc *pmc, u32 value,
+			     unsigned long offset)
 {
 	writel(value, pmc->base + offset);
 }
 
+/*
+ * TODO Figure out a way to call this with the struct tegra_pmc * passed in.
+ * This currently doesn't work because readx_poll_timeout() can only operate
+ * on functions that take a single argument.
+ */
 static inline bool tegra_powergate_state(int id)
 {
 	if (id == TEGRA_POWERGATE_3D && pmc->soc->has_gpu_clamps)
-		return (tegra_pmc_readl(GPU_RG_CNTRL) & 0x1) == 0;
+		return (tegra_pmc_readl(pmc, GPU_RG_CNTRL) & 0x1) == 0;
 	else
-		return (tegra_pmc_readl(PWRGATE_STATUS) & BIT(id)) != 0;
+		return (tegra_pmc_readl(pmc, PWRGATE_STATUS) & BIT(id)) != 0;
 }
 
-static inline bool tegra_powergate_is_valid(int id)
+static inline bool tegra_powergate_is_valid(struct tegra_pmc *pmc, int id)
 {
 	return (pmc->soc && pmc->soc->powergates[id]);
 }
 
-static inline bool tegra_powergate_is_available(int id)
+static inline bool tegra_powergate_is_available(struct tegra_pmc *pmc, int id)
 {
 	return test_bit(id, pmc->powergates_available);
 }
@@ -380,7 +386,7 @@ static int tegra_powergate_lookup(struct tegra_pmc *pmc, const char *name)
 		return -EINVAL;
 
 	for (i = 0; i < pmc->soc->num_powergates; i++) {
-		if (!tegra_powergate_is_valid(i))
+		if (!tegra_powergate_is_valid(pmc, i))
 			continue;
 
 		if (!strcmp(name, pmc->soc->powergates[i]))
@@ -392,10 +398,12 @@ static int tegra_powergate_lookup(struct tegra_pmc *pmc, const char *name)
 
 /**
  * tegra_powergate_set() - set the state of a partition
+ * @pmc: power management controller
  * @id: partition ID
  * @new_state: new state of the partition
  */
-static int tegra_powergate_set(unsigned int id, bool new_state)
+static int tegra_powergate_set(struct tegra_pmc *pmc, unsigned int id,
+			       bool new_state)
 {
 	bool status;
 	int err;
@@ -410,7 +418,7 @@ static int tegra_powergate_set(unsigned int id, bool new_state)
 		return 0;
 	}
 
-	tegra_pmc_writel(PWRGATE_TOGGLE_START | id, PWRGATE_TOGGLE);
+	tegra_pmc_writel(pmc, PWRGATE_TOGGLE_START | id, PWRGATE_TOGGLE);
 
 	err = readx_poll_timeout(tegra_powergate_state, id, status,
 				 status == new_state, 10, 100000);
@@ -420,7 +428,8 @@ static int tegra_powergate_set(unsigned int id, bool new_state)
 	return err;
 }
 
-static int __tegra_powergate_remove_clamping(unsigned int id)
+static int __tegra_powergate_remove_clamping(struct tegra_pmc *pmc,
+					     unsigned int id)
 {
 	u32 mask;
 
@@ -432,7 +441,7 @@ static int __tegra_powergate_remove_clamping(unsigned int id)
 	 */
 	if (id == TEGRA_POWERGATE_3D) {
 		if (pmc->soc->has_gpu_clamps) {
-			tegra_pmc_writel(0, GPU_RG_CNTRL);
+			tegra_pmc_writel(pmc, 0, GPU_RG_CNTRL);
 			goto out;
 		}
 	}
@@ -448,7 +457,7 @@ static int __tegra_powergate_remove_clamping(unsigned int id)
 	else
 		mask = (1 << id);
 
-	tegra_pmc_writel(mask, REMOVE_CLAMPING);
+	tegra_pmc_writel(pmc, mask, REMOVE_CLAMPING);
 
 out:
 	mutex_unlock(&pmc->powergates_lock);
@@ -500,7 +509,7 @@ static int tegra_powergate_power_up(struct tegra_powergate *pg,
 
 	usleep_range(10, 20);
 
-	err = tegra_powergate_set(pg->id, true);
+	err = tegra_powergate_set(pg->pmc, pg->id, true);
 	if (err < 0)
 		return err;
 
@@ -512,7 +521,7 @@ static int tegra_powergate_power_up(struct tegra_powergate *pg,
 
 	usleep_range(10, 20);
 
-	err = __tegra_powergate_remove_clamping(pg->id);
+	err = __tegra_powergate_remove_clamping(pg->pmc, pg->id);
 	if (err)
 		goto disable_clks;
 
@@ -539,7 +548,7 @@ static int tegra_powergate_power_up(struct tegra_powergate *pg,
 	usleep_range(10, 20);
 
 powergate_off:
-	tegra_powergate_set(pg->id, false);
+	tegra_powergate_set(pg->pmc, pg->id, false);
 
 	return err;
 }
@@ -564,7 +573,7 @@ static int tegra_powergate_power_down(struct tegra_powergate *pg)
 
 	usleep_range(10, 20);
 
-	err = tegra_powergate_set(pg->id, false);
+	err = tegra_powergate_set(pg->pmc, pg->id, false);
 	if (err)
 		goto assert_resets;
 
@@ -585,12 +594,13 @@ static int tegra_powergate_power_down(struct tegra_powergate *pg)
 static int tegra_genpd_power_on(struct generic_pm_domain *domain)
 {
 	struct tegra_powergate *pg = to_powergate(domain);
+	struct device *dev = pg->pmc->dev;
 	int err;
 
 	err = tegra_powergate_power_up(pg, true);
 	if (err)
-		pr_err("failed to turn on PM domain %s: %d\n", pg->genpd.name,
-		       err);
+		dev_err(dev, "failed to turn on PM domain %s: %d\n",
+			pg->genpd.name, err);
 
 	return err;
 }
@@ -598,12 +608,13 @@ static int tegra_genpd_power_on(struct generic_pm_domain *domain)
 static int tegra_genpd_power_off(struct generic_pm_domain *domain)
 {
 	struct tegra_powergate *pg = to_powergate(domain);
+	struct device *dev = pg->pmc->dev;
 	int err;
 
 	err = tegra_powergate_power_down(pg);
 	if (err)
-		pr_err("failed to turn off PM domain %s: %d\n",
-		       pg->genpd.name, err);
+		dev_err(dev, "failed to turn off PM domain %s: %d\n",
+			pg->genpd.name, err);
 
 	return err;
 }
@@ -614,10 +625,10 @@ static int tegra_genpd_power_off(struct generic_pm_domain *domain)
  */
 int tegra_powergate_power_on(unsigned int id)
 {
-	if (!tegra_powergate_is_available(id))
+	if (!tegra_powergate_is_available(pmc, id))
 		return -EINVAL;
 
-	return tegra_powergate_set(id, true);
+	return tegra_powergate_set(pmc, id, true);
 }
 
 /**
@@ -626,20 +637,21 @@ int tegra_powergate_power_on(unsigned int id)
  */
 int tegra_powergate_power_off(unsigned int id)
 {
-	if (!tegra_powergate_is_available(id))
+	if (!tegra_powergate_is_available(pmc, id))
 		return -EINVAL;
 
-	return tegra_powergate_set(id, false);
+	return tegra_powergate_set(pmc, id, false);
 }
 EXPORT_SYMBOL(tegra_powergate_power_off);
 
 /**
  * tegra_powergate_is_powered() - check if partition is powered
+ * @pmc: power management controller
  * @id: partition ID
  */
-static int tegra_powergate_is_powered(unsigned int id)
+static int tegra_powergate_is_powered(struct tegra_pmc *pmc, unsigned int id)
 {
-	if (!tegra_powergate_is_valid(id))
+	if (!tegra_powergate_is_valid(pmc, id))
 		return -EINVAL;
 
 	return tegra_powergate_state(id);
@@ -651,10 +663,10 @@ static int tegra_powergate_is_powered(unsigned int id)
  */
 int tegra_powergate_remove_clamping(unsigned int id)
 {
-	if (!tegra_powergate_is_available(id))
+	if (!tegra_powergate_is_available(pmc, id))
 		return -EINVAL;
 
-	return __tegra_powergate_remove_clamping(id);
+	return __tegra_powergate_remove_clamping(pmc, id);
 }
 EXPORT_SYMBOL(tegra_powergate_remove_clamping);
 
@@ -672,7 +684,7 @@ int tegra_powergate_sequence_power_up(unsigned int id, struct clk *clk,
 	struct tegra_powergate *pg;
 	int err;
 
-	if (!tegra_powergate_is_available(id))
+	if (!tegra_powergate_is_available(pmc, id))
 		return -EINVAL;
 
 	pg = kzalloc(sizeof(*pg), GFP_KERNEL);
@@ -687,7 +699,8 @@ int tegra_powergate_sequence_power_up(unsigned int id, struct clk *clk,
 
 	err = tegra_powergate_power_up(pg, false);
 	if (err)
-		pr_err("failed to turn on partition %d: %d\n", id, err);
+		dev_err(pmc->dev, "failed to turn on partition %d: %d\n", id,
+			err);
 
 	kfree(pg);
 
@@ -697,12 +710,14 @@ EXPORT_SYMBOL(tegra_powergate_sequence_power_up);
 
 /**
  * tegra_get_cpu_powergate_id() - convert from CPU ID to partition ID
+ * @pmc: power management controller
  * @cpuid: CPU partition ID
  *
  * Returns the partition ID corresponding to the CPU partition ID or a
  * negative error code on failure.
  */
-static int tegra_get_cpu_powergate_id(unsigned int cpuid)
+static int tegra_get_cpu_powergate_id(struct tegra_pmc *pmc,
+				      unsigned int cpuid)
 {
 	if (pmc->soc && cpuid < pmc->soc->num_cpu_powergates)
 		return pmc->soc->cpu_powergates[cpuid];
@@ -718,11 +733,11 @@ bool tegra_pmc_cpu_is_powered(unsigned int cpuid)
 {
 	int id;
 
-	id = tegra_get_cpu_powergate_id(cpuid);
+	id = tegra_get_cpu_powergate_id(pmc, cpuid);
 	if (id < 0)
 		return false;
 
-	return tegra_powergate_is_powered(id);
+	return tegra_powergate_is_powered(pmc, id);
 }
 
 /**
@@ -733,11 +748,11 @@ int tegra_pmc_cpu_power_on(unsigned int cpuid)
 {
 	int id;
 
-	id = tegra_get_cpu_powergate_id(cpuid);
+	id = tegra_get_cpu_powergate_id(pmc, cpuid);
 	if (id < 0)
 		return id;
 
-	return tegra_powergate_set(id, true);
+	return tegra_powergate_set(pmc, id, true);
 }
 
 /**
@@ -748,7 +763,7 @@ int tegra_pmc_cpu_remove_clamping(unsigned int cpuid)
 {
 	int id;
 
-	id = tegra_get_cpu_powergate_id(cpuid);
+	id = tegra_get_cpu_powergate_id(pmc, cpuid);
 	if (id < 0)
 		return id;
 
@@ -778,9 +793,9 @@ static int tegra_pmc_restart_notify(struct notifier_block *this,
 	writel(value, pmc->scratch + pmc->soc->regs->scratch0);
 
 	/* reset everything but PMC_SCRATCH0 and PMC_RST_STATUS */
-	value = tegra_pmc_readl(PMC_CNTRL);
+	value = tegra_pmc_readl(pmc, PMC_CNTRL);
 	value |= PMC_CNTRL_MAIN_RST;
-	tegra_pmc_writel(value, PMC_CNTRL);
+	tegra_pmc_writel(pmc, value, PMC_CNTRL);
 
 	return NOTIFY_DONE;
 }
@@ -799,7 +814,7 @@ static int powergate_show(struct seq_file *s, void *data)
 	seq_printf(s, "------------------\n");
 
 	for (i = 0; i < pmc->soc->num_powergates; i++) {
-		status = tegra_powergate_is_powered(i);
+		status = tegra_powergate_is_powered(pmc, i);
 		if (status < 0)
 			continue;
 
@@ -861,12 +876,13 @@ static int tegra_powergate_of_get_clks(struct tegra_powergate *pg,
 static int tegra_powergate_of_get_resets(struct tegra_powergate *pg,
 					 struct device_node *np, bool off)
 {
+	struct device *dev = pg->pmc->dev;
 	int err;
 
 	pg->reset = of_reset_control_array_get_exclusive(np);
 	if (IS_ERR(pg->reset)) {
 		err = PTR_ERR(pg->reset);
-		pr_err("failed to get device resets: %d\n", err);
+		dev_err(dev, "failed to get device resets: %d\n", err);
 		return err;
 	}
 
@@ -883,6 +899,7 @@ static int tegra_powergate_of_get_resets(struct tegra_powergate *pg,
 
 static void tegra_powergate_add(struct tegra_pmc *pmc, struct device_node *np)
 {
+	struct device *dev = pmc->dev;
 	struct tegra_powergate *pg;
 	int id, err;
 	bool off;
@@ -893,7 +910,7 @@ static void tegra_powergate_add(struct tegra_pmc *pmc, struct device_node *np)
 
 	id = tegra_powergate_lookup(pmc, np->name);
 	if (id < 0) {
-		pr_err("powergate lookup failed for %pOFn: %d\n", np, id);
+		dev_err(dev, "powergate lookup failed for %pOFn: %d\n", np, id);
 		goto free_mem;
 	}
 
@@ -909,17 +926,17 @@ static void tegra_powergate_add(struct tegra_pmc *pmc, struct device_node *np)
 	pg->genpd.power_on = tegra_genpd_power_on;
 	pg->pmc = pmc;
 
-	off = !tegra_powergate_is_powered(pg->id);
+	off = !tegra_powergate_is_powered(pmc, pg->id);
 
 	err = tegra_powergate_of_get_clks(pg, np);
 	if (err < 0) {
-		pr_err("failed to get clocks for %pOFn: %d\n", np, err);
+		dev_err(dev, "failed to get clocks for %pOFn: %d\n", np, err);
 		goto set_available;
 	}
 
 	err = tegra_powergate_of_get_resets(pg, np, off);
 	if (err < 0) {
-		pr_err("failed to get resets for %pOFn: %d\n", np, err);
+		dev_err(dev, "failed to get resets for %pOFn: %d\n", np, err);
 		goto remove_clks;
 	}
 
@@ -932,19 +949,19 @@ static void tegra_powergate_add(struct tegra_pmc *pmc, struct device_node *np)
 
 	err = pm_genpd_init(&pg->genpd, NULL, off);
 	if (err < 0) {
-		pr_err("failed to initialise PM domain %pOFn: %d\n", np,
+		dev_err(dev, "failed to initialise PM domain %pOFn: %d\n", np,
 		       err);
 		goto remove_resets;
 	}
 
 	err = of_genpd_add_provider_simple(np, &pg->genpd);
 	if (err < 0) {
-		pr_err("failed to add PM domain provider for %pOFn: %d\n",
-		       np, err);
+		dev_err(dev, "failed to add PM domain provider for %pOFn: %d\n",
+			np, err);
 		goto remove_genpd;
 	}
 
-	pr_debug("added PM domain %s\n", pg->genpd.name);
+	dev_dbg(dev, "added PM domain %s\n", pg->genpd.name);
 
 	return;
 
@@ -1000,7 +1017,8 @@ tegra_io_pad_find(struct tegra_pmc *pmc, enum tegra_io_pad id)
 	return NULL;
 }
 
-static int tegra_io_pad_get_dpd_register_bit(enum tegra_io_pad id,
+static int tegra_io_pad_get_dpd_register_bit(struct tegra_pmc *pmc,
+					     enum tegra_io_pad id,
 					     unsigned long *request,
 					     unsigned long *status,
 					     u32 *mask)
@@ -1009,7 +1027,7 @@ static int tegra_io_pad_get_dpd_register_bit(enum tegra_io_pad id,
 
 	pad = tegra_io_pad_find(pmc, id);
 	if (!pad) {
-		pr_err("invalid I/O pad ID %u\n", id);
+		dev_err(pmc->dev, "invalid I/O pad ID %u\n", id);
 		return -ENOENT;
 	}
 
@@ -1029,43 +1047,44 @@ static int tegra_io_pad_get_dpd_register_bit(enum tegra_io_pad id,
 	return 0;
 }
 
-static int tegra_io_pad_prepare(enum tegra_io_pad id, unsigned long *request,
-				unsigned long *status, u32 *mask)
+static int tegra_io_pad_prepare(struct tegra_pmc *pmc, enum tegra_io_pad id,
+				unsigned long *request, unsigned long *status,
+				u32 *mask)
 {
 	unsigned long rate, value;
 	int err;
 
-	err = tegra_io_pad_get_dpd_register_bit(id, request, status, mask);
+	err = tegra_io_pad_get_dpd_register_bit(pmc, id, request, status, mask);
 	if (err)
 		return err;
 
 	if (pmc->clk) {
 		rate = clk_get_rate(pmc->clk);
 		if (!rate) {
-			pr_err("failed to get clock rate\n");
+			dev_err(pmc->dev, "failed to get clock rate\n");
 			return -ENODEV;
 		}
 
-		tegra_pmc_writel(DPD_SAMPLE_ENABLE, DPD_SAMPLE);
+		tegra_pmc_writel(pmc, DPD_SAMPLE_ENABLE, DPD_SAMPLE);
 
 		/* must be at least 200 ns, in APB (PCLK) clock cycles */
 		value = DIV_ROUND_UP(1000000000, rate);
 		value = DIV_ROUND_UP(200, value);
-		tegra_pmc_writel(value, SEL_DPD_TIM);
+		tegra_pmc_writel(pmc, value, SEL_DPD_TIM);
 	}
 
 	return 0;
 }
 
-static int tegra_io_pad_poll(unsigned long offset, u32 mask,
-			     u32 val, unsigned long timeout)
+static int tegra_io_pad_poll(struct tegra_pmc *pmc, unsigned long offset,
+			     u32 mask, u32 val, unsigned long timeout)
 {
 	u32 value;
 
 	timeout = jiffies + msecs_to_jiffies(timeout);
 
 	while (time_after(timeout, jiffies)) {
-		value = tegra_pmc_readl(offset);
+		value = tegra_pmc_readl(pmc, offset);
 		if ((value & mask) == val)
 			return 0;
 
@@ -1075,10 +1094,10 @@ static int tegra_io_pad_poll(unsigned long offset, u32 mask,
 	return -ETIMEDOUT;
 }
 
-static void tegra_io_pad_unprepare(void)
+static void tegra_io_pad_unprepare(struct tegra_pmc *pmc)
 {
 	if (pmc->clk)
-		tegra_pmc_writel(DPD_SAMPLE_DISABLE, DPD_SAMPLE);
+		tegra_pmc_writel(pmc, DPD_SAMPLE_DISABLE, DPD_SAMPLE);
 }
 
 /**
@@ -1095,21 +1114,21 @@ int tegra_io_pad_power_enable(enum tegra_io_pad id)
 
 	mutex_lock(&pmc->powergates_lock);
 
-	err = tegra_io_pad_prepare(id, &request, &status, &mask);
+	err = tegra_io_pad_prepare(pmc, id, &request, &status, &mask);
 	if (err < 0) {
-		pr_err("failed to prepare I/O pad: %d\n", err);
+		dev_err(pmc->dev, "failed to prepare I/O pad: %d\n", err);
 		goto unlock;
 	}
 
-	tegra_pmc_writel(IO_DPD_REQ_CODE_OFF | mask, request);
+	tegra_pmc_writel(pmc, IO_DPD_REQ_CODE_OFF | mask, request);
 
-	err = tegra_io_pad_poll(status, mask, 0, 250);
+	err = tegra_io_pad_poll(pmc, status, mask, 0, 250);
 	if (err < 0) {
-		pr_err("failed to enable I/O pad: %d\n", err);
+		dev_err(pmc->dev, "failed to enable I/O pad: %d\n", err);
 		goto unlock;
 	}
 
-	tegra_io_pad_unprepare();
+	tegra_io_pad_unprepare(pmc);
 
 unlock:
 	mutex_unlock(&pmc->powergates_lock);
@@ -1131,21 +1150,21 @@ int tegra_io_pad_power_disable(enum tegra_io_pad id)
 
 	mutex_lock(&pmc->powergates_lock);
 
-	err = tegra_io_pad_prepare(id, &request, &status, &mask);
+	err = tegra_io_pad_prepare(pmc, id, &request, &status, &mask);
 	if (err < 0) {
-		pr_err("failed to prepare I/O pad: %d\n", err);
+		dev_err(pmc->dev, "failed to prepare I/O pad: %d\n", err);
 		goto unlock;
 	}
 
-	tegra_pmc_writel(IO_DPD_REQ_CODE_ON | mask, request);
+	tegra_pmc_writel(pmc, IO_DPD_REQ_CODE_ON | mask, request);
 
-	err = tegra_io_pad_poll(status, mask, mask, 250);
+	err = tegra_io_pad_poll(pmc, status, mask, mask, 250);
 	if (err < 0) {
-		pr_err("failed to disable I/O pad: %d\n", err);
+		dev_err(pmc->dev, "failed to disable I/O pad: %d\n", err);
 		goto unlock;
 	}
 
-	tegra_io_pad_unprepare();
+	tegra_io_pad_unprepare(pmc);
 
 unlock:
 	mutex_unlock(&pmc->powergates_lock);
@@ -1153,22 +1172,24 @@ int tegra_io_pad_power_disable(enum tegra_io_pad id)
 }
 EXPORT_SYMBOL(tegra_io_pad_power_disable);
 
-static int tegra_io_pad_is_powered(enum tegra_io_pad id)
+static int tegra_io_pad_is_powered(struct tegra_pmc *pmc, enum tegra_io_pad id)
 {
 	unsigned long request, status;
 	u32 mask, value;
 	int err;
 
-	err = tegra_io_pad_get_dpd_register_bit(id, &request, &status, &mask);
+	err = tegra_io_pad_get_dpd_register_bit(pmc, id, &request, &status,
+						&mask);
 	if (err)
 		return err;
 
-	value = tegra_pmc_readl(status);
+	value = tegra_pmc_readl(pmc, status);
 
 	return !(value & mask);
 }
 
-static int tegra_io_pad_set_voltage(enum tegra_io_pad id, int voltage)
+static int tegra_io_pad_set_voltage(struct tegra_pmc *pmc, enum tegra_io_pad id,
+				    int voltage)
 {
 	const struct tegra_io_pad_soc *pad;
 	u32 value;
@@ -1183,29 +1204,29 @@ static int tegra_io_pad_set_voltage(enum tegra_io_pad id, int voltage)
 	mutex_lock(&pmc->powergates_lock);
 
 	if (pmc->soc->has_impl_33v_pwr) {
-		value = tegra_pmc_readl(PMC_IMPL_E_33V_PWR);
+		value = tegra_pmc_readl(pmc, PMC_IMPL_E_33V_PWR);
 
 		if (voltage == TEGRA_IO_PAD_VOLTAGE_1V8)
 			value &= ~BIT(pad->voltage);
 		else
 			value |= BIT(pad->voltage);
 
-		tegra_pmc_writel(value, PMC_IMPL_E_33V_PWR);
+		tegra_pmc_writel(pmc, value, PMC_IMPL_E_33V_PWR);
 	} else {
 		/* write-enable PMC_PWR_DET_VALUE[pad->voltage] */
-		value = tegra_pmc_readl(PMC_PWR_DET);
+		value = tegra_pmc_readl(pmc, PMC_PWR_DET);
 		value |= BIT(pad->voltage);
-		tegra_pmc_writel(value, PMC_PWR_DET);
+		tegra_pmc_writel(pmc, value, PMC_PWR_DET);
 
 		/* update I/O voltage */
-		value = tegra_pmc_readl(PMC_PWR_DET_VALUE);
+		value = tegra_pmc_readl(pmc, PMC_PWR_DET_VALUE);
 
 		if (voltage == TEGRA_IO_PAD_VOLTAGE_1V8)
 			value &= ~BIT(pad->voltage);
 		else
 			value |= BIT(pad->voltage);
 
-		tegra_pmc_writel(value, PMC_PWR_DET_VALUE);
+		tegra_pmc_writel(pmc, value, PMC_PWR_DET_VALUE);
 	}
 
 	mutex_unlock(&pmc->powergates_lock);
@@ -1215,7 +1236,7 @@ static int tegra_io_pad_set_voltage(enum tegra_io_pad id, int voltage)
 	return 0;
 }
 
-static int tegra_io_pad_get_voltage(enum tegra_io_pad id)
+static int tegra_io_pad_get_voltage(struct tegra_pmc *pmc, enum tegra_io_pad id)
 {
 	const struct tegra_io_pad_soc *pad;
 	u32 value;
@@ -1228,9 +1249,9 @@ static int tegra_io_pad_get_voltage(enum tegra_io_pad id)
 		return -ENOTSUPP;
 
 	if (pmc->soc->has_impl_33v_pwr)
-		value = tegra_pmc_readl(PMC_IMPL_E_33V_PWR);
+		value = tegra_pmc_readl(pmc, PMC_IMPL_E_33V_PWR);
 	else
-		value = tegra_pmc_readl(PMC_PWR_DET_VALUE);
+		value = tegra_pmc_readl(pmc, PMC_PWR_DET_VALUE);
 
 	if ((value & BIT(pad->voltage)) == 0)
 		return TEGRA_IO_PAD_VOLTAGE_1V8;
@@ -1302,21 +1323,21 @@ void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
 
 		ticks = pmc->cpu_good_time * rate + USEC_PER_SEC - 1;
 		do_div(ticks, USEC_PER_SEC);
-		tegra_pmc_writel(ticks, PMC_CPUPWRGOOD_TIMER);
+		tegra_pmc_writel(pmc, ticks, PMC_CPUPWRGOOD_TIMER);
 
 		ticks = pmc->cpu_off_time * rate + USEC_PER_SEC - 1;
 		do_div(ticks, USEC_PER_SEC);
-		tegra_pmc_writel(ticks, PMC_CPUPWROFF_TIMER);
+		tegra_pmc_writel(pmc, ticks, PMC_CPUPWROFF_TIMER);
 
 		wmb();
 
 		pmc->rate = rate;
 	}
 
-	value = tegra_pmc_readl(PMC_CNTRL);
+	value = tegra_pmc_readl(pmc, PMC_CNTRL);
 	value &= ~PMC_CNTRL_SIDE_EFFECT_LP0;
 	value |= PMC_CNTRL_CPU_PWRREQ_OE;
-	tegra_pmc_writel(value, PMC_CNTRL);
+	tegra_pmc_writel(pmc, value, PMC_CNTRL);
 }
 #endif
 
@@ -1438,13 +1459,13 @@ static void tegra_pmc_init_tsense_reset(struct tegra_pmc *pmc)
 	if (of_property_read_u32(np, "nvidia,pinmux-id", &pinmux))
 		pinmux = 0;
 
-	value = tegra_pmc_readl(PMC_SENSOR_CTRL);
+	value = tegra_pmc_readl(pmc, PMC_SENSOR_CTRL);
 	value |= PMC_SENSOR_CTRL_SCRATCH_WRITE;
-	tegra_pmc_writel(value, PMC_SENSOR_CTRL);
+	tegra_pmc_writel(pmc, value, PMC_SENSOR_CTRL);
 
 	value = (reg_data << PMC_SCRATCH54_DATA_SHIFT) |
 		(reg_addr << PMC_SCRATCH54_ADDR_SHIFT);
-	tegra_pmc_writel(value, PMC_SCRATCH54);
+	tegra_pmc_writel(pmc, value, PMC_SCRATCH54);
 
 	value = PMC_SCRATCH55_RESET_TEGRA;
 	value |= ctrl_id << PMC_SCRATCH55_CNTRL_ID_SHIFT;
@@ -1462,11 +1483,11 @@ static void tegra_pmc_init_tsense_reset(struct tegra_pmc *pmc)
 
 	value |= checksum << PMC_SCRATCH55_CHECKSUM_SHIFT;
 
-	tegra_pmc_writel(value, PMC_SCRATCH55);
+	tegra_pmc_writel(pmc, value, PMC_SCRATCH55);
 
-	value = tegra_pmc_readl(PMC_SENSOR_CTRL);
+	value = tegra_pmc_readl(pmc, PMC_SENSOR_CTRL);
 	value |= PMC_SENSOR_CTRL_ENABLE_RST;
-	tegra_pmc_writel(value, PMC_SENSOR_CTRL);
+	tegra_pmc_writel(pmc, value, PMC_SENSOR_CTRL);
 
 	dev_info(pmc->dev, "emergency thermal reset enabled\n");
 
@@ -1476,12 +1497,16 @@ static void tegra_pmc_init_tsense_reset(struct tegra_pmc *pmc)
 
 static int tegra_io_pad_pinctrl_get_groups_count(struct pinctrl_dev *pctl_dev)
 {
+	struct tegra_pmc *pmc = pinctrl_dev_get_drvdata(pctl_dev);
+
 	return pmc->soc->num_io_pads;
 }
 
 static const char *tegra_io_pad_pinctrl_get_group_name(
 		struct pinctrl_dev *pctl, unsigned int group)
 {
+	struct tegra_pmc *pmc = pinctrl_dev_get_drvdata(pctl);
+
 	return pmc->soc->io_pads[group].name;
 }
 
@@ -1490,6 +1515,8 @@ static int tegra_io_pad_pinctrl_get_group_pins(struct pinctrl_dev *pctl_dev,
 					       const unsigned int **pins,
 					       unsigned int *num_pins)
 {
+	struct tegra_pmc *pmc = pinctrl_dev_get_drvdata(pctl_dev);
+
 	*pins = &pmc->soc->io_pads[group].id;
 	*num_pins = 1;
 	return 0;
@@ -1506,23 +1533,25 @@ static const struct pinctrl_ops tegra_io_pad_pinctrl_ops = {
 static int tegra_io_pad_pinconf_get(struct pinctrl_dev *pctl_dev,
 				    unsigned int pin, unsigned long *config)
 {
-	const struct tegra_io_pad_soc *pad = tegra_io_pad_find(pmc, pin);
 	enum pin_config_param param = pinconf_to_config_param(*config);
+	struct tegra_pmc *pmc = pinctrl_dev_get_drvdata(pctl_dev);
+	const struct tegra_io_pad_soc *pad;
 	int ret;
 	u32 arg;
 
+	pad = tegra_io_pad_find(pmc, pin);
 	if (!pad)
 		return -EINVAL;
 
 	switch (param) {
 	case PIN_CONFIG_POWER_SOURCE:
-		ret = tegra_io_pad_get_voltage(pad->id);
+		ret = tegra_io_pad_get_voltage(pmc, pad->id);
 		if (ret < 0)
 			return ret;
 		arg = ret;
 		break;
 	case PIN_CONFIG_LOW_POWER_MODE:
-		ret = tegra_io_pad_is_powered(pad->id);
+		ret = tegra_io_pad_is_powered(pmc, pad->id);
 		if (ret < 0)
 			return ret;
 		arg = !ret;
@@ -1540,12 +1569,14 @@ static int tegra_io_pad_pinconf_set(struct pinctrl_dev *pctl_dev,
 				    unsigned int pin, unsigned long *configs,
 				    unsigned int num_configs)
 {
-	const struct tegra_io_pad_soc *pad = tegra_io_pad_find(pmc, pin);
+	struct tegra_pmc *pmc = pinctrl_dev_get_drvdata(pctl_dev);
+	const struct tegra_io_pad_soc *pad;
 	enum pin_config_param param;
 	unsigned int i;
 	int err;
 	u32 arg;
 
+	pad = tegra_io_pad_find(pmc, pin);
 	if (!pad)
 		return -EINVAL;
 
@@ -1566,7 +1597,7 @@ static int tegra_io_pad_pinconf_set(struct pinctrl_dev *pctl_dev,
 			if (arg != TEGRA_IO_PAD_VOLTAGE_1V8 &&
 			    arg != TEGRA_IO_PAD_VOLTAGE_3V3)
 				return -EINVAL;
-			err = tegra_io_pad_set_voltage(pad->id, arg);
+			err = tegra_io_pad_set_voltage(pmc, pad->id, arg);
 			if (err)
 				return err;
 			break;
@@ -1615,7 +1646,7 @@ static ssize_t reset_reason_show(struct device *dev,
 {
 	u32 value, rst_src;
 
-	value = tegra_pmc_readl(pmc->soc->regs->rst_status);
+	value = tegra_pmc_readl(pmc, pmc->soc->regs->rst_status);
 	rst_src = (value & pmc->soc->regs->rst_source_mask) >>
 			pmc->soc->regs->rst_source_shift;
 
@@ -1629,7 +1660,7 @@ static ssize_t reset_level_show(struct device *dev,
 {
 	u32 value, rst_lvl;
 
-	value = tegra_pmc_readl(pmc->soc->regs->rst_status);
+	value = tegra_pmc_readl(pmc, pmc->soc->regs->rst_status);
 	rst_lvl = (value & pmc->soc->regs->rst_level_mask) >>
 			pmc->soc->regs->rst_level_shift;
 
@@ -1926,6 +1957,8 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 	pmc->base = base;
 	mutex_unlock(&pmc->powergates_lock);
 
+	platform_set_drvdata(pdev, pmc);
+
 	return 0;
 
 cleanup_restart_handler:
@@ -1938,14 +1971,18 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 #if defined(CONFIG_PM_SLEEP) && defined(CONFIG_ARM)
 static int tegra_pmc_suspend(struct device *dev)
 {
-	tegra_pmc_writel(virt_to_phys(tegra_resume), PMC_SCRATCH41);
+	struct tegra_pmc *pmc = dev_get_drvdata(dev);
+
+	tegra_pmc_writel(pmc, virt_to_phys(tegra_resume), PMC_SCRATCH41);
 
 	return 0;
 }
 
 static int tegra_pmc_resume(struct device *dev)
 {
-	tegra_pmc_writel(0x0, PMC_SCRATCH41);
+	struct tegra_pmc *pmc, dev_get_drvdata(dev);
+
+	tegra_pmc_writel(pmc, 0x0, PMC_SCRATCH41);
 
 	return 0;
 }
@@ -1982,11 +2019,11 @@ static void tegra20_pmc_init(struct tegra_pmc *pmc)
 	u32 value;
 
 	/* Always enable CPU power request */
-	value = tegra_pmc_readl(PMC_CNTRL);
+	value = tegra_pmc_readl(pmc, PMC_CNTRL);
 	value |= PMC_CNTRL_CPU_PWRREQ_OE;
-	tegra_pmc_writel(value, PMC_CNTRL);
+	tegra_pmc_writel(pmc, value, PMC_CNTRL);
 
-	value = tegra_pmc_readl(PMC_CNTRL);
+	value = tegra_pmc_readl(pmc, PMC_CNTRL);
 
 	if (pmc->sysclkreq_high)
 		value &= ~PMC_CNTRL_SYSCLK_POLARITY;
@@ -1994,12 +2031,12 @@ static void tegra20_pmc_init(struct tegra_pmc *pmc)
 		value |= PMC_CNTRL_SYSCLK_POLARITY;
 
 	/* configure the output polarity while the request is tristated */
-	tegra_pmc_writel(value, PMC_CNTRL);
+	tegra_pmc_writel(pmc, value, PMC_CNTRL);
 
 	/* now enable the request */
-	value = tegra_pmc_readl(PMC_CNTRL);
+	value = tegra_pmc_readl(pmc, PMC_CNTRL);
 	value |= PMC_CNTRL_SYSCLK_OE;
-	tegra_pmc_writel(value, PMC_CNTRL);
+	tegra_pmc_writel(pmc, value, PMC_CNTRL);
 }
 
 static void tegra20_pmc_setup_irq_polarity(struct tegra_pmc *pmc,
@@ -2008,14 +2045,14 @@ static void tegra20_pmc_setup_irq_polarity(struct tegra_pmc *pmc,
 {
 	u32 value;
 
-	value = tegra_pmc_readl(PMC_CNTRL);
+	value = tegra_pmc_readl(pmc, PMC_CNTRL);
 
 	if (invert)
 		value |= PMC_CNTRL_INTR_POLARITY;
 	else
 		value &= ~PMC_CNTRL_INTR_POLARITY;
 
-	tegra_pmc_writel(value, PMC_CNTRL);
+	tegra_pmc_writel(pmc, value, PMC_CNTRL);
 }
 
 static const struct tegra_pmc_soc tegra20_pmc_soc = {
@@ -2419,7 +2456,7 @@ static void tegra186_pmc_setup_irq_polarity(struct tegra_pmc *pmc,
 
 	index = of_property_match_string(np, "reg-names", "wake");
 	if (index < 0) {
-		pr_err("failed to find PMC wake registers\n");
+		dev_err(pmc->dev, "failed to find PMC wake registers\n");
 		return;
 	}
 
@@ -2427,7 +2464,7 @@ static void tegra186_pmc_setup_irq_polarity(struct tegra_pmc *pmc,
 
 	wake = ioremap_nocache(regs.start, resource_size(&regs));
 	if (!wake) {
-		pr_err("failed to map PMC wake registers\n");
+		dev_err(pmc->dev, "failed to map PMC wake registers\n");
 		return;
 	}
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
