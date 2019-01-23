Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B79C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:04:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F3B21855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kStkRuE6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jciz0uSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F3B21855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NvDaFE+Ph7edqftxmAevXXcpe8nZ854BEUar5ZpDln0=; b=kStkRuE6HEP6lU
	POmhQHYxE0efTuXTITjlHUnz/0Yfeqh3d92VPoJ0o0mwKvflMruzw0R/QVezVQYk9YpqoOLgkAiMq
	0G6KUcDOkedvbJHTVbYGKBlwp2640luKULi08DKQ/I76BF2Zq2s5O8MdqZFBPrPM/z80TsRePCCG/
	ObkpBI9rsYeglgNswPjyqiGwl1kCVx6UkIkozvLRc6uaMVEZhcFTD4WzVsstFSbWV28TVtbcbTUh3
	jH2SpJqcTPOVsZstCZYxVhQFpYcqNB5u7iL2gBo95Z0tBUWn0NX7xa5h9BnK2nEauzOrFnGHlkWNf
	qVxOJeyQ+d/K8mgtdRUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmPgn-0006qe-Ur; Wed, 23 Jan 2019 21:04:01 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmPgd-0006nO-VM
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 21:03:56 +0000
Received: by mail-pl1-x644.google.com with SMTP id t13so1753544ply.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 13:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Km16XOLOk0b9T+WFAM5r4R4yphRKA7dHNgFoPKbuaUE=;
 b=jciz0uSX4lgjhXhhG3QKHK7y6eMhDanMRkrvfwh0XsEO4vsFKi+naOcd+SogqlMQ78
 vPM5ERRk4vn+IB0hlF5bnRnDUBY41AsoN9qPvSNReF1LM+zjMo28ZH67F1Jx2+4tUrUQ
 /DvD5pwQSSaJCZ/987sbOLXhlXEiS4HvjIQzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Km16XOLOk0b9T+WFAM5r4R4yphRKA7dHNgFoPKbuaUE=;
 b=GZR7AB+nmfnLDOK7xKOe4tjeFh9Pl09KTQyw5kNMhFLrXlLFPNFC31VGJRunuIfdVM
 k05D99HAeoevfEe2UDsMKv4Efgu13BuVfQ2vFkznzvI6g8YdgcxvQYa6vAMkXuLuYiR/
 1HeBXHoZk1wTMKbQDMBHFvqMosFEG3hhL49z+xOm+JfZvu/XBmaqSnAjII11NyWwAORq
 0Su/ldrXWb137vslwkgAzQF/CTxdZLJXgGSR8PkzdQK21Oq3sZhBFwvFHwSsYk3s8PGL
 kW252PWqeVvOqVIm9smHGeGW/1ln71qbXo+RfArDtzQiLyFqu5tnDg+nKL5f5I6pswDj
 4n2A==
X-Gm-Message-State: AJcUukdR7sCL6mRCLIX5X0oacc3o1NC95PiVqLg+0Mixsyz56B+hYMWK
 mRplffoSkh1NLZcaxlGfelG2yA==
X-Google-Smtp-Source: ALg8bN5561dG4WerG9DX4uMfpsjmRUl8MGKN7doORbyFjGjPGDGYqTBVJdgPXuo0IoO4cuN07QTybw==
X-Received: by 2002:a17:902:4222:: with SMTP id
 g31mr3838681pld.240.1548277431421; 
 Wed, 23 Jan 2019 13:03:51 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id g15sm81104640pfj.131.2019.01.23.13.03.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 23 Jan 2019 13:03:50 -0800 (PST)
Date: Wed, 23 Jan 2019 14:03:48 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v6 2/8] perf cs-etm: Set sample flags for instruction
 range packet
Message-ID: <20190123210348.GB620@xps15>
References: <20190119014347.27441-1-leo.yan@linaro.org>
 <20190119014347.27441-3-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190119014347.27441-3-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_130352_230666_E5D5FCFC 
X-CRM114-Status: GOOD (  24.37  )
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

