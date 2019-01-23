Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B7BC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:39:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A221E217D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UhY/lLBV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jhBfmjWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A221E217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WQnW+3IfnPGhoSVkWvcj8RJcPUfS+mY5ZIriVtXrlkI=; b=UhY/lLBV7W5btz
	8gwqB4Rl71iIr7FBoq5iglCJ5gual8EBgWRTB4PdV/Pa9dyXs9+ZF7DkpteBwyNIkrCdk+0lxudTo
	nMWsdktiI+Zaer66MFpkuDQU1A1+W75FZp1RKR21QUoQsXthEBLZMSEp6vejfXuSlMk+aJmheoOjp
	jIuUuHe+mQW5gXhfzEAUN1CYmjY5l1XlFO8bUtq+piD1yx4PiSfE8bqKwlY70ZcLdWhqYYz9eXma9
	8R898I7DYD+BfHDTwzYXHKq9EViHJWxe3W8LP0b8pbzb5ADjfbj6yHPqOrKrjT19jM6ipMOnXWsHH
	bFclGzVQV06x/huP28+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmQEs-0003OF-3f; Wed, 23 Jan 2019 21:39:14 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmQEo-0003No-Rp
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 21:39:13 +0000
Received: by mail-pg1-x541.google.com with SMTP id j10so1675058pga.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 13:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=UpUpCnIEjawET6RM7EmxQ2pQVnxrMDpSdlEm6HRqknE=;
 b=jhBfmjWZl/iJmm4Nc0O+tz2uYfbqrm3Mkxxb7vMSa6YO4/42aW+C0+w3tdzhtZPSGH
 cbD9WGMpZ+cXD6rYeZhHb+40RSTj/5flH6RedN5Py5yWgKkwaCpkyCUUnzgJBUc9dKCB
 ztEKW5pNpizSYai6GjB0+Eus5LSobH46nXf0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=UpUpCnIEjawET6RM7EmxQ2pQVnxrMDpSdlEm6HRqknE=;
 b=k03Eo+oDI+K0Nghusv/hbU9qO6yL8NETlpkE3defWcXjomUNLi5J3iSlXBgm30w1FZ
 OiMiNsFj7v7B9UZHY5zmkLshoqAxUSt3dfYCKZjIEqP2BkCqv+tX9If3c1JqSVcfsrls
 93kmHG7rd7xSWMBH4k+r7RYAAF/Shijnzr/1OKdR7s2Po44CAgAJ5BXB2EOTj06098sj
 zDigAdaLkh3YRmrZCamaGIGH8nzt3n7FL7rR2O+yBJoKgDAj76AzubMiHlXsaLi0FjvG
 m3gyqXohChWieBQ217G+GuSuVbN7HmlWm+Qz6v3GvWx+D6QwQwIbFwXUu75CDUK0RIji
 cDZw==
X-Gm-Message-State: AJcUukcjFWlM1apcMhAW75+EdjOaPuiCtd35Lh+R4nF+GGd7arEXEAts
 OSQRTDtTx3oR8UdVKVgQUhezzA==
X-Google-Smtp-Source: ALg8bN7l+RTolXxe7+EBH08R0JMUFJ/UH9Sk0nUziC5i34H690PySLCFekgqTIQfksgxkqEOzByvGg==
X-Received: by 2002:a62:29c3:: with SMTP id p186mr3792884pfp.117.1548279549629; 
 Wed, 23 Jan 2019 13:39:09 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id 85sm27197626pfw.17.2019.01.23.13.39.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 23 Jan 2019 13:39:08 -0800 (PST)
Date: Wed, 23 Jan 2019 14:39:06 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v6 7/8] perf cs-etm: Set sample flags for exception packet
Message-ID: <20190123213906.GG620@xps15>
References: <20190119014347.27441-1-leo.yan@linaro.org>
 <20190119014347.27441-8-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190119014347.27441-8-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_133910_985580_C1EADCFD 
X-CRM114-Status: GOOD (  31.47  )
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
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Coresight ML <coresight@lists.linaro.org>, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Robert Walker <robert.walker@arm.com>, Jiri Olsa <jolsa@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Jan 19, 2019 at 09:43:46AM +0800, Leo Yan wrote:
> The exception taken and returning are typical flow for instruction jump
> but it needs to be handled with exception packets. This patch is to set
> sample flags for exception packet.
> 
> Since the exception packet contains the exception number, according to
> the exception number this patch makes decision for belonging to which
> exception types.
> 
> The decoder have defined different exception number for ETMv3 and ETMv4
> separately, hence this patch needs firstly decide the ETM version by
> using the metadata magic number, and this patch adds helper function
> cs_etm__get_magic() for easily getting magic number.
> 
> Based on different ETM version, the exception packet contains the
> exception number, according to the exception number this patch makes
> decision for the exception belonging to which exception types.
> 
> In this patch, it introduces helper function cs_etm__is_svc_instr();
> for ETMv4 CS_ETMV4_EXC_CALL covers SVC, SMC and HVC cases in the
> single exception number, thus need to use cs_etm__is_svc_instr() to
> decide an exception taken for system call.
> 
> Reviewed-by: Robert Walker <robert.walker@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

