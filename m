Return-Path: <SRS0=AzG1=P3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EB3C5AE5E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:44:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84A3620850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IeJ9EBfi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UJR/ZDiL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A3620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=oKhInzoFisXqJfgligl/FKidPmCPpjX7jSxz+Kqi3NE=; b=IeJ9EBfi3lbmNLf2JvchlRb18B
	/yU+3pLaeGdg/XpOVpE5YOREwcdq/7WpXboMdblUdWp07+wZv3dJ9x/lz8xW/g8VtetViZ6rwEA7r
	DqBE/TCMa3VSYH9cSGW30UZS087TVGIowpQuiPND2pV+soVoLtsIwd3z0GlgcWFMhF30nTQgDr+2A
	6g428KLEXL/8DIN3yXa7nQj7VyNJCmOMVUu+31PJvOG2jADR7eSibc3p+SxtnZkKi7sZMO2zXBpGZ
	0NYWvxyGuhVEfLPnlxYxNwv52B/N4g4wO7K/Oe+/b+KwDRcwV89d9XWr/+X/tNZ3Xhy9rTrHbm8wm
	QR/tEAtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkfgP-0001hc-KY; Sat, 19 Jan 2019 01:44:25 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkfgA-0001Sz-KF
 for linux-arm-kernel@lists.infradead.org; Sat, 19 Jan 2019 01:44:17 +0000
Received: by mail-pg1-x542.google.com with SMTP id y4so6850607pgc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 17:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jETu+BduxrzXdBTSoIHDOv28Ri7iXymF5DJaIor1gtI=;
 b=UJR/ZDiLrjsIi9UcHwH4vY5U6Z90QraRTn+RRpSe4uSHbu8vCGNQiDKM6DoVc7aJoU
 9deaQGz1NS/r9W8SPTrMsbninLi8UUuIVDTKQ0/eo21TQ4WaMoF4BdRzhKmdgklUljK/
 ZjkVKboyhwsZShHi77LZBbotd/1pNsLp0lXdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=jETu+BduxrzXdBTSoIHDOv28Ri7iXymF5DJaIor1gtI=;
 b=neGL4L3nnRSIvWbYTHL0jNcuTKbxc5sVLijR49rXINSnSqInTC1vou+JzyfCEpSmwp
 YDx4bithNau2VQrUOQ1v6WL/gaAi9E+AcRIHJSIuhID86B5OBcsSJxMiXte4XZ9s6oXx
 7FhHMcYer8jeenLcLZPC2DV1iP9bR45rUwht1TUx96o1Ph3Xk8o1Gq43ifk0lWXEChce
 XcCJFa780hN10Diht0svoAlbsYylcPQPLz0RfwWqad4gToOPRCSu2QnwVG6mCDGkDnp5
 3yc6kIPsNOdBOXLCRph1Y493xAgYbRGI6kFCa8y0EccrkoC1PntWxdZ5gTRbdRdXbG8V
 OvQg==
X-Gm-Message-State: AJcUukfDBvhCr/nGDwROUBWy9Gov1cXBu8TCNlWXHZuFIs5viQkgnbGs
 +/fE6iq65WL19NRy0wuREueX0Q==
X-Google-Smtp-Source: ALg8bN79tjDtBMZp6UuoXC+x3eva11l1rLyjvJBpSU+Uduh8IjCTpWpfl4YpJtBFLjEuJdIqZ5rqkg==
X-Received: by 2002:a62:6204:: with SMTP id w4mr21762120pfb.5.1547862249054;
 Fri, 18 Jan 2019 17:44:09 -0800 (PST)
Received: from localhost.localdomain (li421-24.members.linode.com.
 [50.116.3.24])
 by smtp.gmail.com with ESMTPSA id d21sm8648436pfo.162.2019.01.18.17.44.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 17:44:08 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Robert Walker <robert.walker@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Coresight ML <coresight@lists.linaro.org>
Subject: [PATCH v6 1/8] perf cs-etm: Add last instruction information in packet
Date: Sat, 19 Jan 2019 09:43:40 +0800
Message-Id: <20190119014347.27441-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190119014347.27441-1-leo.yan@linaro.org>
References: <20190119014347.27441-1-leo.yan@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_174411_108550_FA3D3421 
X-CRM114-Status: GOOD (  12.91  )
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
