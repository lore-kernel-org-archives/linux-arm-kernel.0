Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77E0C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:30:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96C9B2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Da0zHClS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AMhZ5/O1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C9B2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=EnlDbnaL4IbOm6I6OzssiYQdM9WBNUkDv1EBlQVoj7A=; b=Da0zHClS3o2JYrl7jS0wsUd6W6
	OR8jCCIicnY/Wa0Z0Lo0ENqqRkcKzJtvxshdVVgVkei+TbzcTslEIZzbQ8D8+fIzUvngnHjlyspeh
	4JTQziuTGmWENTtnWZhP21opPUOnLpI6JWkEVNhVW++fssoEwMNrtXRpdX+Wyz00uMo/7d+P6D2EZ
	CNtUYqBqayImcD4yZK9t7WZteJ7w4zfHyR8kAeqPZgens2Q/hphzSzd/KvgrqRAvOizKasMjVcNnk
	iiCf+3FmTf8gran+Rc8jXh7dJp/Obdg/SDirow8hoOY3VvMWft2Nt1GMjsWNjjQb3Oz+tCUatRlHT
	Uag6ArFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goSX1-0006uz-6s; Tue, 29 Jan 2019 12:30:23 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goSWX-0005UQ-GG
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 12:29:58 +0000
Received: by mail-pf1-x42b.google.com with SMTP id 64so9578982pfr.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 04:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=euu22pFQ6c9B3mZ1+UtLKySuzqAo82xzEXBgVuSFGfs=;
 b=AMhZ5/O1hNqtAFBJUQruSRENmMh8lJg50fOVNoKhhzNkp8NA9s7yvPtNzKen+3YJG6
 NUy8pnxLr5ZTx4OoqZTa1yDkaZnGz1VdeXBE77mXtYqat31xRQfRjh0touot1/iulW2j
 idEpIUGkLisvveyAZUiytbe6EauWO4R1IOHBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=euu22pFQ6c9B3mZ1+UtLKySuzqAo82xzEXBgVuSFGfs=;
 b=tA5DDfzp0y3AEkQJSBOr3MahcK+cllLYo4D8TE9/mVhD5rWJFUbxDNK/VYwdVmWFEr
 dqzfGYq4++qNM0mo/gykMXgL1Ee954eKXytU7JzqLqQTFgcyiMeE1lpI7r44Aa1RP8eC
 Ss/IQv+GuC1G0712ZkEdvSAo24M/M5LFrS198YW15GSjy60UTJR4iwOTbTELTcnU9Z5i
 ssLK7pISArLWhwxgnGVu4AYoRHDcctLrqxgrKu0QdtuI0TjPnrdOF6A7yw3hWrvA1OHB
 j2jdUcxmG+l+MavcfO61SdWrbvTb5Cf7QZZLGMcqDEU/36rXsNtuC2S0jV2Nlate+ToR
 mmvA==
X-Gm-Message-State: AJcUukd+WVSis70OlKgaAy+UKPjO4hbN71qe7tMOqv5voJc0BZRvJGxs
 0bqQEvRrzBiqoPfFH/ZBad0kMA==
X-Google-Smtp-Source: ALg8bN5AZJ3hYW8LJ/8abK5HrGwAgGNgr9Y3cXE3kcvTXJPyONe32Aqfm/CCN7ALlhicQyTc1a4R+A==
X-Received: by 2002:a63:d747:: with SMTP id w7mr22989225pgi.360.1548764991762; 
 Tue, 29 Jan 2019 04:29:51 -0800 (PST)
Received: from localhost.localdomain (li569-141.members.linode.com.
 [192.155.82.141])
 by smtp.gmail.com with ESMTPSA id h64sm59552502pfc.142.2019.01.29.04.29.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 04:29:51 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Robert Walker <robert.walker@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Coresight ML <coresight@lists.linaro.org>
Subject: [PATCH v7 1/8] perf cs-etm: Add last instruction information in packet
Date: Tue, 29 Jan 2019 20:28:35 +0800
Message-Id: <20190129122842.32041-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190129122842.32041-1-leo.yan@linaro.org>
References: <20190129122842.32041-1-leo.yan@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_042953_773388_A21C51A3 
X-CRM114-Status: GOOD (  12.77  )
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

Decoder provides last instruction related information, these information
can be used for trace analysis; specifically we can get to know what
kind of branch instruction has been executed, mainly the information
are contained in three element fields:

  last_i_type: this is significant type for waypoint calculation, it
  indicates the last instruction is one of immediate branch instruction,
  indirect branch instruction, instruction barrier (ISB), or data
  barrier (DSB/DMB).

  last_i_subtype: this is used for instruction sub type, it can be
  branch with link, ARMv8 return instruction, ARMv8 eret instruction
  (return from exception), or ARMv7 instruction which could imply
  return (e.g. MOV PC, LR; POP { ,PC}).

  last_instr_cond: it indicates if the last instruction was conditional.

But these three fields are not saved into cs_etm_packet struct, thus
cs-etm layer don't know related information and cannot generate sample
flags for branch instructions.

This patch add corresponding three new fields in cs_etm_packet struct
and save related value into the packet structure, it is preparation for
supporting sample flags.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 9 +++++++++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 8c155575c6c5..8a19310500d9 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -290,6 +290,9 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
 		decoder->packet_buffer[i].instr_count = 0;
 		decoder->packet_buffer[i].last_instr_taken_branch = false;
 		decoder->packet_buffer[i].last_instr_size = 0;
+		decoder->packet_buffer[i].last_instr_type = 0;
+		decoder->packet_buffer[i].last_instr_subtype = 0;
+		decoder->packet_buffer[i].last_instr_cond = 0;
 		decoder->packet_buffer[i].cpu = INT_MIN;
 	}
 }
@@ -323,6 +326,9 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
 	decoder->packet_buffer[et].instr_count = 0;
 	decoder->packet_buffer[et].last_instr_taken_branch = false;
 	decoder->packet_buffer[et].last_instr_size = 0;
+	decoder->packet_buffer[et].last_instr_type = 0;
+	decoder->packet_buffer[et].last_instr_subtype = 0;
+	decoder->packet_buffer[et].last_instr_cond = 0;
 
 	if (decoder->packet_count == MAX_BUFFER - 1)
 		return OCSD_RESP_WAIT;
@@ -366,6 +372,9 @@ cs_etm_decoder__buffer_range(struct cs_etm_decoder *decoder,
 	packet->start_addr = elem->st_addr;
 	packet->end_addr = elem->en_addr;
 	packet->instr_count = elem->num_instr_range;
+	packet->last_instr_type = elem->last_i_type;
+	packet->last_instr_subtype = elem->last_i_subtype;
+	packet->last_instr_cond = elem->last_instr_cond;
 
 	switch (elem->last_i_type) {
 	case OCSD_INSTR_BR:
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index a6407d41598f..7cdd6a9c68a7 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -43,6 +43,9 @@ struct cs_etm_packet {
 	u64 start_addr;
 	u64 end_addr;
 	u32 instr_count;
+	u32 last_instr_type;
+	u32 last_instr_subtype;
+	u8 last_instr_cond;
 	u8 last_instr_taken_branch;
 	u8 last_instr_size;
 	int cpu;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
