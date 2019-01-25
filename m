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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2C9C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:24:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D827B2184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rT6QmXG1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRhAKWEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D827B2184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=19M1HpXYb21b9oSbMl92X1zPhe+VPPPT4zEB46lddMU=; b=rT6QmXG1QI+gye
	c6BM6XfBmHr9PGyZNgxEPBi2o6d2Nghf6AujaFCWMUL7q0q7BvIm214zGuLJpsojUxAU18sAyvWp/
	OdHBzmMW2coqF1FHA6P3amooVRNxQhucQQ4/mUi5MUqt1i+8vFMMN1k6H1sNHYQFVBM1xBWklZc5/
	qHErLatyVKWkK7RGA6KRBd2XE5nMK25FUKx8zFLMlLIgZ5aT2lRWjaXEbqkgoqQtPpTQiI5Bq/IRz
	ZpzACqkGUcs7kBzEX7wWqYHo2TmxOscmwsPc7mB2WR6pRvBkKRtPcu6KVBZ73WrVHELjurSzP3lXj
	WwCLdU1Dz1FSwMmVlNUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmyf1-000688-8K; Fri, 25 Jan 2019 10:24:31 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmyde-0004x8-GC
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 10:23:15 +0000
Received: by mail-wr1-x441.google.com with SMTP id z5so9650150wrt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 02:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5+J4Dzb7WlJbT4ecLsbccXPJJHm5Hm3fvugoM88RNhs=;
 b=NRhAKWEpVwaaOAfbRYl9+NUv9vwnuXvRicCH7h0HYjsmgeSiyJG43rtN7K3Gwvhvav
 E6zOVJEcnNbhowyp1lHtc9JBfWlFKR+iNpCQlaPazfsDGXDbTgWBg3XS5Ve84DXuFg+d
 9wi2fcRwytTHyeZXfmMqzQ6mzTHZ1cAZjacwXNbfXEP/NsZl1m9lgBDCwvtBvPKp8UqV
 myNwanw0Oyre2WhVBlOihvc/slFaKzMA5eQ5ekZjVWRhoOKFT3MHLwwa+kYNkAyJTVh6
 au3tM5PczLqVR48qnsDRpjJCnlh+iCA944PuNy8XJztYQAb0P++HBoXoXqs+Kgn5d/Yi
 YJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5+J4Dzb7WlJbT4ecLsbccXPJJHm5Hm3fvugoM88RNhs=;
 b=bxSztMWGwR/EpM6/BJBHD02PrpgpEdY2owJZv9YE1/aGhSMILnLika0NBpecFjXGgF
 7gI9R47UGlC9ki/nu1m2nBk+cYQmBdKlrZRTZF0rUW3BVoaDZk6nrmhqPuHlEDKHDAw1
 EONCwgiBX52J3AtaMs6o3iNPr5/Tsuo7SGLi6WoislDmrxfDQ8RZ1cs55fWR3uvEbysw
 mqytI5kIXlv01tkQM42ifngloQWQi4DvYpFU709TQczCz00YtBtwtXgzzdDgqdWpqPGc
 Rmn8EccLp3oylLQEJ70dh4G/D/cyAE5g7LtkY5Qm2VFTzx860dLYnRs49MMcthFBX/f+
 ENgQ==
X-Gm-Message-State: AJcUukf94WV3zJdcz89+6xVpknTRS43eckDGS+zQWWZbxt3CotxKyq+I
 T0fQAc8zjQME3N6OFh4R90TkOmx1bTc=
X-Google-Smtp-Source: ALg8bN4b3FVQ4+9EckViau0/TAIppru8r12qVX12NcvLSCEjOH6I4xvgv0fj5HeRXTmRQCCwV+XNXg==
X-Received: by 2002:adf:9ec8:: with SMTP id b8mr11321668wrf.164.1548411784921; 
 Fri, 25 Jan 2019 02:23:04 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id f22sm13933757wmj.26.2019.01.25.02.23.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 25 Jan 2019 02:23:04 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 6/7] soc/tegra: pmc: Explicitly initialize all fields
