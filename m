Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619F8C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:18:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 301C2222C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DmpeFoY2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EaEbAYCm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301C2222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=03QPs1ZDGB4vywJrYRvpc0YI4Rly4IJf+OwPpPMesu8=; b=DmpeFoY2zJWnxf95zgGpV6iEOv
	X6OVot3t+8uDbUZhhGtx7hSK3wkaM4dRVx79y4wkddCr44ly+QqxtTPbpbcAYmV6yESATS3sliLxy
	2ZrvIVGhOuJaxNfKW1AlgkEk7/CqWNKszpu+scfylo3esFmI1BgzmX+FUtE9hC3goHnMYPOaWxTlF
	fOM/1ibjxJKQKDmyiIviPjkHmD7P3kUZgdxg1SfGb34gvyFvVyPfaPMqYpg7vrs6qlE9bPDnHyumA
	gq6jd1szzzDkftf5+n3tztYDmtrHRZ6Nxasa81HqR8fW67IYeRk/9wFkuDA0tdQ5/wLcqxDbb5yrr
	/2gH8GzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtbhr-0003YY-Sr; Tue, 12 Feb 2019 17:18:51 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtbfb-0001Pi-BJ
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 17:16:42 +0000
Received: by mail-pg1-x541.google.com with SMTP id g189so1544894pgc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 09:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=AqOVPM1vkj1BcrdjSYH7HyHM4JuITQIO8J2Q0BieCKs=;
 b=EaEbAYCmXtoB46vY9L0sicfUIQl51y7gdkSivvKVXdgCulNJFy3rGyTHCYw7FsdztW
 QGbtQdVdQ13XLwiDeCegaCUYqUOonZlJklzCrQiXmv2hbBnsOncAyHpuLQoc94IU+Onn
 czV39rUvqxM5LG6U0m+E8kVYtgyZYcp/y3zVaoXoQOhxH9v3cwHLwpZOtCNUXn1hDe7Q
 feyHanRxoQyS9Tx+fZNEnxHxy9AQkwaoWGR1RwmvOF+wmhHcr/zvF0Z1ls4anxSBBLym
 o6aTw29G7Ml/Zs47lwpeNF4q7LNXMppTazLo9qyWW7rKkAtdOK9lbbEkScHamCX3nDnr
 /2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=AqOVPM1vkj1BcrdjSYH7HyHM4JuITQIO8J2Q0BieCKs=;
 b=hovBU7iNNgfamLJyimBhySsatTfTE4Zt5Xz6CKGCQMaPTgX85E15Xb379kfcA3f/jw
 eEzQo17T57J4elDP7KsDX3YPLYaLWCtY0iNC3UQJ0VqzpWoCpQY+n17BkO3tBZYp1YkC
 af25wdDq68ZqIRJU3ByEokLkYLZcOEsYx879T7Sc/IKdQ+xmAW0mAJQ9/XfWpj3WvAJS
 qrTToh/WAvppu2Pw2JOypF3tfVlMOWUhUXPhpDcB9Qiekb4jac/Rr/0yN+ZcNLbhWsNU
 fguWi5OmqB8cW2aiLRceUv9112sQtH73pnV4weg+QqAHyMGx/CaKnY7s8Qdd+1y1Hri9
 3Zsw==
X-Gm-Message-State: AHQUAubu1oAtOU/pBd1buVvM2hR3awyzPMGCsgPY4pEjkuHYeetMrwp1
 54p4bjWhGzwE4lBVpfYYP90FrQ==
X-Google-Smtp-Source: AHgI3IZaJXtXTQDon+7FcG+ky50OtOVGuRKECwblcEt3mUY/WcWqaOd7g0So5MYe93TVcpTZFzXveQ==
X-Received: by 2002:a63:2ccd:: with SMTP id s196mr4551020pgs.194.1549991790712; 
 Tue, 12 Feb 2019 09:16:30 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id z4sm8659231pgu.10.2019.02.12.09.16.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 09:16:30 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org
Subject: [PATCH 09/13] perf tools: Rethink kernel address initialisation
Date: Tue, 12 Feb 2019 10:16:14 -0700
Message-Id: <20190212171618.25355-10-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171618.25355-1-mathieu.poirier@linaro.org>
References: <20190212171618.25355-1-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_091631_772036_0FB771BA 
X-CRM114-Status: GOOD (  13.94  )
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

Moving initialisation of the kernel start address to function
cs_etm__setup_queues(), considered to be the common denominator for
queue initialisation.  That way we don't have to repeat the same code
at different places.

No change of functionatlity is introduced by this patch.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index c9a5b4935209..2d2de898ea68 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -523,6 +523,9 @@ static int cs_etm__setup_queues(struct cs_etm_auxtrace *etm)
 	unsigned int i;
 	int ret;
 
+	if (!etm->kernel_start)
+		etm->kernel_start = machine__kernel_start(etm->machine);
+
 	for (i = 0; i < etm->queues.nr_queues; i++) {
 		ret = cs_etm__setup_queue(etm, &etm->queues.queue_array[i], i);
 		if (ret)
@@ -1490,14 +1493,10 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
 
 static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 {
-	struct cs_etm_auxtrace *etm = etmq->etm;
 	struct cs_etm_buffer buffer;
 	size_t buffer_used, processed;
 	int err = 0;
 
-	if (!etm->kernel_start)
-		etm->kernel_start = machine__kernel_start(etm->machine);
-
 	/* Go through each buffer in the queue and decode them one by one */
 	while (1) {
 		buffer_used = 0;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
