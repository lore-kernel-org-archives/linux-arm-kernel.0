Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72266C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:04:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 409EC2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LBIyCEAT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4Xf3TEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409EC2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h12hr706zgsJVgodFgsiHE54DkBizJ3pRrUhb4WUYaI=; b=LBIyCEATbqMUHt
	sGRAl0YKq5XB7RBWeskj3pSBaMDHo01QTER1PzyrKF7Qh+RIJwk2elKW1GqtBlv15KhQbzKKkEvS6
	w9MxNy+XJGMrwp2XFjPWtuo7D22c3RI5XCSkGwcBX0ZKfJtnO96AotBVHYuq80pxaHbMN3Z30ok04
	V65v2eOdW+pPVnVMl4V2SJAm6AfCvDfEHtuKr0hL9zL2rvAH2/kJ+U1frMxVsV+DNOV+YXZBhd+8k
	5502YQpj7reBbwY1lyOz/64ZDweGFyOfJ3+J1YdRLiuUt5YWxo5fuhBbjyX4Ge5Qx5dnUS2Ta4avf
	hn2TgtvJUOCF+bsO8PEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUbWe-0005ig-CE; Wed, 05 Dec 2018 18:03:56 +0000
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUbWa-0005hP-Aj
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 18:03:54 +0000
Received: by mail-io1-xd44.google.com with SMTP id f14so11963750iol.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 10:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aWfZeS78Vkx1R058+bEflsF9sIFx63RBTJ9viV3bmPE=;
 b=Z4Xf3TEtbIW8eDV74nk3AVE9E2eifE6bl+pryztTQP0WSgwDE03Tr0qL7Nw26GMdK5
 wnYoMK2C0wKQDAw2qgBTxzAVOhf88t7+b2yDPV+giitUZOGMxNjvW8D/oNpS5FBwkcRs
 3wxlB5ZzOa/4arCbELlFiNOEvheEPgFF7oZWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aWfZeS78Vkx1R058+bEflsF9sIFx63RBTJ9viV3bmPE=;
 b=XTzxBm+GzDMZvKiMdgw1C73BrMTX9orqpC+fLJK16c0yVS8J+WEm+DwfUsaP7yFf/8
 +potsPB866W4jtfRq/703fJdzjMcd6vbM35LnBfFGPcliGnJj8Re+QAb97G79khLKRS1
 NDj/YP8T1tSY40Z3aSJXsHYgp0LTJ3/nmgx2nbomF/PcGQD1rN83auw+Qtu0R49FYeY4
 ypLV5Ylq4cQnVCIJZp+kzjAV2vQVpjh8EaZayjwnay9uEcGBmwjE8x6RgBRr/VIjrjUR
 akvD2XJO+GZtAgDzUUA/WCQRFW5zEDrRAlbBW7aq54wWbyS3ut6mP47orNL/YfI3JEoL
 DicQ==
X-Gm-Message-State: AA+aEWYF/mQ8+jl3DnRQ237JFl+LJW6IpSHjtxKTdgrSmD/xCm7/xE+u
 5jeLgFoV3PyUTr7az0xA0HNFfazmzOT0LeY01xnliA==
X-Google-Smtp-Source: AFSGD/VVxVoA1iYAS8DUaYuslDs6TjP6ByhgvFeUC4srpHiYDFijWu069qopJoAOtLOsCSwRayVVcMcwZUvOClQAMMg=
X-Received: by 2002:a5d:8491:: with SMTP id t17mr19582901iom.11.1544033020093; 
 Wed, 05 Dec 2018 10:03:40 -0800 (PST)
MIME-Version: 1.0
References: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
 <1541912383-19915-6-git-send-email-leo.yan@linaro.org>
 <20181119204749.GB608@xps15>
 <20181205034950.GB15964@leoy-ThinkPad-X240s>
In-Reply-To: <20181205034950.GB15964@leoy-ThinkPad-X240s>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 5 Dec 2018 11:03:29 -0700
Message-ID: <CANLsYkxY1K-TmJKQb3F=T7MGND5pzOZ5ZrK=UZuVihoOAq5p=w@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] perf cs-etm: Track exception number
To: Leo Yan <leo.yan@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_100352_429008_63067955 
X-CRM114-Status: GOOD (  30.75  )
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

