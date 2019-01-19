Return-Path: <SRS0=AzG1=P3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B2BC5AE5E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:46:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 992EB20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tYymdANu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XMV6KsRA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992EB20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=zilE+MLtSkVehodzjMf7pVJibLREx1gq4DbEPC8BRSU=; b=tYymdANupl3iHxhdwg3HK4W8oB
	8tBHz697yvu3IVJXg6HdJs8ljyDeEahG/81AZ5T0bXisjl/4Lf5JPQGeddhQ1MopEwv8lI1GinxDN
	eJ7Gtr7+s9zZjFTUclTif9pQPQQW9k3OMvekOGvdy/WV9KrAho+8kw84ytoRVyKW7cNeqniLasutI
	WK1LQdeYjxat+8hJsq9EwTUfdE2Iu+4styJwItzgQeNuCn0cAcBBQDsosxJX2uGNOxN+oehyAmA3O
	4hhswQEVzVvkglbFoRcCq1n5i1chKH02rYoMhPJjrW7IJ6cJL0JyR3qPEDQDk9wL9B7Tl1ZukgbJS
	ghxCLSyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkfiH-0004RD-4c; Sat, 19 Jan 2019 01:46:21 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkfgW-0001oa-62
 for linux-arm-kernel@lists.infradead.org; Sat, 19 Jan 2019 01:44:49 +0000
Received: by mail-pg1-x544.google.com with SMTP id z11so6880846pgu.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 17:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=o1aW2CGhgLBcMWaKcauQr3Shg1QlhxeZRzbbJRZFOWM=;
 b=XMV6KsRAVwwNiIFygSUxuEJEjfFTxYEYRKWJo1A+OrtikQWyXy2FPU4cCy9KtMlX8t
 WCM0//koL8tlXt22zOFIf5XsM1Q3LwGzm99etd3piH3q0PF+GFj5soqmS6GfcxJwSqvg
 X5BmOa7kv9EYniirAnTQYA5uSQkKqNlNu2DiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=o1aW2CGhgLBcMWaKcauQr3Shg1QlhxeZRzbbJRZFOWM=;
 b=ppwJecHW5yXH7PKkiXugJb+vnCGL74u5AZWzk/w+W3DHb8R7qNPZmXtoQIE9WxiAtm
 qdh1IAsdnFocSUQWTiyu/1E3NKE0GK5ZhetEgw/ZUHoz9ZWgBGCwSEb0iyQirtX7uos6
 O1/EoYHRPgGJa2RLXzgJlCN7Aca0GrcjAlppcoPauJ2wPQx63TnxUXPDMEyuCNBvYh61
 x7DKFWvkXLDeAzSrknBPhJsNYO0P11vpoW53kvaxjIQin53PNNKpSbfeXjDL3rkE82UV
 rnuuQH1h4J3va3yg539/+aDuSIvs5Pu4/PBu+tMTIGgcXFxzZA9X3MJqClzPsM0HHFDN
 vgfQ==
X-Gm-Message-State: AJcUukfd6PYzJx47JlyaTcxRZG4VeD5nln6zMQc5eQQwuz+v3JQzu4yy
 6QAsQBOjqJrk+WreawsHW6qOQQ==
X-Google-Smtp-Source: ALg8bN6rReQSrI+kU9XWvlLADrp0I040uNys8Sj0miI33ivv1WHtYKFfY8bgspbxzrYE5BqE6LDIpQ==
X-Received: by 2002:a63:70c:: with SMTP id 12mr19418009pgh.352.1547862271298; 
 Fri, 18 Jan 2019 17:44:31 -0800 (PST)
Received: from localhost.localdomain (li421-24.members.linode.com.
 [50.116.3.24])
 by smtp.gmail.com with ESMTPSA id d21sm8648436pfo.162.2019.01.18.17.44.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 17:44:30 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Robert Walker <robert.walker@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Coresight ML <coresight@lists.linaro.org>
Subject: [PATCH v6 7/8] perf cs-etm: Set sample flags for exception packet
Date: Sat, 19 Jan 2019 09:43:46 +0800
Message-Id: <20190119014347.27441-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190119014347.27441-1-leo.yan@linaro.org>
References: <20190119014347.27441-1-leo.yan@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_174432_888349_9BBA80A8 
X-CRM114-Status: GOOD (  21.22  )
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

The exception taken and returning are typical flow for instruction jump
but it needs to be handled with exception packets. This patch is to set
sample flags for exception packet.

