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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C299FC282C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:23:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88E782184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UbbhfPoN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpRDTPim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E782184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6aBpEtnGbUf4vyJvFzCLHnoyFJW9KAJuxITmgD/CBZI=; b=UbbhfPoNYYOT9z
	3Je4kpb3lbdUkTghc/g+DBmEXUDMzrzOFe1MKDkbE0OKMCgv1KLDb6Lp0n0zSLyLV0hZkA+VjA+H3
	pPIwssJLmIA9A7uoYhdXjC53foCs9Uj3Pm0wexJ2w0ze/rS9Ndb9sR7uV/ORRfb5KSRYY94yaGM+z
	6w1Y8Xji+xfBz6uEJ6DqcSg4uJ66nZmJ3+0wpUPeonGsm/S11C1L13WR3m8LP/xP0sAMqzMFhLU0G
	NKscb66h3vKsP4Gys5IXA6CXHzYmw87bOoUG3Yl6rlXDpA3qXmZbrhtIUY28pktzNRiI2zD7+oelI
	RxgDqFGZ/nFydW/A/DgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmyeA-0005O1-C9; Fri, 25 Jan 2019 10:23:38 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmydZ-0004tK-PV
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 10:23:04 +0000
Received: by mail-wr1-x441.google.com with SMTP id t27so9673906wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 02:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XVw4yJ3DeRUUhOCTYlQV70I31SQK+1qVA1VsbWC0olQ=;
 b=TpRDTPimDSAOlU1vu9YH/SZh8OLKNaCHJtqoYS3/ElOmNPrI9RjdxVbYPUqvnua/VP
 +ZO31KNz6uh6EyAONiJS7UZtCy3/c1bhB1nWf4qS5VfMUPqqvw3vl6at63duttor+haz
 bTV3tlKZzP5MLsSSvayntAdWAl6jgpjUkxfM5oETQFSy68JxmLTCjnpAMs97KSBBjfAh
 t5qBdYRDXZSfXxcyoStWt8CdBFZSBjMx4p7aJD9u09FnRIdKBmjY2snBz4LGXddPAle6
 uEQNqqVGJe7cKpXLlolcGoMC6tOoJantH8Xd4RKVsWSNElHyw7mgPp1AWo6cfRYpTHjj
 gR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XVw4yJ3DeRUUhOCTYlQV70I31SQK+1qVA1VsbWC0olQ=;
 b=Bndpn9pt7KjOQf789HB0pr0+rtrNqBIK5EzOUJ0bLxzWHLXeYaDInfbzjbx4PRVOKn
 /Y+lpc7edVH7omk2mZIU9BzdZyy/22aO5sOJ+nTxBYvfuzUFDO81KAi0h9pir9WVJG1M
 f3oNE58aUec+1JR/gASFXW+mHMLiXINYHj5/v5wQmIhC4W+xbcbKawjXQ9k58SaasLvh
 0lS9LWaUfhyThNiiF65JW3ET+YSetBYpc0NNLEKNBQCSbdYlJOyeh2mBzo6wTdCMcrtR
 uCfb1vWt+86CpUMizTbDkaFnP1KtIGijEw4Z7O8HtZ6BQleZLg03R/wrSoiYTMMhP493
 xo+Q==
X-Gm-Message-State: AJcUukeZdN1AHN8KIxSTQVp38uQYmYVfjGS6/xNYWczxseIDcrJZbXQ8
 kKFATfCFOHRF0Mh9qd7vUzI=
X-Google-Smtp-Source: ALg8bN70uKcw/sNISUpWdFwUt/+bkwUw3kz+gUnkpm1pCBV2cqEA+QWVm09TtwzXuI8geLIO1VPF6Q==
X-Received: by 2002:a5d:6487:: with SMTP id r7mr11183650wru.263.1548411779937; 
 Fri, 25 Jan 2019 02:22:59 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id v12sm130936929wmd.27.2019.01.25.02.22.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 25 Jan 2019 02:22:59 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 3/7] soc/tegra: pmc: Make tegra_powergate_is_powered() a local
 function
Date: Fri, 25 Jan 2019 11:22:51 +0100
Message-Id: <20190125102255.6862-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190125102255.6862-1-thierry.reding@gmail.com>
References: <20190125102255.6862-1-thierry.reding@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_022301_837703_A4A6BE45 
X-CRM114-Status: GOOD (  10.83  )
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

From: Jon Hunter <jonathanh@nvidia.com>

Now there are no more external users of tegra_powergate_is_powered(),
make this a local function.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 2 +-
 include/soc/tegra/pmc.h | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 550653302ff2..fa0e1ac6d501 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -637,7 +637,7 @@ EXPORT_SYMBOL(tegra_powergate_power_off);
  * tegra_powergate_is_powered() - check if partition is powered
  * @id: partition ID
  */
-int tegra_powergate_is_powered(unsigned int id)
+static int tegra_powergate_is_powered(unsigned int id)
 {
 	if (!tegra_powergate_is_valid(id))
 		return -EINVAL;
diff --git a/include/soc/tegra/pmc.h b/include/soc/tegra/pmc.h
index a9db1b501de1..b32ee5d82dd4 100644
--- a/include/soc/tegra/pmc.h
+++ b/include/soc/tegra/pmc.h
@@ -161,7 +161,6 @@ enum tegra_io_pad {
 #define TEGRA_IO_RAIL_LVDS	TEGRA_IO_PAD_LVDS
 
 #ifdef CONFIG_SOC_TEGRA_PMC
-int tegra_powergate_is_powered(unsigned int id);
 int tegra_powergate_power_on(unsigned int id);
 int tegra_powergate_power_off(unsigned int id);
 int tegra_powergate_remove_clamping(unsigned int id);
@@ -182,11 +181,6 @@ void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode);
 void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode);
 
 #else
-static inline int tegra_powergate_is_powered(unsigned int id)
-{
-	return -ENOSYS;
-}
-
 static inline int tegra_powergate_power_on(unsigned int id)
 {
 	return -ENOSYS;
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
