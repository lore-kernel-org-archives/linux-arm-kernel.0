Return-Path: <SRS0=AzG1=P3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4167C61CE3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:44:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE98B20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K3K1B514";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GxfMfnje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE98B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=+tiyDAtkVsTYc+JKsZ1TwRiCueAaxp95EaSwZnLxEIo=; b=K3K
	1B514p/VzbX3z+aY4r8P5At/JgVFmQxvPQa0UfblJbZstmAJj/63i3otfsorWlQUVCQufYbLkDRIj
	1580mscWnaKBXnO3zt+Y3Y+3YYCzN9d3W7jBrO4YGyL82JaqfrbNlsOLdZrZ/NOpDi6zzlheRS6DE
	x0fsDZ8KBHP/6KiclHn3im5iEUhv1MX+rrw077J45ay8kM82cCEgQhHroKa78tFZJoRnACxQOEEA2
	8lBDMe4mFG+m9h09Jgy4rjmtwEa1cnZT0m2B55TcftoH9Qdg2EZjgwI0w/Y4LPIrl4zGWvvJ2Lhgx
	1N9pFhM4C3Anl2JRnaM8cn191cqHzqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkfg9-0001Sl-D8; Sat, 19 Jan 2019 01:44:09 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkfg6-0001S1-Bq
 for linux-arm-kernel@lists.infradead.org; Sat, 19 Jan 2019 01:44:07 +0000
Received: by mail-pg1-x541.google.com with SMTP id w6so6864453pgl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 17:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=+gI7uPG/kMFpjvedpiuVotP6KJ84HcEfWwY5I+LGi9I=;
 b=GxfMfnjeWS83+HeD1bR5fowABwHrLh9+7w3HzEeWX5FjWnhJQbvWUlf90S9VqQLda4
 zZNiKYaxtHL4oJtK0GvtuOKWWDBqkFywQeDcBPmoBFQ3qUI3mqiRRVo0ijiE9l6BS4WE
 W36A78xWiyOtkR6XXMWTB4dhfLfMK6OSeGBXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=+gI7uPG/kMFpjvedpiuVotP6KJ84HcEfWwY5I+LGi9I=;
 b=drZEA2peVZPl0fLzhAiPfHizq7xAIVB+WXMOi58PuVCY32f5s0InPlhC9C4ZtjtHbI
 6L1IuJOxncoPPUOxFlFsxaOhk0wq6C4+EXBaWUMg38WGNWUyMqQEx2haoX7JbS0cQwck
 SR9I9cLGBKlZ/zFqFmHQoTuwxhUHSjzEWhpDfdceQliNBQa1mb62JnGBNG+a6qN/M0Re
 6Tf7Hr1B/6/ntnpkhH0ooFapBjmjL7WYY2SvHqH2pVdatNVgNrwCTVPF0OG1wT4QiRmM
 /Oe85wcRhMeYQPn4Y76olh53keUxFg2HFbnwfxExngjKFABmCNWBfcj2poe/8pf0NLwW
 DVLg==
X-Gm-Message-State: AJcUukfc/x1vBt0iwbdAO3LPx5VLaGwleBM9Ict7I872PZWMby00zdyS
 mcn9Kdc8EEZUAATaAElBw9rZnQ==
X-Google-Smtp-Source: ALg8bN6rfHMN+/FzJ0M7MmMKKTVdK5Q+HeWXGJ1ygSC3Pj2hqY/GScdJjTysGVnxLmQMtwMP6LWjbA==
X-Received: by 2002:aa7:8542:: with SMTP id y2mr21883180pfn.83.1547862245254; 
 Fri, 18 Jan 2019 17:44:05 -0800 (PST)
Received: from localhost.localdomain (li421-24.members.linode.com.
 [50.116.3.24])
 by smtp.gmail.com with ESMTPSA id d21sm8648436pfo.162.2019.01.18.17.44.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 17:44:04 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Robert Walker <robert.walker@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Coresight ML <coresight@lists.linaro.org>
