Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E36BC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:49:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46FD62084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R2KghiCb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FroNUStp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46FD62084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iCqZaNEln5vo21w1KeWime5ZA7nkJY5u17ruQmNtlXk=; b=R2KghiCb45BZfZ
	+MOLytjLTOmeE5LYtZy4csN/wB2zLQBogyhMhotRXBVifUYmzGCsiR5fRNAOzlYVSh+4RGHljL1xU
	PLVqQylMQYDYjEh/WIqYNuByWGdlOQeJ0Lxe3n5f2DFyylV9NxLOD/vjs2k+Pi22vLOXmwPGpAhq1
	Xmrswo6wf0J9QzifoQfzwtKIcMKKUnezwXTMCUEDBy6aQFvHHdJl/q3/GtudeIusC7fgqFPLKyorP
	tNAoi2ZV3MiHnlakPjQEjBq89OnOYPqq4KQUpq9JhEly1NUO8tO1QQaQRQEMb0VekpsLXfKvr2lPJ
	O1FH/jCQURFf74qviEZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUbIM-0007B1-Vz; Wed, 05 Dec 2018 17:49:11 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUbIJ-00079q-DJ
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 17:49:09 +0000
Received: by mail-it1-x144.google.com with SMTP id i145so22681277ita.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 09:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=d++t2nZr1qCftJckZMZdxevjAVDxBeVn6BBLCL4SvUA=;
 b=FroNUStp70TJN4KhqRKaYBCwDT3fUlbPZb++pAxek99PQQFInr2JTdm5OIJ5VvK4dB
 X3+gcCZBBNO/cCskrq3DXWa5X3UmCdBjqkPR87gdAygL667H+jSz9c2RN3jFbIRC2Wem
 R80EwNtytgcsLP5c6ETAXoFVZuKjjnjf+l0QU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d++t2nZr1qCftJckZMZdxevjAVDxBeVn6BBLCL4SvUA=;
 b=flSL/8+Es+bYe7wF6IYacujxyHlq4o3rGMptnoQhuhKxoOCqXLVwvVPZ3onfPKvLH/
 e6frny4NXa7fNtk2Z+0E47D39KwZ401k6pmZFKpd/XDN8qo2qAslVlhDmJETcc8yuL5Z
 J9cQU+eC46rFLuVucJtil72BoAhfAA7eGr3+yg1N+63/2G4Qh4mZt+4Wlk3M1ZZpN+7w
 067goTpySGhZ1+Ly3YedCWhBdq07mBEAQpa9CG82SgDRxxPPM5bz284IHsOEEpdeylgD
 uCyBZzz8XAZ5LlOYmgE7Am7VuzIIqKTbBQOs4ItVrQ5mWsHqaylEWCeDzypZdin/6M7J
 +tWw==
X-Gm-Message-State: AA+aEWYnTzA5wiODUxDMK36MOgXSqxnWLgy+UD+sLiCQA8WDHbl3QECf
 E2K0nz7/7yXRsTebEshLBPsSkBdodT3xdXTI9ZHV3UwK
X-Google-Smtp-Source: AFSGD/W8hIa7cRxP2mVTCLSzVJeeWpSsSF+m5HT3tksyPR6MoKV7z1PoaCHvhWrDmH3MK4ggIRBXcTwBhZKRC24Tg7s=
X-Received: by 2002:a05:660c:34f:: with SMTP id
 b15mr16548692itl.146.1544032136245; 
 Wed, 05 Dec 2018 09:48:56 -0800 (PST)
MIME-Version: 1.0
References: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
 <1541912383-19915-4-git-send-email-leo.yan@linaro.org>
 <20181119182759.GA608@xps15>
 <20181205033145.GA15964@leoy-ThinkPad-X240s>
In-Reply-To: <20181205033145.GA15964@leoy-ThinkPad-X240s>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 5 Dec 2018 10:48:45 -0700
Message-ID: <CANLsYkyMb58D9JetJN4BdVcaTmurPRqd5BZy99zX=5DA0J9wDA@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] perf cs-etm: Support for NO_SYNC packet
To: Leo Yan <leo.yan@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_094907_451347_820AC5C8 
X-CRM114-Status: GOOD (  39.89  )
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

