Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2DEC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:53:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D465206DD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tHNvYBh4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1T+RC8x4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vaOFkBps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D465206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ndbCY5+BhIFQxvBm91gmMZ+RptkzAE2z2EuoleOz0mU=; b=tHNvYBh4Qte28G
	qWTNSryBXu3bPrBvP3LN8//03VHLakBgVda7P6SEWRFvqZ4/KB1TwVSF7apKXr5Grwe54LCEECHn3
	50Cv6ucJvuVQgycbz4A2PwsAy5+yyqBMdm83aAPM8c576S+7vs/EYwvASj8S3QtTS7PmJ+jZMbQbi
	TstXn0PqvE9RCQ+t7C0tj+O5N47vNN7kiuuFkywPemrhBxubAy3bYEerMNxxkroSmk0KePV3UWRev
	0H+v7TwOU4F6ZGIru/iVMMbZGceg+6stftJFPOdlH+MFATWwMs2L3Inc+YqIOmxuVIZVF/JsP+uSb
	oflTiax+w5sVQ0tU8DoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grSK6-0007X7-Aq; Wed, 06 Feb 2019 18:53:26 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grSIR-0005zw-2b
 for linux-arm-kernel@bombadil.infradead.org; Wed, 06 Feb 2019 18:51:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Xxnu0lhLyO1/07Nesmop4W56l4fU+TxKmI3E19fnMAk=; b=1T+RC8x45QrXQdluoe2cbvQV+J
 C82qivtldX9IsB7hIyOpIDEayNvnc3SDj5aNhFhLIPelvajvXVGxw9VxoeRiT5yhkYfbgjU+qa+qI
 kuFs8eMYFl/++yVoBgzUug2B2pWrKHYdodiibJpArXO4j8vwp2I6UKOZ6csQ3LvchmWWjD8kWAKOw
 9KE9L6lQAeuX6YT7NeudOidWvTm2N5Fw8e0ZVdvQDcp1vhvBXYC2e4sUfphfIgr+Qh4tN+jlJ55/s
 VJB5TAM2Pt3UoPjY/y9HchoXqVdBtmT/EHAbzsO++Ns4t1cSMvf14dEB8Ws2i8v1ZquJSr3xF5v8H
 odlDFBgA==;
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grSIO-0005DE-9y
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 18:51:41 +0000
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EA902218C3;
 Wed,  6 Feb 2019 18:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549479098;
 bh=0zDhEzCbtodJsblH+IgDpVRl0siGrXzYw48Mzfi37ag=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vaOFkBpszFjLzlO6x/VekHIN+sXlvFZY/PD8mixGPZFeNQFLlU1J5W+4RJLqunDEA
 mqP3wB3ti967XOG3Tl/E+Jxc+So+TF2TvbA56ioItqatkEZddjhXQ0tdD1Jo3+VWpe
 CvMoPaYD6atGUUyLD6jZN6Msnb3yVNjR2FcHYpBc=
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 43/53] perf cs-etm: Set sample flags for exception return
 packet
Date: Wed,  6 Feb 2019 15:48:53 -0300
Message-Id: <20190206184903.24054-44-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_135140_512595_3E115965 
X-CRM114-Status: GOOD (  19.26  )
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
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulouse <suzuki.poulose@arm.com>,
 Clark Williams <williams@redhat.com>,
 coresight ml <coresight@lists.linaro.org>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Leo Yan <leo.yan@linaro.org>,
 Namhyung Kim <namhyung@kernel.org>, Robert Walker <robert.walker@arm.com>,
 Jiri Olsa <jolsa@redhat.com>, linux-arm-kernel@lists.infradead.org,
 Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Leo Yan <leo.yan@linaro.org>

When return from exception, we need to distinguish if it's system call
return or for other type exceptions for setting sample flags.  Due to
the exception return packet doesn't contain exception number, so we
cannot decide sample flags based on exception number.

On the other hand, the exception return packet is followed by an
instruction range packet; this range packet deliveries the start address
after exception handling, we can check if it is a SVC instruction just
before the start address.  If there has one SVC instruction is found
ahead the return address, this means it's an exception return for system
call; otherwise it is an normal return for other exceptions.

This patch is to set sample flags for exception return packet, firstly
it simply set sample flags as PERF_IP_FLAG_INTERRUPT for all exception
returns since at this point it doesn't know what's exactly the exception
type.  We will defer to decide if it's an exception return for system
call when the next instruction range packet comes, it checks if there
has one SVC instruction prior to the start address and if so we will
change sample flags to PERF_IP_FLAG_SYSCALLRET for system call return.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: coresight ml <coresight@lists.linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190129122842.32041-9-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index a714b31656ea..8b3f882d6e2f 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1372,6 +1372,20 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
 		if (prev_packet->sample_type == CS_ETM_DISCONTINUITY)
 			prev_packet->flags |= PERF_IP_FLAG_BRANCH |
 					      PERF_IP_FLAG_TRACE_BEGIN;
+
+		/*
+		 * If the previous packet is an exception return packet
+		 * and the return address just follows SVC instuction,
+		 * it needs to calibrate the previous packet sample flags
+		 * as PERF_IP_FLAG_SYSCALLRET.
+		 */
+		if (prev_packet->flags == (PERF_IP_FLAG_BRANCH |
+					   PERF_IP_FLAG_RETURN |
+					   PERF_IP_FLAG_INTERRUPT) &&
+		    cs_etm__is_svc_instr(etmq, packet, packet->start_addr))
+			prev_packet->flags = PERF_IP_FLAG_BRANCH |
+					     PERF_IP_FLAG_RETURN |
+					     PERF_IP_FLAG_SYSCALLRET;
 		break;
 	case CS_ETM_DISCONTINUITY:
 		/*
@@ -1422,6 +1436,36 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
 			prev_packet->flags = packet->flags;
 		break;
 	case CS_ETM_EXCEPTION_RET:
+		/*
+		 * When the exception return packet is inserted, since
+		 * exception return packet is not used standalone for
+		 * generating samples and it's affiliation to the previous
+		 * instruction range packet; so set previous range packet
+		 * flags to tell perf it is an exception return branch.
+		 *
+		 * The exception return can be for either system call or
+		 * other exception types; unfortunately the packet doesn't
+		 * contain exception type related info so we cannot decide
+		 * the exception type purely based on exception return packet.
+		 * If we record the exception number from exception packet and
+		 * reuse it for excpetion return packet, this is not reliable
+		 * due the trace can be discontinuity or the interrupt can
+		 * be nested, thus the recorded exception number cannot be
+		 * used for exception return packet for these two cases.
+		 *
+		 * For exception return packet, we only need to distinguish the
+		 * packet is for system call or for other types.  Thus the
+		 * decision can be deferred when receive the next packet which
+		 * contains the return address, based on the return address we
+		 * can read out the previous instruction and check if it's a
+		 * system call instruction and then calibrate the sample flag
+		 * as needed.
+		 */
+		if (prev_packet->sample_type == CS_ETM_RANGE)
+			prev_packet->flags = PERF_IP_FLAG_BRANCH |
+					     PERF_IP_FLAG_RETURN |
+					     PERF_IP_FLAG_INTERRUPT;
+		break;
 	case CS_ETM_EMPTY:
 	default:
 		break;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
