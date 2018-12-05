Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F44C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:38:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B33B22082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DAERsZr2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KEyepbLf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B33B22082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1xh2wlFkcDsPOj9lVPfmI5kqoaZfcF5aY7CPTmPV4GY=; b=DAERsZr2FkGQ+Y
	uvYxMzo4EpoN0sG7iT0HoOmichoQYxqfooFIWBjagQkTeRmU+nA3+f+DhN7gcJdOnRq0+sWO06P4V
	I+05Kfj8nrLvIh+AEv31pDe/rHXiRmYDiyJR6cOPzFT42Upqe4LpY1Hlmj+luhjmoozH6HbyDfwqp
	eHzuzYJ2iszc+XXsmAsRK5HnIrcYqr6n9u24MbPxHsUt6mUE8IfxxZWUb9NgleE5SfUB1X3eb3iuN
	ajlVm6Axh/7i1PC7+3AikQPPaH6Fv5ahGyUp9y35jO2uPu2v1b2T0TXYAQm6UPu3robWnbaPbnOW3
	oMjng7c+9dPHF/0G2wEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUQpj-00007A-Jg; Wed, 05 Dec 2018 06:38:55 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUQpg-00006A-ET
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 06:38:53 +0000
Received: by mail-wr1-x434.google.com with SMTP id 96so18412873wrb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 22:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=YaiSxZ5zkOGPVEb7SNIkGxQnViLDgHomOE3rkzH+wJQ=;
 b=KEyepbLfn5jgV2F/LPX1AhONZV1ZhSYUqc9vpS9PODTbg4yDlHzDBVaC2JHadV0X+Y
 dudr3lrwALsby41XvGFezJtr7Ufsf+EBNykIzCiGWoQzNVcoBQO6GgScrd2VKLv4cqa3
 5bOoUw1WU8SxOmPkr3ES8cwADkVOj+p69XXAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=YaiSxZ5zkOGPVEb7SNIkGxQnViLDgHomOE3rkzH+wJQ=;
 b=fCGpwK3fKoAr19+oWBNDUt1bPuQrwNLfhhzhYVxIl+Xr+xtW7LHYj/LQltfyzJaMpV
 QOGuxNxSrbFXZUQxC3LbEKnwIBYBM+wiuvdXC7TO+qOzv+NjYTDIQo3u0CNq4XqYX04I
 HWxfU/lsG4dIwQ52g73IBRHCtB/hLNyrdzg4Ios7D8mBOMypqezpdypkMlLuECTPC8+G
 2dfzi6DUGdemb4SJYVgG+gnigxZgFcyG6jSMEIpmNhm6Eb25rfRTh70d2SbsZq9CFa0T
 utfV2J1DAkYVHFemkxoOr1l8sK7PAzAk1taq6GAxpGEyxGRCCcZrO12Ms+4K8ndkVrt9
 zB3Q==
X-Gm-Message-State: AA+aEWZxhDGgaETbpPelSj43dKab/42PD9Dy6AKZduxNDA81d59cn8yw
 IND1+gmw55jpctAouH6bl1QaFg==
X-Google-Smtp-Source: AFSGD/UIBxZhPvwSzO4XP9p0z5SPl3sTHAnRmegI2zn8LoIhY6PXVWK5gLRTW52hhnRmgK2M+jx1cA==
X-Received: by 2002:a5d:49cd:: with SMTP id t13mr6227276wrs.144.1543991920382; 
 Tue, 04 Dec 2018 22:38:40 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
 by smtp.gmail.com with ESMTPSA id k135sm18248835wmd.42.2018.12.04.22.38.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 22:38:39 -0800 (PST)
