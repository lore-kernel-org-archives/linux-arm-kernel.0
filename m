Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044BAC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:24:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5CA52184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QmtXM8rq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3UvVsmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5CA52184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4RTOOf3dwsvmoVbsY9ND4PgRF5LRtJfnu9frZETRZ3Q=; b=QmtXM8rqpER5Yi
	cPln8l2BElzbdCT6doyzpWRgW8hYyHOs5Y6pRTpPrIkH+bS4/Ccnn07PMKfyTExjqrVYuyO3Dazfv
	TDZOohKFr958bLRZsWQOritFnUkOkKsNxLqn/eFyELN07SlQKhBlU4Ti8FQtSuUWp150+F5lA+BiA
	ZNmu4t/96iN+Pc2NApJBxI/ccsMy8oDsiWH6N4G6171E+KBbXQn3bANehIGrXDzR+lREpNzSkvPIT
	Iff0B72KcDflmtiajD8mRzlcKob3pO0k/ysmIDmaPMRzZLvtrsHrg393cCf5U2fMbhsKevR6lzQVH
	dXC9mDktoEG7gkdM75ew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmyeR-0005dz-DO; Fri, 25 Jan 2019 10:23:55 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmydd-0004vL-EM
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 10:23:10 +0000
Received: by mail-wr1-x444.google.com with SMTP id t6so9633566wrr.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 02:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9ESKf+NTV2tZwpCvoTuHSzsM0y5nQHTu9YPl83xksac=;
 b=V3UvVsmo8od8cG4m1268uDUygbmaCtDPDKMrcj0vwSVmrc/ka4AGEAxbFklAKcwFe5
 3XEO2wa9ti+8IsxURyGuAedjw6SI4kTtuzW+JG9I6VfH99M5DmTcmV9gFF7TWjMJWz4k
 bcqLNPblJ4aKPvgV1wwD+7Awmd00+oAzk1vXYuJLrbeUPWaP9UGVd5EfRmvcaS485sHI
 LUAce+5efV3tDuwYalyrHhwbllLc8T+RC2yGkxjjMEUkVrsIswmJK0cWFTiPve1YsSep
 NaRxTA20SSwMc5cecQQFU+Uj7FpwydwCxOSDPWHrmq+PrFT9lyz/4gsQvpob3qYltmYM
 jTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9ESKf+NTV2tZwpCvoTuHSzsM0y5nQHTu9YPl83xksac=;
 b=VSv0AQfm9BFNjKO5IGWSvSLt9zM/MQokeJMQ7OAE+xMywZcx0MITgNrMR0Id/oZmpd
 zCfDiQWLWKcB9IQ+hHslwthxC3INuwRMn27XjTPxUlRYMm2pplzxW1SH9UfxDKPAsdke
 4TwPAWrdPddMLKXwVFeJHntYvL33DhM7ZyLk45KRcQhz9YCWkZO0XGe7OTAap/HCWY1o
 NJx8+Yzfv9V63tqNYbT0Yid3arEAW1CUlDZ6HXo/p6L5Kabrp+hYkoKsPOCSLWGQ88IF
 0OAd+3JyRTkV3SD3AjwE+IglqtIEgNnT3c/X3OjQBkbuwp3t/mEAHPvWY+40YFo+IBWF
 2a+Q==
X-Gm-Message-State: AJcUuke/2qlfMWrYpb8w9mz6kdyfA7p7Uw7zmURCP4zkQA5woCicp9qe
 BXwg1LFqzluHIInBFcr6Zc0=
X-Google-Smtp-Source: ALg8bN7icbo0zobuv2S7bV/Ku+UarJhxk54I+l3dtnhLiT5rblymee+1D7c9HiktRk/ZNNS2H3uK+g==
X-Received: by 2002:adf:8b4d:: with SMTP id v13mr10438970wra.282.1548411783250; 
 Fri, 25 Jan 2019 02:23:03 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id 200sm65839601wmw.31.2019.01.25.02.23.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 25 Jan 2019 02:23:02 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 5/7] soc/tegra: pmc: Make alignment consistent
