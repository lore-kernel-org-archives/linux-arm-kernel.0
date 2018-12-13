Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79532C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:39:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2546C20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AM5Ed5/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2546C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q3YbvVwzx7u7D/rpbS+Qk1rwnr8aJnV9yl5uJQfvPUI=; b=AM5Ed5/sMuuJ+Q
	/ist7eDs5QsCEwtT3vhRbRRVu0l5pqeKqU8waoArQjlVdoVu+Adp2nFhCvanOe48NAziZ5ETWyuZH
	s9dUTzEqn6NXmcSakoGmSTs0/10KqcTCn/AI0R3xyy8KgMatk0pWTgwbkukHhGQyTHWwRbFrm5XW8
	biJRdlURBL+JUlTQm+HUhYfUZ5RpuCh6srTpuH8SItQGfTVxvjZ1ilzZdEqCEL8yQZgmQ9Tf7TAks
	wIpj+aduhdIvSiA/yhwdmTZC9FNwFwnSizQQX/5KdxBkD5wkgVXwh0bN6N65ZFxzLzTQPdNNYlQEa
	qiSA0UEfceW5SNR7PuEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXQGZ-0003tT-JQ; Thu, 13 Dec 2018 12:38:59 +0000
Received: from [190.15.121.82] (helo=quaco.ghostprotocols.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQGX-0003ph-Af
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 12:38:57 +0000
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
 id 7AA2241B1D; Thu, 13 Dec 2018 09:38:54 -0300 (-03)
Date: Thu, 13 Dec 2018 09:38:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v3 6/8] perf cs-etm: Treat NO_SYNC element as trace
 discontinuity
Message-ID: <20181213123854.GE21027@kernel.org>
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
 <1544513908-16805-7-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544513908-16805-7-git-send-email-leo.yan@linaro.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Coresight ML <coresight@lists.linaro.org>, linux-kernel@vger.kernel.org,
 Namhyung Kim <namhyung@kernel.org>, Robert Walker <robert.walker@arm.com>,
 Jiri Olsa <jolsa@redhat.com>, linux-arm-kernel@lists.infradead.org,
 Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Em Tue, Dec 11, 2018 at 03:38:26PM +0800, Leo Yan escreveu:
> CoreSight tracer driver might insert barrier packet between different
> buffers, thus the decoder can spot the boundaries based on the barrier
> packet; the decoder is possible to hit a barrier packet and emit a
> NO_SYNC element, then the decoder will find a periodic synchronisation
> point inside that next trace block that starts trace again but does not
> have the TRACE_ON element as indicator - usually because this block of
> trace has wrapped the buffer so we have lost the original point that
> trace was enabled.
> 
> In upper case, it results in the trace stream only inserts the
> OCSD_GEN_TRC_ELEM_NO_SYNC element in the middle of tracing stream, but
> we don't handle NO_SYNC element properly and at the end users miss to
> see the info for trace discontinuity.


"In upper case"? Maybe:

In the former case it causes the insertion of a OCSD_GEN_TRC_ELEM_NO_SYNC
in the middle of the the tracing stream, but as we were npt handling the
NO_SYNC element properly which ends up making users miss the
discontinuity indication"?


> Though OCSD_GEN_TRC_ELEM_NO_SYNC is different from CS_ETM_TRACE_ON when
> output from the decoder, but both of them indicate the trace data is

can we remove the "but" and "of them" (redundant) above?

> discontinuous; this patch treats OCSD_GEN_TRC_ELEM_NO_SYNC as trace
                                                               a
> discontinuity and generates CS_ETM_DISCONTINUITY packet for it, so
> cs-etm can handle discontinuity for this case, finally it saves the last
                       it (way too many "discontinuity")
> trace data for previous trace block and restart samples for new block.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Robert Walker <robert.walker@arm.com>
> ---
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 1039f364..bee026e 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -410,7 +410,6 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>  	case OCSD_GEN_TRC_ELEM_UNKNOWN:
>  		break;
>  	case OCSD_GEN_TRC_ELEM_NO_SYNC:
> -		break;
>  	case OCSD_GEN_TRC_ELEM_TRACE_ON:
>  		resp = cs_etm_decoder__buffer_discontinuity(decoder,
>  							    trace_chan_id);
> -- 
> 2.7.4

-- 

- Arnaldo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
