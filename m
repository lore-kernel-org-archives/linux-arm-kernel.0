Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98D9C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:55:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 663B620850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="INJTvGto";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EjElAK8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 663B620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=GZqpbXwkbJOMm486kgIPIQ0t902t9rRUL+9qOFPJv1Q=; b=INJ
	TvGtoTvSFRA5Ndcvrb6xtYiLKR4fYC78C0QztEvIwJBWYjYN3WOqjlprWr4PS3CJB7f4oib4xiZui
	f6EBDDm1onahtvr6Vwx7oeCbw94ThfDlySB2PtuX/nYNRi8bfalGGjGhy21hMcidD9BWnLr0BEmcI
	JQX7kZX2SGi3IifpBVWfjLFAo91yc6+S483Kku2f55oBPmDW7wVL4eO+O8W0dFzW4TT6Q5mrZt6pX
	1zGy/GMZUxlry7RYimERvGQBUvf5xN9inw2zeAc3Wu6cm02gN6BBljw8x0NsssiB0/ygSGRfj0kaN
	4k6lgLB+YsmVgyTuOUnVihHIyw4boUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTx7c-00036F-Gi; Mon, 03 Dec 2018 22:55:24 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTx7O-0001da-7T
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 22:55:12 +0000
Received: by mail-pl1-x644.google.com with SMTP id e5so7217319plb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 14:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=ksGSE6Cc9VG/A00Ld7RPZ1CW6RRFzM/pQBtwpovt2X4=;
 b=EjElAK8T7sc3RlBItuETx3nTXgWFHr9nCABkxA218Abq/dx48F5iaSIeddLSCPX6nq
 +PQuDPIWvlxSJNwzkIQBGwDXQle5xlG8fOxi9EwD8Ysj6GeW7niyPBHvC1lPLsQcUf++
 MZw2sN8I+m2IsI/ajfl2KSM38fiILd8Xx2Wkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ksGSE6Cc9VG/A00Ld7RPZ1CW6RRFzM/pQBtwpovt2X4=;
 b=e1PhAzH5QPnCnCrKZOpe2dYFAw1d7PqaRX6EMowYN0LLXfhTohNo5mUbJ9K7OVy06u
 b38wjbwCGmUhwu8I5nL9wqVmsalIYQUXmP7+hiWtyq42ntmnMj0VkfkhVFarXqhD01nq
 k7XaG6LWPYODC3BPBo8P++uFzLcPQoZUmbBtrG7C1tZazCeucfDtllsWFCH9EDKGY2WM
 stdi6MBx8K+J6SzbyIJj3ROZL1VGwFb2XkT0db5RrVlWX6GLTjaOAwi26SA2z99/tAVz
 jQsUJb65Q0Btg8nkr6kvZGz92lqNf16Yc1c5I4jtUIJ69YNckvUJEgMz0eKjx+P6Wjst
 5dwA==
X-Gm-Message-State: AA+aEWZsvHLSqArgd+d32EWzYPqvRauh2Fv3QDNuYtGn+CNsv4LsKgWY
 lH6OBwDvhgI5+NyxNRywHN8/Kw==
X-Google-Smtp-Source: AFSGD/Ww4eM+LZIWxdpW1D9qjHHHG7bAP0l5nJVoGhm4sibL/3GhitseWLv+7fxMz918qVGiK6mqKQ==
X-Received: by 2002:a17:902:8a91:: with SMTP id
 p17mr17698810plo.316.1543877699012; 
 Mon, 03 Dec 2018 14:54:59 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id v9sm20933057pfg.144.2018.12.03.14.54.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 03 Dec 2018 14:54:58 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org,
	peterz@infradead.org,
	gregkh@linuxfoundation.org
