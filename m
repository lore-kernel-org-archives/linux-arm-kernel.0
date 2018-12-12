Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_MIXED_ES autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30055C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:46:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D359D20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RRy97xvQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J7WRkS09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D359D20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1xo3HhFrZnboGFjK3Q6DYghWNr87pHIwB4RWT1lVYao=; b=RRy97xvQ/C6o2i
	Mbk828PHlicVZKImGThXckVxfjwc5Tfmbty/5ZWRC+jFUE7DVwy+3TUdoVuRNCqp1zGtX7iRddMrR
	DyQoc/LSeqwnzdQmRjXRb0BLU8N+BcapSYIPVMJWEC1JKKzEUHatMKilhg04LzU6ZVv0pcsQHTe/7
	B9JWmS5pNEscxy2qXmwtOywQfZ9+MQy9/he7pNYuBr4AoO5XfAsv32blGG7fROLRM5Bb7FiuuvUdK
	qmcRD5x4aPmHvs5sWTI6mclo7Z5R8+X60TdG2LdM9uXZ7+zKeO7qT/d+HhDt4VRN2PRbOMihk9wN/
	6wbPaQVTAqhuTeEDHqRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX9WM-00066Z-JV; Wed, 12 Dec 2018 18:46:10 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX9WI-00065e-Ve
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 18:46:08 +0000
Received: by mail-it1-x142.google.com with SMTP id b5so11490071iti.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 10:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4w6cnngQONcEaZHQonIAO2XA4e1xiIW1455RBSKyJcE=;
 b=J7WRkS09oZNB+d4IyMaq4Qou01ZZX4URlAAGzAEDNhnNtMP93BRafpxN7hWcAQB161
 G4cs+UhUa6UIdFX+8kwNT04A+2eS+X4h6agFPqR5bQE7Sl8N9Dom78xhZFslfxbo2jnm
 XIgyk/oc5XAHNEMW/9oQe8nvg13DhofbCB/Vk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4w6cnngQONcEaZHQonIAO2XA4e1xiIW1455RBSKyJcE=;
 b=B2B8Z2gQjEanRm+GA8IGJ+cbuhgKYDaHFJPyFU/Jv7sfAWcFOjCH55bABgQkVkNs31
 ebTOREsdvmnbvJFkxwhAFIiuwZRfhZFniNbSJbI+9jZH5SA7nDKb5/EttbN569mjoUDa
 HHqzKlo5CtdrvHYv621wFg0zGFDdCj66n/NoEZYdKDPboJ601+vXTiJEMIbdcvBT5orH
 c2cHgEOVI0Anva3Wu8uJvJt42AXT8u5ZNNluhgVvXGSc87CDME0I5ZFzUmztwARbQWbH
 cfhrV+L2Ao3jIiYxTcF4mbK/Ub8hpECWedmtZ/TI4KDBPwGkPpKOkUFhtHsQJTBiVjxB
 Yedw==
X-Gm-Message-State: AA+aEWbQZGhBMJiKtAB89AOjYPGJMs9X7SoevJXYCiO1m3/pCG5y/xmg
 XuXy5PPOGJvDl3fo2XlATUaL4kvkcTA6yZhMj0Q3pEN3
X-Google-Smtp-Source: AFSGD/X8rJE4ZgFQiaR8ze20bK2wBuLiuYIfCz9IO+oVXyUfiRLeeBA2/vemQeGax0qqddvlGSLEiaDo90PzbetlcuQ=
X-Received: by 2002:a05:660c:34f:: with SMTP id
 b15mr7137137itl.146.1544640355933; 
 Wed, 12 Dec 2018 10:45:55 -0800 (PST)
MIME-Version: 1.0
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
In-Reply-To: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 12 Dec 2018 11:45:44 -0700
Message-ID: <CANLsYkyFZqUYghGmSS-j50EaOvce57CP+Y737xRF3HjPrHDVqw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] perf cs-etm: Correct packets handling
To: Arnaldo Carvalho de Melo <acme@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_104607_013700_746DA025 
X-CRM114-Status: GOOD (  21.81  )
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
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Coresight ML <coresight@lists.linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Leo Yan <leo.yan@linaro.org>, Namhyung Kim <namhyung@kernel.org>,
 Jiri Olsa <jolsa@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 11 Dec 2018 at 00:40, Leo Yan <leo.yan@linaro.org> wrote:
