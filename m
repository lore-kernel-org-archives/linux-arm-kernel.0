Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FD1C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:03:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C03F921855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UqpvjqX8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jw4Tnn7d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03F921855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ldWOLGw+TRHHZkN+gZtZNPLLH28NaktERmluYs7m2vo=; b=UqpvjqX8fDHTT+
	1pfle4aBzUFHPEXmAj/qisSBbwZY+TYA/lEk8trDJbW3Io+Nx/tE5ExwoTe9VOt93bO5Ljsye6ZXX
	9V+0vB6NaEVW11evaI5q9h7QsIXY5zdrSeqgv7a6W7gxnPIvWGA0itQdSX5COsgubzPLkIb30RBXf
	xQeKyWP25EEL6XanatLLUUPlLFUBOozK5KpBdPRCuo38m9o+q1XT/oCwzilQEbPAXTtr0yUAQO5RP
	1yaNm78UADPn6AIKHdsa9DBOg6msI3FQJEqHI4XwrjAhFTwaL74ULu8PnTcdEsAbd9+34QDH5RFLb
	rO9bwl3IspsGWQYTaEUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmPg2-0006Il-FI; Wed, 23 Jan 2019 21:03:14 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmPfz-0006IM-92
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 21:03:12 +0000
Received: by mail-pg1-x544.google.com with SMTP id j10so1633915pga.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 13:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=GIwaEMRKzxnb6kRlUoX4AjXq8zujt0bvbN32eIubOBc=;
 b=jw4Tnn7d+cdlFORADnV4fHvzTEsuKH9PUcz1TG4QwybCM5scoDtiyf0TFXz7RoYnhu
 15TSgEO90GhRuif3wdIZQnZ9aZEai85d7t7yCyOzaPOx+CGvLTWfIKyDLkvSCxzgE2OI
 anOvV8s9CYDNbOf8Ch0HEEQza8YwQJ0d9a4w0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=GIwaEMRKzxnb6kRlUoX4AjXq8zujt0bvbN32eIubOBc=;
 b=h87pfKO4J4mW0tfFAMPZvBB+QQE558TLd4TIv8doTI5XefzoKhYEbLdSsIwMjlDT6u
 +3MNMyHY6CxlDICR6J+QmGXTKT6ay8I9x1txJZweJdbgNj0BL3Ze6c5K/w2LAidxDVk2
 0Dp9wFwGvB0WUFFqkzBWmOILnAAy5BZZoLScfCSzLLQ/7wKhqgWkFqoPlOnsRh8MwvVs
 V+mHy8E/GDljH1aGi6ykQRXpUDrL+ZJjq+1YUNgfbZHrRtTO1VhZiL9ncsXMx4jW0PNg
 /4+8w0eDojJpQHeSYeKvP//KwDfl+XgPUJz0x2H1TdR5PrXDgzX+KCUWfukf0suplPIS
 joRw==
X-Gm-Message-State: AJcUukd5h5+1ykrM44W2y+7OSKxf3yISSvnptF82u9es+jDUmL/q3HED
 6K6NmKLV07pEwPE5zNzfy8VTaQ==
X-Google-Smtp-Source: ALg8bN6Ibk65HSi4ruiPnRIoOacUpKzIF4tLbRSmz8AoF+PAvtwAeCDJtz4oaio856vh+dYJMUWWNA==
X-Received: by 2002:a62:e044:: with SMTP id f65mr3585000pfh.208.1548277390263; 
 Wed, 23 Jan 2019 13:03:10 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id r187sm67184687pfc.63.2019.01.23.13.03.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 23 Jan 2019 13:03:09 -0800 (PST)
Date: Wed, 23 Jan 2019 14:03:07 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v6 1/8] perf cs-etm: Add last instruction information in
 packet
Message-ID: <20190123210307.GA620@xps15>
References: <20190119014347.27441-1-leo.yan@linaro.org>
 <20190119014347.27441-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190119014347.27441-2-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_130311_324583_98B90B95 
X-CRM114-Status: GOOD (  19.52  )
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

On Sat, Jan 19, 2019 at 09:43:40AM +0800, Leo Yan wrote:
> Decoder provides last instruction related information, these information
> can be used for trace analysis; specifically we can get to know what
> kind of branch instruction has been executed, mainly the information
> are contained in three element fields:
> 
>   last_i_type: this is significant type for waypoint calculation, it
>   indicates the last instruction is one of immediate branch instruction,
>   indirect branch instruction, instruction barrier (ISB), or data
>   barrier (DSB/DMB).
> 
>   last_i_subtype: this is used for instruction sub type, it can be
>   branch with link, ARMv8 return instruction, ARMv8 eret instruction
>   (return from exception), or ARMv7 instruction which could imply
>   return (e.g. MOV PC, LR; POP { ,PC}).
> 
>   last_instr_cond: it indicates if the last instruction was conditional.
> 
> But these three fields are not saved into cs_etm_packet struct, thus
> cs-etm layer don't know related information and cannot generate sample
> flags for branch instructions.
> 
> This patch add corresponding three new fields in cs_etm_packet struct
> and save related value into the packet structure, it is preparation for
> supporting sample flags.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 9 +++++++++
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 3 +++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 8c155575c6c5..8a19310500d9 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -290,6 +290,9 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
>  		decoder->packet_buffer[i].instr_count = 0;
>  		decoder->packet_buffer[i].last_instr_taken_branch = false;
>  		decoder->packet_buffer[i].last_instr_size = 0;
> +		decoder->packet_buffer[i].last_instr_type = 0;
> +		decoder->packet_buffer[i].last_instr_subtype = 0;
> +		decoder->packet_buffer[i].last_instr_cond = 0;
>  		decoder->packet_buffer[i].cpu = INT_MIN;
>  	}
>  }
> @@ -323,6 +326,9 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
>  	decoder->packet_buffer[et].instr_count = 0;
>  	decoder->packet_buffer[et].last_instr_taken_branch = false;
>  	decoder->packet_buffer[et].last_instr_size = 0;
> +	decoder->packet_buffer[et].last_instr_type = 0;
> +	decoder->packet_buffer[et].last_instr_subtype = 0;
> +	decoder->packet_buffer[et].last_instr_cond = 0;
>  
>  	if (decoder->packet_count == MAX_BUFFER - 1)
>  		return OCSD_RESP_WAIT;
> @@ -366,6 +372,9 @@ cs_etm_decoder__buffer_range(struct cs_etm_decoder *decoder,
>  	packet->start_addr = elem->st_addr;
>  	packet->end_addr = elem->en_addr;
>  	packet->instr_count = elem->num_instr_range;
> +	packet->last_instr_type = elem->last_i_type;
> +	packet->last_instr_subtype = elem->last_i_subtype;
> +	packet->last_instr_cond = elem->last_instr_cond;
>  
>  	switch (elem->last_i_type) {
>  	case OCSD_INSTR_BR:
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> index a6407d41598f..7cdd6a9c68a7 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> @@ -43,6 +43,9 @@ struct cs_etm_packet {
>  	u64 start_addr;
>  	u64 end_addr;
>  	u32 instr_count;
> +	u32 last_instr_type;
> +	u32 last_instr_subtype;
> +	u8 last_instr_cond;
>  	u8 last_instr_taken_branch;
>  	u8 last_instr_size;
>  	int cpu;

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
