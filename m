Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870EBC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:48:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D3252081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="miLWnRJd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="koWvXWbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3252081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pBPh5lFQpIOVhK0UekY4ZlzYiqaV/U4fE7IFzreFNrM=; b=miLWnRJdQAGU5t
	liW8wOjDZWR/8seLMpfa8q2tftfgt/9QQ0r+Md/FGbA98uJ+n+iI+fHGBzI+oFDMKQtI6kQkJZINA
	7xXYRL3HHG7RZCz2lo5toMQ+sVeHAUggQs/ua3DP5eL+rubntoyzCYaP+ge4BEoDuhnJo+nVrn8R1
	S+ObjkH72Vzb9PPMYUSqf91pGjcor0gHKZo6PguwauSFU0CiGqFwi783xmHyiAMjPA7nCFTIORE2m
	jCtb0n+CgeQ6nn1AEkvNd+//ldoth2ZA581mI2Fa2oAKFwBTMfLEsiLxId2RhU8jZb0CtYX2PGk/s
	EENaAc1LCcKkAYP+0Deg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWULw-0001HW-7v; Mon, 10 Dec 2018 22:48:40 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWULl-00012n-2H
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 22:48:30 +0000
Received: by mail-pg1-x544.google.com with SMTP id z10so5660527pgp.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 14:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=hGe7qh3okuyxooCLsgUyfOmoqYrSDkgBoKxwLswAXg0=;
 b=koWvXWbfmhws346COuZgCbvBbaa0sSZxmbEBuI/o8nwwhV0k+rrg9xxidl4KsOwa3R
 ey48SgNcf7PE30JHBlDQw8qBw9ISUaRhDXdK1n16FlypnXb2aKPBaU0GMchaLiHeIkHa
 gUV2p/a6/8BweVZvrK9o7rSynZxJXKdZUU/Yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=hGe7qh3okuyxooCLsgUyfOmoqYrSDkgBoKxwLswAXg0=;
 b=eGK9ER+g44RVKBZjAfSECXx9SS4IZFeOrBmdz8cLFN74IdwXW2K/2iyEUlSX6PjBTd
 AXbdqvCT4wPMAFCAwH9KPGjqfalsWngdQphwCScRhtsd/UU7lglnvhoNiUU1k+UtCaIK
 hKLGQH+7766AL8lZrHSEJ2mIpLMkrmtRC9+9gu/9crqr8nH9e8YzufI1S/hbjwHtShs0
 zVYyxfv139l0rnH3HdWE4o8I3y8HK+BJ+tZ/jVQXQbWymhao6UDamx84s69VGY7llORa
 pw/NBuPaZG4LzSx4wxJVn7BpfEQAbwjddLVZ3Nc59jVhxEqLt5kbr41d/EWDLzCwb+N/
 SvGA==
X-Gm-Message-State: AA+aEWbD3SvrC2Lcc42k2N3TF+gSLip9lfvGpCzsw5cYUYGJZEuvX1ni
 LGG2oQb1+wr+4q//gOHOX4C6xxPoloA=
X-Google-Smtp-Source: AFSGD/VnE4FdwJgoPAFlY9fwqdmwzqqIIvMAmPZROPT2tYSnlIYT60fQJg+h3nlMVHyF9sdbE4jcMQ==
X-Received: by 2002:a62:824c:: with SMTP id w73mr14005099pfd.150.1544482098381; 
 Mon, 10 Dec 2018 14:48:18 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id g136sm19265654pfb.154.2018.12.10.14.48.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 14:48:17 -0800 (PST)
Date: Mon, 10 Dec 2018 15:48:15 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v2 2/6] perf cs-etm: Avoid stale branch samples when
 flush packet
Message-ID: <20181210224815.GA12152@xps15>
References: <1544431981-24144-1-git-send-email-leo.yan@linaro.org>
 <1544431981-24144-3-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544431981-24144-3-git-send-email-leo.yan@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_144829_103607_46AB114B 