On Tue, 4 Dec 2018 at 20:49, <leo.yan@linaro.org> wrote:
>
> On Mon, Nov 19, 2018 at 01:47:49PM -0700, Mathieu Poirier wrote:
> > On Sun, Nov 11, 2018 at 12:59:43PM +0800, Leo Yan wrote:
> > > When an exception packet comes, it contains the info for exception
> > > number; the exception number indicates the exception types, so from it
> > > we can know if the exception is taken for interrupt, system call or
> > > other traps, etc.  But because the exception return packet cannot
> > > delivery exception number correctly by decoder thus when prepare sample
> > > flags we cannot know what's type for exception return.
> > >
> > > This patch adds a new 'exc_num' array in decoder structure to record
> > > exception number per CPU, the exception number is recorded in the array
> > > when the exception packet comes and this exception number can be used by
> > > exception return packet.  If detect there have discontinuous trace with
> > > TRACE_ON or TRACE_OFF packet, the exception number is set to invalid
> > > value.
> > >
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > ---
> > >  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 67 ++++++++++++++++++++++---
> > >  1 file changed, 59 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > index b8cb7a3e..d1a6cbc 100644
> > > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > @@ -43,6 +43,7 @@ struct cs_etm_decoder {
> > >     u32 packet_count;
> > >     u32 head;
> > >     u32 tail;
> > > +   u32 *exc_num;
> > >     struct cs_etm_packet packet_buffer[MAX_BUFFER];
> > >  };
> > >
> > > @@ -368,24 +369,64 @@ static ocsd_datapath_resp_t
> > >  cs_etm_decoder__buffer_trace_off(struct cs_etm_decoder *decoder,
> > >                              const uint8_t trace_chan_id)
> > >  {
> > > -   return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> > > -                                        CS_ETM_TRACE_OFF);
> > > +   int ret;
> > > +   struct cs_etm_packet *packet;
> > > +
> > > +   ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> > > +                                       CS_ETM_TRACE_OFF);
> > > +   if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
> > > +           return ret;
> > > +
> > > +   packet = &decoder->packet_buffer[decoder->tail];
> > > +
> > > +   /* Clear execption number for discontinuous trace */
> > > +   decoder->exc_num[packet->cpu] = UINT32_MAX;
> > > +
> > > +   return ret;
> > >  }
> > >
> > >  static ocsd_datapath_resp_t
> > >  cs_etm_decoder__buffer_trace_on(struct cs_etm_decoder *decoder,
> > >                             const uint8_t trace_chan_id)
> > >  {
> > > -   return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> > > -                                        CS_ETM_TRACE_ON);
> > > +   int ret;
> > > +   struct cs_etm_packet *packet;
> > > +
> > > +   ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> > > +                                       CS_ETM_TRACE_ON);
> > > +   if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
> > > +           return ret;
> > > +
> > > +   packet = &decoder->packet_buffer[decoder->tail];
> > > +
> > > +   /* Clear execption number for discontinuous trace */
> > > +   decoder->exc_num[packet->cpu] = UINT32_MAX;
> > > +
> > > +   return ret;
> > >  }
> > >
> > >  static ocsd_datapath_resp_t
> > >  cs_etm_decoder__buffer_exception(struct cs_etm_decoder *decoder,
> > > +                            const ocsd_generic_trace_elem *elem,
> > >                              const uint8_t trace_chan_id)
> > >  {
> > > -   return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> > > -                                        CS_ETM_EXCEPTION);
> > > +   int ret;
> > > +   struct cs_etm_packet *packet;
> > > +
> > > +   ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> > > +                                       CS_ETM_EXCEPTION);
> > > +   if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
> > > +           return ret;
> > > +
> > > +   packet = &decoder->packet_buffer[decoder->tail];
> > > +
> > > +   /*
> > > +    * Exception number is recorded per CPU and later can be used
> > > +    * for exception return instruction analysis.
> > > +    */
> > > +   decoder->exc_num[packet->cpu] = elem->exception_number;
> >
> > Am I missing something or the information about the exception number that is
> > recorded here isn't used anywhere?
>
> The exception number will be used to set branch flag patch [1].

Right, I realised that when I started reviewing that set.  The rule of
thumb here is to introduce code in the same patchset it is used so
that we avoid adding needless code to the kernel.

> According to exception number we can know it's for system call,
> interrupt or other traps.
>
> [1] http://archive.armlinux.org.uk/lurker/message/20181111.050755.d1c1b257.en.html
>
> > If you want to use this in perf report/script,
> > the exception number will have to be added to the cs_etm_packet struct.
>
> Actually before has discussed this with Mike but found it's hard to
> save the exception number in cs_etm_packet struct.  The reason is the
> exception packet contains the correct exception number, but the
> exception return packet doesn't contain exception number.  Thus this
> patch uses cs_etm_decoder struct to save exception number per CPU
> context when receive exception packet, and later the saved exception
> number will be used by exception return packet.
>
> Please see related discussion at the end of page [2].

I find Mike's point about the possibility of seeing exception returns
without having a prior exception due to various factors very
interesting.  I will make sure to keep an eye out for that in the next
revision.

>
> [2] https://lists.linaro.org/pipermail/coresight/2018-October/001832.html
>
> > I am done with the revision of this set.
>
> Thanks a lot for reviewing.
>
> [...]
>
> Thanks,
> Leo Yan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
