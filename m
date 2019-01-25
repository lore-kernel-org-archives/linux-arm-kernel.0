Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423AAC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:02:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A512184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jDukWR/i";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YjkIfraW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A512184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=TxFkFEHHDHDW1JgRAiADx8ZDP4gDdwysrqqywCHCbOw=; b=jDu
	kWR/iV+J0ce4wQfRBt7qpqBm2ljiLoHYygxbuG5kobPKqcZUJabUH/CBaPcrZ3bfn7jZVJfsJfXT3
	DGmHU9ue0zMnm/YddLLcGV0shnm3jT1cZCOhmGH0Z2qyWaqMahqWHrsHUt0vOWaZ/nrIZAmPfXAKI
	st5NXykZbqPnX9jgqrAXWzVSjL0ifHSVzjiT4xoXJWkLgHlJ053+2/MPdMr2EkfT5cw8mEZfGVYzD
	ZXOE/2rHriYR+XTYyHxSTtfsnV4VKQ1bCjoywAt4xfBsB0n92W+bT1I+9SmWuEqY26/ql23Mmn6m0
	a/q4mksdhElQIlbkfk+A9mzyBDhv8Yg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmvVw-0004Zj-SI; Fri, 25 Jan 2019 07:02:56 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmvVt-0004Z3-5l
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 07:02:54 +0000
Received: by mail-ed1-x531.google.com with SMTP id f9so6540508eds.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 23:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=cyLosbw975pFE25Y2vfzwPuN8/wk+kN4j80s9bRHwe4=;
 b=YjkIfraWX8lxLQ8cGi6MkrIdQxnCp/M421VYz7v5jtMHz4OSFLCQF2G8fcaOqM8Mi0
 b8M7FlN0Hp8OLqSRWstF6FJIcMHF+BrfEhDjVfMTxE/KFhRATuaossCsCZztkLqSn5rl
 FSB3WWby34rQutSqSnKub+MKY9OFnWAZTUf0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=cyLosbw975pFE25Y2vfzwPuN8/wk+kN4j80s9bRHwe4=;
 b=s2lFh6kQbEhCxIVHqtsB3OTScdAJwEkTeS73TOwez8Z9iR7k9/8ZH1EkLMMytH2Myc
 kvGzm1DjIXbNF2tPeAPHn9ixSy5U3qtbpGob3Oudcdfl3sCJ3GqLiy09UeU49vPMEFyQ
 t+8xSC+j9Aym28Pn7t9k2np1Pefo4W9Y+64ZBE8znSNlGWZ6XFPaIXStICmhc1vNteKH
 uco8H+iDdozeGlkzKQ6iCiozfom5zbRdQPuVplOBWAseNc4ZWCVnUtChz+qHkdgI/AUG
 PSwUj+w4JQlffKXxnn6AqSODczB3I8jWRiew9rTHtZxiPEHsvIHwi8uATcEVAh8TbnOf
 aB1A==
X-Gm-Message-State: AJcUukc57wOqM3h3RUTdEqHPr+OeoJRxJEL56eJnYJtQ+vPk7UcAgs6e
 LIahV5Mu1FHcCnzOFAU/Hwhr5g==
X-Google-Smtp-Source: ALg8bN5g4aavWdMqMtIL3By+udehsRSZVXv41h+ZMTiqy0c+hxDeesoxs/MIYpFMI3AGMUu2dlb6fQ==
X-Received: by 2002:a50:bae3:: with SMTP id x90mr9829519ede.221.1548399769658; 
 Thu, 24 Jan 2019 23:02:49 -0800 (PST)
Received: from localhost ([49.248.181.51])
 by smtp.gmail.com with ESMTPSA id x47sm11711410eda.91.2019.01.24.23.02.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 24 Jan 2019 23:02:49 -0800 (PST)
From: Amit Kucheria <amit.kucheria@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCHv3 0/9] cpufreq: Add flag to auto-register as cooling device
Date: Fri, 25 Jan 2019 12:32:20 +0530
Message-Id: <cover.1548398851.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_230253_237899_3F872CAA 
X-CRM114-Status: UNSURE (   9.11  )
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
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 linux-arm-msm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, dianders@chromium.org,
 swboyd@chromium.org, edubezval@gmail.com, mka@chromium.org,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 viresh.kumar@linaro.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Zhang Rui <rui.zhang@intel.com>, "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a flag for cpufreq drivers to tell cpufreq core to auto-register
themselves as a thermal cooling device.

There series converts over all the drivers except arm_big_little.c.
Tested on SDM845 with the qcom-cpufreq-hw driver. Only compile-tested the
others.

Things needing fixing (but not a blocker for the series):
 - Look at how to detect that we're not in IKS mode in arm_big_little's
   .ready callback.

Changes since v2:
 - Get rid of #ifdef'ery and let the pointer exist in all cases
 - Get rid of (!CPU_THERMAL || THERMAL) dependency in all cpufreq drivers'
   Kconfig

Changes since v1:
- Fix compilation failures with allmodconfig
- Get rid of #ifdef in cpufreq.c
- Removed miscellaneous patches and sent them separately
- Merged patches 1 and 2 from v1

Amit Kucheria (9):
  thermal: cpu_cooling: Require thermal core to be compiled in
  cpufreq: Auto-register the driver as a thermal cooling device if asked
  cpufreq: qcom-hw: Register as a cpufreq cooling device
  cpufreq: imx6q: Use auto-registration of thermal cooling device
  cpufreq: cpufreq-dt: Use auto-registration of thermal cooling device
  cpufreq: mediatek: Use auto-registration of thermal cooling device
  cpufreq: qoriq: Use auto-registration of thermal cooling device
  cpufreq: scmi: Use auto-registration of thermal cooling device
  cpufreq: scpi: Use auto-registration of thermal cooling device

 drivers/cpufreq/Kconfig            |  3 ---
 drivers/cpufreq/Kconfig.arm        |  5 -----
 drivers/cpufreq/cpufreq-dt.c       | 14 ++------------
 drivers/cpufreq/cpufreq.c          |  6 ++++++
 drivers/cpufreq/imx6q-cpufreq.c    | 24 ++----------------------
 drivers/cpufreq/mediatek-cpufreq.c | 14 ++------------
 drivers/cpufreq/qcom-cpufreq-hw.c  |  3 ++-
 drivers/cpufreq/qoriq-cpufreq.c    | 15 ++-------------
 drivers/cpufreq/scmi-cpufreq.c     | 14 ++------------
 drivers/cpufreq/scpi-cpufreq.c     | 14 ++------------
 drivers/thermal/Kconfig            |  1 +
 include/linux/cpufreq.h            | 21 +++++++++++++++++++++
 12 files changed, 42 insertions(+), 92 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