X-CRM114-Status: GOOD (  29.04  )
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

On Mon, Dec 10, 2018 at 04:52:57PM +0800, Leo Yan wrote:
> At the end of trace buffer handling, function cs_etm__flush() is invoked
> to flush any remaining branch stack entries.  As a side effect, it also
> generates branch sample, because the 'etmq->packet' doesn't contains any
> new coming packet but point to one stale packet after packets swapping,
> so it wrongly makes synthesize branch samples with stale packet info.
> 
> We could review below detailed flow which causes issue:
> 
>   Packet1: start_addr=0xffff000008b1fbf0 end_addr=0xffff000008b1fbfc
>   Packet2: start_addr=0xffff000008b1fb5c end_addr=0xffff000008b1fb6c
> 
>   step 1: cs_etm__sample():
> 	sample: ip=(0xffff000008b1fbfc-4) addr=0xffff000008b1fb5c
> 
>   step 2: flush packet in cs_etm__run_decoder():
> 	cs_etm__run_decoder()
> 	  `-> err = cs_etm__flush(etmq, false);
> 	sample: ip=(0xffff000008b1fb6c-4) addr=0xffff000008b1fbf0
> 
> Packet1 and packet2 are two continuous packets, when packet2 is the new
> coming packet, cs_etm__sample() generates branch sample for these two
> packets and use [packet1::end_addr - 4 => packet2::start_addr] as branch
> jump flow, thus we can see the first generated branch sample in step 1.
> At the end of cs_etm__sample() it swaps packets so 'etm->prev_packet'=
> packet2 and 'etm->packet'=packet1, so far it's okay for branch sample.
> 
> If packet2 is the last one packet in trace buffer, even there have no
> any new coming packet, cs_etm__run_decoder() invokes cs_etm__flush() to
> flush branch stack entries as expected, but it also generates branch
> samples by taking 'etm->packet' as a new coming packet, thus the branch
> jump flow is as [packet2::end_addr - 4 =>  packet1::start_addr]; this
> is the second sample which is generated in step 2.  So actually the
> second sample is a stale sample and we should not generate it.
> 
> This patch introduces a new function cs_etm__end_block(), at the end of
> trace block this function is invoked to only flush branch stack entries
> and thus can avoid to generate branch sample for stale packet.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Robert Walker <robert.walker@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 789707b..ffc4fe5 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1055,6 +1055,39 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
>  	return err;
>  }
>  
> +static int cs_etm__end_block(struct cs_etm_queue *etmq)
> +{
> +	int err;
> +
> +	/*
> +	 * It has no new packet coming and 'etmq->packet' contains the stale
> +	 * packet which was set at the previous time with packets swapping;
> +	 * so skip to generate branch sample to avoid stale packet.
> +	 *
> +	 * For this case only flush branch stack and generate a last branch
> +	 * event for the branches left in the circular buffer at the end of
> +	 * the trace.
> +	 */
> +	if (etmq->etm->synth_opts.last_branch &&
> +	    etmq->prev_packet->sample_type == CS_ETM_RANGE) {
> +		/*
> +		 * Use the address of the end of the last reported execution
> +		 * range.
> +		 */
> +		u64 addr = cs_etm__last_executed_instr(etmq->prev_packet);
> +
> +		err = cs_etm__synth_instruction_sample(
> +			etmq, addr,
> +			etmq->period_instructions);
> +		if (err)
> +			return err;
> +
> +		etmq->period_instructions = 0;
> +	}
> +
> +	return 0;
> +}
> +
>  static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
>  {
>  	struct cs_etm_auxtrace *etm = etmq->etm;
> @@ -1137,7 +1170,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
>  
>  		if (err == 0)
>  			/* Flush any remaining branch stack entries */
> -			err = cs_etm__flush(etmq);
> +			err = cs_etm__end_block(etmq);
>  	}
>  
>  	return err;

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
