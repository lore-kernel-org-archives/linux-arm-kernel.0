Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA4AC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 00:22:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D8521872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 00:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TVC3J95Z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V2ZSrLHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D8521872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IJVXgE3qD4kGvdUO9SHGyLHg911J2YivwCTtPm8cJH8=; b=TVC3J95Zng4zft
	Y/nM2Ds+1e3sonVrvQGJE5lpQygli0KslDePSL8RX/ylnEVxERjCuJWv8DuhBETxl/6RA8zJvlNu+
	PHM18MO7ROmzmCJ3NcyzK6tGdcU4338ZCYo2Rs1l8Ih6MNR8jpAC6U4AADeu8nhGFooSPfg2brQqn
	AIdcbWZm2EyGoPq0fMtsdAbQhIsCNpclUhQ1oG58GXfzQljCBoVANK6LXxP35ivZEQqxZte72y9Us
	6FugRkCwFQ2145u5r9bISPrMEONZEVNs4954BE/RpnsnFJ+jg7iFAS/vgEqQw8r/etdd/4rQ1alTi
	yXx37MZi26ulfeO3dmCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmSmh-00034Q-5c; Thu, 24 Jan 2019 00:22:19 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmSme-000343-4z
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 00:22:17 +0000
Received: by mail-it1-x142.google.com with SMTP id w18so2210633ite.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 16:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jq26wBwdphGhxuD+bxSAg1THJpV9yeIbnvU9pP25ugg=;
 b=V2ZSrLHtPGy/QsRaIVfwbLq5z50RyCplDtJXZD+mYEt+A4b0DQekuo/ZHBjl9avzmK
 wLnlbf345GHtuNxJEEgBCwIvcDWlspoy4408WqXG2NGffO9tVHFuIDIrxrj8LnVjsBI/
 81jQ/4VdHPZYf0yAYCUZCviqii8GZZTY6AAp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jq26wBwdphGhxuD+bxSAg1THJpV9yeIbnvU9pP25ugg=;
 b=SAE7mbVw+JPKuNyUk4+gdNnYc8LBFdw5GkCCvHdBYlHZQ+bxgUZh94GszoAAMW+ARw
 hwkxdpQVDcyzrqpTkDp2pOopKNel9yTiH/MCNau5alpWUPb3QUfhtr8c0ThtWeNg8aI2
 ngfhHEAIaWYmWmB7OMEkHv19Ne3RB7qlHiLsQmBcFPUdOBg++bWUFQcY0tDAWalVXm+f
 8hw2Z0xZLSEXoOtPfZtHiHUfqX0kUTIcqQVNyA/gP/hcZlSkPhP7kNuBZsaafNRhGHbp
 vkLlapZzx7YkrnFuKrc5oMAjE3GqnHb1eLgCeZQ+ftpGTVOPu7kj1mwJTc2lhHgQN92j
 TpEQ==
X-Gm-Message-State: AJcUukdkX2Ki7GRMWZAuLuqS/E+0/OOfNwW+GeuwYZLEjarkVTaG+DjM
 jO5KSZgzCLr1U1Lmx6IK9TfMyBMG60feC6fsH2SU4w==
X-Google-Smtp-Source: ALg8bN5vDM8g0uhzGEp4oUuFFTMPPk1J39z4bNDEp9807L9tGf4zyswfDCKYyWwJjZpor9i+wlaAQjdtxl9PTpXthW8=
X-Received: by 2002:a02:570d:: with SMTP id u13mr2886958jaa.71.1548289334699; 
 Wed, 23 Jan 2019 16:22:14 -0800 (PST)
