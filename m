Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0F2C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:10:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC7D020849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YJi7y7Iy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DwgYHu3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7D020849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0HlhEEfVLNL1XnZO7YQZAEb+eAGXrTw2bxRh0yOXKxk=; b=YJi7y7IyTdNj+M
	vmOubEgApVhQF+9ifdcYDsyZQomILnT1ZyAah1FUtZTJrlJ+RJ34xi/j4A7zNlA1s++8mpzAqYdHW
	hKl2i4ngIQaa2NubCaYh6OhdAj2tC8ucWOpZ76DqXzYbvZn+uUqE87FOSkRPGON5ys1kD9dvarzrC
	sUUJJgK3DJVNOX/f9cUuICFX4vG83kJJyzw9/DXY3f45NZ1+yUKFAXF+wq8XuFsDux+JyHzQU+jPV
	51g6aTdyWb7Ck5R0uhuR3dQkR+PSLJ5Y0P4Oh+ZoWIVeMgaS/XiFElJ2aDRv7P/8wNykdzTZHXCBx
	U6cARavPx4rS8EU9/qyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXQkx-0000Qt-Te; Thu, 13 Dec 2018 13:10:23 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQku-000865-Ld
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 13:10:22 +0000
Received: by mail-wm1-x344.google.com with SMTP id s14so2302896wmh.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 05:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=38mbt+BqVhFnc/CjZGS2t6U4Vp7zJP4jXDTl/C7yvYY=;
 b=DwgYHu3D5WYQJRF4/72VhnR6oNXBOgmN/Uo1a62KHbYyC8jN6zL4KZNhUXO/c0OeCL
 pSGIakLqb8mRF+NG6S7fq9N6IdlyD27dYvw7u+csVxpsScCu+jYlDk8dQqyxGe54z4iI
 n+viNKVVnSNRk2DPDrVV/tdg5S4Xx0ei2a3Eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=38mbt+BqVhFnc/CjZGS2t6U4Vp7zJP4jXDTl/C7yvYY=;
 b=rKTWzXJyPUxOMsULxCI92P0Y0QmT7r/3abUEsEPcPGlY1L5JVbKRQw8qYveBjZrnap
 My+El5RbDvch/MFXquziM4tDmjcRJpceD1XZtJSOG/5IpMEybEcc0R+5LLkbfSRgqRBf
 Uxtgi3nxvcZaZaZn8dxJ5RhXXXjfZJcQmsJ+sOQGDxWwbFqKczSvpKx9kgpINGwd+Yu6
 rmc/XvbscNuCh3vCWgclS7iISqZqrVZJhpNtKb6Au7fyL6lbNFyvZWpiVmDbtakrUmj9
 MrGBQsbBS7pg7WHCnTCrEOJ7DFBGWX+JEmuLROMFZRlAgqd401W8O3Q4ohu1WsS4OUVd
 0JMg==
X-Gm-Message-State: AA+aEWY2/8LWHpSdxTv6tCRXVrMi8a0gKCVHwgkYFXKVccFkEvrykxe4
 AOsLc11iOmhI+aGJ7CNmatIhRw==
X-Google-Smtp-Source: AFSGD/WyFLVEfjsdKtOcn9yelNWlk6saP74A/ECCNprpBA7mXmBpPy2H53+CUCvHQfsVKeb/aVqOaQ==
X-Received: by 2002:a1c:b515:: with SMTP id e21mr10258132wmf.82.1544706608515; 
 Thu, 13 Dec 2018 05:10:08 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
 by smtp.gmail.com with ESMTPSA id o5sm3727983wmg.25.2018.12.13.05.10.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Dec 2018 05:10:07 -0800 (PST)
Date: Thu, 13 Dec 2018 21:09:49 +0800
From: leo.yan@linaro.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3 6/8] perf cs-etm: Treat NO_SYNC element as trace
 discontinuity
Message-ID: <20181213130949.GB17663@leoy-ThinkPad-X240s>
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
 <1544513908-16805-7-git-send-email-leo.yan@linaro.org>
 <20181213123854.GE21027@kernel.org>
 <20181213124154.GF21027@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181213124154.GF21027@kernel.org>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_051020_712360_D0E24E26 
X-CRM114-Status: GOOD (  25.34  )
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

Hi Arnaldo,

