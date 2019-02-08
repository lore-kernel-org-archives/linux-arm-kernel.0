Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730AFC4151A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:22:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F8A2217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uo/BFRub";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jLQew3c4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8A2217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=yVDpTed60yGs3Scslb4/gp0TDbApMWT4su+s92hXVuA=; b=uo/BFRubKnsm7g
	A2CmQawpL5oqxcJsluavUfYkbDZtoBtRs9lgNcXvX+T5uHxJ1z08za637Sw1TBbsHien837YAnXxG
	KQhVIHpJ8PP76UxQeLJSY4VnXQcxWijAhhfg9/KnVZFNykkUxlsE3NwnP1e6xYl7ncQy84945kqHe
	enzctDCrBvYo4HyZeVHvfm1Jz50q1ysKT4BPWjse6j1J+uiNUC0rh9qN69fnWcRi2eR+YqCdXtW5b
	aM58sA+E6uunuA+1dmQFynRidz/TlCVISFtATeWqAR8L1dGPPCx2JDViMx4Uznkr/P3xZRZa7emQ1
	R1TV/cD9sJ0r7MZ/5piw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs9qj-0000Rk-US; Fri, 08 Feb 2019 17:22:01 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs9qg-0000QM-Hr
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 17:21:59 +0000
Received: by mail-wm1-x344.google.com with SMTP id b11so4286780wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 09:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=knS4i6xgOZz/mz8J43X7M1/Qd3FKTH7ujh7tUYXNntY=;
 b=jLQew3c45KYmBgVsAuVYVMiGF20EenaPxST1N6IErKjLVqzDDkQDu1tyrmdfzFv7Yr
 A8wUw/Hk0v+GNyxvtsH8EL/WcTP89V5/LovXQpEYLP8FC9U3c69nYipJg8Zlk3MCUB15
 Ug7bm2zOM8ZmxsUzNuaeAi057fOee8TqJ0mEVh9BV8m3r695gCN2rhN5HjSk9RxATK1r
 /iIh6PBTQ77VSPq5yy4wqzZxD4AJZKamHLtfDt866SPjVK8hLxBO4m5SWs8rnbk5sNLi
 MoNKWbO7lycOsN4EvNx0xHvxtc4ELuW8SRN3kVogVN7WHxguAhFTr6rr3ccdxvOX15TL
 joCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=knS4i6xgOZz/mz8J43X7M1/Qd3FKTH7ujh7tUYXNntY=;
 b=EfR1eK34QBSVfValzb2Xm4llGIl8eniUmiDa8PMEL8TSNaPAYtHTaectxR8kxtw5JG
 f+T781l+YUnfLr6jkKdU+1RbyC7B505P+35e+nRMkP7Xdm+y3dYwrWMeCwqImdUt5O0B
 yulmzdJ1O23BDJHwd7pgJCExteTg0v6fBMuRJQ9j6xpDaIVw8SNVRWbjtnSs6QBaYyN4
 TCaAY6mvddPzb2+ISWqRVizfUmzqbJ98VpRN52csdDB5TxdMNQgE+BuPuyxLXIrbMzap
 hVnuekACN6wSmA4z6cZYflbyR9xFAkmWXNlV/HZHH1FUhd3XiwlR/2umV+7NxO69ytaH
 8Aog==
X-Gm-Message-State: AHQUAub7n840+I0k/K8/MFdVkLwRNHtgOA8je2YAIt3F90ar0tGwDIGi
 S5/5GRQTlQahZ3Gdowe58U7HvA==
X-Google-Smtp-Source: AHgI3IbSkxE70hvE6hEsTR0dsK+wCs+VlcnFHXDYH5GnybORz2T0MG58aGjYmCf/4I4RpIKys9BUkQ==
X-Received: by 2002:adf:bc87:: with SMTP id g7mr17136749wrh.250.1549646514707; 
 Fri, 08 Feb 2019 09:21:54 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
 by smtp.googlemail.com with ESMTPSA id k23sm4097150wmj.32.2019.02.08.09.21.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 08 Feb 2019 09:21:53 -0800 (PST)
From: Georgi Djakov <georgi.djakov@linaro.org>
To: linux-pm@vger.kernel.org
Subject: [PATCH v1 0/2] interconnect: Add path tagging support
Date: Fri,  8 Feb 2019 19:21:50 +0200
Message-Id: <20190208172152.1807-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_092158_597771_56A5C908 
X-CRM114-Status: UNSURE (   9.94  )
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
Cc: vincent.guittot@linaro.org, sanjayc@nvidia.com, seansw@qti.qualcomm.com,
 linux-kernel@vger.kernel.org, mturquette@baylibre.com,
 daidavid1@codeaurora.org, dianders@chromium.org, evgreen@chromium.org,
 bjorn.andersson@linaro.org, thierry.reding@gmail.com, henryc.chen@mediatek.com,
 amit.kucheria@linaro.org, linux-arm-msm@vger.kernel.org, ksitaraman@nvidia.com,
 georgi.djakov@linaro.org, linux-arm-kernel@lists.infradead.org,
 abailon@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SoCs that have multiple coexisting CPUs and DSPs, may have shared
interconnect buses between them. In such cases, each CPU/DSP may have
different bandwidth needs, depending on whether it is active or sleeping.
This means that we have to keep different bandwidth configurations for
the CPU (active/sleep). In such systems, usually there is a way to
communicate and synchronize this information with some firmware or pass
it to another processor responsible for monitoring and switching the
interconnect configurations based on the state of each CPU/DSP.

The above problem can be solved by introducing the path tagging concept,
that allows consumers to optionally attach a tag to each path they use.
This tag is used to differentiate between the aggregated bandwidth values
for each state. The tag is generic and how it's handled is up to the
platform specific interconnect provider drivers.

David Dai (1):
  interconnect: qcom: Add tagging and wake/sleep support for sdm845

Georgi Djakov (1):
  interconnect: Add support for path tags

 drivers/interconnect/core.c           |  27 ++++++-
 drivers/interconnect/qcom/sdm845.c    | 103 +++++++++++++++++++-------
 include/linux/interconnect-provider.h |   4 +-
 include/linux/interconnect.h          |   5 ++
 4 files changed, 106 insertions(+), 33 deletions(-)


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