MIME-Version: 1.0
References: <20190119014347.27441-1-leo.yan@linaro.org>
In-Reply-To: <20190119014347.27441-1-leo.yan@linaro.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 23 Jan 2019 17:22:03 -0700
Message-ID: <CANLsYkwj0jU+GAXXCNY7h-8C40oouF8dx_fzUVRTbV=buS4M2g@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] perf cs-etm: Add support for sample flags
To: Leo Yan <leo.yan@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_162216_204322_9D1F91F8 
X-CRM114-Status: GOOD (  20.50  )
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
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Coresight ML <coresight@lists.linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Robert Walker <robert.walker@arm.com>, Jiri Olsa <jolsa@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 18 Jan 2019 at 18:44, Leo Yan <leo.yan@linaro.org> wrote:
>
> This patch seris adds support for sample flags so can facilitate perf
> to print sample flags for branch instruction.
>
> Patch 0001 is used to save last branch information in packet structure,
> this includes instruction type, subtype and condition flag to help
> making decision for which branch instruction it is.  It passes related
> information from decoder layer to cs-etm.c, so we use cs-etm.c as a
> central place to set sample flags.
>
> Patch 0002 is used to set sample flags for instruction range packet.
>
> Patch 0003 is used to set sample flags for trace discontinuity packet.
>
> Patches 0004/0005/0006 are preparation for exception packet handling:
> Patch 0004 addes exception number in packet; pacth 0005/0006 is to use
> traceID/metadata tuple to access metadata pointer based on traceID, this
> can help decide if the CPU is connected with ETMv3 or ETMv4, ETMv3 and
> ETMv4 have totally different definition for exception numbers.
>
> Patch 0007 sets sample flags for exception packet; patch 0008 support
> sample flags for exception return packet.
>
> This patch series is applied on the acme's perf core branch with the
> with latest commit 02bb912ae451 ("perf tools: Replace automatic const
> char[] variables by statics").
>
> After applying this patch series, we can verify sample flags with below
> command:
>
>   # perf script -F,-time,+flags,+ip,+sym,+dso,+addr,+symoff -k vmlinux

Since you are going for another iteration please add a "before" and
"after" example.

Thanks,
Mathieu


>
> Changes from v5:
> * Addressed Rob's suggestion to add specification info for exception
>   number encoding;
> * Added Rob's review tag in patch 0007.
>
> Changes from v4:
> * Fixed typos in comments, and removed redundant info from commit log;
> * Addressed Mathieu's suggestion to add helper functions for metadata
>   fields (CS_ETM_CPU and CS_ETM_MAGIC) accessing;
> * Addressed Mathieu's suggestion to include headers with alphabetical
>   order.
>
> Changes from v3:
> * Fixed typos in commit logs;
> * Rearranged fields in cs_etm_packet by grouping with same variable
>   types;
> * Fixed ETMv4 exception number which pointed by Mike;
> * Fixed ETMv4 SVC / SMC / HVC in the same CALL, by checking svc
>   instruction to distinguish them;
> * Refine ETMv4 return exception packet handling.
>
> Changes from v2:
> * Addressed Mathieu's suggestion to split one big patch to 3 small
>   patches for setting sample flags, one is for instruction range
>   packet, one is for discontinuity packet and one is for exception
>   packet.
> * Added supporting for ETMv3 exception packet.
> * Followed Mathieu's suggestion to move all sample flags handling
>   from decoder layer to cs-etm.c, thus it has enough info to set flags
>   based on trace context in single place.
>
> Changes from v1:
> * Moved exception packets handling patches into patch series 'perf
>   cs-etm: Correct packets handling'.
> * Added sample flags fixing up for TRACE_OFF packet.
> * Created a new function which is used to maintain flags fixing up.
>
>
> Leo Yan (8):
>   perf cs-etm: Add last instruction information in packet
>   perf cs-etm: Set sample flags for instruction range packet
>   perf cs-etm: Set sample flags for trace discontinuity
>   perf cs-etm: Add exception number in exception packet
>   perf cs-etm: Change tuple from traceID-CPU# to traceID-metadata
>   perf cs-etm: Add traceID in packet
>   perf cs-etm: Set sample flags for exception packet
>   perf cs-etm: Set sample flags for exception return packet
>
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  41 +-
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.h |   6 +
>  tools/perf/util/cs-etm.c                      | 405 +++++++++++++++++-
>  tools/perf/util/cs-etm.h                      |  48 ++-
>  4 files changed, 482 insertions(+), 18 deletions(-)
>
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
