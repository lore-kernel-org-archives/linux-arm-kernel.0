Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8968C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:50:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 595242084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DgQs8w22";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bj8ToTz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595242084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9aAVZzRNk+lHnp7st6Tl0R1qI/6hXvLuuQU78EQR8no=; b=DgQs8w22pqY/+X
	CEkCRcjI7M7LQrgDyLOvzLHrZelb/yFxzcI2JGo5i5cb2lo4QHUtRdmSxzgvibR5dluj2ahj+H1Aa
	jnPQ2P6U5+ZEjyPs8Q0dfhDFuXwsOoGiKQ4o31i3uuPK5MKGq6JUm6wp7KrawcQOOlLUd5O+NZ79J
	hQJo4ojCCSMgdRBZv2H84lh7oGIOdnko2EyxaBhgxg2Tj1iyfTchafKVTgPwg11OgFDb/9kJdImBC
	G+8KnZwgKHWbg4Q+JWsZA3ZKlq2v1Wxv8NIPxaC0Q9X8FZn8coJdYYVc5WcOCSxZzavRk3Sy9KdB6
	rURZXGULSn4rfUuEnrJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUOCU-0000D2-NO; Wed, 05 Dec 2018 03:50:14 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUOCQ-0007P4-CD
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 03:50:12 +0000
Received: by mail-wr1-x442.google.com with SMTP id b14so4527990wru.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 19:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=MzhuMjMGrWaYPBgj7NxnknHks4PiChgmdxDKPESvPbc=;
 b=bj8ToTz0U/XeuaDa194Kl5Fl8S7aXHODD+Ff7zXQmX6p4ifH4Y/OPI5I/f0rCJWtme
 Yq0mg3AGrXPioOAY6IqTuIHcLHCulJcFpDRInk9BPvuscwmlAqwh+rWAvUA7jnT7idkZ
 unhkBB09ZourdALAM9IH0NIgtUAL8XW52qnOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=MzhuMjMGrWaYPBgj7NxnknHks4PiChgmdxDKPESvPbc=;
 b=MkmlLC+ypgmnnCPRG3VI/HAiNQp2/SN+2UEzLnXZbgUN3zsFHjNKm4IzTGh3E55ODr
 0VRBBibXNU4kEGtW7cFzBvIX6VxEtueYybxoOm+HfAp5zSxrH9NAIs7ArwfZN31cbvcE
 ovaP864ccMwn5mu5JG+UZMuMaZA4S0ECoy07XL1xGa83FSRFB1rCt32q1Ne1D6QQW772
 otr5qcZKuVF+NTGqZ63n/aNUsY2PVMXgGHx1IbDhQCs02V1fguDNckXMGDd763XRiyX5
 qpy/nCHu+7sUpnwRo8OaDOeiZ0vKgY7iztM47ZgCjFiV1bdkkNGFKdboueFn+NW1sqRu
 0syQ==
X-Gm-Message-State: AA+aEWaWfSAJ98xB4cuFVg7pmU/urRzxOO4DfKIVRhW2WYnliv1yvjBO
 lg+v7E/xcZu1wDo6Tvuz5uPrVxwC40eyyw==
X-Google-Smtp-Source: AFSGD/W5ZXFHJS9SIZlY4c7hLN0kpMIFwaRXz5fh+wyBPSX2RK0gyp5GQwHplqzUevvj1yrL7cQFEA==
X-Received: by 2002:a5d:5351:: with SMTP id t17mr20015207wrv.288.1543981797276; 
 Tue, 04 Dec 2018 19:49:57 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
 by smtp.gmail.com with ESMTPSA id y13sm3195946wrn.73.2018.12.04.19.49.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 19:49:56 -0800 (PST)
Date: Wed, 5 Dec 2018 11:49:50 +0800
From: leo.yan@linaro.org
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v1 5/5] perf cs-etm: Track exception number
Message-ID: <20181205034950.GB15964@leoy-ThinkPad-X240s>
References: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
 <1541912383-19915-6-git-send-email-leo.yan@linaro.org>
 <20181119204749.GB608@xps15>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181119204749.GB608@xps15>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_195010_422576_86EA6FAD 
