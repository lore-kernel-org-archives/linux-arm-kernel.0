Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B43CC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:41:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C9DE20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rFIpONRR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MPUAA2S6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9DE20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SBPBMWYqxxR2tTpPgqktVlf4+ZQzh2xuyjtiLIBpdMM=; b=rFIpONRRxfNcsi
	mHS3qKgNHUPRV05l4WNETB0xOgPdnTwNBzEX1xgmnqFeSqEEbTllw+s5+qYnY/vfbZTLoPvKzsso+
	r/CxmLdadN0JanKE+ItJo7iJK/YE42l9MGTrjq8Yw/huixy/BDVAz3RaPmybX7KHpogmsUK0w64jV
	mym2D15e/4OEAn4jVhdbma2qq+8RWE+fkrXHpWkmbq8CH7WjOWT6l+qaXH6OQArty+IgVUyc4S5qV
	l1jKNnPQQrX4NP0KOXSfN8u9NxVxzrZs5aWn6WwnBcWWXR3Hoawyd9eczV3RCrROVO0iKxvGhaYle
	TS8GxiO+z2/SPTsOx/4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX9Rj-0004J0-EJ; Wed, 12 Dec 2018 18:41:23 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX9Rf-0004He-Ov
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 18:41:21 +0000
Received: by mail-pf1-x442.google.com with SMTP id u6so9267947pfh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 10:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=AQUGeZO51KzJnoqlQO0qPHq/gKBQeA0epVLv7slJukw=;
 b=MPUAA2S69XVZbGZM+4ddVx3ynmkB/gCcBUjkh5VfFH8k53dDWYN4hXppJNS9NrSped
 0KqKlHkca2bX3DDGwioKCKy64jgFh34KaktSOr48RSYCaIKwPyibtVUfu3x6D9AAEK5A
 zZMQIx000wdcptQbioSLCSLHLJ2qdsu6Ow4Rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=AQUGeZO51KzJnoqlQO0qPHq/gKBQeA0epVLv7slJukw=;
 b=MEMSGpNxYUQTaVn8yC7l13YbcdG8J7GCi+l2JsqAPFOkMRnco8PLxefLcW54zS0Ytf
 Bg8CcR2O95qsyYKrOLiArcUYBzQl3vpUmNYrjYvfIJ18nBTdMdbtAP+t1I/tjduZGSZO
 S/7nZUVJ/jKc0DlaE/p9XDW5YoMU9TYgbZ3gpwiQK0+VRdOflhyPJTaTgpSGkQu3IZBZ
 T2GJEu4UiEiaDSGo41zX07ByGyRbI9Mvz0QuMusX5D62Lh+386RFe43BGYdMpcqRw4yq
 VVbFV0tK7/QmzFadWPk/SzQKSJvzswDRaAbzvXOmCpwycZ4Genylk8NcOewv4CA/qNYe
 dWfA==
X-Gm-Message-State: AA+aEWZMRFQBqBlXtFoMaCJ49yuCrvw9gdsI1BZnNVid50Bp3ecNs0hD
 D7VgTVas4Q+HYigSQTq8pcxrLjTxkQA=
X-Google-Smtp-Source: AFSGD/XUKu6LJif/wRxOlZTXmtOSD1giS0jdioQ4tRM+d2+pUg73nmRV/ljJbFvHWuxGBlp64tJj6Q==
X-Received: by 2002:a63:507:: with SMTP id 7mr18679965pgf.411.1544640068478;
 Wed, 12 Dec 2018 10:41:08 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id i21sm19044531pgm.17.2018.12.12.10.41.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Dec 2018 10:41:07 -0800 (PST)
Date: Wed, 12 Dec 2018 11:41:05 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v3 3/8] perf cs-etm: Remove unused 'trace_on' in
 cs_etm_decoder
Message-ID: <20181212184105.GA24556@xps15>
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
 <1544513908-16805-4-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544513908-16805-4-git-send-email-leo.yan@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_104119_805597_8E9A9576 
X-CRM114-Status: GOOD (  15.34  )
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

On Tue, Dec 11, 2018 at 03:38:23PM +0800, Leo Yan wrote:
> cs_etm_decoder::trace_on is being assigned when TRACE_ON or NO_SYNC
> element is coming, but it is never used hence it is redundant and can
> be removed.
> 
> So let's remove 'trace_on' field from cs_etm_decoder struct.
> 
> Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Robert Walker <robert.walker@arm.com>
> ---
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 0b4c862..97b39b1 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -36,7 +36,6 @@
>  struct cs_etm_decoder {
>  	void *data;
>  	void (*packet_printer)(const char *msg);
> -	bool trace_on;
>  	dcd_tree_handle_t dcd_tree;
>  	cs_etm_mem_cb_type mem_access;
>  	ocsd_datapath_resp_t prev_return;
> @@ -411,12 +410,10 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>  	case OCSD_GEN_TRC_ELEM_UNKNOWN:
>  		break;
>  	case OCSD_GEN_TRC_ELEM_NO_SYNC:
> -		decoder->trace_on = false;
>  		break;
>  	case OCSD_GEN_TRC_ELEM_TRACE_ON:
>  		resp = cs_etm_decoder__buffer_trace_on(decoder,
>  						       trace_chan_id);
> -		decoder->trace_on = true;
>  		break;
>  	case OCSD_GEN_TRC_ELEM_INSTR_RANGE:
>  		resp = cs_etm_decoder__buffer_range(decoder, elem,

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
