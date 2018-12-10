Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B6BC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:53:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77E0520821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EfOO128T";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X6TJCEvg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E0520821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L10vpbhdsAuRJdMO7XQG97pc54r1wGAg4AelArCOtCg=; b=EfOO128T1WAq0a
	iTGADKt1hyuZKYNMKeIq2yRvSJ8scKzOEDTEHn00ySOpSwlMRhHIxk8bmoEoTgU+djNgcqV0uSb0S
	w0PhbZd+jU/rY76v36z3qnCyTWvvH6O+EwHJ53a2QYwrZ3MByjGJAk58Czgm8DM8I0PuI6x5KYZVl
	POqSWLWk5jpZ09bmB0yJzWLhgd2L4erQBdmk08qCg6IVUo9dhCcH9deTewtGqsFQqM/XSIELuuDGp
	Z9I9vMepgDtzNL5FY6W6y6gcp4G2LnrQdkweuFYoqGLu6XKGqvLLvQVPQjYwWKRy9QynyN6hE8YSa
	P4MOmDikhNd0JJACIw9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWUQH-000406-JL; Mon, 10 Dec 2018 22:53:09 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWUQF-0003wC-2A
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 22:53:08 +0000
Received: by mail-pl1-x644.google.com with SMTP id t13so5924321ply.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 14:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=LPg3oUpZHEnWx9O7rTLdZ2aDIdl1EKNxaEX9UC5JeT0=;
 b=X6TJCEvgujaWaoSvbu4e853EtnZzmHzldHliAtmYT+cl0bqttsH5TeaZs/Tzgn7YO5
 +YsM+SSE3eZwc+j9aWXeklWfRd4ZUYoOeggVhrQ4ZSr5AS3DJ1fv4s4a4T6G0p5mI27p
 hnwS86lzkCMlnmAxlCHd8Y3BjoRoL/Xn814VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=LPg3oUpZHEnWx9O7rTLdZ2aDIdl1EKNxaEX9UC5JeT0=;
 b=nxEMGqMc4HQo6XCe6rPBdItE4pHlYLhzHs3XjKOuRPg5YckrC+MBuj02dEW0o7vOLp
 TIRnDC5tecdmnRUF/r4FDnbn/4lxShH0L9WlrU3JSHIEYc1g8Ofgl5lYkyATr2mPwaVR
 CnyWFjYakI9GfrMQUp0WLDXU0AaHv5Q9wS8laiNN6ekTjDcrqBguDoG7FkXLUosGUvTV
 GWalayeB+K2jFpso7lTd6o70h/odgvzqphDU7I2UV+lCiFiE2CVG8Yg5CVAd4wVWucRd
 HcIQ6I0WNTAwNkYRNL59GqjtBdxqX6KK0wAjmpzeyZBjDo8+Qm18HYbVnI9iPa792vSr
 Q6gw==
X-Gm-Message-State: AA+aEWaVzv/wzgujaTKzmMDSzBJnXRHMWUxmoAwiH+tYqV3GeWtK53LZ
 2yGy4YLciNtoL7OrVZ0fEoTXXg==
X-Google-Smtp-Source: AFSGD/WDG7ADSFkKZ50eAzp09duznXizg9DvJvPJoc4x5p9KAc9sQcl4xF1A7qOB2r5AHqrGxHnJIA==
X-Received: by 2002:a17:902:264:: with SMTP id
 91mr13947570plc.108.1544482385151; 
 Mon, 10 Dec 2018 14:53:05 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id q195sm16359249pgq.7.2018.12.10.14.53.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 14:53:04 -0800 (PST)
Date: Mon, 10 Dec 2018 15:53:02 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v2 4/6] perf cs-etm: Treat NO_SYNC element as trace
 discontinuity
Message-ID: <20181210225302.GC12152@xps15>
References: <1544431981-24144-1-git-send-email-leo.yan@linaro.org>
 <1544431981-24144-5-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544431981-24144-5-git-send-email-leo.yan@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_145307_105717_193DAED3 
X-CRM114-Status: GOOD (  19.41  )
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

On Mon, Dec 10, 2018 at 04:52:59PM +0800, Leo Yan wrote:
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
> 
> Though OCSD_GEN_TRC_ELEM_NO_SYNC is different from CS_ETM_TRACE_ON when
> output from the decoder, but both of them indicate the trace data is
> discontinuous; this patch treats OCSD_GEN_TRC_ELEM_NO_SYNC as trace
> discontinuity and generates CS_ETM_DISCONTINUITY packet for it, so
> cs-etm can handle discontinuity for this case, finally it saves the last
> trace data for previous trace block and restart samples for new block.
> 
> Credit to Mike Leach and Robert Walker who made me clear for underlying
> mechanism for NO_SYNC element, Mike also shared with me for detailed
> explanation for why we can treat NO_SYNC and TRACE_ON elements as the
> same, so this commit log reused most of his explanation.

Credit and thank you note such as this one go in the cover letter.  With this
change:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Robert Walker <robert.walker@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index a3994f1..46b67f1 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -411,6 +411,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>  	case OCSD_GEN_TRC_ELEM_UNKNOWN:
>  		break;
>  	case OCSD_GEN_TRC_ELEM_NO_SYNC:
> +		resp = cs_etm_decoder__buffer_discontinuity(decoder,
> +							    trace_chan_id);
>  		decoder->trace_on = false;
>  		break;
>  	case OCSD_GEN_TRC_ELEM_TRACE_ON:
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