Date: Wed, 5 Dec 2018 14:38:32 +0800
From: leo.yan@linaro.org
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v2 2/2] perf cs-etm: Add support sample flags
Message-ID: <20181205063832.GD15964@leoy-ThinkPad-X240s>
References: <1541912876-20967-1-git-send-email-leo.yan@linaro.org>
 <1541912876-20967-3-git-send-email-leo.yan@linaro.org>
 <20181119232202.GA7001@xps15>
 <CANLsYkxQVpSP1D2M_bCni=nkZyo4qC=d33bWC1Xy0_vDfX9Agg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANLsYkxQVpSP1D2M_bCni=nkZyo4qC=d33bWC1Xy0_vDfX9Agg@mail.gmail.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_223852_481585_9920A515 
X-CRM114-Status: GOOD (  21.62  )
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
 Coresight ML <coresight@lists.linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Robert Walker <robert.walker@arm.com>, Jiri Olsa <jolsa@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Nov 20, 2018 at 09:53:41AM -0700, Mathieu Poirier wrote:

[...]

> > > +static void cs_etm__fixup_flags(struct cs_etm_queue *etmq)
> > > +{
> > > +     /*
> > > +      * Decoding stream might insert one TRACE_OFF packet in the
> > > +      * middle of instruction packets, this means it doesn't
> > > +      * contain the pair packets with TRACE_OFF and TRACE_ON.
> > > +      * For this case, the instruction packet follows with
> > > +      * TRACE_OFF packet so we need to fixup prev_packet with flag
> > > +      * PERF_IP_FLAG_TRACE_BEGIN, this flag finally is used by the
> > > +      * instruction packet to generate samples.
> > > +      */
> > > +     if (etmq->prev_packet->sample_type == CS_ETM_TRACE_OFF &&
> > > +         etmq->packet->sample_type == CS_ETM_RANGE)
> > > +             etmq->prev_packet->flags = PERF_IP_FLAG_BRANCH |
> > > +                                        PERF_IP_FLAG_TRACE_BEGIN;
> > > +
> > > +     if (etmq->prev_packet->sample_type == CS_ETM_RANGE) {
> > > +             /*
> > > +              * When the exception packet is inserted, update flags
> > > +              * so tell perf it is exception related branches.
> > > +              */
> > > +             if (etmq->packet->sample_type == CS_ETM_EXCEPTION ||
> > > +                 etmq->packet->sample_type == CS_ETM_EXCEPTION_RET)
> > > +                     etmq->prev_packet->flags = etmq->packet->flags;
> > > +
> > > +             /*
> > > +              * The trace is discontinuous, weather this is caused by
> > > +              * TRACE_ON packet or TRACE_OFF packet is coming, if the
> > > +              * previous packet is instruction packet, simply set flag
> > > +              * PERF_IP_FLAG_TRACE_END for previous packet.
> > > +              */
> > > +             if (etmq->packet->sample_type == CS_ETM_TRACE_ON ||
> > > +                 etmq->packet->sample_type == CS_ETM_TRACE_OFF)
> > > +                     etmq->prev_packet->flags |= PERF_IP_FLAG_TRACE_END;
> > > +     }
> > > +}
> > > +
> >
> > I think it would be better to keep all the flag related processing in
> > cs-etm-decoder.c so that things in cs-etm.c are only concered with dealing with
> > perf.
> >
> > Look at function cs_etm__alloc_queue(), there you'll find "d_params.data = etmq".
> >
> > In function cs_etm_decoder__new(), decoder->data = d_params->data;
> >
> > This means that anywhere you have a decoder, decoder->data is an etmq.  I've
> > used this profusely in my work on CPU-wide trace scenarios.  Because you're
> > getting there ahead of me you'll need to fix the declaration of struct
> > cs_etm_queue but that's easy.
> 
> I've been thinking further about this and manipulating the etmq packet
> and prev_packet from the cs-etm-decoder.c won't work because all we
> have at that time is the decoder's packet queue.  My goal is to
> manipulate the flags in only one place - either in cs-etm.c or
> cs-etm-decoder.c but not in both.  It might be worth trying to do the
> implementation in cs-etm.c since there is already a lot of packet flow
> intelligence happening there.

Agree.  cs-etm.c has more context info than cs-etm-decoder.c, will
try to refactor in single place in cs-etm.c.

[...]

Thanks,
Leo Yan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
