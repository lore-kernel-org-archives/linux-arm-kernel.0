Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE25C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:04:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA8521855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ENDGhV2Y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UpokBVX+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA8521855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Pxb8LAekmZ+AtMP7U6AxG051jvMNNHmHv1R88lTVuTY=; b=ENDGhV2YJCcMGJ
	wd0IkhZhDqDW5jkilBis7uhiATcoUYE0LIc8uZu+tRMwCx513bVRSxjvb6aZeQ2oCIJRMIDpJOxOE
	MjQHKN7V3S5cKRD7RABhdVCyOf2RkRpC9v86GrUvSCueaXKZZzUYlOuQmc7M8fUdE1bjWckxxcUqf
	cX6IjiKsalx1iWfPx+fbftWsJIP3/8SjeqtVcH3A5QjCi/4GKuukm/R+kqwcTyaBin29vqFh20CMT
	2KX5gszqKIkA6vdeZbtuDVHjZGy63mX56e4XyrzLQpsTq2geWlCrzzxSgh+RFWOzylWmKosc9Wg/2
	tjk5pbs7Q5zjRLDi05fQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmPhR-00078T-TT; Wed, 23 Jan 2019 21:04:41 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmPhP-00077n-Ld
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 21:04:41 +0000
Received: by mail-pg1-x542.google.com with SMTP id w6so1622462pgl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 13:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=u2iNqCv7TOhC/4UqBgffEhFyn0TxD69aDUz67Y7wuUQ=;
 b=UpokBVX+S3di5cVpj4vmVr0VO89zxM2F7TEyP2nvow0WIvXu5UIQIQ78SJB1mls57W
 fXXXfwY+Xz3TdZ1pXPeeT/14CRTF9sQQEG+6OqgYQagZJZHgHnwOVS+VP17IkpC9jBub
 AziVjG397BLX2I8E1iCPwKHyrLFv0Erh+os3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=u2iNqCv7TOhC/4UqBgffEhFyn0TxD69aDUz67Y7wuUQ=;
 b=SldeaypkTwdb/e47NyXTSTkuATB9TPzllNw5lKeTVWgtmMa4ifLzv0AqQJGZgg0cSZ
 SLY/i7EhfV4NUP9a+Bh3KESZ4BkiCdPzxsTRqsxPxMT6m3RU9t6ttgurI7sq5maDdlU5
 BSJJ99hndpOU9INlIubA7AoWXPW6xXgycBgupVh+Ah8p5QG4JimMi3wvkJDWlcLQThSP
 iscuTmvrqF84JGfbHH8AwU2bjiiCFP+ONA1UbuEBVDdNjV3uoAOO5N/Y1xhel+CoKEeg
 msaeUC9r6RZzk+GWYrwz9MKm7fIFzkaPBKNxlJLPnWI+bIkquNatDpT4frBHqHpHDfW7
 X92w==
X-Gm-Message-State: AJcUukeWlmNGZdi26UHZ69GK+B78EIT29XJhXdrPa2nRRElewjZXfcgP
 cdLIIXhkRQPy61g2qNOipLKbyw==
X-Google-Smtp-Source: ALg8bN5BBMz4/Mfq982/5yU+ouWDKvlqAZz2NJanW5P1lN5l4I0S/sb3e5bi2HhjZij6PXG3bRzVMQ==
X-Received: by 2002:a63:c64f:: with SMTP id x15mr3378936pgg.16.1548277478810; 
 Wed, 23 Jan 2019 13:04:38 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id j73sm28881726pge.13.2019.01.23.13.04.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 23 Jan 2019 13:04:38 -0800 (PST)
Date: Wed, 23 Jan 2019 14:04:35 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v6 3/8] perf cs-etm: Set sample flags for trace
 discontinuity
Message-ID: <20190123210435.GC620@xps15>
References: <20190119014347.27441-1-leo.yan@linaro.org>
 <20190119014347.27441-4-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190119014347.27441-4-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_130439_705908_85DFA3FA 
X-CRM114-Status: GOOD (  20.09  )
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

On Sat, Jan 19, 2019 at 09:43:42AM +0800, Leo Yan wrote:
> In the middle of trace stream, it might be interrupted thus the trace
> data is not continuous, the trace stream firstly is ended for previous
> trace block and restarted for next block.
> 
> To display related information for showing trace is restarted, this
> patch set sample flags for trace discontinuity:
> 
> - If one discontinuity packet is coming, append flag
>   PERF_IP_FLAG_TRACE_END to the previous packet to indicate the trace
>   has been ended;
> - If one instruction packet is following discontinuity packet, this
>   instruction packet is the first one packet to restarting trace.  So
>   set flag PERF_IP_FLAG_TRACE_START to discontinuity packet, this flag
>   will be used to generate sample when connect with the sequential
>   instruction packet.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index d05cac5295f1..1aa29633ce77 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1111,6 +1111,7 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq)
>  static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
>  {
>  	struct cs_etm_packet *packet = etmq->packet;
> +	struct cs_etm_packet *prev_packet = etmq->prev_packet;
>  
>  	switch (packet->sample_type) {
>  	case CS_ETM_RANGE:
> @@ -1170,8 +1171,26 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
>  		    packet->last_instr_subtype == OCSD_S_INSTR_V8_RET)
>  			packet->flags = PERF_IP_FLAG_BRANCH |
>  					PERF_IP_FLAG_RETURN;
> +
> +		/*
> +		 * Decoder might insert a discontinuity in the middle of
> +		 * instruction packets, fixup prev_packet with flag
> +		 * PERF_IP_FLAG_TRACE_BEGIN to indicate restarting trace.
> +		 */
> +		if (prev_packet->sample_type == CS_ETM_DISCONTINUITY)
> +			prev_packet->flags |= PERF_IP_FLAG_BRANCH |
> +					      PERF_IP_FLAG_TRACE_BEGIN;
>  		break;
>  	case CS_ETM_DISCONTINUITY:
> +		/*
> +		 * The trace is discontinuous, if the previous packet is
> +		 * instruction packet, set flag PERF_IP_FLAG_TRACE_END
> +		 * for previous packet.
> +		 */
> +		if (prev_packet->sample_type == CS_ETM_RANGE)
> +			prev_packet->flags |= PERF_IP_FLAG_BRANCH |
> +					      PERF_IP_FLAG_TRACE_END;
> +		break;
>  	case CS_ETM_EXCEPTION:
>  	case CS_ETM_EXCEPTION_RET:
>  	case CS_ETM_EMPTY:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
