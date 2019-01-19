Return-Path: <SRS0=AzG1=P3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229E3C5AE5E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:46:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA6F420850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="euj/s5PB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fe57EdFx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6F420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=WySsdxHA4xA0gjTjvEcXJbdEnGX8622tUvtG/xEzdKY=; b=euj/s5PB4PM0mmySLEDHD921tI
	T7cDCncIgbzF8pkOFuUM5hMQDBFZkRnNICTL0OvE6iKqaZKNi68juXE7WBWyGYW998qvR9fKcSFk4
	rJ1kDs/z6L9QzkdQeMzi5NPmti+fgXKHk+9NQvSiGGzLSxxKjkaLqdHzuTyr4GdoeSN4ObZO5HON2
	j1mYb4P3IsmG9g+m+JEsOW6ckE6myPIToCtk0OFgwWtblTbVOGx0ZKbvESREFQGmeDNFcAAg3uU2T
	bWxCSzqZo0lTCfQiHUkb8AF9SzpITKoD7FffiShxqkjjFLpe2XUT61cF9vf0JuDrwYNsQT96jmdx8
	2N0A3f5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkfiZ-0004gh-WF; Sat, 19 Jan 2019 01:46:40 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkfgZ-0001s0-JQ
 for linux-arm-kernel@lists.infradead.org; Sat, 19 Jan 2019 01:45:02 +0000
Received: by mail-pg1-x544.google.com with SMTP id m1so6860184pgq.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 17:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=LZ4bZwBosJupXg7CIOURZH9virkdhXUo2HCt4H7yUU8=;
 b=Fe57EdFxK6kI+lHGwpQH8xnNTbrW0/jksnNtirzNJTrXF8NB+Akxw9ig42x6GxIgan
 Oqpnn4Vm9OzKKdSFU4ZTGFM9yj9O+2/xO9KyLf2DrXvq1d1wcKLzzHNSPAwaev1q0PG/
 Y87VHwpzpGjJjzFZi8R6PVtBv/Bwy+jbiiAe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=LZ4bZwBosJupXg7CIOURZH9virkdhXUo2HCt4H7yUU8=;
 b=gZEj4nLlwNJ73XGC/1XsN85lK3qr9fZOrHlLCwxmMI5n5ZvQ/CUQEo+O7vZAHwhKiT
 L8rm+o6nTItPVYY1UWPulPXCEtlMuvFnCaskW8XZ4iKhAo0uFl6F8pZnSEi5S0uNEkdC
 zVipFaHIurcC2p4yvZb7e1QbAxg64m7ir1H/FQTExT3afyI0wuI3wmraZjrS6GykOeH2
 s+Vi7jlux1yQ5Fao4ZdcC4Id9TPuSQLR/V9MD298Z8cp4w/fGL/pAtxR/yyzpIgWVoMF
 Gla1dLzKYLdXo985kvJ+EZC7qk+ic19956nilT2hewyNczkMWAX9RYj9eN5IoLuP8ZAH
 A6aw==
X-Gm-Message-State: AJcUukefboDPo4+KrtrUR4psX2scJojUN62o/7mQ7xIqzRvkFcWnXztw
 m+BWFs6MShiOWkmMU7GRro5F+A==
X-Google-Smtp-Source: ALg8bN4aRSllEoQS6qOBXM67VRq8Zbq528mO2mZ07KiTph7jhppxPYSLm99bU7hZqn4JXpglzRT5ig==
X-Received: by 2002:a62:2082:: with SMTP id m2mr21222637pfj.163.1547862274868; 
 Fri, 18 Jan 2019 17:44:34 -0800 (PST)
Received: from localhost.localdomain (li421-24.members.linode.com.
 [50.116.3.24])
 by smtp.gmail.com with ESMTPSA id d21sm8648436pfo.162.2019.01.18.17.44.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 17:44:34 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Robert Walker <robert.walker@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Coresight ML <coresight@lists.linaro.org>
Subject: [PATCH v6 8/8] perf cs-etm: Set sample flags for exception return
 packet
Date: Sat, 19 Jan 2019 09:43:47 +0800
Message-Id: <20190119014347.27441-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190119014347.27441-1-leo.yan@linaro.org>
References: <20190119014347.27441-1-leo.yan@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_174436_387500_E73B03D0 
X-CRM114-Status: GOOD (  18.37  )
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
change sample flags to PERF_IP_FLAG_SYSCALLRET for system call
return.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 052805de6513..7547a7178f46 100644
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
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