Subject: [PATCH v6 0/8] perf cs-etm: Add support for sample flags
Date: Sat, 19 Jan 2019 09:43:39 +0800
Message-Id: <20190119014347.27441-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_174406_411073_C02A1C0C 
X-CRM114-Status: GOOD (  12.73  )
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
Cc: Leo Yan <leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch seris adds support for sample flags so can facilitate perf
to print sample flags for branch instruction.

Patch 0001 is used to save last branch information in packet structure,
this includes instruction type, subtype and condition flag to help
making decision for which branch instruction it is.  It passes related
information from decoder layer to cs-etm.c, so we use cs-etm.c as a
central place to set sample flags.

Patch 0002 is used to set sample flags for instruction range packet.

Patch 0003 is used to set sample flags for trace discontinuity packet.

Patches 0004/0005/0006 are preparation for exception packet handling:
Patch 0004 addes exception number in packet; pacth 0005/0006 is to use
traceID/metadata tuple to access metadata pointer based on traceID, this
can help decide if the CPU is connected with ETMv3 or ETMv4, ETMv3 and
ETMv4 have totally different definition for exception numbers.

Patch 0007 sets sample flags for exception packet; patch 0008 support
sample flags for exception return packet.

This patch series is applied on the acme's perf core branch with the
with latest commit 02bb912ae451 ("perf tools: Replace automatic const
char[] variables by statics").

After applying this patch series, we can verify sample flags with below
command:

  # perf script -F,-time,+flags,+ip,+sym,+dso,+addr,+symoff -k vmlinux

Changes from v5:
* Addressed Rob's suggestion to add specification info for exception
  number encoding;
* Added Rob's review tag in patch 0007.

Changes from v4:
* Fixed typos in comments, and removed redundant info from commit log;
* Addressed Mathieu's suggestion to add helper functions for metadata
  fields (CS_ETM_CPU and CS_ETM_MAGIC) accessing;
* Addressed Mathieu's suggestion to include headers with alphabetical
  order.

Changes from v3:
* Fixed typos in commit logs;
* Rearranged fields in cs_etm_packet by grouping with same variable
  types;
* Fixed ETMv4 exception number which pointed by Mike;
* Fixed ETMv4 SVC / SMC / HVC in the same CALL, by checking svc
  instruction to distinguish them;
* Refine ETMv4 return exception packet handling.

Changes from v2:
* Addressed Mathieu's suggestion to split one big patch to 3 small
  patches for setting sample flags, one is for instruction range
  packet, one is for discontinuity packet and one is for exception
  packet.
* Added supporting for ETMv3 exception packet.
* Followed Mathieu's suggestion to move all sample flags handling
  from decoder layer to cs-etm.c, thus it has enough info to set flags
  based on trace context in single place.

Changes from v1:
* Moved exception packets handling patches into patch series 'perf
  cs-etm: Correct packets handling'.
* Added sample flags fixing up for TRACE_OFF packet.
* Created a new function which is used to maintain flags fixing up.


Leo Yan (8):
  perf cs-etm: Add last instruction information in packet
  perf cs-etm: Set sample flags for instruction range packet
  perf cs-etm: Set sample flags for trace discontinuity
  perf cs-etm: Add exception number in exception packet
  perf cs-etm: Change tuple from traceID-CPU# to traceID-metadata
  perf cs-etm: Add traceID in packet
  perf cs-etm: Set sample flags for exception packet
  perf cs-etm: Set sample flags for exception return packet

 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  41 +-
 .../perf/util/cs-etm-decoder/cs-etm-decoder.h |   6 +
 tools/perf/util/cs-etm.c                      | 405 +++++++++++++++++-
 tools/perf/util/cs-etm.h                      |  48 ++-
 4 files changed, 482 insertions(+), 18 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