On Tue, 4 Dec 2018 at 20:31, <leo.yan@linaro.org> wrote:
>
> On Mon, Nov 19, 2018 at 11:27:59AM -0700, Mathieu Poirier wrote:
> > On Sun, Nov 11, 2018 at 12:59:41PM +0800, Leo Yan wrote:
> > > As described in OpenCSD (CoreSight decoder lib), in the decoding stream
> > > it includes one trace element with type OCSD_GEN_TRC_ELEM_NO_SYNC; the
> > > element indicates 'either at start of decode, or after overflow / bad
> > > packet', we should take it as a signal for the tracing off and this will
> > > cause tracing discontinuity.  From the trace dump with 'perf script',
> > > sometimes the element OCSD_GEN_TRC_ELEM_NO_SYNC collaborates with
> > > element OCSD_GEN_TRC_ELEM_TRACE_ON to show the tracing flow have been
> > > turned off and on, in this case the cs-etm code has handled TRACE_ON
> > > packet well so we observe the tracing discontinuity; but in another case
> > > it only inserts the element OCSD_GEN_TRC_ELEM_NO_SYNC into instructions
> > > packets, we miss to handle the case if has only standalone NO_SYNC
> > > element and users cannot receive the info for tracing discontinuity.
> > >
> > > This patch introduces new type CS_ETM_TRACE_OFF to generate packet for
> > > receiving element OCSD_GEN_TRC_ELEM_NO_SYNC from decoder; when generate
> > > sample, CS_ETM_TRACE_OFF packet has almost the same behaviour with
> >
> > Here you have used the word "almost", leading me to beleive there are cases
> > where the handling of TRACE_ON and NO_SYNC packets differ, but the
> > implementation enacts the same behavior for both.
> >
> > Mike or Robert, can you confirm that TRACE_ON and NO_SYNC packets should be
> > treated the same way?
>
> I also would like to get suggestions/comments from Mike and Rob.
>
> For NO_SYNC packet, Mike before has given some explination for it:
>
> "looking at the decoder flow, when the decoder is reset, then it is
> returned to an unsynchronised state and a NO_SYNC will be output.
> With perf, it can concatenate multiple trace buffers into a single
> section of the perf.data file. To ensure that the decode process can
> see the start of a new buffer, the drivers will insert a barrier
> packet between different buffers so that the decoder can spot the
> boundaries. When the decoder hits a barrier packet it will
> automatically reset so that it correctly decodes the next trace
> buffer. This could be what you are seeing here."
>
> So I think there still have some difference between TRACE_ON and
> NO_SYNC packets, TRACE_ON packet indicates the start of trace and it's
> also possible caused by tracing discontinuity; NO_SYNC packets usually
> caused by an unsynchronised state.  But both of them presents
> discontinuity in perf trace data.
>
> I prefer to use two different packet types to present them, this can
> let the code to be more readable and easier to be maintained later.

Absolutely.  Make sure to get to the bottom of the story with Mike
and/or Robert before sending your next patchset.

>
> If you agree with this, I also will rephrase the commit log to avoid
> confusion that these two packets are the same thing.

Yes please.

