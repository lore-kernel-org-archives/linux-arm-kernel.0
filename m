Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73020C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:11:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48C2921019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="isz/ianO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EmSVJ3tX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C2921019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=u1Mwq9JzYpRzyFzReMWADffuGV3oKzyizADIboX9YhE=; b=isz
	/ianOCpPvnomzDiSydjZE6NKnaHQSh0K4kH69zbaTQcXeZey3qSsT2T7/zbkW40y06jUBQBq1MMQr
	z+ZSp/YnWhXKcOkiGiaS0w00vy3VrugCh6/0np0xwtBfW5VqAEuU4TII4ZKJfFO0iesfc512DYTa9
	g2MWmW/IU4Gvj+UMK8ux79BC1pcHEgVM3sXPz9L1PG88H0BJViz92BcZxqmu5NEkju3T24z6TFHsV
	pbXi+AYnY7HD3ceWXnnDCqGLKir2bDfgwdOYomei247DP9IZi7vPaQP7L5jcr6Jz+/AkDN+XN9vBE
	FageT9V+jaw/oFwhjG+e0JFK9Ynqcgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm0Wd-0004Gl-GN; Tue, 22 Jan 2019 18:11:51 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm0Wa-0004G6-0E
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 18:11:49 +0000
Received: by mail-pf1-x442.google.com with SMTP id w73so12136049pfk.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 10:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=1fSj0al6b5p/fuO8Ttc0sOxMG/zIPvqM89wtR7MI5cE=;
 b=EmSVJ3tXchTy4Cb+5I0JIS6FzteJVLymsc7Hvm3uW7lYGbX36Jg/+LhpItLWP2KZIZ
 2SNlGVc5JqWt66IlT358eZSKAKj05G/Il0bn3nVaQNEq6PsJC1rnmY2uDILo0wbZyesF
 7A70SBB6vCyx5P9loDLSaljOqkUFWRobSNPO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=1fSj0al6b5p/fuO8Ttc0sOxMG/zIPvqM89wtR7MI5cE=;
 b=fduNswqc57WNMRl3fp7WJl7D12ae+IQ2K1KuHwFRc9bURWy/BS4VnJ8gWQMgrYdgp4
 LdMTuKP9Z+SOx2UupKwoEEnE75LJYRpO+kRNEbV9exfHmWzTTQMpNQpKBHc2eSKS2hxc
 /tOkLtoxS6MGqhjQgCzwZF/FZZO3+GRbqQsjIM5wPKEHMICgxvRqfmf3rQsJSdHhsD8k
 IHgIvxPVk9v9UzH1LS+BWHIzKHIPSps8BRsyqyEmFlrY9OV405AJR3W/x9VZ+ymZcRlU
 WrVOEqq7I94N8JexgKKRQPVA12UCk5XuFpDE1VpeUfeJ7Xj0T1tT0BrJR8FDyKwIbXaX
 EnvA==
X-Gm-Message-State: AJcUuke4eRnfuTyH4DomYzMnvRnIBORJlq9OzPXCbfdCchUPZLU+w+do
 pdEPhvhRliPUbrZMNBsId2+d/w==
X-Google-Smtp-Source: ALg8bN5K/I9VMx03fEQTJB2qUFipw60oVI7IVLbTpB2RtPwhq7cDj16EeESYWdcZhrfjZMyuN4GDUg==
X-Received: by 2002:a63:680a:: with SMTP id d10mr33146762pgc.396.1548180707266; 
 Tue, 22 Jan 2019 10:11:47 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id a18sm23489919pgj.30.2019.01.22.10.11.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Jan 2019 10:11:46 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org,
	peterz@infradead.org
Subject: [PATCH v2 0/7] perf: Communicate sink via event::attr:config2
Date: Tue, 22 Jan 2019 11:11:37 -0700
Message-Id: <20190122181144.26645-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_101148_049049_98CA2AF7 
X-CRM114-Status: GOOD (  12.25  )
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
Cc: mark.rutland@arm.com, linux-s390@vger.kernel.org, suzuki.poulose@arm.com,
 alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org,
 heiko.carstens@de.ibm.com, adrian.hunter@intel.com, will.deacon@arm.com,
 ast@kernel.org, mingo@redhat.com, linux-arm-kernel@lists.infradead.org,
 hpa@zytor.com, schwidefsky@de.ibm.com, namhyung@kernel.org, tglx@linutronix.de,
 jolsa@redhat.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This is the second revision of a patchset allowing multiple sources to select
the same sink for a session which is a prerequisite for the support of CoreSight
CPU-wide trace scenarios.

The sink ID is communicated to the kernel by way of the event's configuration
attribute (event::attr:config2).  The ID itself is an hash of the sink's name,
something that is readily available and doesn't require the addition of a new
information field in the coresight_device structure.

With this set the mechanic to communicate sink selection to the kernel via
sysfs is no longer needed and removed.

Applies cleanly and tested on 5.0-rc3.

Thanks,
Mathieu

Changes for V2:
* Addressed memory leak in etm_perf_add_symlink_sink()
* Keep track of device attribute for future removal.
* Added PMU attribure for config2.
* Fixed email address signature.

Mathieu Poirier (7):
  perf/aux: Make perf_event accessible to setup_aux()
  coresight: perf: Add "sinks" group to PMU directory
  coresight: Use event attributes for sink selection
  perf pmu: Moving EVENT_SOURCE_DEVICE_PATH to PMU header file
  perf tools: Use event attributes to send sink information to kernel
  perf tools: Removing CoreSight set_drv_config() API
  perf tools: Remove PMU::set_drv_config API

 arch/s390/kernel/perf_cpum_sf.c               |   6 +-
 arch/x86/events/intel/bts.c                   |   4 +-
 arch/x86/events/intel/pt.c                    |   5 +-
 .../hwtracing/coresight/coresight-etm-perf.c  | 106 +++++++++++++++---
 .../hwtracing/coresight/coresight-etm-perf.h  |   6 +-
 drivers/hwtracing/coresight/coresight-priv.h  |   1 +
 drivers/hwtracing/coresight/coresight.c       |  57 ++++++++++
 drivers/perf/arm_spe_pmu.c                    |   6 +-
 include/linux/coresight.h                     |   7 +-
 include/linux/perf_event.h                    |   2 +-
 kernel/events/ring_buffer.c                   |   2 +-
 tools/perf/arch/arm/util/cs-etm.c             |  94 +++++++---------
 tools/perf/arch/arm/util/cs-etm.h             |   3 -
 tools/perf/arch/arm/util/pmu.c                |   2 -
 tools/perf/builtin-record.c                   |  10 --
 tools/perf/builtin-stat.c                     |   9 --
 tools/perf/builtin-top.c                      |  13 ---
 tools/perf/util/Build                         |   1 -
 tools/perf/util/drv_configs.c                 |  78 -------------
 tools/perf/util/drv_configs.h                 |  26 -----
 tools/perf/util/pmu.c                         |   2 -
 tools/perf/util/pmu.h                         |   2 +-
 22 files changed, 214 insertions(+), 228 deletions(-)
 delete mode 100644 tools/perf/util/drv_configs.c
 delete mode 100644 tools/perf/util/drv_configs.h

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
