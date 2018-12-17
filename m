Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D61C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:22:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0495C2133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jw6Acmq8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jUvOrxtH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0495C2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=egicnP7YvaWN2t7BTruTyP67l5z07CW6lcyvM/+P04w=; b=Jw6Acmq8BZSnQccMG5ilr/ykbr
	P1w/t1wtNmEL+qapusWXbCM55C+ldt78F+bNWSyZHP0ftAql71AXjUOhxRK1bEkxCWJnGbt6k6AK1
	Ocn8pSfiViWPoWXrtmTbtODN2xL3a4rToXq/1LElBmnTCttwtrbpuZkJPoTjYjt+MlpM/2DMDTRpY
	nmyhLixj7rnuj/PfRd54IPh/LEjQb4IDpxZBpg4ilxRJvYcrYCyvjoaSQq/Au0823Wf9Qs1txuzNm
	fqXVtR0weGLPL3PwIsdR1uHp6bvbkm1+j4SB9+855Q5GcEP7hqHCT2EU7hsJYNDZd3M2ts5h0WgsY
	HFPIOfOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYwbH-0004LB-Q7; Mon, 17 Dec 2018 17:22:39 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYwag-0003mD-KD
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 17:22:03 +0000
Received: by mail-pg1-x543.google.com with SMTP id n2so6431804pgm.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 09:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=m66nW8iS1E+go7FhvR8iwCr/rCMmVZB6DxxcxVV5OJA=;
 b=jUvOrxtHlUgY/BFT4v3ZK6gRAks785QtJRvw46Ep6IRQVOgDtruq4cxZlhLqUy+z1T
 PMFlT99Q/QaWBntvS9KUjESXmSD26TxOwa91kqwylbOHv2NZUuW19Pg2YICcEl5lSy9f
 8pcK3qsHFRwG7jQRlZjsinIo2nFdnH1gvNWg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=m66nW8iS1E+go7FhvR8iwCr/rCMmVZB6DxxcxVV5OJA=;
 b=T3QpJX6gzl2GtysPn+EZ8PE5CYY/7sEOAtUSNrgw+HbFztYmle2VsSyTi2KvHcUZjj
 Ba+KRETLUYHaABT7BSUVYfz/YkQ24Fmvl3/kj9mln/LPN1pEcipGg/f8of7FY1xx0b9W
 /k2bLn98aLOspF/J7uhpJQ93Q6rp3/HHE77a43Yu4eup4CUgTaFuZNiRKMWZrDAnG8H7
 Qi9qfNd6TMuB3FpDIwpWsJYBHFcpVeVCOXqidDXH4Bl9N/bUXG0+TiD/4CBkdo1Jv1Ca
 r4kNvuU4oaGiIwWyuza7Gwy1cAdWOr8VreoR+gYdOt4gNkIULjQrsdA6QPLzc0+iEP84
 S+Rw==
X-Gm-Message-State: AA+aEWYWBza6IWR0zb1/m+PsErzcF9KWO2gKoVNfECZzkA+xlt2W+i/l
 L6CNm/rS+hk7AR8e9PkpFDJE6Q==
X-Google-Smtp-Source: AFSGD/X4rNaJfW/npRwt3TGxmZ3I0y9o/KLYnds1Guaz3YDiztq3DWEHWqEZf+h5mHTczt2NcjK3Ew==
X-Received: by 2002:a62:7086:: with SMTP id l128mr13520574pfc.68.1545067311075; 
 Mon, 17 Dec 2018 09:21:51 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id j6sm20526648pfg.126.2018.12.17.09.21.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 17 Dec 2018 09:21:50 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org,
	peterz@infradead.org,
	gregkh@linuxfoundation.org
Subject: [RESEND PATCH v5 1/6] perf: Introduce ioctl to communicate driver
 configuration to kernel
Date: Mon, 17 Dec 2018 10:21:41 -0700
Message-Id: <1545067306-31687-2-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
References: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_092202_663588_8DFD46EC 
X-CRM114-Status: GOOD (  12.02  )
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

Adding a new IOCTL command to communicate PMU specific configuration to
PMU kernel drivers.  This can be anything a PMU might need for
configuration that doesn't fit in the perf_event_attr structure, such
as the CoreSight sink to use for a session.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 include/uapi/linux/perf_event.h       | 1 +
 tools/include/uapi/linux/perf_event.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 9de8780ac8d9..a39d8dc2e7a9 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -462,6 +462,7 @@ struct perf_event_query_bpf {
 #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
 #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
 #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
+#define PERF_EVENT_IOC_SET_DRV_CONFIG		_IOW('$', 12, __u64 *)
 
 enum perf_event_ioc_flags {
 	PERF_IOC_FLAG_GROUP		= 1U << 0,
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 9de8780ac8d9..a39d8dc2e7a9 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -462,6 +462,7 @@ struct perf_event_query_bpf {
 #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
 #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
 #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
+#define PERF_EVENT_IOC_SET_DRV_CONFIG		_IOW('$', 12, __u64 *)
 
 enum perf_event_ioc_flags {
 	PERF_IOC_FLAG_GROUP		= 1U << 0,
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
