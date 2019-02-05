Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F2DC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:52:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDC7D20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jYnh4Zhn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC7D20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=8I0jnJeOhhrQAHkS5JGHsA/SOha+ejsFLdmtngcCJME=; b=jYnh4ZhnNOjqm+
	aQ13ma94uXKo5jDwTFaJtZ/v/k4hOrLSVgY/4F34f4nsYbyNqkdFrs2rjmHcCsjYPN5R+s7uXt0mS
	0vRGRzIibv3g8dgjmnwRDbqftTuiQoau6e9CoqT1ob+mjdeSLEomemQAYP0xtwXvc/1bYWDPWpCI9
	Oewoa7sKDNo9QErJw/D9/okd7/G/39UfdhSBV9MK+6V3h3zJAfy6mvL29N4zkVWHp5zX5CiBqMoze
	sK1ulGVcFNMBP53yTycUXvOrJzNAcV3m6/JLMZChArmVsuxrIWkQ3vwKc9wiJuDuUSdrbVNF8WaKS
	PBDOZVEavrCdeey4mDiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr4tu-0007px-34; Tue, 05 Feb 2019 17:52:50 +0000
Received: from mail-pl1-f196.google.com ([209.85.214.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr4tp-0007nt-UX
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 17:52:47 +0000
Received: by mail-pl1-f196.google.com with SMTP id b5so1819733plr.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 09:52:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4VqdMM+w0qT/K7e9KJmdykIErjiwD51l9d/UiASd0yI=;
 b=rzMWRiY+q6C25ISYkWTBllLVp1okhlq/0B6BTpk2eisJjHgk1oQFp1YgIB9ABKHLtg
 SVYPvSCY3Xj9q5pk7lAZPD8Z7fafI2HkLczEDxXuGD2dr38kqjabBfc45SCjBmpoSYt7
 nY1lSfJOutNgLW9WnJ1gfCmEr63gBOA7qd223UpFbfV1/als5C1FqpSNYlPijm7nZgn0
 TSgLXit6EbZh6cMSxNtBqP54VYYHN0nQy9Y9LfR7HpB627Z22TYa1DD7MOcDIeYGhxbC
 yKJDEWn/o5o5SYHZsVUu/ofiNM7UCZ3swR9Rcy+CTRgvchCwy4q4NxHBVqFiv7/ayyK6
 5/xQ==
X-Gm-Message-State: AHQUAuZh4N6qzH+YTIia61lvY2v0O7x9oKSx2AjYI+6WlgQWO1eBi3cB
 h1K6i+yeM95okXPQHtYQmuGyJA==
X-Google-Smtp-Source: AHgI3Ib6RXJt5ElBZ9izg3szJBC/E9z6G3PfrBwxlRYuo4v44yqQw+q4lCZNCEb+c8BP7RerBeaqEg==
X-Received: by 2002:a17:902:6bc7:: with SMTP id
 m7mr6396409plt.106.1549389162105; 
 Tue, 05 Feb 2019 09:52:42 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
 by smtp.gmail.com with ESMTPSA id 85sm6030280pfw.17.2019.02.05.09.52.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 09:52:41 -0800 (PST)
From: Matthias Kaehlcke <mka@chromium.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 1/2] cpufreq: qcom-hw: Register an Energy Model
Date: Tue,  5 Feb 2019 09:52:24 -0800
Message-Id: <20190205175225.25923-1-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_095245_989333_262D8BC9 
X-CRM114-Status: GOOD (  11.28  )
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

Try and register an Energy Model from qcom-cpufreq-hw to allow
interested sub-systems like the task scheduler to use the provided
information.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index d83939a1b3d4c..a16b9dca7ea3b 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -205,6 +205,8 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 		goto error;
 	}
 
+	dev_pm_opp_of_register_em(policy->cpus);
+
 	policy->fast_switch_possible = true;
 
 	return 0;
-- 
2.20.1.611.gfbb209baf1-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