Since the exception packet contains the exception number, according to
the exception number this patch makes decision for belonging to which
exception types.

The decoder have defined different exception number for ETMv3 and ETMv4
separately, hence this patch needs firstly decide the ETM version by
using the metadata magic number, and this patch adds helper function
cs_etm__get_magic() for easily getting magic number.

Based on different ETM version, the exception packet contains the
exception number, according to the exception number this patch makes
decision for the exception belonging to which exception types.

In this patch, it introduces helper function cs_etm__is_svc_instr();
for ETMv4 CS_ETMV4_EXC_CALL covers SVC, SMC and HVC cases in the
single exception number, thus need to use cs_etm__is_svc_instr() to
decide an exception taken for system call.

Reviewed-by: Robert Walker <robert.walker@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 215 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/cs-etm.h |  44 ++++++++
 2 files changed, 259 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index e89989fe0a5c..052805de6513 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -97,6 +97,20 @@ static u32 cs_etm__get_v7_protocol_version(u32 etmidr)
 	return CS_ETM_PROTO_ETMV3;
 }
 
+static int cs_etm__get_magic(u8 trace_chan_id, u64 *magic)
+{
+	struct int_node *inode;
+	u64 *metadata;
+
+	inode = intlist__find(traceid_list, trace_chan_id);
+	if (!inode)
+		return -EINVAL;
+
+	metadata = inode->priv;
+	*magic = metadata[CS_ETM_MAGIC];
+	return 0;
+}
+
 int cs_etm__get_cpu(u8 trace_chan_id, int *cpu)
 {
 	struct int_node *inode;
@@ -1122,10 +1136,174 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq)
 	return 0;
 }
 