On Sat, Jan 19, 2019 at 09:43:41AM +0800, Leo Yan wrote:
> The perf sample data contains flags to indicate the hardware trace data
> is belonging to which type branch instruction, thus this can be used to
> print out the human readable string.  Arm CoreSight ETM sample data is
> missed to set flags and it is always set to zeros, this results in perf
> tool skips to print string for instruction types.
> 
> This patch is to set branch instruction flags for instruction range
> packet.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  2 +
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  1 +
>  tools/perf/util/cs-etm.c                      | 90 ++++++++++++++++++-
>  3 files changed, 91 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 8a19310500d9..e98ee49a1527 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -293,6 +293,7 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
>  		decoder->packet_buffer[i].last_instr_type = 0;
>  		decoder->packet_buffer[i].last_instr_subtype = 0;
>  		decoder->packet_buffer[i].last_instr_cond = 0;
> +		decoder->packet_buffer[i].flags = 0;
>  		decoder->packet_buffer[i].cpu = INT_MIN;
>  	}
>  }
> @@ -329,6 +330,7 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
>  	decoder->packet_buffer[et].last_instr_type = 0;
>  	decoder->packet_buffer[et].last_instr_subtype = 0;
>  	decoder->packet_buffer[et].last_instr_cond = 0;
> +	decoder->packet_buffer[et].flags = 0;
>  
>  	if (decoder->packet_count == MAX_BUFFER - 1)
>  		return OCSD_RESP_WAIT;
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> index 7cdd6a9c68a7..23600e57a215 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> @@ -45,6 +45,7 @@ struct cs_etm_packet {
>  	u32 instr_count;
>  	u32 last_instr_type;
>  	u32 last_instr_subtype;
> +	u32 flags;
>  	u8 last_instr_cond;
>  	u8 last_instr_taken_branch;
>  	u8 last_instr_size;
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 27a374ddf661..d05cac5295f1 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -12,6 +12,7 @@
>  #include <linux/log2.h>
>  #include <linux/types.h>
>  
> +#include <opencsd/ocsd_if_types.h>
>  #include <stdlib.h>
>  
>  #include "auxtrace.h"
> @@ -719,7 +720,7 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>  	sample.stream_id = etmq->etm->instructions_id;
>  	sample.period = period;
>  	sample.cpu = etmq->packet->cpu;
> -	sample.flags = 0;
> +	sample.flags = etmq->prev_packet->flags;
>  	sample.insn_len = 1;
>  	sample.cpumode = event->sample.header.misc;
>  
> @@ -778,7 +779,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq)
>  	sample.stream_id = etmq->etm->branches_id;
>  	sample.period = 1;
>  	sample.cpu = etmq->packet->cpu;
> -	sample.flags = 0;
> +	sample.flags = etmq->prev_packet->flags;
>  	sample.cpumode = event->sample.header.misc;
>  
>  	/*
> @@ -1107,6 +1108,80 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq)
>  	return 0;
>  }
>  
> +static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
> +{
> +	struct cs_etm_packet *packet = etmq->packet;
> +
> +	switch (packet->sample_type) {
> +	case CS_ETM_RANGE:
> +		/*
> +		 * Immediate branch instruction without neither link nor
> +		 * return flag, it's normal branch instruction within
> +		 * the function.
> +		 */
> +		if (packet->last_instr_type == OCSD_INSTR_BR &&
> +		    packet->last_instr_subtype == OCSD_S_INSTR_NONE) {
> +			packet->flags = PERF_IP_FLAG_BRANCH;
> +
> +			if (packet->last_instr_cond)
> +				packet->flags |= PERF_IP_FLAG_CONDITIONAL;
> +		}
> +
> +		/*
> +		 * Immediate branch instruction with link (e.g. BL), this is
> +		 * branch instruction for function call.
> +		 */
> +		if (packet->last_instr_type == OCSD_INSTR_BR &&
> +		    packet->last_instr_subtype == OCSD_S_INSTR_BR_LINK)
> +			packet->flags = PERF_IP_FLAG_BRANCH |
> +					PERF_IP_FLAG_CALL;
> +
> +		/*
> +		 * Indirect branch instruction with link (e.g. BLR), this is
> +		 * branch instruction for function call.
> +		 */
> +		if (packet->last_instr_type == OCSD_INSTR_BR_INDIRECT &&
> +		    packet->last_instr_subtype == OCSD_S_INSTR_BR_LINK)
> +			packet->flags = PERF_IP_FLAG_BRANCH |
> +					PERF_IP_FLAG_CALL;
> +
> +		/*
> +		 * Indirect branch instruction with subtype of
> +		 * OCSD_S_INSTR_V7_IMPLIED_RET, this is explicit hint for
> +		 * function return for A32/T32.
> +		 */
> +		if (packet->last_instr_type == OCSD_INSTR_BR_INDIRECT &&
> +		    packet->last_instr_subtype == OCSD_S_INSTR_V7_IMPLIED_RET)
> +			packet->flags = PERF_IP_FLAG_BRANCH |
> +					PERF_IP_FLAG_RETURN;
> +
> +		/*
> +		 * Indirect branch instruction without link (e.g. BR), usually
> +		 * this is used for function return, especially for functions
> +		 * within dynamic link lib.
> +		 */
> +		if (packet->last_instr_type == OCSD_INSTR_BR_INDIRECT &&
> +		    packet->last_instr_subtype == OCSD_S_INSTR_NONE)
> +			packet->flags = PERF_IP_FLAG_BRANCH |
> +					PERF_IP_FLAG_RETURN;
> +
> +		/* Return instruction for function return. */
> +		if (packet->last_instr_type == OCSD_INSTR_BR_INDIRECT &&
> +		    packet->last_instr_subtype == OCSD_S_INSTR_V8_RET)
> +			packet->flags = PERF_IP_FLAG_BRANCH |
> +					PERF_IP_FLAG_RETURN;
> +		break;
> +	case CS_ETM_DISCONTINUITY:
> +	case CS_ETM_EXCEPTION:
> +	case CS_ETM_EXCEPTION_RET:
> +	case CS_ETM_EMPTY:
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
>  static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
>  {
>  	struct cs_etm_auxtrace *etm = etmq->etm;
> @@ -1158,6 +1233,17 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
>  					 */
>  					break;
>  
> +				/*
> +				 * Since packet addresses are swapped in packet
> +				 * handling within below switch() statements,
> +				 * thus setting sample flags must be called
> +				 * prior to switch() statement to use address
> +				 * information before packets swapping.
> +				 */
> +				err = cs_etm__set_sample_flags(etmq);
> +				if (err < 0)
> +					break;
> +
>  				switch (etmq->packet->sample_type) {
>  				case CS_ETM_RANGE:
>  					/*

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
