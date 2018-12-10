Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9539C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:51:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9849520821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bGbkPQSW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CbspZhJ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9849520821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ljRSFOrwH0N9IaS7SjiibbG3TwmZVTBR8+bIhIO5OTI=; b=bGbkPQSWUCKnRN
	DxNKFANgDdhil4HKP/z9xMfiZMU5C8cJ0tOmi0gKnrAFp2Fn90M8nnnvD7JhwOJs2EKfgI++PwX5b
	TPgPGJL9LNsiRUl0CAdku6zqJHdaYiXwa/AeM1oFwH0bJPQ82rfcC8U6d37m6zugH+R4eir1B6Z9Z
	QIc3l0f72NlCYOYFN07jofhyGczNXFbKO5oCkbYEZx9DgCxAlKz4/Z0QhnNrNWaKRgLbrsEAY3gJS
	lvLC7S80caexdJs5subF1Ianc+4SLNKbbi07fQHgxoWNx+hvufLb2TTS/52kyJaqAjecWeJgiqxJK
	opgrHhiT+IXbhAUYfQbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWUP0-0003NB-2U; Mon, 10 Dec 2018 22:51:50 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWUOw-0003Lq-O2
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 22:51:48 +0000
Received: by mail-pf1-x444.google.com with SMTP id g62so6094253pfd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 14:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=K3zZ2MB2wxzKqc6a540cTp6h6khYOD6gkZKgbHXHJz0=;
 b=CbspZhJ62s/YO1i5o3Q5sH/GadMa+RzZMrc3d78FzV7/1i+om+CCQinmCUtMf3dGL0
 W9b/fDQ4IZn+7NMEIS/3bNMKNgltobfKVDf49D4Ia8FnR6XgyBHmhWTGv3ahNyml0rn2
 OBPIsdk4zgCV6/RBF3rOKm8JxXagTDyc4BiPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=K3zZ2MB2wxzKqc6a540cTp6h6khYOD6gkZKgbHXHJz0=;
 b=iKdzaKFm2aMKY1n8UOXjExGFcRo+duCAlBwNPCYmELT3HiIx3k9pnjQKqrmxhl8ccU
 7z2Wy7I0L7592hQsA83o0cucuYzVvmbUl+S2b+xyPc/Kc5v+bUJtO4VFyY8vtwH88YTA
 OglqU76JSfYPr//R7/lLPZaCd06bXok6Bascj3k9EHJe4uNjSwlZmdiRpKgnECDrh6Kk
 ebGmQtXGzzsdpiPJaNZ489Seo4kDlrEFm8Xvj2wzWtnbO/Z5RgIRKjsV025H9tn+kkQ0
 R+4rLgNxh7wWKhgUBW4pbs7o9UCKCYzDzuuROgBAlxEMQygp1dUPiqQO4oQhN6bojEqO
 zzpg==
X-Gm-Message-State: AA+aEWan9iKMcvuHKJkMO2HVRWsjWENsgZ3sgNwNXb0KS4/qxTWSOhu+
 A2vYc9v5bp5RVxteju4uiflN4Q==
X-Google-Smtp-Source: AFSGD/W+RXXzs8t8P158CQIotdh2tNvy4YP44lJEGs6ilfrZbSAp8Z2a1PaOQQk4V4Pjg2HmiDziNw==
X-Received: by 2002:a63:1904:: with SMTP id z4mr12129827pgl.135.1544482295613; 
 Mon, 10 Dec 2018 14:51:35 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id i193sm24105563pgc.22.2018.12.10.14.51.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 14:51:34 -0800 (PST)
Date: Mon, 10 Dec 2018 15:51:32 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v2 3/6] perf cs-etm: Rename CS_ETM_TRACE_ON to
 CS_ETM_DISCONTINUITY
Message-ID: <20181210225132.GB12152@xps15>
References: <1544431981-24144-1-git-send-email-leo.yan@linaro.org>
 <1544431981-24144-4-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544431981-24144-4-git-send-email-leo.yan@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_145146_785788_83018882 
X-CRM114-Status: GOOD (  27.80  )
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

Hi Leo,

