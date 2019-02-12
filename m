Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7655C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:19:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB062222C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HQlJVac5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wYgl3NNS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB062222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=y0JSA1xx5rhBlp+0RE0WV0J30Z0LfxLnma/lF8qwmeA=; b=HQlJVac5J2Mk/P8W0otpKnAO6c
	g5toFfhco82xvB9SaX+EOOmwXB89NNqR+HMscPck87KbBNHIKajyaHdC1zHAnqjxLIA0IytfLfNdz
	f6TiYG7S/wImWU56xkylBMmHNNNcyvUeyOsp26SeHnM6M3h2F6sNOu7m3Dwz581FsO/lyPbT57E9U
	irGJHXbTWGsnx3gXy9TW2B5ptMVVMorwDhWuZKy7ACzor/vRxOTreUysj/W5ff7TvvI2eKRSiiym+
	/PekFYikugw40lbZJmXTtioZU5Q1of/xVj4JXOo3VwwtmoHK1i/Q9nPSAuevzwm6sVwZ0XYmyMTnP
	Ll0C7jNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtbiB-0003pL-Ea; Tue, 12 Feb 2019 17:19:11 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtbfd-0001SW-HY
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 17:16:45 +0000
Received: by mail-pf1-x441.google.com with SMTP id g6so1576475pfh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 09:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/UH8SrTya5tl/qVTuklo7mGBNz+HUAk8Fnba3ZSHvA4=;
 b=wYgl3NNS2JG8qwab9R9cIm8sIzbImuxDxN/dEDQKbHn/IZUxPZN4CrrHj/nYcEJ1/t
 k6e8vUwg3Q0MY2UCkeCKEZg7zsYkRBA2GJ/GuRjwOXc+MOl7EPcEu9AF4GivB6xj1c5J
 mupsEFF7+AIvSu5UrKasfzWJNwMa8+63ZiNnzfSRhKi/FW+EdOUavkb+s4OD64ZPCMiM
 5NUe4upIhs3RiQ3XivQgnTPmmHYasY7g7hJK2AjoCngqbQJkJWPcX8w9OZg7pC2omM7a
 m7NepYWwAZAaY/CQ3wcCKiqWx8J6WGI0cZs+qudK88BiSlBpZiW9/OtU8z6SyKjWL+63
 Tk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/UH8SrTya5tl/qVTuklo7mGBNz+HUAk8Fnba3ZSHvA4=;
 b=a5mZv/yKFBaWo89C1LH37SszUXIL+6aSx7Il2L5t9xM0DoNLzTyb9BVLdWQSsOyuM5
 fjVBmYEu1w/dx2/qt61tWe/W9b4GQR9NxqKxH3If3ucwEFLYLnZXx0r3Cq9G3l8uB+1m
 L9afBQyDKR1uepJ7HKotx3bLsbwABIW05DjM2gxOdp8U9IqsXj08SJRzpOZ8AFAPtgHo
 fo8Yg4e8iH44dhptpZq5wJ4Br54C+01/PRNQN1/vLPM1yMeXmrB6CBUD98vA7mxZzh83
 ikxRcJ6yVwmB4Pcvoh5hrKCsGzyEgkuSI3YW5bOtMJXiaJmfNqMK2eHx5iIazzlFMh6G
 jmYQ==
X-Gm-Message-State: AHQUAuZwVZ2CYqSX4786cdXAhp2thYykz8IKfGNEd6cGpbpsb/CApV/O
 CYqA5zqYkJCVAWVz138GBfPaqzzF1/I=
X-Google-Smtp-Source: AHgI3IbPeLvGGSj7sEXTX99OIebwz8qfGFIesAcnfY+REMjVGkxG+jmv3dCOEEzUD0A/U91rpEDS5Q==
X-Received: by 2002:a65:514c:: with SMTP id g12mr4481382pgq.169.1549991792926; 
 Tue, 12 Feb 2019 09:16:32 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id z4sm8659231pgu.10.2019.02.12.09.16.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 09:16:32 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org
Subject: [PATCH 11/13] perf tools: Modularize main decoder function
Date: Tue, 12 Feb 2019 10:16:16 -0700
Message-Id: <20190212171618.25355-12-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171618.25355-1-mathieu.poirier@linaro.org>
References: <20190212171618.25355-1-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_091634_333697_EA95EAC3 
X-CRM114-Status: GOOD (  15.63  )
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

Making the main decoder block modular so that it can be called from
different decoding context (timeless vs. non-timeless), avoiding
to repeat code.

No change in functionality is introduced by this patch.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm.c | 41 ++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index d2c90b369e7c..cfa686fe223e 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1491,9 +1491,36 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
 	return 0;
 }
 
+static int cs_etm__decode_data_block(struct cs_etm_queue *etmq)
+{
+	int ret = 0;
+	size_t processed = 0;
+
+	/*
+	 * Packets are decoded and added to the decoder's packet queue
+	 * until the decoder packet processing callback has requested that
+	 * processing stops or there is nothing left in the buffer.  Normal
+	 * operations that stop processing are a timestamp packet or a full
+	 * decoder buffer queue.
+	 */
+	ret = cs_etm_decoder__process_data_block(etmq->decoder,
+						 etmq->offset,
+						 &etmq->buf[etmq->buf_used],
+						 etmq->buf_len,
+						 &processed);
+	if (ret)
+		goto out;
+
+	etmq->offset += processed;
+	etmq->buf_used += processed;
+	etmq->buf_len -= processed;
+
+out:
+	return ret;
+}
+
 static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 {
-	size_t processed;
 	int err = 0;
 
 	/* Go through each buffer in the queue and decode them one by one */
@@ -1513,20 +1540,10 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 
 		/* Run trace decoder until buffer consumed or end of trace */
 		do {
-			processed = 0;
-			err = cs_etm_decoder__process_data_block(
-				etmq->decoder,
-				etmq->offset,
-				&etmq->buf[etmq->buf_used],
-				etmq->buf_len,
-				&processed);
+			err = cs_etm__decode_data_block(etmq);
 			if (err)
 				return err;
 
-			etmq->offset += processed;
-			etmq->buf_used += processed;
-			etmq->buf_len -= processed;
-
 			/* Process each packet in this chunk */
 			while (1) {
 				err = cs_etm_decoder__get_packet(etmq->decoder,
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