Date: Fri, 25 Jan 2019 11:22:54 +0100
Message-Id: <20190125102255.6862-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190125102255.6862-1-thierry.reding@gmail.com>
References: <20190125102255.6862-1-thierry.reding@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_022306_826033_4354932C 
X-CRM114-Status: GOOD (  11.76  )
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

It's not strictly necessary to initialize the fields in struct
tegra_pmc_soc if they are 0/false. However, we already initialize them
explicitly even if unnecessary, so keep doing that for consistency.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 2a2e6aaae97e..976f93628fff 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -2069,6 +2069,8 @@ static const struct tegra_pmc_soc tegra20_pmc_soc = {
 	.cpu_powergates = NULL,
 	.has_tsense_reset = false,
 	.has_gpu_clamps = false,
+	.needs_mbist_war = false,
+	.has_impl_33v_pwr = false,
 	.num_io_pads = 0,
 	.io_pads = NULL,
 	.num_pin_descs = 0,
@@ -2113,6 +2115,7 @@ static const struct tegra_pmc_soc tegra30_pmc_soc = {
 	.cpu_powergates = tegra30_cpu_powergates,
 	.has_tsense_reset = true,
 	.has_gpu_clamps = false,
+	.needs_mbist_war = false,
 	.has_impl_33v_pwr = false,
 	.num_io_pads = 0,
 	.io_pads = NULL,
@@ -2162,6 +2165,7 @@ static const struct tegra_pmc_soc tegra114_pmc_soc = {
 	.cpu_powergates = tegra114_cpu_powergates,
 	.has_tsense_reset = true,
 	.has_gpu_clamps = false,
+	.needs_mbist_war = false,
 	.has_impl_33v_pwr = false,
 	.num_io_pads = 0,
 	.io_pads = NULL,
@@ -2271,6 +2275,7 @@ static const struct tegra_pmc_soc tegra124_pmc_soc = {
 	.cpu_powergates = tegra124_cpu_powergates,
 	.has_tsense_reset = true,
 	.has_gpu_clamps = true,
+	.needs_mbist_war = false,
 	.has_impl_33v_pwr = false,
 	.num_io_pads = ARRAY_SIZE(tegra124_io_pads),
 	.io_pads = tegra124_io_pads,
@@ -2375,8 +2380,8 @@ static const struct tegra_pmc_soc tegra210_pmc_soc = {
 	.cpu_powergates = tegra210_cpu_powergates,
 	.has_tsense_reset = true,
 	.has_gpu_clamps = true,
-	.has_impl_33v_pwr = false,
 	.needs_mbist_war = true,
+	.has_impl_33v_pwr = false,
 	.num_io_pads = ARRAY_SIZE(tegra210_io_pads),
 	.io_pads = tegra210_io_pads,
 	.num_pin_descs = ARRAY_SIZE(tegra210_pin_descs),
@@ -2499,6 +2504,7 @@ static const struct tegra_pmc_soc tegra186_pmc_soc = {
 	.cpu_powergates = NULL,
 	.has_tsense_reset = false,
 	.has_gpu_clamps = false,
+	.needs_mbist_war = false,
 	.has_impl_33v_pwr = true,
 	.num_io_pads = ARRAY_SIZE(tegra186_io_pads),
 	.io_pads = tegra186_io_pads,
@@ -2577,6 +2583,8 @@ static const struct tegra_pmc_soc tegra194_pmc_soc = {
 	.cpu_powergates = NULL,
 	.has_tsense_reset = false,
 	.has_gpu_clamps = false,
+	.needs_mbist_war = false,
+	.has_impl_33v_pwr = false,
 	.num_io_pads = ARRAY_SIZE(tegra194_io_pads),
 	.io_pads = tegra194_io_pads,
 	.regs = &tegra186_pmc_regs,
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