>
> perf cs-etm module converts decoder elements to packets and then we have
> more context crossing packets to generate synthenize samples, finally
> perf tool can faciliate samples for statistics and report the results.
>
> This patch series is to address several issues found related with
> packets handling and samples generation when worked firstly on branch
> sample flags support for Arm CoreSight trace data, so this patch series
> is dependency for sample flags setting, will send another dedicated
> patch series for sample flags later.
>
> In this patch series, the first two patches are mainly to fix issues in
> cs_etm__flush(): patch 0001 corrects packets swapping in cs_etm__flush()
> and this can fix the wrong branch sample caused by the missed packets
> swapping; patch 0002 is to fix the wrong samples generation with stale
> packets at the end of trace block.
>
> Patch 0003 and 0004 are for minor fixing; patch 0003 removes unused field
> 'cs_etm_decoder::trace_on', this can simplize the switch-case code for all
> discontinuity packet generation by using one code block; patch 0004 is to
> refactor enumeration cs_etm_sample_type.
>
> Patch 0005 is to rename CS_ETM_TRACE_ON to CS_ETM_DISCONTINUITY, we use
> a more general packet type to present trace discontinuity, so it can be
> used by TRACE_ON event, and also can be used by NO_SYNC and EO_TRACE
> elements.
>
> Patch 0006 is used to support NO_SYNC packet, otherwise the trace
> decoding cannot reflect the tracing discontinuity caused by NO_SYNC
> packet.
>
> Patch 0007 is used to support EO_TRACE packet, which also introduces
> the tracing discontinuity at the end of trace and we should save last
> trace data for it.
>
> Patch 0008 is used to generate branch sample for exception packets.
>
> Credit to Mike Leach and Robert Walker who made me clear for underlying
> mechanism for NO_SYNC/EO_TRACE elements, Mike also shared the detailed
> explanation for why we can treat NO_SYNC and TRACE_ON elements as the
> same, so except following Mike & Rob suggestion for trace discontinuity
> consolidation, most commit log of patches 0006/0007 also come from
> Mike's explanation.
>
> This patch series is applied directly on the acme's perf/core branch [1]
> with latest commit aaab25f03e9e ("perf trace: Allow selecting use the
> use of the ordered_events code").
>
> With applying the dependency patch, this patch series has been tested
> for branch samples dumping with below command on Juno board:
>
>   # perf script -F,-time,+ip,+sym,+dso,+addr,+symoff -k vmlinux

Good day Arnaldo,

I have reviewed all the changes in this set - please consider adding
to your next branch.  Let me know if you want a pull request.

Regards,
Mathieu

>
> Changes from v2:
> * Addressed Mathieu's comments and suggestions for minor refactoring
>   for removing unused field 'cs_etm_decoder::trace_on' and added one
>   dedicated patch to refactor enumeration cs_etm_sample_type.
> * Added Mathieu's 'reviewed' tags;  Very appreciate Mathieu's many
>   suggestion for crossing several patch series.
>
> Changes from v1:
> * Synced the consistent code in patch 0001 for condition checking.
> * Introduced new function cs_etm__end_block() for flushing packet
>   at the end of trace block.
> * Added new patch 0003 to rename CS_ETM_TRACE_ON to
>   CS_ETM_DISCONTINUITY.
> * Used the same one packet type CS_ETM_DISCONTINUITY for all
>   trace discontinuity (include support TRACE_ON/EO_TRACE/NO_SYNC
>   packets).
> * Removed tracking exception number patch, which will be added in
>   sample flag patch series.
>
>
> Leo Yan (8):
>   perf cs-etm: Correct packets swapping in cs_etm__flush()
>   perf cs-etm: Avoid stale branch samples when flush packet
>   perf cs-etm: Remove unused 'trace_on' in cs_etm_decoder
>   perf cs-etm: Refactor enumeration cs_etm_sample_type
>   perf cs-etm: Rename CS_ETM_TRACE_ON to CS_ETM_DISCONTINUITY
>   perf cs-etm: Treat NO_SYNC element as trace discontinuity
>   perf cs-etm: Treat EO_TRACE element as trace discontinuity
>   perf cs-etm: Generate branch sample for exception packet
>
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 42 +++++++++-----
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 10 ++--
>  tools/perf/util/cs-etm.c                        | 77 ++++++++++++++++++++++---
>  3 files changed, 100 insertions(+), 29 deletions(-)
>
> --
> 2.7.4
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