Subject: [PATCH v5 0/6] perf: Add ioctl for PMU driver configuration 
Date: Mon,  3 Dec 2018 15:54:50 -0700
Message-Id: <1543877696-17174-1-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_145510_276562_F6360633 
X-CRM114-Status: GOOD (  15.99  )
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
Cc: mark.rutland@arm.com, linux-s390@vger.kernel.org,
 alexander.shishkin@linux.intel.com, will.deacon@arm.com,
 heiko.carstens@de.ibm.com, adrian.hunter@intel.com, ast@kernel.org,
 mingo@redhat.com, linux-arm-kernel@lists.infradead.org, hpa@zytor.com,
 schwidefsky@de.ibm.com, namhyung@kernel.org, tglx@linutronix.de,
 suzuki.poulosi@arm.com, jolsa@redhat.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In the coresight world there can be more than one sink to aggregate
trace data generated by CPUs, hence the need for users to select which
one to use from the perf command line.

Up until now sysfs was used to communicate sink information to the
kernel but that was never the right way to proceed because it breaks
when more than one perf session are created at the same time.  The
situation was manageable when working with per-thread scenarios where
a single HW trace event is created but in CPU-wide mode a HW trace
event is created for each CPU that is specified on the perf command
line, taking us back to the concurrency problem we have when dealing
with multiple per-thread session.

This work fits in a wider scheme to support CPU-wide trace scenarios on
CoreSight that is available here [1]. The first step in that venture is
to address sysfs concurrency issues, which this patchset does.

The main difference with V4 is the usage of a CoreSight sink's HW start
address (u64) to uniquely identify a sink, negating the need to use the
component's name (char *).

By using a u64 we can theoretically add the sink information to the
perf_event_attr structure, avoiding the need to add a new perf ioctl().
On flip side it would introduce a very specific CoreSight field
to a structure that is generic.  I have opted for the ioctl() method,
let me know if you want me to proceed with the latter.

Regards,
Mathieu

# Before this set: 

root@juno:/home/linaro# perf record -e cs_etm/@20070000.etr/ -C 2,3 sleep 1
failed to mmap with 12 (Cannot allocate memory)

# After this set:

root@juno:/home/linaro# perf record -e cs_etm/@20070000.etr/ -C 2,3 sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 4.145 MB perf.data ]

[1]. https://git.linaro.org/people/mathieu.poirier/coresight.git/log/?h=cpu-wide-coresight

---
Changes for V5:
. Went from a char * to a u64 for ioctl argument (GKH).
. Added a better description of the problem being fixed to
  the cover letter (GKH).

Changes for V4:
. Made passing of information between ioctl() and PMU simpler.

Mathieu Poirier (6):
  perf: Introduce ioctl to communicate driver configuration to kernel
  perf/core: Use ioctl to communicate driver configuration to kernel
  perf/aux: Make perf_event accessible to setup_aux()
  coresight: Use PMU driver configuration for sink selection
  perf tools: Make perf_evsel accessible to PMU driver configuration
    code
  perf tools: Use ioctl function to send sink information to kernel

 arch/s390/kernel/perf_cpum_sf.c                  |  6 +-
 arch/x86/events/intel/bts.c                      |  4 +-
 arch/x86/events/intel/pt.c                       |  5 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c | 80 +++++++++++++++++-----
 drivers/perf/arm_spe_pmu.c                       |  6 +-
 include/linux/perf_event.h                       | 40 ++++++++++-
 include/uapi/linux/perf_event.h                  |  1 +
 kernel/events/core.c                             | 67 +++++++++++++++++++
 kernel/events/ring_buffer.c                      |  2 +-
 tools/include/uapi/linux/perf_event.h            |  1 +
 tools/perf/arch/arm/util/cs-etm.c                | 84 +++++++++++++++++++++++-
 tools/perf/arch/arm/util/cs-etm.h                |  3 +-
 tools/perf/util/drv_configs.c                    | 30 ++-------
 tools/perf/util/evsel.c                          |  6 ++
 tools/perf/util/evsel.h                          |  1 +
 tools/perf/util/pmu.h                            |  3 +-
 16 files changed, 287 insertions(+), 52 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
