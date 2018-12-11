Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50420C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:40:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14D652084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V0dhgmg/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VwvNbU9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D652084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=jCM4Y/NoacUhozWPutbxaIbkOdni4guXSXKUjsJnQMw=; b=V0d
	hgmg/ZFC/b8vqxBRbhgjCW5G/U4vrfQrFVm/EwnINx273+uLxqTeX9odQF/292brCnJvh/m8FWb00
	CRkd4ejrvP+3pXBmDV7yFRTp0gq1HkM+3A4eB+32OGVm/9XOKjbfKDiZh8NE7cw+fPjdmLPXqgstD
	sUhByAFxup/nRn3vzvyFkioNbK44iZoLfg6CDxqJl67/Pm+1zsq1Bxtqmg6grWWOemt5TDgBucwUi
	YlFndXn+lkqm8HAIKTSGBOhvO6plJr/+LZghhdbGYeTyiNaRkqWR+bnsrQK4aUZF8I0O2sMgtbF2/
	mmlOC+qNWmL5xlvO2g3cGLAQPSvVYoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWcem-0007JT-2d; Tue, 11 Dec 2018 07:40:40 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWcei-0007IQ-EG
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 07:40:38 +0000
Received: by mail-wm1-x344.google.com with SMTP id a62so1087326wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 23:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=0xLf3aem1vzf4H8wFJd5N/TwF8GP4yaYTkHAgIk8oEc=;
 b=VwvNbU9lZKLc+Y2c74QwselZ8HynQkbR9SKH6SvYczrrl6K8zB1Wx2d3DAyKpbYmvo
 1ClMh1ZVA0bl8+HtEF0LY/GABmQ184O6JTCoEERgdqwK12qEfQCH/qqauptEVfOkwIDF
 98KTh0wkyBn01uujOkgcheSOHPnAqltUfapBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=0xLf3aem1vzf4H8wFJd5N/TwF8GP4yaYTkHAgIk8oEc=;
 b=EavD3CehzrvLarnYluxm/9gQQfxGG/Ylrtr0cN5vmc/2MtozQZ7FmyXtaaw4EplQuh
 A08/c6Txgw0UlVHtxQOZ/+IcwkqTBhQKYTuH8jaQPg3WNoaNTnu17pZ+RIsbircHJHtW
 2yeIyq9N2ioDctxL1/A5uvQzODMmS9xVUjpoyZbdpqJT+fdZZZfvdp7ieJNAa4wrEuK7
 Inyes7J3ebLnLDFpV2Fe/AB9r/ucogocw9ZAed/q79u/43msxFaGMlPZxNJLvpGNGkkI
 Fhs/c5cYYERd+UJ8L++djptpa+tKaViOUdXSIyPYZuMPA5sUJ5GdPf0kV09ELFxqxOJC
 R9Mw==
X-Gm-Message-State: AA+aEWbtq6BxrbpOd9lhxlde8StSDU0+AfWzI5/PHVfakyirrLdKJQf8
 fmnDahPksB0NbOrjcreCyBdWRg==
X-Google-Smtp-Source: AFSGD/W9vrjOwA7NvaqQdsKPsDMOaTOfXCMEykKZNDi5Ka33RLq/OnTmvjvHqf0yfQO2WSDgqsEayA==
X-Received: by 2002:a1c:5506:: with SMTP id j6mr1385634wmb.44.1544514024252;
 Mon, 10 Dec 2018 23:40:24 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
 by smtp.gmail.com with ESMTPSA id k7sm14186961wrl.51.2018.12.10.23.40.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 10 Dec 2018 23:40:23 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Coresight ML <coresight@lists.linaro.org>
Subject: [PATCH v3 0/8] perf cs-etm: Correct packets handling
Date: Tue, 11 Dec 2018 15:38:20 +0800
Message-Id: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_234036_484742_EE439808 
X-CRM114-Status: GOOD (  12.42  )
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

