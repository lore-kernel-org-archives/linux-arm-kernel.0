Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7830C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:51:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78AA5218A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ctcn3CCm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eEkdUoNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78AA5218A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lkvp5GRnktrTQbA8bx9rbTfx+jEAn+7KZjQ0ezSuCA4=; b=Ctcn3CCmuJV69a
	XJKClt6dpEZvLX+FSeMmLNNkn16u7mM/wQSUJW/ikhWfwzB7Op+Fv1Icc6oFhzEac+ahX6xWUedeG
	n58C+pvvNU0IkrMSlKodeUk+nGJYRufeXLr6P3S9KzkN1L/lvuRyirLkgrpskCf2JHPsvchHuk91B
	5QW56fPtucZUO8CsTvcW/+1HCPK405xluJVqgHT/XBLGaBmlalLSIOwI0rEouIWgTqxfqBSiPKtrs
	LB/z3Jutc+9LBUTdgH5QJofegdAYHQBDv2JUkGsta06YNGEUo7/OC6Mzsd+a6b0uWFzjBfihWqLaq
	+f4ozXCeM2pFxWuNql+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmQQc-0008EC-5M; Wed, 23 Jan 2019 21:51:22 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmQQY-0008Dr-AE
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 21:51:19 +0000
Received: by mail-pl1-x644.google.com with SMTP id 101so1829122pld.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 13:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Un+ddWOkrcLIgcdYaVmErVN+SdzigN0j9GGeHRptMoo=;
 b=eEkdUoNNh9LMxCmSkRnBatUg64bUk2CRLGuYq4jPvAFodhiYnkcuCyuBi3UwyPTUE3
 YQAVq8xUHy2zT0eK2l0l2wDqgIxd1lGXBImoYakKSCs7WXYnCbd0LijXqy5A1SvFnKC1
 nfrQi5eiB3sf31qcEgIw18lTlTEyqlXxDPAq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Un+ddWOkrcLIgcdYaVmErVN+SdzigN0j9GGeHRptMoo=;
 b=DO9FITRZTUetnr/rU+naQOZoxFgxpyy2jsguz40nM5v/tqZj9M35YMVIlW/IXUmFPC
 5o7N7YDaFIiGBspI3sAnWuO7U/8sdTl1JSfFuVYyehmm7KiUJVWVHPgENuwxj6If+G75
 LyT+LGsYWX+f5dLo8GWBouqtmNFEL2nn47Q3SdZinKt0ODo73DlFR3VsiQOo80oqohw1
 uxe8udEGKDciN4l5DbJHXq3y2yh5Czg0eWJYpTdbhQFr+0VwoWopgIJhuZ4lSlEj4eQb
 /4Frm3CnQ+O+RosDd263lhTZ1ovnYaBBa966FnNgYoVoqvSyDGlS/0YbicRBUf5BDkiF
 3mcA==
X-Gm-Message-State: AJcUukce9P3cA/k76mAHrzJGWRKD5n+c+aUu3cjBiLd7SShY67FdETdG
 nGNPWzVFlFjHZqo/pBQpjeyfZA==
X-Google-Smtp-Source: ALg8bN7llw7Cbe+fDZE2zaKxL2R0lB+Y1xOkgy/EbdJS2qcmASmFFWyDk+Z97ikucEQRIB77Uxe6bQ==
X-Received: by 2002:a17:902:ba89:: with SMTP id
 k9mr4022026pls.189.1548280277555; 
 Wed, 23 Jan 2019 13:51:17 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id r4sm41423684pgn.54.2019.01.23.13.51.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 23 Jan 2019 13:51:16 -0800 (PST)
Date: Wed, 23 Jan 2019 14:51:14 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v6 8/8] perf cs-etm: Set sample flags for exception
 return packet
Message-ID: <20190123215114.GH620@xps15>
References: <20190119014347.27441-1-leo.yan@linaro.org>
 <20190119014347.27441-9-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190119014347.27441-9-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_135118_396961_8E7FD4AE 
X-CRM114-Status: GOOD (  27.17  )
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