X-CRM114-Status: GOOD (  25.93  )
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
Cc: Al Grant <Al.Grant@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Coresight ML <coresight@lists.linaro.org>, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Robert Walker <robert.walker@arm.com>, Jiri Olsa <jolsa@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Nov 19, 2018 at 01:47:49PM -0700, Mathieu Poirier wrote:
> On Sun, Nov 11, 2018 at 12:59:43PM +0800, Leo Yan wrote:
> > When an exception packet comes, it contains the info for exception
> > number; the exception number indicates the exception types, so from it
> > we can know if the exception is taken for interrupt, system call or
> > other traps, etc.  But because the exception return packet cannot
> > delivery exception number correctly by decoder thus when prepare sample
> > flags we cannot know what's type for exception return.
> > 
> > This patch adds a new 'exc_num' array in decoder structure to record
> > exception number per CPU, the exception number is recorded in the array
> > when the exception packet comes and this exception number can be used by
> > exception return packet.  If detect there have discontinuous trace with
> > TRACE_ON or TRACE_OFF packet, the exception number is set to invalid
> > value.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 67 ++++++++++++++++++++++---
> >  1 file changed, 59 insertions(+), 8 deletions(-)
> > 
> > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > index b8cb7a3e..d1a6cbc 100644
> > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > @@ -43,6 +43,7 @@ struct cs_etm_decoder {
> >  	u32 packet_count;
> >  	u32 head;
> >  	u32 tail;
> > +	u32 *exc_num;
> >  	struct cs_etm_packet packet_buffer[MAX_BUFFER];
> >  };
> >  
> > @@ -368,24 +369,64 @@ static ocsd_datapath_resp_t
> >  cs_etm_decoder__buffer_trace_off(struct cs_etm_decoder *decoder,
> >  				 const uint8_t trace_chan_id)
> >  {
> > -	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> > -					     CS_ETM_TRACE_OFF);
> > +	int ret;
> > +	struct cs_etm_packet *packet;
> > +
> > +	ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> > +					    CS_ETM_TRACE_OFF);
> > +	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
> > +		return ret;
> > +
> > +	packet = &decoder->packet_buffer[decoder->tail];
> > +
> > +	/* Clear execption number for discontinuous trace */
> > +	decoder->exc_num[packet->cpu] = UINT32_MAX;
> > +
> > +	return ret;
> >  }
> >  
> >  static ocsd_datapath_resp_t
> >  cs_etm_decoder__buffer_trace_on(struct cs_etm_decoder *decoder,
> >  				const uint8_t trace_chan_id)
> >  {
> > -	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> > -					     CS_ETM_TRACE_ON);
> > +	int ret;
> > +	struct cs_etm_packet *packet;
> > +
> > +	ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> > +					    CS_ETM_TRACE_ON);
> > +	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
> > +		return ret;
> > +
> > +	packet = &decoder->packet_buffer[decoder->tail];
> > +
> > +	/* Clear execption number for discontinuous trace */
> > +	decoder->exc_num[packet->cpu] = UINT32_MAX;
> > +
> > +	return ret;
> >  }
> >  
> >  static ocsd_datapath_resp_t
> >  cs_etm_decoder__buffer_exception(struct cs_etm_decoder *decoder,
> > +				 const ocsd_generic_trace_elem *elem,
> >  				 const uint8_t trace_chan_id)
> >  {
> > -	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> > -					     CS_ETM_EXCEPTION);
> > +	int ret;
> > +	struct cs_etm_packet *packet;
> > +
> > +	ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> > +					    CS_ETM_EXCEPTION);
> > +	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
> > +		return ret;
> > +
> > +	packet = &decoder->packet_buffer[decoder->tail];
> > +
> > +	/*
> > +	 * Exception number is recorded per CPU and later can be used
> > +	 * for exception return instruction analysis.
> > +	 */
> > +	decoder->exc_num[packet->cpu] = elem->exception_number;
> 
> Am I missing something or the information about the exception number that is
> recorded here isn't used anywhere?

The exception number will be used to set branch flag patch [1].
According to exception number we can know it's for system call,
interrupt or other traps.

[1] http://archive.armlinux.org.uk/lurker/message/20181111.050755.d1c1b257.en.html

> If you want to use this in perf report/script,
> the exception number will have to be added to the cs_etm_packet struct.

Actually before has discussed this with Mike but found it's hard to
save the exception number in cs_etm_packet struct.  The reason is the
exception packet contains the correct exception number, but the
exception return packet doesn't contain exception number.  Thus this
patch uses cs_etm_decoder struct to save exception number per CPU
context when receive exception packet, and later the saved exception
number will be used by exception return packet.

Please see related discussion at the end of page [2].

[2] https://lists.linaro.org/pipermail/coresight/2018-October/001832.html

> I am done with the revision of this set.

Thanks a lot for reviewing.

[...]

Thanks,
Leo Yan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
