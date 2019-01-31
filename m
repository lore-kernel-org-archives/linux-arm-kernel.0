Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49101C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:47:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C4C1218EA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pLhiJ37R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U2AtEKWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4C1218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=EMNTpjrb6aekZsKmY+J+Pfe/J+ENtIVyy7LXTMLyIfQ=; b=pLh
	iJ37Rua1Q7sSYx1eYsYYYllPqvRsXEtEOfxi4e0kudMlDHVs3wY9pIrSiLdNojgPcByINzxw4VR5M
	MczRWVRlzfiMeKwh+ioCSttjkdjE9M/J5rjSk8il070Du0BiLotj1ZHZ5Ya0jLr9rQF0kI7x6fF1s
	KZATLX0TYW6VsHhLZpiqTW4Ry4i58xnBMFO8q0aRIp+PuRDzMl3/ZAY67bN/bcZcaCJpMwALScbL7
	YgNwP8H0BLtADlZ1MxxjhGXBFLdVshkY7CrAQ1Zcu/J0JEw8meXWLQr3y3c2zyr/n5Xo6pxPIO+0w
	vEp7GGLtD3AcSmZ8UmUXaUxlqEmPPMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpHMx-0002sR-8v; Thu, 31 Jan 2019 18:47:23 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpHMt-0002rX-7H
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 18:47:20 +0000
Received: by mail-pg1-x541.google.com with SMTP id d72so1719494pga.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 10:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=6dsOnCFxfIDVb3Xp4oLLINOMaTRi9MeMgOxwf7sFMUA=;
 b=U2AtEKWJCT3eEoJlJ9/lLlwKpctPOGXDCmUQQ+/Odv6ccDR4GVBoQ9SprSmIqTqOVk
 Hh9BU8IdddzmczJWQ0UTOvDy4k5eV8A/lfGzBTdB1eS4+utcYcNH7zsZMKAKIbX/kbgI
 Upl3jJGrpLoC00r0MpUYBUhePBELJvTYa9X+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=6dsOnCFxfIDVb3Xp4oLLINOMaTRi9MeMgOxwf7sFMUA=;
 b=X6rLItvyrF6f6TBBes9CDfQtCOXsoJ/JUlu4V0RJ221dEvxDblniTFQxPqCIIZn2gI
 0DLD1I87lRx6W+RObgpQqWiufnIheleb+PScwjYTMaeIdbh/eKOV8X17EnBinyuLSKHJ
 vVGNd2NoS5PT/FMcTYc2hYSYs2SEQyKLNofCdi/H+LT0KU/+OYqo4jSiwaIERMHoLTDz
 NU5wAFpBWplFwiG6QXUAsAwPvEiem4eY4DegLmjPpc0ngNHW7peq76iZbLqCJfkXOVD0
 wUOXKseH4jB2w9N3YByqCWcCa1L5rpVGi4EP2OUVZbD8Jur8b0nN0IEQLbfcHsKMZcXV
 cKsA==
X-Gm-Message-State: AJcUukcm+jHci4auSo3XkYvj4Z/aG9QYrAz5VK+wS8vj5XXieCDKLehc
 qPOoo/qG+z0ulsZ05XvD8cA/PA==
X-Google-Smtp-Source: ALg8bN44f60OMhTD5z0UBl7ucNLcBF9kGWLfbLrJstu2KplNXgOHx1uUOPfi8pd99IuwVaJYTjhigA==
X-Received: by 2002:a62:6f49:: with SMTP id k70mr35555339pfc.7.1548960437133; 
 Thu, 31 Jan 2019 10:47:17 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id o66sm6236234pgo.75.2019.01.31.10.47.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 10:47:16 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org,
	peterz@infradead.org
Subject: [PATCH v3 0/7] perf: Communicate sink via event::attr:config2
Date: Thu, 31 Jan 2019 11:47:07 -0700
Message-Id: <20190131184714.20388-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_104719_286095_24F1F5C3 
X-CRM114-Status: GOOD (  12.69  )
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

This is the third revision of a patchset allowing multiple sources to select
the same sink for a session which is a prerequisite for the support of CoreSight
CPU-wide trace scenarios.

The sink ID is communicated to the kernel by way of the event's configuration
attribute (event::attr:config2).  The ID itself is an hash of the sink's name,
something that is readily available and unique.

With this set the mechanic to communicate sink selection to the kernel via
sysfs is no longer needed and removed.

Applies cleanly and tested on 5.0-rc4.

Thanks,
Mathieu

Changes for V3:
* Rebased to rc4.
* Fixed a perf tools command line problem (reported by Suzuki).
* Enhanced error handling in etm_perf_add_symlink_sink().
* Modified memory allocation to used devm_xyx() API.
* Went from using struct device_attribute to struct dev_ext_attribute.

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
 .../hwtracing/coresight/coresight-etm-perf.c  | 112 +++++++++++++++---
 .../hwtracing/coresight/coresight-etm-perf.h  |   6 +-
 drivers/hwtracing/coresight/coresight-priv.h  |   1 +
 drivers/hwtracing/coresight/coresight.c       |  60 ++++++++++
 drivers/perf/arm_spe_pmu.c                    |   6 +-
 include/linux/coresight.h                     |   7 +-
 include/linux/perf_event.h                    |   2 +-
 kernel/events/ring_buffer.c                   |   2 +-
 tools/perf/arch/arm/util/cs-etm.c             |  98 +++++++--------
 tools/perf/arch/arm/util/cs-etm.h             |   3 -
 tools/perf/arch/arm/util/pmu.c                |   2 -
 tools/perf/builtin-record.c                   |  10 --
 tools/perf/builtin-stat.c                     |   9 --
 tools/perf/builtin-top.c                      |  13 --
 tools/perf/util/Build                         |   1 -
 tools/perf/util/drv_configs.c                 |  78 ------------
 tools/perf/util/drv_configs.h                 |  26 ----
 tools/perf/util/pmu.c                         |   2 -
 tools/perf/util/pmu.h                         |   2 +-
 22 files changed, 227 insertions(+), 228 deletions(-)
 delete mode 100644 tools/perf/util/drv_configs.c
 delete mode 100644 tools/perf/util/drv_configs.h

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
