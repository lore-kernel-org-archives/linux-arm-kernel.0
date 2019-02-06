Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B2AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:33:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9501206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="erIYRfpT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9501206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x4+I//YugmJTxFGGv6h9On2y25kv3RWy5UkmY7p/Bao=; b=erIYRfpTTIDSTd
	cVrAs7/EcPVCpTfOMavZrocTQ92sNvXOOivukUQ6Ic8NLjTSrDGbhkFXVu9poHDqsR+4sUkVoC2Sn
	tyeDftFfrrxfAo8+ZCdeDFf4SWqQnoq8ZzfSDOQ/Qd3GsHY+389ezve1ox+yycFS1Uqp3hitRm2EW
	dZpiST9ejbuxx1T6gJI6iYABncC13lZv/nWIktvNTZngpGyzrkKCISLu8m1bu5tkyzjv0T7r4Qze1
	ZiZXlVw9qi+Hyj+0qgB6W0gINp4dBIMHQsAHCtO0Uzog7wdY2uXmt+3EHjd4yUrXRSnfJZlvpHX5/
	DYZWBPzaUKb7GbrT3ZXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grKWE-0000tG-TO; Wed, 06 Feb 2019 10:33:26 +0000
Received: from cloudserver094114.home.pl ([79.96.170.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grKWB-0000sn-M9; Wed, 06 Feb 2019 10:33:25 +0000
Received: from 79.184.254.36.ipv4.supernova.orange.pl (79.184.254.36) (HELO
 aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 70cda8ed52eeddda; Wed, 6 Feb 2019 11:33:21 +0100
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v5 0/9] cpufreq: Add flag to auto-register as cooling
 device
Date: Wed, 06 Feb 2019 11:32:09 +0100
Message-ID: <2181391.oHn0C2QMFc@aspire.rjw.lan>
In-Reply-To: <cover.1548737236.git.amit.kucheria@linaro.org>
References: <cover.1548737236.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_023323_880379_5B0FB805 
X-CRM114-Status: GOOD (  10.85  )
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
Cc: "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Eduardo Valentin <edubezval@gmail.com>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Zhang Rui <rui.zhang@intel.com>, "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tuesday, January 29, 2019 5:55:06 AM CET Amit Kucheria wrote:
> Add a flag for cpufreq drivers to tell cpufreq core to auto-register
> themselves as a thermal cooling device.
> 
> There series converts over all the drivers except arm_big_little.c.
> Tested on SDM845 with the qcom-cpufreq-hw driver. Only compile-tested the
> others.
> 
> Things needing fixing (but not a blocker for the series):
>  - Look at how to detect that we're not in IKS mode in arm_big_little's
>    .ready callback.
> 
> Changes since v4:
>  - Added IS_ENABLED guards in cpufreq.c
>  - Changed flag name to CPUFREQ_IS_COOLING_DEV
>  - Collected various review tags
> 
> Changes since v3:
>  - Got rid of wrapper function to register/unregister cooling devices.
>    Directly call the function in cpufreq.c
> 
> Changes since v2:
>  - Get rid of #ifdef'ery and let the pointer exist in all cases
>  - Get rid of (!CPU_THERMAL || THERMAL) dependency in all cpufreq drivers'
>    Kconfig
> 
> Changes since v1:
> - Fix compilation failures with allmodconfig
> - Get rid of #ifdef in cpufreq.c
> - Removed miscellaneous patches and sent them separately
> - Merged patches 1 and 2 from v1
> 
> Amit Kucheria (9):
>   thermal: cpu_cooling: Require thermal core to be compiled in
>   cpufreq: Auto-register the driver as a thermal cooling device if asked
>   cpufreq: qcom-hw: Register as a cpufreq cooling device
>   cpufreq: imx6q: Use auto-registration of thermal cooling device
>   cpufreq: cpufreq-dt: Use auto-registration of thermal cooling device
>   cpufreq: mediatek: Use auto-registration of thermal cooling device
>   cpufreq: qoriq: Use auto-registration of thermal cooling device
>   cpufreq: scmi: Use auto-registration of thermal cooling device
>   cpufreq: scpi: Use auto-registration of thermal cooling device
> 
>  drivers/cpufreq/Kconfig            |  3 ---
>  drivers/cpufreq/Kconfig.arm        |  5 -----
>  drivers/cpufreq/cpufreq-dt.c       | 14 ++------------
>  drivers/cpufreq/cpufreq.c          | 13 +++++++++++++
>  drivers/cpufreq/imx6q-cpufreq.c    | 24 ++----------------------
>  drivers/cpufreq/mediatek-cpufreq.c | 14 ++------------
>  drivers/cpufreq/qcom-cpufreq-hw.c  |  3 ++-
>  drivers/cpufreq/qoriq-cpufreq.c    | 15 ++-------------
>  drivers/cpufreq/scmi-cpufreq.c     | 14 ++------------
>  drivers/cpufreq/scpi-cpufreq.c     | 14 ++------------
>  drivers/thermal/Kconfig            |  1 +
>  include/linux/cpufreq.h            |  9 +++++++++
>  12 files changed, 37 insertions(+), 92 deletions(-)
> 
> 

I've applied the series, thanks!



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