On Sat, Jan 19, 2019 at 09:43:47AM +0800, Leo Yan wrote:
> When return from exception, we need to distinguish if it's system call
> return or for other type exceptions for setting sample flags.  Due to
> the exception return packet doesn't contain exception number, so we
> cannot decide sample flags based on exception number.
> 
> On the other hand, the exception return packet is followed by an
> instruction range packet; this range packet deliveries the start address
> after exception handling, we can check if it is a SVC instruction just
> before the start address.  If there has one SVC instruction is found
> ahead the return address, this means it's an exception return for system
> call; otherwise it is an normal return for other exceptions.
> 
> This patch is to set sample flags for exception return packet, firstly
> it simply set sample flags as PERF_IP_FLAG_INTERRUPT for all exception
> returns since at this point it doesn't know what's exactly the exception
> type.  We will defer to decide if it's an exception return for system
> call when the next instruction range packet comes, it checks if there
> has one SVC instruction prior to the start address and if so we will
> change sample flags to PERF_IP_FLAG_SYSCALLRET for system call
> return.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 44 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 052805de6513..7547a7178f46 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1372,6 +1372,20 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
>  		if (prev_packet->sample_type == CS_ETM_DISCONTINUITY)
>  			prev_packet->flags |= PERF_IP_FLAG_BRANCH |
>  					      PERF_IP_FLAG_TRACE_BEGIN;
> +
> +		/*
> +		 * If the previous packet is an exception return packet
> +		 * and the return address just follows SVC instuction,
> +		 * it needs to calibrate the previous packet sample flags
> +		 * as PERF_IP_FLAG_SYSCALLRET.
> +		 */
> +		if (prev_packet->flags == (PERF_IP_FLAG_BRANCH |
> +					   PERF_IP_FLAG_RETURN |
> +					   PERF_IP_FLAG_INTERRUPT) &&

Would it make more sense to just look for prev-packet->sample_type ==
CS_ETM_EXCEPTION_RET ?

> +		    cs_etm__is_svc_instr(etmq, packet, packet->start_addr))
> +			prev_packet->flags = PERF_IP_FLAG_BRANCH |
> +					     PERF_IP_FLAG_RETURN |
> +					     PERF_IP_FLAG_SYSCALLRET;
>  		break;
>  	case CS_ETM_DISCONTINUITY:
>  		/*
> @@ -1422,6 +1436,36 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
>  			prev_packet->flags = packet->flags;
>  		break;
>  	case CS_ETM_EXCEPTION_RET:
> +		/*
> +		 * When the exception return packet is inserted, since
> +		 * exception return packet is not used standalone for
> +		 * generating samples and it's affiliation to the previous
> +		 * instruction range packet; so set previous range packet
> +		 * flags to tell perf it is an exception return branch.
> +		 *
> +		 * The exception return can be for either system call or
> +		 * other exception types; unfortunately the packet doesn't
> +		 * contain exception type related info so we cannot decide
> +		 * the exception type purely based on exception return packet.
> +		 * If we record the exception number from exception packet and
> +		 * reuse it for excpetion return packet, this is not reliable
> +		 * due the trace can be discontinuity or the interrupt can
> +		 * be nested, thus the recorded exception number cannot be
> +		 * used for exception return packet for these two cases.
> +		 *
> +		 * For exception return packet, we only need to distinguish the
> +		 * packet is for system call or for other types.  Thus the
> +		 * decision can be deferred when receive the next packet which
> +		 * contains the return address, based on the return address we
> +		 * can read out the previous instruction and check if it's a
> +		 * system call instruction and then calibrate the sample flag
> +		 * as needed.
> +		 */
> +		if (prev_packet->sample_type == CS_ETM_RANGE)
> +			prev_packet->flags = PERF_IP_FLAG_BRANCH |
> +					     PERF_IP_FLAG_RETURN |
> +					     PERF_IP_FLAG_INTERRUPT;
> +		break;
>  	case CS_ETM_EMPTY:
>  	default:
>  		break;
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
