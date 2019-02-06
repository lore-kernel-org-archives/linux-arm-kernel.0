Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0758C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:52:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97E0D206DD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XmKDtf+8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="On2/dhP8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgcghQgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E0D206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k/gTOJpPFT062nZ3kUVwE4HGpQnzVCn+f6j/84Yfl4g=; b=XmKDtf+8W3i44u
	CivN3LHPY3V3TH9zhHXpAI8J3SboehfMRc2n9leXidzd0RBAFj9D1cl/itVuypfERj8Tz6n9GmAno
	zTvoLGppZ3UdjxF3XAqmfzylOhxYd0POUb1oRYrQkL5To70RKZpDfwP1k0SHEvfu4A1ucn8wJ0jaq
	p6EHudCj31CRrL06NYA4PsDE71KIFu3Cu+mdzQGNiQu+Ob3n9oMwtLkQWSp/f3sb1WTa6HbfwTDK7
	SxY0R5gcagXjCVS8T4EthNN93o39ZDwqjN7xqzgFXF+1bPkCQ6QkTdUP6X8vOB42NE5krLdRpDVX3
	1iRkhOiTqwEdokEITtvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grSIv-0006SI-76; Wed, 06 Feb 2019 18:52:13 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grSHy-0005Yu-Mq
 for linux-arm-kernel@bombadil.infradead.org; Wed, 06 Feb 2019 18:51:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f8o8wIjeb0DXa0GeiqIsRRQ29wyEyTVFUXCxh4DM6vE=; b=On2/dhP8yluJjigKdNZ36cRLLR
 a82pDuZ6QaqhQud15oS35lpvWaHcpT28WmYfuKD2xrL/1WBxPUAM+7V9gdot8wsfZ+EX/UGUpWVxC
 LtS0rgs3daCnOEFnnj0qC63j3J0sZXNvrjY/36YWODSH/Mu4DlHZEiq87N4dNKPE8XBHCb+PKImdM
 bAAm4pyXN4UHeLsXaax3BQC4VM7YRw/KVJkMx1hSJDQdKvJwwsulfdMMZR29D8scv1zUJL4gFtno8
 HyCg8ogmtxkJG7qbSz/iRoi21O79K3NKw6cuZULMrQZZau5/2BSJvucAcKKvvhw83NQ0Mf0LmBlSI
 G6WvfNdw==;
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grSHw-0005BM-2J
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 18:51:12 +0000
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 125F8206DD;
 Wed,  6 Feb 2019 18:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549479071;
 bh=DPf6+m4SQ6YL80tHDJ5sakvRWpQ41t/xOw6ARq7RVvw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YgcghQgV5rLpoQYci3DExRdStKbSRvc7AatPj14kKp5XFx7XAqVs6lp3gLWmuia2v
 Wi1+KBFnQZfmUsSdYj6xCzGNflgUyA68+ZZYrru10ZqKQIa+fKlDOxdBikDpWHlq2a
 CdCfyDzL/ezZqdI5e8eO8yJNWZhntqwVi6gVPTZU=
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 36/53] perf cs-etm: Add last instruction information in packet
Date: Wed,  6 Feb 2019 15:48:46 -0300
Message-Id: <20190206184903.24054-37-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_135112_244721_5FBECE4B 
X-CRM114-Status: GOOD (  13.65  )
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

Decoder provides last instruction related information, these information
can be used for trace analysis; specifically we can get to know what
kind of branch instruction has been executed, mainly the information are
contained in three element fields:

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
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: coresight ml <coresight@lists.linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190129122842.32041-2-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
