Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9341AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:07:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63C2420821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jcnqy2EF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jLsicohe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C2420821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zAdWY/pDCPmhrhVC2O0Gm8tlyC/qNItpi2y6E3kVRLc=; b=Jcnqy2EFkEH/gj
	39D2UOpwDq+W35PnXCZH40CMGPQUR4MxmG9BLBpmc82tg7LvqOoWqrS50i54QvCDwerA8kQr+jD2g
	yJXQKzwgsnQMuxqyBgkljGXoMB0gcFrvMe+W0oLG63F/pGd0qRj4CiMnAkyte6VaH9jC+nWuhljt1
	JB4Bl5vWWqjrExQjYiAhVLOcfQ12QGvVqm4RVpawR4yC+do4qj7tEf6hQZ7t5aTZFZ9zY9yepYFch
	fpp92z+98qL3anQXV6LBk5wwItkOmi/6pyx+gkau74ApFKRUxaGSoqgWXhfGQP3jN83lWkFCZFzXn
	x36PcjOo1z9frCwKjbUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWUeA-0001KV-8q; Mon, 10 Dec 2018 23:07:30 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWUe6-0001Jh-TM
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 23:07:28 +0000
Received: by mail-pl1-x641.google.com with SMTP id gn14so5948167plb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 15:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=KajPpNpOgrL0VO3d60pcbzSZddZYvplWvjJeszmfwf0=;
 b=jLsicohekTzRCFYCxeAjHkMkdau3fy4Q/3gSfIFipECOOf5SQ/Q/a6svw6nOVA6Iuq
 ZXru8IEP9bFNC/fJ67lbnLgLDsgDINbCFX/zEPoE8FVk0JjyoXhH+8h5JLy5NtvZhkhZ
 HPKdEAwV4D1nm9ZsuhwM/RDnkUQF0+ieQv5cY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KajPpNpOgrL0VO3d60pcbzSZddZYvplWvjJeszmfwf0=;
 b=tsunwrQf1bJrxX7+sqGWrjHhIWP3xpf1WfWkzNK15lTO/LIBZGQskfpNkSdpMeZJh7
 vVHFRwOfsQQ+fN508VJdAfHF0fiYHjloOYlgdweGCo/GuEslMV+3LceB2XjyzzEvyrcA
 4YoBL/B+5w6jpg/nXwxSRX5ZUzzRM1oD3XR/UAxo4lEz5xIG7MnEmLGcM2J6fecSloHU
 dk7IvMrXowvbTnyc5o9LbTlsNMIgo9r5PSI01eY9tXAgTqSbF75ea8IDk2+tXJ/Xw7ZW
 LITVfJerXrpySMMMl+/pGdCYfKIxSVC8aj8TzHULz65DKEFh4LDGiYf2MA2FKpFPj7n7
 fYgQ==
X-Gm-Message-State: AA+aEWbeEysYBR1TNTqBSB3M5+FE8hsh87Ymn88Yg4+bKtaHIHzKEB+2
 obt0S79o5UDZD/Irp2q8iJHIxA==
X-Google-Smtp-Source: AFSGD/VXGcYCMcbzMQkGDlH6pGkUj7ZbUPeUvTQg5SxmdDn+xGa32vy2JPXze8KWlyfkn29CFoqKyQ==
X-Received: by 2002:a17:902:4503:: with SMTP id
 m3mr14107347pld.23.1544483236082; 
 Mon, 10 Dec 2018 15:07:16 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id l184sm20203460pfc.112.2018.12.10.15.07.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 15:07:15 -0800 (PST)
Date: Mon, 10 Dec 2018 16:07:13 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v2 6/6] perf cs-etm: Generate branch sample for exception
 packet
Message-ID: <20181210230713.GE12152@xps15>
References: <1544431981-24144-1-git-send-email-leo.yan@linaro.org>
 <1544431981-24144-7-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544431981-24144-7-git-send-email-leo.yan@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_150726_951177_C6CF24BA 