Date: Fri, 25 Jan 2019 11:22:53 +0100
Message-Id: <20190125102255.6862-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190125102255.6862-1-thierry.reding@gmail.com>
References: <20190125102255.6862-1-thierry.reding@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_022306_029731_65DE4727 
X-CRM114-Status: GOOD (  14.52  )
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

Some recently added code used weird alignment and indentation. Fix these
occurrences to make them consistent with the rest of the code.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 32dd619c098e..2a2e6aaae97e 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1502,8 +1502,8 @@ static int tegra_io_pad_pinctrl_get_groups_count(struct pinctrl_dev *pctl_dev)
 	return pmc->soc->num_io_pads;
 }
 
-static const char *tegra_io_pad_pinctrl_get_group_name(
-		struct pinctrl_dev *pctl, unsigned int group)
+static const char *tegra_io_pad_pinctrl_get_group_name(struct pinctrl_dev *pctl,
+						       unsigned int group)
 {
 	struct tegra_pmc *pmc = pinctrl_dev_get_drvdata(pctl);
 
@@ -1519,6 +1519,7 @@ static int tegra_io_pad_pinctrl_get_group_pins(struct pinctrl_dev *pctl_dev,
 
 	*pins = &pmc->soc->io_pads[group].id;
 	*num_pins = 1;
+
 	return 0;
 }
 
@@ -1548,14 +1549,18 @@ static int tegra_io_pad_pinconf_get(struct pinctrl_dev *pctl_dev,
 		ret = tegra_io_pad_get_voltage(pmc, pad->id);
 		if (ret < 0)
 			return ret;
+
 		arg = ret;
 		break;
+
 	case PIN_CONFIG_LOW_POWER_MODE:
 		ret = tegra_io_pad_is_powered(pmc, pad->id);
 		if (ret < 0)
 			return ret;
+
 		arg = !ret;
 		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -1622,7 +1627,7 @@ static struct pinctrl_desc tegra_pmc_pctl_desc = {
 
 static int tegra_pmc_pinctrl_init(struct tegra_pmc *pmc)
 {
-	int err = 0;
+	int err;
 
 	if (!pmc->soc->num_pin_descs)
 		return 0;
@@ -1635,14 +1640,16 @@ static int tegra_pmc_pinctrl_init(struct tegra_pmc *pmc)
 					      pmc);
 	if (IS_ERR(pmc->pctl_dev)) {
 		err = PTR_ERR(pmc->pctl_dev);
-		dev_err(pmc->dev, "unable to register pinctrl, %d\n", err);
+		dev_err(pmc->dev, "failed to register pin controller: %d\n",
+			err);
+		return err;
 	}
 
-	return err;
+	return 0;
 }
 
 static ssize_t reset_reason_show(struct device *dev,
-			struct device_attribute *attr, char *buf)
+				 struct device_attribute *attr, char *buf)
 {
 	u32 value, rst_src;
 
@@ -1656,7 +1663,7 @@ static ssize_t reset_reason_show(struct device *dev,
 static DEVICE_ATTR_RO(reset_reason);
 
 static ssize_t reset_level_show(struct device *dev,
-			struct device_attribute *attr, char *buf)
+				struct device_attribute *attr, char *buf)
 {
 	u32 value, rst_lvl;
 
@@ -1678,16 +1685,16 @@ static void tegra_pmc_reset_sysfs_init(struct tegra_pmc *pmc)
 		err = device_create_file(dev, &dev_attr_reset_reason);
 		if (err < 0)
 			dev_warn(dev,
-				"failed to create attr \"reset_reason\": %d\n",
-				err);
+				 "failed to create attr \"reset_reason\": %d\n",
+				 err);
 	}
 
 	if (pmc->soc->reset_levels) {
 		err = device_create_file(dev, &dev_attr_reset_level);
 		if (err < 0)
 			dev_warn(dev,
-				"failed to create attr \"reset_level\": %d\n",
-				err);
+				 "failed to create attr \"reset_level\": %d\n",
+				 err);
 	}
 }
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
