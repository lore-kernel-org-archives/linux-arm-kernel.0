Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3CAC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:05:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E92C2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eRVHVAx4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H6UQrq8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E92C2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TBNdlf3Zpv221Pu8cJilaOf3H+mpLLvbgnkc7pf84K4=; b=eRVHVAx4dcPFSU
	AQTcdYLLzl+4YBnGK1uWWCO/ZkYF5KxwAtzf0XtTnIKvOoVvwByIi40GgDrrgSHFKtQPZ8jkVDv69
	miyB3zzqybosbWm4kDPkursaGmeFYa+CtWej4OpoKrBtBe8etxb4Yo/1mSe5lDYXF/rUKkkUM09RD
	YwArBafgtpampimeI9Aas8JOQA+wOZ9zIWxxSPfA+NNdW/0f49WKtU/2GofyvUcEhDs+ieuvDKffM
	6NN/HY2eb6ZUe7kPvs9ETmELRCp5hRubh8bOegd51z3OH87ijc75p9vNarjfPqvd/bPmPAuH3RMBp
	MUpUd2Q1nUYLYptYg8sA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWUbm-0007kd-68; Mon, 10 Dec 2018 23:05:02 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWUbj-0007jI-9M
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 23:05:00 +0000
Received: by mail-pf1-x442.google.com with SMTP id h3so6126449pfg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 15:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=hINzrVelB9T/aQFX4msXU++fDns10Zd4lk+L9kApzq4=;
 b=H6UQrq8Gw7l9XhwWSGmB31G/kq6Jquc0Q85jqgVJVtyOA2t7AZreIfscWmuZXczXmW
 357ceCRu6X8bqv3lwgaWOW/AsS5hvzSxPdMfAjQUPG1ysqwxdWn9Xl/S0BNn+ZOvGXEm
 Ru70TdzKwmbnb6YEv7vTEhqxHmEnbXFTF5m8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=hINzrVelB9T/aQFX4msXU++fDns10Zd4lk+L9kApzq4=;
 b=r9ES+NTM6WSc2Jg01eGvwQeA6mf46UB+Iou5evY31d7rOCaoG/DYFwCvGxa4hMUKlK
 TNx0Rn3uOh7f9FptVApdis7B+HPNPsS5VbDB/d7NHaNjKQdx0i0LejhAh3ZMXgmL0m7v
 QeZ1tFeGEOhNRnO3oMJY74iHzxkCurOGUE84uDAmVOjj5JZLI3pMh2rgPufTLx2N1kh/
 rG7FPBHgVN6R3vyKyUDIXJWwCw2GLnx877zwmlbqKGYxt/1CQdq+Vfj5Z0uLhMeJWECC
 tccm4fo0hA4JWviNhaFCCkxrcxXLCDbLRX74r4NMebWZkGb1r2EkACz5Yiak6SqJN82h
 L9RQ==
X-Gm-Message-State: AA+aEWZFqNOoljl9W9ZAaJIjIcW4AkdEQhfR+TNVMe+7BYXcmagERW/M
 QNSeeB/fh9JdqmJ4jL4mUmYET9OvxgE=
X-Google-Smtp-Source: AFSGD/W3oBIwBUqStyEYbfLUmp7pEsrP9axmV9vesJHMRjX+nd736Vto3mtWKk/tmc1obuT54qqfhw==
X-Received: by 2002:a63:c503:: with SMTP id f3mr12154702pgd.431.1544483088673; 
 Mon, 10 Dec 2018 15:04:48 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id w5sm15951184pfn.89.2018.12.10.15.04.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 15:04:47 -0800 (PST)
Date: Mon, 10 Dec 2018 16:04:45 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v2 5/6] perf cs-etm: Treat EO_TRACE element as trace
 discontinuity
Message-ID: <20181210230445.GD12152@xps15>
References: <1544431981-24144-1-git-send-email-leo.yan@linaro.org>
 <1544431981-24144-6-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544431981-24144-6-git-send-email-leo.yan@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_150459_325311_7659179D 
X-CRM114-Status: GOOD (  20.21  )
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

On Mon, Dec 10, 2018 at 04:53:00PM +0800, Leo Yan wrote:
> If decoder outputs EO_TRACE element, it means the end of the trace
> buffer; this is a discontinuity and in this case the end of trace data
> needs to be saved.
> 
> This patch generates CS_ETM_DISCONTINUITY packet for EO_TRACE element
> hereby flushing the end of trace data in cs-etm.c.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Robert Walker <robert.walker@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 46b67f1..bcb5c98 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -411,6 +411,7 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>  	case OCSD_GEN_TRC_ELEM_UNKNOWN:
>  		break;
>  	case OCSD_GEN_TRC_ELEM_NO_SYNC:
> +	case OCSD_GEN_TRC_ELEM_EO_TRACE:
>  		resp = cs_etm_decoder__buffer_discontinuity(decoder,
>  							    trace_chan_id);

If you were to get rid of decoder::trace_on at the beginning of this set you
could put NO_SYNC, EO_TRACE and TRACE_ON together and call
cs_etm_decoder__buffer_discontinuity() only once.  I wouldn't mention it if you did
not have to respin but since you do, might as well just do it.  But that's
entirely up to you considering, at least in my opinion, that you have addressed
all of Mike and Rob' comments.

If you do not want to deal with decoder::trace_on as part of this set:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  		decoder->trace_on = false;
> @@ -431,7 +432,6 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>  		decoder->packet_buffer[decoder->tail].exc_ret = true;
>  		break;
>  	case OCSD_GEN_TRC_ELEM_PE_CONTEXT:
> -	case OCSD_GEN_TRC_ELEM_EO_TRACE:
>  	case OCSD_GEN_TRC_ELEM_ADDR_NACC:
>  	case OCSD_GEN_TRC_ELEM_TIMESTAMP:
>  	case OCSD_GEN_TRC_ELEM_CYCLE_COUNT:
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
