Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCC6C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:20:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DB55222C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cr+R14bt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sVIhgAj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB55222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=SsjMTZP3l7qeIwaNRQZc/mPBGtRU41jISIiCZITKOPQ=; b=Cr+R14btHy/JnNdmpl6Wf4qwW3
	z1UzWMCbNP2QQTafjp198ygkbqfKCII89sSbLCUmA/hVSVz6AgHyXWddn6lDl75xVAGX2efPvCJmD
	TCYSmoVbM6RXNsQF5WswDi+x7oiXTsKy+uThe8EfadkZEz+6BVfo4aIfJTDlrpt/OCl8MZS0gEzaZ
	bkpLAK4ou93JeVcEFPpSnh9LDyV3rmcVXEqsoLAbfSbAJDhR+fxJjqPZvfT6PUd1YtD271aj5JR4t
	9TtG0LCIwNkMygILei/6VyqaU+bw/nnoGexRjyTsMDD3kXUG5mz9agU6C9krqKHgWJjIvjzPp8eqY
	c2d/yWDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtbjF-0005Q1-4r; Tue, 12 Feb 2019 17:20:17 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtbff-0001Ua-LR
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 17:16:48 +0000
Received: by mail-pl1-x644.google.com with SMTP id 101so1598788pld.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 09:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qkiQiMGL+p9I6/iS3vRnEYYc23edBwfSeQJiedeTSRc=;
 b=sVIhgAj1YxApYOZcGkQA8IOcPqUHNNfVOBXsJ3MIFFlT1Hp8bmWs5av4xevdXiVNZW
 FSC1Yo1a8IBZkR46UdZoVR3FzPxk79HkIZCfHoTxlU8GGBKw8v8cOrzeCP54IGWvsR8v
 PzMzDOol6q8ak1JwyqPhqIVjqViUCZIG9JLB5SZUtCUZFE9WQIA8YFOKafHfRMcpwksv
 /KbApTEcZ92QxjNlFM9SVa3rUX1XD/RHSE+zlfpd9Po0e8bq1JYHfK3fA5fMbe3UteYg
 vcupn0WP+VnbtW/3yDgT6jB0RLT7I35yBoSiTePGbd5SNZIGI/BeE40t1UPLDRoc5QhJ
 lluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qkiQiMGL+p9I6/iS3vRnEYYc23edBwfSeQJiedeTSRc=;
 b=li1YlBlgHqiqGFsEMbJ7XCRAxdN20dnhwPs7qQahYLdG0U/vaY+QMWj/h+bXcyyI0V
 0TfHknm9jMy0/qSEDA0Xzp/pEy27E/ZqbeMC5QQHLFqZNMJyfyBuSvI8IkU2ZaytaGfr
 uHA7grxPm3nbaCF74hFhZb6cMzZMsehyR4rg/pEmnXiQ7ZWegR+AzIZXLj/X0D3zYP/t
 mshPnfO/scnvvcsHYKDadeAyj1EkiYNIkEWSXU+V0zdQ9aNQme5gNw12x6Y7rwDLqKSR
 9D2hAMhIEY4bQDC3omIjbxYazMP8mV3HIWa61Ekv9+R9xUjedBRugWWqJzzGdI3HnAy5
 v5Bg==
X-Gm-Message-State: AHQUAuZLi0yYg+NJ6sya5Nsb4/soJpMaRKzg4jgIT/zswlslFDspgnOS
 J5Nf9VzcikAbWqH9tv8z0MXlEg==
X-Google-Smtp-Source: AHgI3IZIH7pBK/F0JpcB5vmS60BvdRnS+wNobaGXypdhiP9CX2irU2g9uwx3QZUi1h1HLU/7h51cZg==
X-Received: by 2002:a17:902:14b:: with SMTP id
 69mr4904861plb.120.1549991795240; 
 Tue, 12 Feb 2019 09:16:35 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id z4sm8659231pgu.10.2019.02.12.09.16.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 09:16:34 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org
Subject: [PATCH 13/13] perf tools: Modularize auxtrace_buffer fetch function
Date: Tue, 12 Feb 2019 10:16:18 -0700
Message-Id: <20190212171618.25355-14-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171618.25355-1-mathieu.poirier@linaro.org>
References: <20190212171618.25355-1-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_091636_975302_1F0FB29F 
X-CRM114-Status: GOOD (  16.90  )
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

Making the auxtrace_buffer fetch function modular so that it can be called
from different decoding context (timeless vs. non-timeless), avoiding to
repeat code.

No change in functionality is introduced by this patch.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm.c | 41 ++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f607bc58bd03..110804936fc3 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1152,6 +1152,32 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq)
 
 	return 0;
 }
+/*
+ * cs_etm__get_data_block: Fetch a block from the auxtrace_buffer queue
+ *			   if need be.
+ * Returns:	< 0	if error
+ *		= 0	if no more auxtrace_buffer to read
+ *		> 0	if the current buffer isn't empty yet
+ */
+static int cs_etm__get_data_block(struct cs_etm_queue *etmq)
+{
+	int ret;
+
+	if (!etmq->buf_len) {
+		ret = cs_etm__get_trace(etmq);
+		if (ret <= 0)
+			return ret;
+		/*
+		 * We cannot assume consecutive blocks in the data file
+		 * are contiguous, reset the decoder to force re-sync.
+		 */
+		ret = cs_etm_decoder__reset(etmq->decoder);
+		if (ret)
+			return ret;
+	}
+
+	return etmq->buf_len;
+}
 
 static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq,
 				 struct cs_etm_packet *packet,
@@ -1591,18 +1617,9 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 
 	/* Go through each buffer in the queue and decode them one by one */
 	while (1) {
-		if (!etmq->buf_len) {
-			err = cs_etm__get_trace(etmq);
-			if (err <= 0)
-				return err;
-			/*
-			 * We cannot assume consecutive blocks in the data file
-			 * are contiguous, reset the decoder to force re-sync.
-			 */
-			err = cs_etm_decoder__reset(etmq->decoder);
-			if (err != 0)
-				return err;
-		}
+		err = cs_etm__get_data_block(etmq);
+		if (err <= 0)
+			return err;
 
 		/* Run trace decoder until buffer consumed or end of trace */
 		do {
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
