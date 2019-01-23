Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC46C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:05:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D290221855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PV8ClukD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dGOySgWc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D290221855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AzTuddYFseCUYIVXp8JYTPX5EqfXjIj3Z6ZJlBCGUhY=; b=PV8ClukDtOkh5/
	j5LSVe5gPLMRGR0dAbExDH3bza/TQLrc9zquJVvkqW3seDhLB8fomykX7XzskXnsa5zGvyuEsUQRj
	zM6XWbQ8C/rskD1bsuU97w/QJT7iH8xT1f5AX5zd6Hy4F4ihwBB2nN+qnxdetiKM/fGjJUxFTjtDZ
	ELeiw0GIROFqjX7d4GADFM8mMx24hz4Xe213r1pWPwo+rnxwJt9HlRAUjtDz1TjcBIktuqgoq7k76
	rIcj4e4n14fCfVUsa2qsYPWwjF47z0Msi+U+lqZa67b0ETgq7Bx8ztDFKwDCqK1Cq7jmRv9qxWl3Q
	veefv2zaZZ6/DI/ggPIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmPiJ-0000ci-Lm; Wed, 23 Jan 2019 21:05:35 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmPiE-0000at-F3
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 21:05:33 +0000
Received: by mail-pf1-x443.google.com with SMTP id u6so1775864pfh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 13:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Um5Owx2PZ+cWE2aTU1iit32Xs0VOzk8bkixgF58pEFE=;
 b=dGOySgWcV6Pw48djtIKVzyc/SNYn5ilF/jKajV8oMaREDn94xgmI2Z59oPJtbKNocW
 UzxmvlgkLg/3yW1ssJ8YPUgCaeDsb/+0nGqpYLFA8GsXpkBjJxWmby1JQak4or5z8UvT
 nZQdU7KtPjuqTUh9nv6DZ7qYwScEoiEuLRM50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Um5Owx2PZ+cWE2aTU1iit32Xs0VOzk8bkixgF58pEFE=;
 b=FC7aNhFO2ixkPf39FZaUBifrIv0Ij0CpXLUctnC2fGGT1PhPtjh5wJ3JHTHWokkhY5
 msaGkkBt7XxZFowPLtMfmlbmbZK8vM5wLbqWWvidzjLks6FtTIqUCWv/eA9sU0W4aEaX
 FwaWPqLHgBaVpZCZtP7X8HMrxRvLEjFkzGbMy3EFFOlIN6ADqGKj2Z/yL0N30vnz6Y93
 kFJuDW2WgDvNTI4lw71X9kXFZzMfeqlNrCE9aRPctOLc1AWStpXurTBkoksErxQox5X3
 LA43pSch2taSqk50CeVbFuqkO1Vdb8o21FKESij+8xRtX0Evk9beJpy1C/xREFzLPLzs
 sNKA==
X-Gm-Message-State: AJcUukfPuwF1gCx9mwmvEkSsDElVwt4+Mo05QOenw8i+ZUfUieAXxj43
 XMwPks2dUoB+r+L3b+jcH3pGpQ==
X-Google-Smtp-Source: ALg8bN6M98STrR8TVeZxsL6rsxPMIrFC3XoqlQOZO2BycCzfZ12gHpUajYkKIulsWjCvyHP7ibo/Bw==
X-Received: by 2002:aa7:8802:: with SMTP id c2mr3620470pfo.20.1548277529541;
 Wed, 23 Jan 2019 13:05:29 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id f20sm24183091pfn.177.2019.01.23.13.05.27
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 23 Jan 2019 13:05:28 -0800 (PST)
Date: Wed, 23 Jan 2019 14:05:26 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v6 4/8] perf cs-etm: Add exception number in exception
 packet
Message-ID: <20190123210526.GD620@xps15>
References: <20190119014347.27441-1-leo.yan@linaro.org>
 <20190119014347.27441-5-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190119014347.27441-5-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_130530_640067_8BC2D086 
X-CRM114-Status: GOOD (  19.02  )
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

On Sat, Jan 19, 2019 at 09:43:43AM +0800, Leo Yan wrote:
> When an exception packet comes, it contains the information for
> exception number; the exception number indicates the exception types,
> so from it we can know if the exception is taken for interrupt,
> system call or other traps, etc.
> 
> This patch simply adds a field in cs_etm_packet struct, it records
> exception number for exception packet that will then be used to
> properly identify exception types to the perf synthesize mechanic.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 20 +++++++++++++++----
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  1 +
>  2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index e98ee49a1527..294efa76c9e3 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -294,6 +294,7 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
>  		decoder->packet_buffer[i].last_instr_subtype = 0;
>  		decoder->packet_buffer[i].last_instr_cond = 0;
>  		decoder->packet_buffer[i].flags = 0;
> +		decoder->packet_buffer[i].exception_number = UINT32_MAX;
>  		decoder->packet_buffer[i].cpu = INT_MIN;
>  	}
>  }
> @@ -331,6 +332,7 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
>  	decoder->packet_buffer[et].last_instr_subtype = 0;
>  	decoder->packet_buffer[et].last_instr_cond = 0;
>  	decoder->packet_buffer[et].flags = 0;
> +	decoder->packet_buffer[et].exception_number = UINT32_MAX;
>  
>  	if (decoder->packet_count == MAX_BUFFER - 1)
>  		return OCSD_RESP_WAIT;
> @@ -406,10 +408,20 @@ cs_etm_decoder__buffer_discontinuity(struct cs_etm_decoder *decoder,
>  
>  static ocsd_datapath_resp_t
>  cs_etm_decoder__buffer_exception(struct cs_etm_decoder *decoder,
> +				 const ocsd_generic_trace_elem *elem,
>  				 const uint8_t trace_chan_id)
> -{
> -	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> -					     CS_ETM_EXCEPTION);
> +{	int ret = 0;
> +	struct cs_etm_packet *packet;
> +
> +	ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> +					    CS_ETM_EXCEPTION);
> +	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
> +		return ret;
> +
> +	packet = &decoder->packet_buffer[decoder->tail];
> +	packet->exception_number = elem->exception_number;
> +
> +	return ret;
>  }
>  
>  static ocsd_datapath_resp_t
> @@ -443,7 +455,7 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>  						    trace_chan_id);
>  		break;
>  	case OCSD_GEN_TRC_ELEM_EXCEPTION:
> -		resp = cs_etm_decoder__buffer_exception(decoder,
> +		resp = cs_etm_decoder__buffer_exception(decoder, elem,
>  							trace_chan_id);
>  		break;
>  	case OCSD_GEN_TRC_ELEM_EXCEPTION_RET:
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> index 23600e57a215..012b4728a46f 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> @@ -46,6 +46,7 @@ struct cs_etm_packet {
>  	u32 last_instr_type;
>  	u32 last_instr_subtype;
>  	u32 flags;
> +	u32 exception_number;
>  	u8 last_instr_cond;
>  	u8 last_instr_taken_branch;
>  	u8 last_instr_size;

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