X-CRM114-Status: GOOD (  29.15  )
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
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Coresight ML <coresight@lists.linaro.org>, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Robert Walker <robert.walker@arm.com>, Jiri Olsa <jolsa@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 04:53:01PM +0800, Leo Yan wrote:
> The exception packet appears as one element with 'elem_type' ==
> OCSD_GEN_TRC_ELEM_EXCEPTION or OCSD_GEN_TRC_ELEM_EXCEPTION_RET,
> which present for exception entry and exit respectively.  The decoder
> set packet fields 'packet->exc' and 'packet->exc_ret' to indicate the
> exception packets; but exception packets don't have dedicated sample
> type and shares the same sample type CS_ETM_RANGE with normal
> instruction packets.
> 
> As result, the exception packets are taken as normal instruction packets
> and this introduces confusion to mix different packet types.
> Furthermore, these instruction range packets will be processed for
> branch sample only when 'packet->last_instr_taken_branch' is true,
> otherwise they will be omitted, this can introduce mess for exception
> and exception returning due we don't have complete address range info
> for context switching.
> 
> To process exception packets properly, this patch introduce two new
> sample type: CS_ETM_EXCEPTION and CS_ETM_EXCEPTION_RET; for these two
> kind packets, they will be handled by cs_etm__exception().  The func
> cs_etm__exception() forces to set previous CS_ETM_RANGE packet flag
> 'prev_packet->last_instr_taken_branch' to true, this matches well with
> the program flow when the exception is trapped from user space to kernel
> space, no matter if the most recent flow has branch taken or not; this
> is also safe for returning to user space after exception handling.
> 
> After exception packets have their own sample type, the packet fields
> 'packet->exc' and 'packet->exc_ret' aren't needed anymore, so remove
> them.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Robert Walker <robert.walker@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 26 +++++++++++++++++------
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  4 ++--
>  tools/perf/util/cs-etm.c                        | 28 +++++++++++++++++++++++++
>  3 files changed, 50 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index bcb5c98..6d89d0e 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -291,8 +291,6 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
>  		decoder->packet_buffer[i].instr_count = 0;
>  		decoder->packet_buffer[i].last_instr_taken_branch = false;
>  		decoder->packet_buffer[i].last_instr_size = 0;
> -		decoder->packet_buffer[i].exc = false;
> -		decoder->packet_buffer[i].exc_ret = false;
>  		decoder->packet_buffer[i].cpu = INT_MIN;
>  	}
>  }
> @@ -320,8 +318,6 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
>  
>  	decoder->packet_buffer[et].sample_type = sample_type;
>  	decoder->packet_buffer[et].isa = CS_ETM_ISA_UNKNOWN;
> -	decoder->packet_buffer[et].exc = false;
> -	decoder->packet_buffer[et].exc_ret = false;
>  	decoder->packet_buffer[et].cpu = *((int *)inode->priv);
>  	decoder->packet_buffer[et].start_addr = CS_ETM_INVAL_ADDR;
>  	decoder->packet_buffer[et].end_addr = CS_ETM_INVAL_ADDR;
> @@ -398,6 +394,22 @@ cs_etm_decoder__buffer_discontinuity(struct cs_etm_decoder *decoder,
>  					     CS_ETM_DISCONTINUITY);
>  }
>  
> +static ocsd_datapath_resp_t
> +cs_etm_decoder__buffer_exception(struct cs_etm_decoder *decoder,
> +				 const uint8_t trace_chan_id)
> +{
> +	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> +					     CS_ETM_EXCEPTION);
> +}
> +
> +static ocsd_datapath_resp_t
> +cs_etm_decoder__buffer_exception_ret(struct cs_etm_decoder *decoder,
> +				     const uint8_t trace_chan_id)
> +{
> +	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> +					     CS_ETM_EXCEPTION_RET);
> +}
> +
>  static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>  				const void *context,
>  				const ocsd_trc_index_t indx __maybe_unused,
> @@ -426,10 +438,12 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>  						    trace_chan_id);
>  		break;
>  	case OCSD_GEN_TRC_ELEM_EXCEPTION:
> -		decoder->packet_buffer[decoder->tail].exc = true;
> +		resp = cs_etm_decoder__buffer_exception(decoder,
> +							trace_chan_id);
>  		break;
>  	case OCSD_GEN_TRC_ELEM_EXCEPTION_RET:
> -		decoder->packet_buffer[decoder->tail].exc_ret = true;
> +		resp = cs_etm_decoder__buffer_exception_ret(decoder,
> +							    trace_chan_id);
>  		break;
>  	case OCSD_GEN_TRC_ELEM_PE_CONTEXT:
>  	case OCSD_GEN_TRC_ELEM_ADDR_NACC:
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> index a272317..a6407d4 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> @@ -26,6 +26,8 @@ enum cs_etm_sample_type {
>  	CS_ETM_EMPTY,
>  	CS_ETM_RANGE,
>  	CS_ETM_DISCONTINUITY,
> +	CS_ETM_EXCEPTION,
> +	CS_ETM_EXCEPTION_RET,
>  };
>  
>  enum cs_etm_isa {
> @@ -43,8 +45,6 @@ struct cs_etm_packet {
>  	u32 instr_count;
>  	u8 last_instr_taken_branch;
>  	u8 last_instr_size;
> -	u8 exc;
> -	u8 exc_ret;
>  	int cpu;
>  };
>  
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index cea3158..27a374d 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1000,6 +1000,25 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
>  	return 0;
>  }
>  
> +static int cs_etm__exception(struct cs_etm_queue *etmq)
> +{
> +	/*
> +	 * When the exception packet is inserted, whether the last instruction
> +	 * in previous range packet is taken branch or not, we need to force
> +	 * to set 'prev_packet->last_instr_taken_branch' to true.  This ensures
> +	 * to generate branch sample for the instruction range before the
> +	 * exception is trapped to kernel or before the exception returning.
> +	 *
> +	 * The exception packet includes the dummy address values, so don't
> +	 * swap PACKET with PREV_PACKET.  This keeps PREV_PACKET to be useful
> +	 * for generating instruction and branch samples.
> +	 */
> +	if (etmq->prev_packet->sample_type == CS_ETM_RANGE)
> +		etmq->prev_packet->last_instr_taken_branch = true;
> +
> +	return 0;
> +}
> +
>  static int cs_etm__flush(struct cs_etm_queue *etmq)
>  {
>  	int err = 0;
> @@ -1148,6 +1167,15 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
>  					 */
>  					cs_etm__sample(etmq);
>  					break;
> +				case CS_ETM_EXCEPTION:
> +				case CS_ETM_EXCEPTION_RET:
> +					/*
> +					 * If the exception packet is coming,
> +					 * make sure the previous instruction
> +					 * range packet to be handled properly.
> +					 */
> +					cs_etm__exception(etmq);
> +					break;
>  				case CS_ETM_DISCONTINUITY:
>  					/*
>  					 * Discontinuity in trace, flush
> -- 
> 2.7.4
>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