+static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq,
+				 struct cs_etm_packet *packet,
+				 u64 end_addr)
+{
+	u16 instr16;
+	u32 instr32;
+	u64 addr;
+
+	switch (packet->isa) {
+	case CS_ETM_ISA_T32:
+		/*
+		 * The SVC of T32 is defined in ARM DDI 0487D.a, F5.1.247:
+		 *
+		 *  b'15         b'8
+		 * +-----------------+--------+
+		 * | 1 1 0 1 1 1 1 1 |  imm8  |
+		 * +-----------------+--------+
+		 *
+		 * According to the specifiction, it only defines SVC for T32
+		 * with 16 bits instruction and has no definition for 32bits;
+		 * so below only read 2 bytes as instruction size for T32.
+		 */
+		addr = end_addr - 2;
+		cs_etm__mem_access(etmq, addr, sizeof(instr16), (u8 *)&instr16);
+		if ((instr16 & 0xFF00) == 0xDF00)
+			return true;
+
+		break;
+	case CS_ETM_ISA_A32:
+		/*
+		 * The SVC of A32 is defined in ARM DDI 0487D.a, F5.1.247:
+		 *
+		 *  b'31 b'28 b'27 b'24
+		 * +---------+---------+-------------------------+
+		 * |  !1111  | 1 1 1 1 |        imm24            |
+		 * +---------+---------+-------------------------+
+		 */
+		addr = end_addr - 4;
+		cs_etm__mem_access(etmq, addr, sizeof(instr32), (u8 *)&instr32);
+		if ((instr32 & 0x0F000000) == 0x0F000000 &&
+		    (instr32 & 0xF0000000) != 0xF0000000)
+			return true;
+
+		break;
+	case CS_ETM_ISA_A64:
+		/*
+		 * The SVC of A64 is defined in ARM DDI 0487D.a, C6.2.294:
+		 *
+		 *  b'31               b'21           b'4     b'0
+		 * +-----------------------+---------+-----------+
+		 * | 1 1 0 1 0 1 0 0 0 0 0 |  imm16  | 0 0 0 0 1 |
+		 * +-----------------------+---------+-----------+
+		 */
+		addr = end_addr - 4;
+		cs_etm__mem_access(etmq, addr, sizeof(instr32), (u8 *)&instr32);
+		if ((instr32 & 0xFFE0001F) == 0xd4000001)
+			return true;
+
+		break;
+	case CS_ETM_ISA_UNKNOWN:
+	default:
+		break;
+	}
+
+	return false;
+}
+
+static bool cs_etm__is_syscall(struct cs_etm_queue *etmq, u64 magic)
+{
+	struct cs_etm_packet *packet = etmq->packet;
+	struct cs_etm_packet *prev_packet = etmq->prev_packet;
+
+	if (magic == __perf_cs_etmv3_magic)
+		if (packet->exception_number == CS_ETMV3_EXC_SVC)
+			return true;
+
+	/*
+	 * ETMv4 exception type CS_ETMV4_EXC_CALL covers SVC, SMC and
+	 * HVC cases; need to check if it's SVC instruction based on
+	 * packet address.
+	 */
+	if (magic == __perf_cs_etmv4_magic) {
+		if (packet->exception_number == CS_ETMV4_EXC_CALL &&
+		    cs_etm__is_svc_instr(etmq, prev_packet,
+					 prev_packet->end_addr))
+			return true;
+	}
+
+	return false;
+}
+
+static bool cs_etm__is_async_exception(struct cs_etm_queue *etmq, u64 magic)
+{
+	struct cs_etm_packet *packet = etmq->packet;
+
+	if (magic == __perf_cs_etmv3_magic)
+		if (packet->exception_number == CS_ETMV3_EXC_DEBUG_HALT ||
+		    packet->exception_number == CS_ETMV3_EXC_ASYNC_DATA_ABORT ||
+		    packet->exception_number == CS_ETMV3_EXC_PE_RESET ||
+		    packet->exception_number == CS_ETMV3_EXC_IRQ ||
+		    packet->exception_number == CS_ETMV3_EXC_FIQ)
+			return true;
+
+	if (magic == __perf_cs_etmv4_magic)
+		if (packet->exception_number == CS_ETMV4_EXC_RESET ||
+		    packet->exception_number == CS_ETMV4_EXC_DEBUG_HALT ||
+		    packet->exception_number == CS_ETMV4_EXC_SYSTEM_ERROR ||
+		    packet->exception_number == CS_ETMV4_EXC_INST_DEBUG ||
+		    packet->exception_number == CS_ETMV4_EXC_DATA_DEBUG ||
+		    packet->exception_number == CS_ETMV4_EXC_IRQ ||
+		    packet->exception_number == CS_ETMV4_EXC_FIQ)
+			return true;
+
+	return false;
+}
+
+static bool cs_etm__is_sync_exception(struct cs_etm_queue *etmq, u64 magic)
+{
+	struct cs_etm_packet *packet = etmq->packet;
+	struct cs_etm_packet *prev_packet = etmq->prev_packet;
+
+	if (magic == __perf_cs_etmv3_magic)
+		if (packet->exception_number == CS_ETMV3_EXC_SMC ||
+		    packet->exception_number == CS_ETMV3_EXC_HYP ||
+		    packet->exception_number == CS_ETMV3_EXC_JAZELLE_THUMBEE ||
+		    packet->exception_number == CS_ETMV3_EXC_UNDEFINED_INSTR ||
+		    packet->exception_number == CS_ETMV3_EXC_PREFETCH_ABORT ||
+		    packet->exception_number == CS_ETMV3_EXC_DATA_FAULT ||
+		    packet->exception_number == CS_ETMV3_EXC_GENERIC)
+			return true;
+
+	if (magic == __perf_cs_etmv4_magic) {
+		if (packet->exception_number == CS_ETMV4_EXC_TRAP ||
+		    packet->exception_number == CS_ETMV4_EXC_ALIGNMENT ||
+		    packet->exception_number == CS_ETMV4_EXC_INST_FAULT ||
+		    packet->exception_number == CS_ETMV4_EXC_DATA_FAULT)
+			return true;
+
+		/*
+		 * For CS_ETMV4_EXC_CALL, except SVC other instructions
+		 * (SMC, HVC) are taken as sync exceptions.
+		 */
+		if (packet->exception_number == CS_ETMV4_EXC_CALL &&
+		    !cs_etm__is_svc_instr(etmq, prev_packet,
+					  prev_packet->end_addr))
+			return true;
+
+		/*
+		 * ETMv4 has 5 bits for exception number; if the numbers
+		 * are in the range ( CS_ETMV4_EXC_FIQ, CS_ETMV4_EXC_END ]
+		 * they are implementation defined exceptions.
+		 *
+		 * For this case, simply take it as sync exception.
+		 */
+		if (packet->exception_number > CS_ETMV4_EXC_FIQ &&
+		    packet->exception_number <= CS_ETMV4_EXC_END)
+			return true;
+	}
+
+	return false;
+}
+
 static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
 {
 	struct cs_etm_packet *packet = etmq->packet;
 	struct cs_etm_packet *prev_packet = etmq->prev_packet;
+	u64 magic;
+	int ret;
 
 	switch (packet->sample_type) {
 	case CS_ETM_RANGE:
@@ -1206,6 +1384,43 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
 					      PERF_IP_FLAG_TRACE_END;
 		break;
 	case CS_ETM_EXCEPTION:
+		ret = cs_etm__get_magic(packet->trace_chan_id, &magic);
+		if (ret)
+			return ret;
+
+		/* The exception is for system call. */
+		if (cs_etm__is_syscall(etmq, magic))
+			packet->flags = PERF_IP_FLAG_BRANCH |
+					PERF_IP_FLAG_CALL |
+					PERF_IP_FLAG_SYSCALLRET;
+		/*
+		 * The exceptions are triggered by external signals from bus,
+		 * interrupt controller, debug module, PE reset or halt.
+		 */
+		else if (cs_etm__is_async_exception(etmq, magic))
+			packet->flags = PERF_IP_FLAG_BRANCH |
+					PERF_IP_FLAG_CALL |
+					PERF_IP_FLAG_ASYNC |
+					PERF_IP_FLAG_INTERRUPT;
+		/*
+		 * Otherwise, exception is caused by trap, instruction &
+		 * data fault, or alignment errors.
+		 */
+		else if (cs_etm__is_sync_exception(etmq, magic))
+			packet->flags = PERF_IP_FLAG_BRANCH |
+					PERF_IP_FLAG_CALL |
+					PERF_IP_FLAG_INTERRUPT;
+
+		/*
+		 * When the exception packet is inserted, since exception
+		 * packet is not used standalone for generating samples
+		 * and it's affiliation to the previous instruction range
+		 * packet; so set previous range packet flags to tell perf
+		 * it is an exception taken branch.
+		 */
+		if (prev_packet->sample_type == CS_ETM_RANGE)
+			prev_packet->flags = packet->flags;
+		break;
 	case CS_ETM_EXCEPTION_RET:
 	case CS_ETM_EMPTY:
 	default:
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 5d70d10f3907..7bd16ea8a62d 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -53,6 +53,50 @@ enum {
 	CS_ETMV4_PRIV_MAX,
 };
 
+/*
+ * ETMv3 exception encoding number:
+ * See Embedded Trace Macrocell spcification (ARM IHI 0014Q)
+ * table 7-12 Encoding of Exception[3:0] for non-ARMv7-M processors.
+ */
+enum {
+	CS_ETMV3_EXC_NONE = 0,
+	CS_ETMV3_EXC_DEBUG_HALT = 1,
+	CS_ETMV3_EXC_SMC = 2,
+	CS_ETMV3_EXC_HYP = 3,
+	CS_ETMV3_EXC_ASYNC_DATA_ABORT = 4,
+	CS_ETMV3_EXC_JAZELLE_THUMBEE = 5,
+	CS_ETMV3_EXC_PE_RESET = 8,
+	CS_ETMV3_EXC_UNDEFINED_INSTR = 9,
+	CS_ETMV3_EXC_SVC = 10,
+	CS_ETMV3_EXC_PREFETCH_ABORT = 11,
+	CS_ETMV3_EXC_DATA_FAULT = 12,
+	CS_ETMV3_EXC_GENERIC = 13,
+	CS_ETMV3_EXC_IRQ = 14,
+	CS_ETMV3_EXC_FIQ = 15,
+};
+
+/*
+ * ETMv4 exception encoding number:
+ * See ARM Embedded Trace Macrocell Architecture Specification (ARM IHI 0064D)
+ * table 6-12 Possible values for the TYPE field in an Exception instruction
+ * trace packet, for ARMv7-A/R and ARMv8-A/R PEs.
+ */
+enum {
+	CS_ETMV4_EXC_RESET = 0,
+	CS_ETMV4_EXC_DEBUG_HALT = 1,
+	CS_ETMV4_EXC_CALL = 2,
+	CS_ETMV4_EXC_TRAP = 3,
+	CS_ETMV4_EXC_SYSTEM_ERROR = 4,
+	CS_ETMV4_EXC_INST_DEBUG = 6,
+	CS_ETMV4_EXC_DATA_DEBUG = 7,
+	CS_ETMV4_EXC_ALIGNMENT = 10,
+	CS_ETMV4_EXC_INST_FAULT = 11,
+	CS_ETMV4_EXC_DATA_FAULT = 12,
+	CS_ETMV4_EXC_IRQ = 14,
+	CS_ETMV4_EXC_FIQ = 15,
+	CS_ETMV4_EXC_END = 31,
+};
+
 /* RB tree for quick conversion between traceID and metadata pointers */
 struct intlist *traceid_list;
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