>
> > Leo, if handling of the TRACE_ON and NO_SYNC packets is the same then we should
> > treat them the same way in cs_etm_decoder__gen_trace_elem_printer(), i.e simply
> > call cs_etm_decoder__buffer_trace_on().  That way packet handling in cs-etm.c
> > doesn't change.  Otherwise see my comments below.
> >
> > > CS_ETM_TRACE_ON packet: both of them invokes cs_etm__flush() to generate
> > > samples for the previous instructions packet, and in cs_etm__sample() it
> > > also needs to generate samples if TRACE_OFF packet is followed by one
> > > sequential instructions packet.  This patch also converts the address to
> > > 0 for TRACE_OFF packet, this is same with TRACE_ON packet as well.
> > >
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > ---
> > >  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 10 ++++++++++
> > >  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  7 ++++---
> > >  tools/perf/util/cs-etm.c                        | 15 +++++++++++----
> > >  3 files changed, 25 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > index 5efb616..9d52727 100644
> > > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > @@ -369,6 +369,14 @@ cs_etm_decoder__buffer_range(struct cs_etm_decoder *decoder,
> > >  }
> > >
> > >  static ocsd_datapath_resp_t
> > > +cs_etm_decoder__buffer_trace_off(struct cs_etm_decoder *decoder,
> > > +                            const uint8_t trace_chan_id)
> > > +{
> > > +   return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> > > +                                        CS_ETM_TRACE_OFF);
> > > +}
> > > +
> > > +static ocsd_datapath_resp_t
> > >  cs_etm_decoder__buffer_trace_on(struct cs_etm_decoder *decoder,
> > >                             const uint8_t trace_chan_id)
> > >  {
> > > @@ -389,6 +397,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
> > >     case OCSD_GEN_TRC_ELEM_UNKNOWN:
> > >             break;
> > >     case OCSD_GEN_TRC_ELEM_NO_SYNC:
> > > +           resp = cs_etm_decoder__buffer_trace_off(decoder,
> > > +                                                   trace_chan_id);
> >
> > If we want to handle NO_SYNC element types, why introduce a "trace_off"
> > function?  Wouldn't it make more sense to call it
> > cs_etm_decoder__buffer_no_sync() ?
>
> Will change to cs_etm_decoder__buffer_no_sync().
>
> > >             decoder->trace_on = false;
> > >             break;
> > >     case OCSD_GEN_TRC_ELEM_TRACE_ON:
> > > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> > > index 9351bd1..a38c97c 100644
> > > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> > > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> > > @@ -23,9 +23,10 @@ struct cs_etm_buffer {
> > >  };
> > >
> > >  enum cs_etm_sample_type {
> > > -   CS_ETM_EMPTY = 0,
> > > -   CS_ETM_RANGE = 1 << 0,
> > > -   CS_ETM_TRACE_ON = 1 << 1,
> > > +   CS_ETM_EMPTY            = 0,
> > > +   CS_ETM_RANGE            = 1 << 0,
> > > +   CS_ETM_TRACE_ON         = 1 << 1,
> > > +   CS_ETM_TRACE_OFF        = 1 << 2,
> >
> > CS_ETM_NO_SYNC, see above comment.  And please don't use indentation.
>
> Will do this.
>
> > >  };
> > >
> > >  enum cs_etm_isa {
> > > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > > index f4fa877..2a0cef9 100644
> > > --- a/tools/perf/util/cs-etm.c
> > > +++ b/tools/perf/util/cs-etm.c
> > > @@ -517,8 +517,9 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
> > >
> > >  static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
> > >  {
> > > -   /* Returns 0 for the CS_ETM_TRACE_ON packet */
> > > -   if (packet->sample_type == CS_ETM_TRACE_ON)
> > > +   /* Returns 0 for TRACE_ON and TRACE_OFF packets */
> > > +   if (packet->sample_type == CS_ETM_TRACE_ON ||
> > > +       packet->sample_type == CS_ETM_TRACE_OFF)
> > >             return 0;
> > >
> > >     return packet->start_addr;
> > > @@ -527,8 +528,9 @@ static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
> > >  static inline
> > >  u64 cs_etm__last_executed_instr(const struct cs_etm_packet *packet)
> > >  {
> > > -   /* Returns 0 for the CS_ETM_TRACE_ON packet */
> > > -   if (packet->sample_type == CS_ETM_TRACE_ON)
> > > +   /* Returns 0 for TRACE_ON and TRACE_OFF packets */
> > > +   if (packet->sample_type == CS_ETM_TRACE_ON ||
> > > +       packet->sample_type == CS_ETM_TRACE_OFF)
> > >             return 0;
> > >
> > >     return packet->end_addr - packet->last_instr_size;
> > > @@ -930,6 +932,10 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
> > >             if (etmq->prev_packet->sample_type == CS_ETM_TRACE_ON)
> > >                     generate_sample = true;
> > >
> > > +           /* Generate sample for tracing off packet */
> > > +           if (etmq->prev_packet->sample_type == CS_ETM_TRACE_OFF)
> > > +                   generate_sample = true;
> > > +
> > >             /* Generate sample for branch taken packet */
> > >             if (etmq->prev_packet->sample_type == CS_ETM_RANGE &&
> > >                 etmq->prev_packet->last_instr_taken_branch)
> > > @@ -1085,6 +1091,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
> > >                                     cs_etm__sample(etmq);
> > >                                     break;
> > >                             case CS_ETM_TRACE_ON:
> > > +                           case CS_ETM_TRACE_OFF:
> > >                                     /*
> > >                                      * Discontinuity in trace, flush
> > >                                      * previous branch stack
> > > --
> > > 2.7.4
> > >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
