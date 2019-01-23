Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC1CC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:23:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B04992184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b9NK9cHW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VpVK4CnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B04992184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TIgoAb+tnIIPsczSk+VRHMDrO+ibtLvo9CVE3Db0zOw=; b=b9NK9cHWLeRrxK
	So5ZCXKLCf7ICVmspULo2JEFP4nEK5AFNv4TgdTvrX73hYJ9rPeo5sv8cOS5CtEpmTswBpkWpBWBb
	4goqIlirHIRUviUKxIOUTiG0kzXS53uY5XsgbCgUTvcQxnVOzLR3dgPRz44BR0OEM6Lyp7/zkWujh
	naMvKLnA4xrDYfv4mXjFebK32xsz7FAoOsuMu7OsFw7NIsPdHOHLGwXBTEPXCmaqB/hwHgQ3sPkN+
	gTKrttBzGrqCPGyAGF0at6mF6UvEf8sGQ/xxNzskIOLBQj6yROrESilzbvD5jrxWLsN603/YjnMP4
	5MNd+gYxB2Qr/JCrFuzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmPzq-0006GH-1T; Wed, 23 Jan 2019 21:23:42 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmPzn-0006Fu-B1
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 21:23:40 +0000
Received: by mail-pl1-x641.google.com with SMTP id e11so1785573plt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 13:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=kMvEGohdbgzHXLbqMasWVSocy33cwNII+RxYNB+qKAs=;
 b=VpVK4CnMrfetk2FX7kRbZ6T/xoin0s/8Y7ilAFk3ysZ0fWiE+GfGoY5VQ4JMiVCffc
 LG3k6UlZvXNhcHcofyf2PquRq+3I+OifoV6+r4giy/iBCGIP8ANPz1DA8Chhc0VdXuVj
 yGw2qg8H7jXbpTSG24SXr+ns7PKT1/5xNIuFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=kMvEGohdbgzHXLbqMasWVSocy33cwNII+RxYNB+qKAs=;
 b=Fro6/PdkYrFQWIIVyad7EyW96pvxama5u+zhUvZbXez0sfeIna6x/2dN+bKeB+MOTc
 D0XFUWB5CJTKqIAXbOQQJvke96N89ddF3azfQgnKh6CdzjatUdQaiXmmaALoSNm4JOFL
 NkJQwwBD0reEC+KWJBUN6kdZgb3vbKMP+lVW27EhLWpynuuTkHGL8gLZVa6geeJT+FpR
 kGppX6WjXWwGG2i68oL5Iw57xu0sFuXQW39mlnwna1COoy5eW9TvFigL8KEpH1VrrHum
 rfU6AC90/kQomPO/lCby3TbsxDGohpa5oOckr0kruEVi+cl67bGMGpbFpHnem81bhhYy
 +5rQ==
X-Gm-Message-State: AJcUuke2mLRhKe9UFT/0EK97WzDdGiUVqKeCdapmtJ6C83IU0We87pc+
 LzqBsZHJEfPiEurhGL0ox/fOWw==
X-Google-Smtp-Source: ALg8bN5rnthAxS//lzD29sMzwZmud4gLRPS4Kcfadbk0154OFPD9WVwMYiBHxw85qZ7vx9TZKqPCLA==
X-Received: by 2002:a17:902:7201:: with SMTP id
 ba1mr3884772plb.105.1548278617984; 
 Wed, 23 Jan 2019 13:23:37 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id k24sm28483745pfj.13.2019.01.23.13.23.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 23 Jan 2019 13:23:37 -0800 (PST)
Date: Wed, 23 Jan 2019 14:23:34 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v6 6/8] perf cs-etm: Add traceID in packet
Message-ID: <20190123212334.GF620@xps15>
References: <20190119014347.27441-1-leo.yan@linaro.org>
 <20190119014347.27441-7-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190119014347.27441-7-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_132339_377814_27146ABC 
X-CRM114-Status: GOOD (  15.20  )
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

On Sat, Jan 19, 2019 at 09:43:45AM +0800, Leo Yan wrote:
> Add traceID in packet, thus we can use traceID to retrieve metadata
> pointer from traceID-metadata tuple.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 2 ++
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index cdd38ffd10d2..ba4c623cd8de 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -295,6 +295,7 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
>  		decoder->packet_buffer[i].last_instr_cond = 0;
>  		decoder->packet_buffer[i].flags = 0;
>  		decoder->packet_buffer[i].exception_number = UINT32_MAX;
> +		decoder->packet_buffer[i].trace_chan_id = UINT8_MAX;
>  		decoder->packet_buffer[i].cpu = INT_MIN;
>  	}
>  }
> @@ -331,6 +332,7 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
>  	decoder->packet_buffer[et].last_instr_cond = 0;
>  	decoder->packet_buffer[et].flags = 0;
>  	decoder->packet_buffer[et].exception_number = UINT32_MAX;
> +	decoder->packet_buffer[et].trace_chan_id = trace_chan_id;
>  
>  	if (decoder->packet_count == MAX_BUFFER - 1)
>  		return OCSD_RESP_WAIT;
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> index 012b4728a46f..7e6a8850be4a 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> @@ -50,6 +50,7 @@ struct cs_etm_packet {
>  	u8 last_instr_cond;
>  	u8 last_instr_taken_branch;
>  	u8 last_instr_size;
> +	u8 trace_chan_id;
>  	int cpu;

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  };
>  
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
