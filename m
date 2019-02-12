Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9B0C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:16:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AF39222C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XSS9K2ps";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EVKqyCWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF39222C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ZQPkbflyNLJB60yFaGz+KWhjPSGrdTrTmxpijTaYBNo=; b=XSS9K2psK/6l8IqP460u11O1eT
	btEDz1aoNJqworY1dUns1v8y1nDvz0K++Yy1RwhcMi6I8fEzhxSeZtO/i7rkCBmk7+h024bPGJ8jE
	SJWgsHPbHra44PnL+MwdSQmEMcf9Z70DJbecDcajSIlQEJE+gFg6ecL14loPiy+dIzNIyjgKJo/T2
	6kNL9A0cEtFcMbBlrtDMkbZowi0KNTs7cYQD7E8D0CmkGBuZ/yKkv4Fm4YPBq4Bst2Cxj/+qS5kXU
	RoIGmqKWZ7tWoLggMc5qeyQpEqIDAM2qcfWChEQKqZpLpfTWSJTgzDG+IgDQaiyR+AXmTNy+IzOSO
	C+CCpowQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtbfi-0001U2-NA; Tue, 12 Feb 2019 17:16:38 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtbfS-0001HG-1w
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 17:16:23 +0000
Received: by mail-pg1-x543.google.com with SMTP id m1so1540434pgq.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 09:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=F3htzumhw0wsBNPb1jzbmXRsC9SD4nCo3kem2V3UyCY=;
 b=EVKqyCWCkFmsCIw/cwaM55FNXGvjvtuhlkDhHlLuPyeOPf1jNJCvsyST22FJeP3N08
 SaUxsMOgtm6P50sL15JMmR15PmSkCrH7Rttno88S5ejE67CA5y6fcMGBHTgku9Qvoldn
 6LHz6eMcW4WrUw+DLg2ZzIZX7HE3TADx1uCL/CAwi7l7OolGwnyBVPQLc58u51PjOREH
 j09tKlsRce7Blh6xjKlly0m9P2mkNaI0jIfNrVusW8yp/oJGh184U583VnC1fFtUtlGE
 l+U+UiptDpUXCrhGP5Dkj4MK8dEzNwss8XtKGp9yE+5xMLnzlv0bxS4HsJFkAnp4orIa
 m2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=F3htzumhw0wsBNPb1jzbmXRsC9SD4nCo3kem2V3UyCY=;
 b=iOy3AqkBjwixLBJ4eLLdnrN5u1tbg6k5z21oNkxnVaKFVYgJGfbDN7Rbp30EqNVMRG
 gsrg5IEpoqmULgeBsKaKsjCJRa3G1X9NTVHXJ2EWYuDg4aaeLI+bHys/LJ6nd4pqGP2Q
 7zqeBrM45EKgfvN4agAG99/o8zDc5St3DFIzwna/LklBh4Y2Q8tlKV9AajcqwrCfiD11
 d9GEn6C/WeS0gd7B8ak5LY5IOFlPkO9txY1/vKBryM9VFvt+QIcDLkFkfKqXys7p7w9F
 9+9O9+E3ygWepzT7X9zAn8276uISzhKcJa3OfEsCqzampN4RmsN3X4WQ3YE4fag5nzsG
 s5uA==
X-Gm-Message-State: AHQUAubRsfXYtwv+ZxnTCwMnf3zXjXM8oNZWJfpLU6A0pWJAPDvrMTq5
 dlk6uNWR+JKdqcGzL+QLy743vg==
X-Google-Smtp-Source: AHgI3IYVQEgGd8GVx9h2KcqYyLeFJbvp2oQ5fHkPZJ8hTsJjwnPaCpYreGyEhGFYJKr1a9wmYlkuBg==
X-Received: by 2002:a63:cc4e:: with SMTP id q14mr4499520pgi.291.1549991781471; 
 Tue, 12 Feb 2019 09:16:21 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id z4sm8659231pgu.10.2019.02.12.09.16.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 09:16:20 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org
Subject: [PATCH 01/13] perf tools: Remove unused structure field "state"
Date: Tue, 12 Feb 2019 10:16:06 -0700
Message-Id: <20190212171618.25355-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171618.25355-1-mathieu.poirier@linaro.org>
References: <20190212171618.25355-1-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_091622_091553_74DC376A 
X-CRM114-Status: GOOD (  10.30  )
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
Cc: suzuki.poulose@arm.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
 mingo@redhat.com, leo.yan@linaro.org, jolsa@redhat.com,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Field "state" in structure cs_etm_queue is no longer used and needs
to be removed.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 0b11d653cfbe..ebd68eb43da9 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -65,7 +65,6 @@ struct cs_etm_queue {
 	struct thread *thread;
 	struct cs_etm_decoder *decoder;
 	struct auxtrace_buffer *buffer;
-	const struct cs_etm_state *state;
 	union perf_event *event_buf;
 	unsigned int queue_nr;
 	pid_t pid, tid;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
