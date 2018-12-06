Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69199C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:48:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33E312146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CiyVtMBQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OT5slp1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E312146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Po6WPCMx3tnPF6931Afk6DJv1owJ5FVWPCAcBSTKmLk=; b=CiyVtMBQYy8Xcm
	IDjmrVTVvlb7CJQFX/RPut5N1B5l5gN2IFqchElbhjlYvHp1F0Ho8Tb+81pdurABFQwA0q+KyKf0N
	UiwgtS1/bE/4duXtdrrzXa5P/KE2GCTqvBvzhzL3XVLISEf/VwD4d2XgaFN4ngAwrHNi7htpxAfZ7
	qsYjcko3894ETjMNcilBoRgaO15I4au498cpN/UDZPC9jRDPGvDsKPDQUIHeVvkfPOgPMbTrdmD8p
	G+z5nRYSLDnnufDYhosJuErFb3OEiNqEKP25md8Sxmc7OoH3SaZE8XbIeS5Qxb8p0nRgvUQ+ZKwV3
	h9KY0pHpLevRzTcfl/QA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUmW1-0003Ir-OM; Thu, 06 Dec 2018 05:48:01 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUmVw-0003Hf-ND
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 05:48:00 +0000
Received: by mail-wm1-x344.google.com with SMTP id g67so15081892wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 21:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=r/LCm/PIII5ixONfxT5d8IeI+92VrPuxYpOqN8TpFlY=;
 b=OT5slp1JSIQiMzeuLnOdPnVBwWYnXEeq8rMeHECnXYR5GtfxycpFt9uOXeEinrksL4
 AQ/nW+RiXoSXy2S6yU/PyKdZsZmX30UUZX1UJy4AdnLruCFxS2n7z8s9PwXL/JJIJwxY
 Xn4c5PhjytNVX2kGuPPhL7LNAfoRfqKVtSmT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=r/LCm/PIII5ixONfxT5d8IeI+92VrPuxYpOqN8TpFlY=;
 b=ckzq8s7Y85OYJROQDB3wzhm9pBEk8zXufQDMMG3KOUesdZ+l3Uyw6NiIVQ8vZ9r+5k
 84Em1XYeUutcR4XSQKPjnnEnyYVU3v2yTXkjx5VRC1a+tqyIc1lDeFWrJgYxLF9dVb/b
 Nyn8OlZAU5r1qtSTp3gVac130rS+WVGRxv7JogNIefGQQzZ5MATFVXIwwg2/M4UUbN/O
 io6HRNMyOTZGUT7gpAx8dhLfaXhAAUrW72yuDS9kZU7Pa0m1/2+Er8qnpoJWLoXZoftc
 Qraz2rvaZ7ZJxgxYslUaR736+gOi8HBZOlhCCluZCZ1JdYGvDsGDC+Q7icfvQfyApbxe
 MGqA==
X-Gm-Message-State: AA+aEWb3w7VTi+ddLhHutw5zDXt8gKfOKT266L5uQNMrNoLQLvUfYvfK
 pHxRbppqzUYHO48Are4PRdxN+zydZJrukA==
X-Google-Smtp-Source: AFSGD/UzqxK5925AhONzys+Ms4XgUswpjFmXUX86B0p6l4QsSTy70r0K8RQTak/irpc/5boUSWbrKw==
X-Received: by 2002:a1c:8484:: with SMTP id
 g126mr19097697wmd.117.1544075265108; 
 Wed, 05 Dec 2018 21:47:45 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
 by smtp.gmail.com with ESMTPSA id m15sm15746598wrr.95.2018.12.05.21.47.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 21:47:44 -0800 (PST)
Date: Thu, 6 Dec 2018 13:47:38 +0800
From: leo.yan@linaro.org
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v1 5/5] perf cs-etm: Track exception number
Message-ID: <20181206054738.GC4244@leoy-ThinkPad-X240s>
References: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
 <1541912383-19915-6-git-send-email-leo.yan@linaro.org>
 <20181119204749.GB608@xps15>
 <20181205034950.GB15964@leoy-ThinkPad-X240s>
 <CANLsYkxY1K-TmJKQb3F=T7MGND5pzOZ5ZrK=UZuVihoOAq5p=w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANLsYkxY1K-TmJKQb3F=T7MGND5pzOZ5ZrK=UZuVihoOAq5p=w@mail.gmail.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_214756_761881_9CE1ED57 
X-CRM114-Status: GOOD (  15.65  )
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

On Wed, Dec 05, 2018 at 11:03:29AM -0700, Mathieu Poirier wrote:

[...]

> > > >  static ocsd_datapath_resp_t
> > > >  cs_etm_decoder__buffer_exception(struct cs_etm_decoder *decoder,
> > > > +                            const ocsd_generic_trace_elem *elem,
> > > >                              const uint8_t trace_chan_id)
> > > >  {
> > > > -   return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> > > > -                                        CS_ETM_EXCEPTION);
> > > > +   int ret;
> > > > +   struct cs_etm_packet *packet;
> > > > +
> > > > +   ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> > > > +                                       CS_ETM_EXCEPTION);
> > > > +   if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
> > > > +           return ret;
> > > > +
> > > > +   packet = &decoder->packet_buffer[decoder->tail];
> > > > +
> > > > +   /*
> > > > +    * Exception number is recorded per CPU and later can be used
> > > > +    * for exception return instruction analysis.
> > > > +    */
> > > > +   decoder->exc_num[packet->cpu] = elem->exception_number;
> > >
> > > Am I missing something or the information about the exception number that is
> > > recorded here isn't used anywhere?
> >
> > The exception number will be used to set branch flag patch [1].
> 
> Right, I realised that when I started reviewing that set.  The rule of
> thumb here is to introduce code in the same patchset it is used so
> that we avoid adding needless code to the kernel.

Will move this patch into sample flag series.

Thanks,
Leo Yan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