On Thu, Dec 13, 2018 at 09:41:54AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Dec 13, 2018 at 09:38:54AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, Dec 11, 2018 at 03:38:26PM +0800, Leo Yan escreveu:
> > > CoreSight tracer driver might insert barrier packet between different
> > > buffers, thus the decoder can spot the boundaries based on the barrier
> > > packet; the decoder is possible to hit a barrier packet and emit a
> > > NO_SYNC element, then the decoder will find a periodic synchronisation
> > > point inside that next trace block that starts trace again but does not
> > > have the TRACE_ON element as indicator - usually because this block of
> > > trace has wrapped the buffer so we have lost the original point that
> > > trace was enabled.
> > > 
> > > In upper case, it results in the trace stream only inserts the
> > > OCSD_GEN_TRC_ELEM_NO_SYNC element in the middle of tracing stream, but
> > > we don't handle NO_SYNC element properly and at the end users miss to
> > > see the info for trace discontinuity.
> > 
> > 
> > "In upper case"? Maybe:
> > 
> > In the former case it causes the insertion of a OCSD_GEN_TRC_ELEM_NO_SYNC
> > in the middle of the the tracing stream, but as we were npt handling the
> > NO_SYNC element properly which ends up making users miss the
> > discontinuity indication"?
> 
> > > Though OCSD_GEN_TRC_ELEM_NO_SYNC is different from CS_ETM_TRACE_ON when
> > > output from the decoder, but both of them indicate the trace data is
> > 
> > can we remove the "but" and "of them" (redundant) above?
> > 
> > > discontinuous; this patch treats OCSD_GEN_TRC_ELEM_NO_SYNC as trace
> >                                                                a
> > > discontinuity and generates CS_ETM_DISCONTINUITY packet for it, so
> > > cs-etm can handle discontinuity for this case, finally it saves the last
> >                        it (way too many "discontinuity")
> > > trace data for previous trace block and restart samples for new block.
> 
> I've tentatively done those changes (and a few more) in my local branch,
> resulting in the wording below, plese let me know if you are ok with it:

Very appreciate your helping.  Please see some minor typos in below
commit:

> commit 148068b45fe2e93b19c06cfc1140ea12ca72eb59
> Author: Leo Yan <leo.yan@linaro.org>
> Date:   Tue Dec 11 15:38:26 2018 +0800
> 
>     perf cs-etm: Treat NO_SYNC element as trace discontinuity
>     
>     The CoreSight tracer driver might insert a barrier packets between
                                                         packet
>     different buffers, thus the decoder can spot the boundaries based on the
>     barrier packet; it is possible for the decoder to hit a barrier packet
>     and emit a NO_SYNC element, then the decoder will find a periodic
>     synchronisation point inside that next trace block that starts the trace
>     again but does not have the TRACE_ON element as indicator - usually
>     because this trace block has wrapped the buffer so we have lost the
>     original point when the trace was enabled.
>     
>     In the first case it causes the insertion of a OCSD_GEN_TRC_ELEM_NO_SYNC
             former
>     in the middle of the the tracing stream, but as we were npt handling the
                                                              not
>     NO_SYNC element properly which ends up making users miss the
>     discontinuity indication"?
                              s/?/.

Thanks a lot for helping.  If you prefer me to resend the patch set,
also let me know.

>     Though OCSD_GEN_TRC_ELEM_NO_SYNC is different from CS_ETM_TRACE_ON when
>     output from the decoder, both indicate that the trace data is
>     discontinuous; this patch treats OCSD_GEN_TRC_ELEM_NO_SYNC as a trace
>     discontinuity and generates a CS_ETM_DISCONTINUITY packet for it, so
>     cs-etm can handle the discontinuity for this case, finally it saves the
>     last trace data for the previous trace block and restart samples for the
>     new block.
>     
>     Signed-off-by: Leo Yan <leo.yan@linaro.org>
>     Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>     Cc: Jiri Olsa <jolsa@redhat.com>
>     Cc: Mike Leach <mike.leach@linaro.org>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Robert Walker <robert.walker@arm.com>
>     Cc: coresight ml <coresight@lists.linaro.org>
>     Cc: linux-arm-kernel@lists.infradead.org
>     Link: http://lkml.kernel.org/r/1544513908-16805-7-git-send-email-leo.yan@linaro.org
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 1039f364f4cc..bee026e76a4c 100644
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
> 
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
