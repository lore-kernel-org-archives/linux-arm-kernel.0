Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4612EC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:53:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1378420811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VVQ/TOgq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1378420811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EtfOY2ZB0MNZeC/oJNUGzU/J1HfLjEjh0xZZ6Jy0Zxw=; b=VVQ/TOgqOlMTh1
	0obGqJLZqd6e7uj5q2G+jho3DYTHa120i/DMwrsJFzweeSIEqLt7xgdHwLgCIelWtykMT4gDL/3lV
	+0wsuPMP+dseynR+FNmjeDxaOwGY7TFgDb/16gY8wit3kCKFpPtROCxhT+ASr5mQ1mZPphRvRi9K+
	O/SRKX0Z2lj7W6uz3VG8pM7+wYX9gqnSjgm7STZaLibYNDvJHnP9A0hS/zHxWIRnvoNxMMAsnpC9P
	MwmH7OA1u8ucDXtezTGaGcFzSsm3P7nnnmzva2oprAWgKqf4XCAfKQeUcmClljPpxD0wVi1fYicoB
	5TsGtvQX+bPD32hQoAfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr4u9-00085i-IN; Tue, 05 Feb 2019 17:53:05 +0000
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr4tr-0007nu-3i
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 17:52:48 +0000
Received: by mail-pg1-f195.google.com with SMTP id n2so1701761pgm.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 09:52:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lE5yLqTeGGzTuTS9U9D6qCeOCCp6sDjOXNtuvEolMxk=;
 b=T3nBpuhWngrt/JnXzzJOIKVLjQZ0VP7sTANLrHka+WDXYufavUi3bFUSTjQJWPXBCN
 rU77vSlvClhBzSz8s5adNDPDFtOHND2R51bZCWknJPnOIvXJn2b5SwCuO++bQJ5jPDzn
 R4uUY93HjDskdSZMnfP0JAqcHpxaFoQz/Mn4CSyMlD4Jkp0pO+kOMNEAjoAUcpnso31R
 z1c1yLcJeSPKET3GKjWTVTZRQt/1uxtHC+BO/sWoBVjtK0IFJcAVQ3PxOk3ygN2vYIb3
 Gb1HPSaN9V25N+Z0hgKrWSYIvixvXhpK1P7VDkdc8ZfWnfqKbuv7s0be3fKhslz6eJ2q
 E5WA==
X-Gm-Message-State: AHQUAuZ/gkAoOwmmKAVqNJwrF59RegOa9V6rVt31Ho85WVrQeMemqCOs
 bbVvFa1qyiJ1Mp5fckmQsFGbgg==
X-Google-Smtp-Source: AHgI3Ibt+4FhFR95YadQ/0Wt8EUUFAo7LV3Q9O8AHSTCYnFhrRQqz1N2Dxc8bQw0LXsxw7UzzitZqQ==
X-Received: by 2002:a63:571f:: with SMTP id l31mr2796053pgb.91.1549389163752; 
 Tue, 05 Feb 2019 09:52:43 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
 by smtp.gmail.com with ESMTPSA id 85sm6030280pfw.17.2019.02.05.09.52.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 09:52:42 -0800 (PST)
From: Matthias Kaehlcke <mka@chromium.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 2/2] cpufreq: mediatek: Register an Energy Model
Date: Tue,  5 Feb 2019 09:52:25 -0800
Message-Id: <20190205175225.25923-2-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
In-Reply-To: <20190205175225.25923-1-mka@chromium.org>
References: <20190205175225.25923-1-mka@chromium.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_095247_144124_FC9CA5C9 
X-CRM114-Status: GOOD (  11.73  )
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
 drivers/cpufreq/mediatek-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index eb8920d398181..e6168ee582783 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -460,6 +460,8 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
 		return ret;
 	}
 
+	dev_pm_opp_of_register_em(policy->cpus);
+
 	cpumask_copy(policy->cpus, &info->cpus);
 	policy->freq_table = freq_table;
 	policy->driver_data = info;
-- 
2.20.1.611.gfbb209baf1-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