On Mon, Dec 10, 2018 at 04:52:58PM +0800, Leo Yan wrote:
> TRACE_ON element is used at the beginning of trace, it also can be
> appeared in the middle of trace data to indicate discontinuity; for
> example, it's possible to see multiple TRACE_ON elements in the trace
> stream if the trace is being limited by address range filtering.
> 
> Furthermore, except TRACE_ON element is for discontinuity, NO_SYNC and
> EO_TRACE also can be used to indicate discontinuity, though they are
> used for different scenarios for trace is interrupted.
> 
> This patch is to rename sample type CS_ETM_TRACE_ON to
> CS_ETM_DISCONTINUITY, firstly the new name describes more closely the
> purpose of the packet; secondly this is a preparation for other output
> elements which also cause the trace discontinuity thus they can share
> the same one packet type.
> 
> This patch also refactors the enumerations in cs_etm_sample_type by
> converting from bit shifting value to continuous numbers.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Robert Walker <robert.walker@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 10 +++++-----
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  6 +++---
>  tools/perf/util/cs-etm.c                        | 12 ++++++------
>  3 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 0b4c862..a3994f1 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -391,11 +391,11 @@ cs_etm_decoder__buffer_range(struct cs_etm_decoder *decoder,
>  }
>  
>  static ocsd_datapath_resp_t
> -cs_etm_decoder__buffer_trace_on(struct cs_etm_decoder *decoder,
> -				const uint8_t trace_chan_id)
> +cs_etm_decoder__buffer_discontinuity(struct cs_etm_decoder *decoder,
> +					   const uint8_t trace_chan_id)
>  {
>  	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> -					     CS_ETM_TRACE_ON);
> +					     CS_ETM_DISCONTINUITY);
>  }
>  
>  static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
> @@ -414,8 +414,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>  		decoder->trace_on = false;
>  		break;
>  	case OCSD_GEN_TRC_ELEM_TRACE_ON:
> -		resp = cs_etm_decoder__buffer_trace_on(decoder,
> -						       trace_chan_id);
> +		resp = cs_etm_decoder__buffer_discontinuity(decoder,
> +							    trace_chan_id);
>  		decoder->trace_on = true;
>  		break;
>  	case OCSD_GEN_TRC_ELEM_INSTR_RANGE:
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> index b295dd2..a272317 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> @@ -23,9 +23,9 @@ struct cs_etm_buffer {
>  };
>  
>  enum cs_etm_sample_type {
> -	CS_ETM_EMPTY = 0,
> -	CS_ETM_RANGE = 1 << 0,
> -	CS_ETM_TRACE_ON = 1 << 1,
> +	CS_ETM_EMPTY,
> +	CS_ETM_RANGE,
> +	CS_ETM_DISCONTINUITY,
>  };

I'm in agreement with what you're doing in this patch but the above is a
different change and you can't pack it in here.  Just split it off in a separate
patch and everything will be fine.

>  
>  enum cs_etm_isa {
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index ffc4fe5..cea3158 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -562,8 +562,8 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
>  
>  static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
>  {
> -	/* Returns 0 for the CS_ETM_TRACE_ON packet */
> -	if (packet->sample_type == CS_ETM_TRACE_ON)
> +	/* Returns 0 for the CS_ETM_DISCONTINUITY packet */
> +	if (packet->sample_type == CS_ETM_DISCONTINUITY)
>  		return 0;
>  
>  	return packet->start_addr;
> @@ -572,8 +572,8 @@ static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
>  static inline
>  u64 cs_etm__last_executed_instr(const struct cs_etm_packet *packet)
>  {
> -	/* Returns 0 for the CS_ETM_TRACE_ON packet */
> -	if (packet->sample_type == CS_ETM_TRACE_ON)
> +	/* Returns 0 for the CS_ETM_DISCONTINUITY packet */
> +	if (packet->sample_type == CS_ETM_DISCONTINUITY)
>  		return 0;
>  
>  	return packet->end_addr - packet->last_instr_size;
> @@ -972,7 +972,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
>  		bool generate_sample = false;
>  
>  		/* Generate sample for tracing on packet */
> -		if (etmq->prev_packet->sample_type == CS_ETM_TRACE_ON)
> +		if (etmq->prev_packet->sample_type == CS_ETM_DISCONTINUITY)
>  			generate_sample = true;
>  
>  		/* Generate sample for branch taken packet */
> @@ -1148,7 +1148,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
>  					 */
>  					cs_etm__sample(etmq);
>  					break;
> -				case CS_ETM_TRACE_ON:
> +				case CS_ETM_DISCONTINUITY:
>  					/*
>  					 * Discontinuity in trace, flush
>  					 * previous branch stack
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