This is the other way around, i.e you wrote the code and then Robert reviewed
it.  With this change:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> ---
>  tools/perf/util/cs-etm.c | 215 +++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/cs-etm.h |  44 ++++++++
>  2 files changed, 259 insertions(+)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index e89989fe0a5c..052805de6513 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -97,6 +97,20 @@ static u32 cs_etm__get_v7_protocol_version(u32 etmidr)
>  	return CS_ETM_PROTO_ETMV3;
>  }
>  
> +static int cs_etm__get_magic(u8 trace_chan_id, u64 *magic)
> +{
> +	struct int_node *inode;
> +	u64 *metadata;
> +
> +	inode = intlist__find(traceid_list, trace_chan_id);
> +	if (!inode)
> +		return -EINVAL;
> +
> +	metadata = inode->priv;
> +	*magic = metadata[CS_ETM_MAGIC];
> +	return 0;
> +}
> +
>  int cs_etm__get_cpu(u8 trace_chan_id, int *cpu)
>  {
>  	struct int_node *inode;
> @@ -1122,10 +1136,174 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq)
>  	return 0;
>  }
>  
> +static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq,
> +				 struct cs_etm_packet *packet,
> +				 u64 end_addr)
> +{
> +	u16 instr16;
> +	u32 instr32;
> +	u64 addr;
> +
> +	switch (packet->isa) {
> +	case CS_ETM_ISA_T32:
> +		/*
> +		 * The SVC of T32 is defined in ARM DDI 0487D.a, F5.1.247:
> +		 *
> +		 *  b'15         b'8
> +		 * +-----------------+--------+
> +		 * | 1 1 0 1 1 1 1 1 |  imm8  |
> +		 * +-----------------+--------+
> +		 *
> +		 * According to the specifiction, it only defines SVC for T32
> +		 * with 16 bits instruction and has no definition for 32bits;
> +		 * so below only read 2 bytes as instruction size for T32.
> +		 */
> +		addr = end_addr - 2;
> +		cs_etm__mem_access(etmq, addr, sizeof(instr16), (u8 *)&instr16);
> +		if ((instr16 & 0xFF00) == 0xDF00)
> +			return true;
> +
> +		break;
> +	case CS_ETM_ISA_A32:
> +		/*
> +		 * The SVC of A32 is defined in ARM DDI 0487D.a, F5.1.247:
> +		 *
> +		 *  b'31 b'28 b'27 b'24
> +		 * +---------+---------+-------------------------+
> +		 * |  !1111  | 1 1 1 1 |        imm24            |
> +		 * +---------+---------+-------------------------+
> +		 */
> +		addr = end_addr - 4;
> +		cs_etm__mem_access(etmq, addr, sizeof(instr32), (u8 *)&instr32);
> +		if ((instr32 & 0x0F000000) == 0x0F000000 &&
> +		    (instr32 & 0xF0000000) != 0xF0000000)
> +			return true;
> +
> +		break;
> +	case CS_ETM_ISA_A64:
> +		/*
> +		 * The SVC of A64 is defined in ARM DDI 0487D.a, C6.2.294:
> +		 *
> +		 *  b'31               b'21           b'4     b'0
> +		 * +-----------------------+---------+-----------+
> +		 * | 1 1 0 1 0 1 0 0 0 0 0 |  imm16  | 0 0 0 0 1 |
> +		 * +-----------------------+---------+-----------+
> +		 */
> +		addr = end_addr - 4;
> +		cs_etm__mem_access(etmq, addr, sizeof(instr32), (u8 *)&instr32);
> +		if ((instr32 & 0xFFE0001F) == 0xd4000001)
> +			return true;
> +
> +		break;
> +	case CS_ETM_ISA_UNKNOWN:
> +	default:
> +		break;
> +	}
> +
> +	return false;
> +}
> +
> +static bool cs_etm__is_syscall(struct cs_etm_queue *etmq, u64 magic)
> +{
> +	struct cs_etm_packet *packet = etmq->packet;
> +	struct cs_etm_packet *prev_packet = etmq->prev_packet;
> +
> +	if (magic == __perf_cs_etmv3_magic)
> +		if (packet->exception_number == CS_ETMV3_EXC_SVC)
> +			return true;
> +
> +	/*
> +	 * ETMv4 exception type CS_ETMV4_EXC_CALL covers SVC, SMC and
> +	 * HVC cases; need to check if it's SVC instruction based on
> +	 * packet address.
> +	 */
> +	if (magic == __perf_cs_etmv4_magic) {
> +		if (packet->exception_number == CS_ETMV4_EXC_CALL &&
> +		    cs_etm__is_svc_instr(etmq, prev_packet,
> +					 prev_packet->end_addr))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool cs_etm__is_async_exception(struct cs_etm_queue *etmq, u64 magic)
> +{
> +	struct cs_etm_packet *packet = etmq->packet;
> +
> +	if (magic == __perf_cs_etmv3_magic)
> +		if (packet->exception_number == CS_ETMV3_EXC_DEBUG_HALT ||
> +		    packet->exception_number == CS_ETMV3_EXC_ASYNC_DATA_ABORT ||
> +		    packet->exception_number == CS_ETMV3_EXC_PE_RESET ||
> +		    packet->exception_number == CS_ETMV3_EXC_IRQ ||
> +		    packet->exception_number == CS_ETMV3_EXC_FIQ)
> +			return true;
> +
> +	if (magic == __perf_cs_etmv4_magic)
> +		if (packet->exception_number == CS_ETMV4_EXC_RESET ||
> +		    packet->exception_number == CS_ETMV4_EXC_DEBUG_HALT ||
> +		    packet->exception_number == CS_ETMV4_EXC_SYSTEM_ERROR ||
> +		    packet->exception_number == CS_ETMV4_EXC_INST_DEBUG ||
> +		    packet->exception_number == CS_ETMV4_EXC_DATA_DEBUG ||
> +		    packet->exception_number == CS_ETMV4_EXC_IRQ ||
> +		    packet->exception_number == CS_ETMV4_EXC_FIQ)
> +			return true;
> +
> +	return false;
> +}
> +
> +static bool cs_etm__is_sync_exception(struct cs_etm_queue *etmq, u64 magic)
> +{
> +	struct cs_etm_packet *packet = etmq->packet;
> +	struct cs_etm_packet *prev_packet = etmq->prev_packet;
> +
> +	if (magic == __perf_cs_etmv3_magic)
> +		if (packet->exception_number == CS_ETMV3_EXC_SMC ||
> +		    packet->exception_number == CS_ETMV3_EXC_HYP ||
> +		    packet->exception_number == CS_ETMV3_EXC_JAZELLE_THUMBEE ||
> +		    packet->exception_number == CS_ETMV3_EXC_UNDEFINED_INSTR ||
> +		    packet->exception_number == CS_ETMV3_EXC_PREFETCH_ABORT ||
> +		    packet->exception_number == CS_ETMV3_EXC_DATA_FAULT ||
> +		    packet->exception_number == CS_ETMV3_EXC_GENERIC)
> +			return true;
> +
> +	if (magic == __perf_cs_etmv4_magic) {
> +		if (packet->exception_number == CS_ETMV4_EXC_TRAP ||
> +		    packet->exception_number == CS_ETMV4_EXC_ALIGNMENT ||
> +		    packet->exception_number == CS_ETMV4_EXC_INST_FAULT ||
> +		    packet->exception_number == CS_ETMV4_EXC_DATA_FAULT)
> +			return true;
> +
> +		/*
> +		 * For CS_ETMV4_EXC_CALL, except SVC other instructions
> +		 * (SMC, HVC) are taken as sync exceptions.
> +		 */
> +		if (packet->exception_number == CS_ETMV4_EXC_CALL &&
> +		    !cs_etm__is_svc_instr(etmq, prev_packet,
> +					  prev_packet->end_addr))
> +			return true;
> +
> +		/*
> +		 * ETMv4 has 5 bits for exception number; if the numbers
> +		 * are in the range ( CS_ETMV4_EXC_FIQ, CS_ETMV4_EXC_END ]
> +		 * they are implementation defined exceptions.
> +		 *
> +		 * For this case, simply take it as sync exception.
> +		 */
> +		if (packet->exception_number > CS_ETMV4_EXC_FIQ &&
> +		    packet->exception_number <= CS_ETMV4_EXC_END)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
>  {
>  	struct cs_etm_packet *packet = etmq->packet;
>  	struct cs_etm_packet *prev_packet = etmq->prev_packet;
> +	u64 magic;
> +	int ret;
>  
>  	switch (packet->sample_type) {
>  	case CS_ETM_RANGE:
> @@ -1206,6 +1384,43 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
>  					      PERF_IP_FLAG_TRACE_END;
>  		break;
>  	case CS_ETM_EXCEPTION:
> +		ret = cs_etm__get_magic(packet->trace_chan_id, &magic);
> +		if (ret)
> +			return ret;
> +
> +		/* The exception is for system call. */
> +		if (cs_etm__is_syscall(etmq, magic))
> +			packet->flags = PERF_IP_FLAG_BRANCH |
> +					PERF_IP_FLAG_CALL |
> +					PERF_IP_FLAG_SYSCALLRET;
> +		/*
> +		 * The exceptions are triggered by external signals from bus,
> +		 * interrupt controller, debug module, PE reset or halt.
> +		 */
> +		else if (cs_etm__is_async_exception(etmq, magic))
> +			packet->flags = PERF_IP_FLAG_BRANCH |
> +					PERF_IP_FLAG_CALL |
> +					PERF_IP_FLAG_ASYNC |
> +					PERF_IP_FLAG_INTERRUPT;
> +		/*
> +		 * Otherwise, exception is caused by trap, instruction &
> +		 * data fault, or alignment errors.
> +		 */
> +		else if (cs_etm__is_sync_exception(etmq, magic))
> +			packet->flags = PERF_IP_FLAG_BRANCH |
> +					PERF_IP_FLAG_CALL |
> +					PERF_IP_FLAG_INTERRUPT;
> +
> +		/*
> +		 * When the exception packet is inserted, since exception
> +		 * packet is not used standalone for generating samples
> +		 * and it's affiliation to the previous instruction range
> +		 * packet; so set previous range packet flags to tell perf
> +		 * it is an exception taken branch.
> +		 */
> +		if (prev_packet->sample_type == CS_ETM_RANGE)
> +			prev_packet->flags = packet->flags;
> +		break;
>  	case CS_ETM_EXCEPTION_RET:
>  	case CS_ETM_EMPTY:
>  	default:
> diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> index 5d70d10f3907..7bd16ea8a62d 100644
> --- a/tools/perf/util/cs-etm.h
> +++ b/tools/perf/util/cs-etm.h
> @@ -53,6 +53,50 @@ enum {
>  	CS_ETMV4_PRIV_MAX,
>  };
>  
> +/*
> + * ETMv3 exception encoding number:
> + * See Embedded Trace Macrocell spcification (ARM IHI 0014Q)
> + * table 7-12 Encoding of Exception[3:0] for non-ARMv7-M processors.
> + */
> +enum {
> +	CS_ETMV3_EXC_NONE = 0,
> +	CS_ETMV3_EXC_DEBUG_HALT = 1,
> +	CS_ETMV3_EXC_SMC = 2,
> +	CS_ETMV3_EXC_HYP = 3,
> +	CS_ETMV3_EXC_ASYNC_DATA_ABORT = 4,
> +	CS_ETMV3_EXC_JAZELLE_THUMBEE = 5,
> +	CS_ETMV3_EXC_PE_RESET = 8,
> +	CS_ETMV3_EXC_UNDEFINED_INSTR = 9,
> +	CS_ETMV3_EXC_SVC = 10,
> +	CS_ETMV3_EXC_PREFETCH_ABORT = 11,
> +	CS_ETMV3_EXC_DATA_FAULT = 12,
> +	CS_ETMV3_EXC_GENERIC = 13,
> +	CS_ETMV3_EXC_IRQ = 14,
> +	CS_ETMV3_EXC_FIQ = 15,
> +};
> +
> +/*
> + * ETMv4 exception encoding number:
> + * See ARM Embedded Trace Macrocell Architecture Specification (ARM IHI 0064D)
> + * table 6-12 Possible values for the TYPE field in an Exception instruction
> + * trace packet, for ARMv7-A/R and ARMv8-A/R PEs.
> + */
> +enum {
> +	CS_ETMV4_EXC_RESET = 0,
> +	CS_ETMV4_EXC_DEBUG_HALT = 1,
> +	CS_ETMV4_EXC_CALL = 2,
> +	CS_ETMV4_EXC_TRAP = 3,
> +	CS_ETMV4_EXC_SYSTEM_ERROR = 4,
> +	CS_ETMV4_EXC_INST_DEBUG = 6,
> +	CS_ETMV4_EXC_DATA_DEBUG = 7,
> +	CS_ETMV4_EXC_ALIGNMENT = 10,
> +	CS_ETMV4_EXC_INST_FAULT = 11,
> +	CS_ETMV4_EXC_DATA_FAULT = 12,
> +	CS_ETMV4_EXC_IRQ = 14,
> +	CS_ETMV4_EXC_FIQ = 15,
> +	CS_ETMV4_EXC_END = 31,
> +};
> +
>  /* RB tree for quick conversion between traceID and metadata pointers */
>  struct intlist *traceid_list;
>  
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