perf cs-etm module converts decoder elements to packets and then we have
more context crossing packets to generate synthenize samples, finally
perf tool can faciliate samples for statistics and report the results.

This patch series is to address several issues found related with
packets handling and samples generation when worked firstly on branch
sample flags support for Arm CoreSight trace data, so this patch series
is dependency for sample flags setting, will send another dedicated
patch series for sample flags later.

In this patch series, the first two patches are mainly to fix issues in
cs_etm__flush(): patch 0001 corrects packets swapping in cs_etm__flush()
and this can fix the wrong branch sample caused by the missed packets
swapping; patch 0002 is to fix the wrong samples generation with stale
packets at the end of trace block.

Patch 0003 and 0004 are for minor fixing; patch 0003 removes unused field
'cs_etm_decoder::trace_on', this can simplize the switch-case code for all
discontinuity packet generation by using one code block; patch 0004 is to
refactor enumeration cs_etm_sample_type.

Patch 0005 is to rename CS_ETM_TRACE_ON to CS_ETM_DISCONTINUITY, we use
a more general packet type to present trace discontinuity, so it can be
used by TRACE_ON event, and also can be used by NO_SYNC and EO_TRACE
elements.

Patch 0006 is used to support NO_SYNC packet, otherwise the trace
decoding cannot reflect the tracing discontinuity caused by NO_SYNC
packet.

Patch 0007 is used to support EO_TRACE packet, which also introduces
the tracing discontinuity at the end of trace and we should save last
trace data for it.

Patch 0008 is used to generate branch sample for exception packets.

Credit to Mike Leach and Robert Walker who made me clear for underlying
mechanism for NO_SYNC/EO_TRACE elements, Mike also shared the detailed
explanation for why we can treat NO_SYNC and TRACE_ON elements as the
same, so except following Mike & Rob suggestion for trace discontinuity
consolidation, most commit log of patches 0006/0007 also come from
Mike's explanation.

This patch series is applied directly on the acme's perf/core branch [1]
with latest commit aaab25f03e9e ("perf trace: Allow selecting use the
use of the ordered_events code").

With applying the dependency patch, this patch series has been tested
for branch samples dumping with below command on Juno board:

  # perf script -F,-time,+ip,+sym,+dso,+addr,+symoff -k vmlinux

Changes from v2:
* Addressed Mathieu's comments and suggestions for minor refactoring
  for removing unused field 'cs_etm_decoder::trace_on' and added one
  dedicated patch to refactor enumeration cs_etm_sample_type.
* Added Mathieu's 'reviewed' tags;  Very appreciate Mathieu's many
  suggestion for crossing several patch series.

Changes from v1:
* Synced the consistent code in patch 0001 for condition checking.
* Introduced new function cs_etm__end_block() for flushing packet
  at the end of trace block.
* Added new patch 0003 to rename CS_ETM_TRACE_ON to
  CS_ETM_DISCONTINUITY.
* Used the same one packet type CS_ETM_DISCONTINUITY for all
  trace discontinuity (include support TRACE_ON/EO_TRACE/NO_SYNC
  packets).
* Removed tracking exception number patch, which will be added in
  sample flag patch series.


Leo Yan (8):
  perf cs-etm: Correct packets swapping in cs_etm__flush()
  perf cs-etm: Avoid stale branch samples when flush packet
  perf cs-etm: Remove unused 'trace_on' in cs_etm_decoder
  perf cs-etm: Refactor enumeration cs_etm_sample_type
  perf cs-etm: Rename CS_ETM_TRACE_ON to CS_ETM_DISCONTINUITY
  perf cs-etm: Treat NO_SYNC element as trace discontinuity
  perf cs-etm: Treat EO_TRACE element as trace discontinuity
  perf cs-etm: Generate branch sample for exception packet

 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 42 +++++++++-----
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 10 ++--
 tools/perf/util/cs-etm.c                        | 77 ++++++++++++++++++++++---
 3 files changed, 100 insertions(+), 29 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
