Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EDAC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:51:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54AFC218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oG+Nbzcb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54AFC218D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bgLGdIAA56keNPHzl6MlbUSp998Q2Ve+XGuP8xr5wsA=; b=oG+NbzcbBZ5d9K
	OiBtIKuuB+31qrRgVlQAw9kzRnDt16LvLoKdwG6k4TObM6Cjz9qx2Q5RhmuCcNxux4EjA86jUrS1w
	/qMV2PqiIcjlJfCPyAgFaRTaEPmk3iG8+XE+/oyDlGpOAPN4Q+60q5N2VX/+axN8lLRep66QJDbo/
	do+m1L15cI0qLZpogY5OyjZCW7/TiScBBqIjc2ewEtVfxJfYQ0m1sD4BDFJvXHcLnZsv59MWA4eK+
	k4vAV0EILgQemJ3LdNosRGhtoPxfzM3Vx3lcBGgXHl7t0HxzPXZ/Pl5dWI+U9nkPuMoa58RXR0Mpg
	mSO9uEFW/rsQPsBoVAFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grSHz-0005Z7-3o; Wed, 06 Feb 2019 18:51:15 +0000
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grSH9-0004ic-VB
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 18:50:36 +0000
Received: by mail-pg1-f195.google.com with SMTP id d72so3283162pga.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 10:50:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JQbxrapc2NPnl+P0Ls8p326l329nCPDkPd21a4zaEEI=;
 b=RbvuAB6wi2aybE8ViQ3I4ugJI6V9DKtJ1fyJ8hR/4PXqqgHCBk7vLXuQk57ZvpRgxj
 2kHVbrS4i1X3SAwXJhPq/f97Divju1jgh7mrbREgBtNENjle3+nQJJ6oZluxo6ehp/Fo
 k+K9KWjqAfArPGzQmwlP8t05KRrNHoFAgJQcH49RgJC7l82beAi1wrAWx8MUp1vMrxxH
 NqUtl3pC+esQIWAQ0WVwBVYOylSVZ7FOEIYDwPWdNZlUlQnsLR3y9+IBVEoLrowirufB
 JI6F2CS+rVBWBsTV1cBODy9gs5Y0Se3pA/BtGJeRXTaaZl8benu9sDI92HCiMSXFrbyX
 PECA==
X-Gm-Message-State: AHQUAuYwQOqaz494GEUtpPendxgOdZ8pD0Dhp56HIYhmPDTceX0ONkbd
 Vl9Q+ZWy4Tcgz15NCP4LLPuT6hbzJ4DlWQ==
X-Google-Smtp-Source: AHgI3IafxK7A45j7DPk2dDGMnhfEgfmvvN1wJQ5fhQLgtS8AFXMRxB/QDJlbg44k6TcxL6vBpcS/KQ==
X-Received: by 2002:a63:dc54:: with SMTP id f20mr694144pgj.410.1549479019745; 
 Wed, 06 Feb 2019 10:50:19 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
 by smtp.gmail.com with ESMTPSA id d21sm10393015pfo.162.2019.02.06.10.50.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Feb 2019 10:50:19 -0800 (PST)
From: Matthias Kaehlcke <mka@chromium.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v2] cpufreq: mediatek: Register an Energy Model
Date: Wed,  6 Feb 2019 10:50:04 -0800
Message-Id: <20190206185004.54779-1-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_105024_430745_F3F8871C 
X-CRM114-Status: GOOD (  11.22  )
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
Cc: Taniya Das <tdas@codeaurora.org>, Nicolas Boichat <drinkcat@chromium.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Douglas Anderson <dianders@chromium.org>,
 Quentin Perret <quentin.perret@arm.com>, Matthias Kaehlcke <mka@chromium.org>,
 linux-mediatek@lists.infradead.org, CK Hu <ck.hu@mediatek.com>,
 Eddie Huang <eddie.huang@mediatek.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Try and register an Energy Model from mediatek-cpufreq to allow
interested subsystems like the task scheduler to use the provided
information.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- register the EM after setting the cpumask
---
 drivers/cpufreq/mediatek-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index eb8920d398181..5250df762814e 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -465,6 +465,8 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
 	policy->driver_data = info;
 	policy->clk = info->cpu_clk;
 
+	dev_pm_opp_of_register_em(policy->cpus);
+
 	return 0;
 }
 
-- 
2.20.1.611.gfbb209baf1-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
