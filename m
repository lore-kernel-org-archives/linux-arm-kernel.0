Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0094BC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:21:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3EFE2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NfNX6Vqt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cCXG2usp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3EFE2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rOuYSHMJWJIGAO7PMsFFmvaCrKyr6D/9jHcY/M8YhjE=; b=NfNX6VqtBZK5tJ
	1uHetjj9M+8eP+vrhaNH4KU6+C8gYKwhmLcgzymG4q7VM922fY6d2ycq6ExHxmGtQj6uMgZNwmqld
	Vt2CPSJYE2q2x8OuPtK7PHQU+SFAryBUdWEqjZ1nG22EtS46EuCqnqr8eJg/9fdBW/I+SpOYXeJgw
	360/Wkmng7vGmjPpEXwpb7Xr1e8WUQ7r2NXITNdKb/jXSXSPeR/DCZbokWA/32nSdJavOjRAC0Qip
	3reVzNhOr3He++UjOXiAwyuU72H2ORJNkEjvUborTnrmlr6aoHxBh5/fbUqoR2VJ0mOCsDQZVmv4f
	iMSFo3TVRAvdGDypq4oA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXQvk-0000PI-22; Thu, 13 Dec 2018 13:21:32 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQvh-0000PA-UU
 for linux-arm-kernel@bombadil.infradead.org; Thu, 13 Dec 2018 13:21:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D/SYV24iLaqgpZ/h3tavYKQaN/FuCRi+YdbFT+PGgqY=; b=cCXG2uspW+71Ej3MWcjRNIpuO
 Pv8Bk6Ss/zlAIqegnKATn9TEQWUEOZ0yLs4U30x+unrulv/4w+iltLy5bdnhLmLfrC6sKddlgzw7b
 02kJv+M9mi954q0gKs/i6cTtwQn2OVhKkdG+2//4/ftf6PXiI/RLFY+c84sYMxhMlMd1LE/b9CvSJ
 0BdqOPpwnuCd6KtBKUmq4r2iv5NtHypyVhOW6arUx8C4VW3qNHXCEMBB7Awa13JDCdfw/H91GGjLs
 F1FfVChzKkzkMy1+09EAAiDwnqomrVDy+szCaKaTHlbFPJTJGw/7p3OiOxwD+MasTvOeXiKdUIE4F
 n4P35VXyQ==;
Received: from [190.15.121.82] (helo=quaco.ghostprotocols.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQvf-0004HA-SE
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 13:21:28 +0000
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
 id 490D141B1D; Thu, 13 Dec 2018 10:21:26 -0300 (-03)
Date: Thu, 13 Dec 2018 10:21:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: leo.yan@linaro.org
Subject: Re: [PATCH v3 6/8] perf cs-etm: Treat NO_SYNC element as trace
 discontinuity
Message-ID: <20181213132126.GI21027@kernel.org>
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
 <1544513908-16805-7-git-send-email-leo.yan@linaro.org>
 <20181213123854.GE21027@kernel.org>
 <20181213124154.GF21027@kernel.org>
 <20181213130949.GB17663@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181213130949.GB17663@leoy-ThinkPad-X240s>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Coresight ML <coresight@lists.linaro.org>, linux-kernel@vger.kernel.org,
 Namhyung Kim <namhyung@kernel.org>, Robert Walker <robert.walker@arm.com>,
 Jiri Olsa <jolsa@redhat.com>, linux-arm-kernel@lists.infradead.org,
 Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Em Thu, Dec 13, 2018 at 09:09:49PM +0800, leo.yan@linaro.org escreveu:
> Hi Arnaldo,
> 
> On Thu, Dec 13, 2018 at 09:41:54AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Dec 13, 2018 at 09:38:54AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Tue, Dec 11, 2018 at 03:38:26PM +0800, Leo Yan escreveu:
> > > > CoreSight tracer driver might insert barrier packet between different
> > > > buffers, thus the decoder can spot the boundaries based on the barrier
> > > > packet; the decoder is possible to hit a barrier packet and emit a
> > > > NO_SYNC element, then the decoder will find a periodic synchronisation
> > > > point inside that next trace block that starts trace again but does not
> > > > have the TRACE_ON element as indicator - usually because this block of
> > > > trace has wrapped the buffer so we have lost the original point that
> > > > trace was enabled.
> > > > 
> > > > In upper case, it results in the trace stream only inserts the
> > > > OCSD_GEN_TRC_ELEM_NO_SYNC element in the middle of tracing stream, but
> > > > we don't handle NO_SYNC element properly and at the end users miss to
> > > > see the info for trace discontinuity.
> > > 
> > > 
> > > "In upper case"? Maybe:
> > > 
> > > In the former case it causes the insertion of a OCSD_GEN_TRC_ELEM_NO_SYNC
> > > in the middle of the the tracing stream, but as we were npt handling the
> > > NO_SYNC element properly which ends up making users miss the
> > > discontinuity indication"?
> > 
> > > > Though OCSD_GEN_TRC_ELEM_NO_SYNC is different from CS_ETM_TRACE_ON when
> > > > output from the decoder, but both of them indicate the trace data is
> > > 
> > > can we remove the "but" and "of them" (redundant) above?
> > > 
> > > > discontinuous; this patch treats OCSD_GEN_TRC_ELEM_NO_SYNC as trace
> > >                                                                a
> > > > discontinuity and generates CS_ETM_DISCONTINUITY packet for it, so
> > > > cs-etm can handle discontinuity for this case, finally it saves the last
> > >                        it (way too many "discontinuity")
> > > > trace data for previous trace block and restart samples for new block.
> > 
> > I've tentatively done those changes (and a few more) in my local branch,
> > resulting in the wording below, plese let me know if you are ok with it:
> 
> Very appreciate your helping.  Please see some minor typos in below
> commit:
> 
> > commit 148068b45fe2e93b19c06cfc1140ea12ca72eb59
> > Author: Leo Yan <leo.yan@linaro.org>
> > Date:   Tue Dec 11 15:38:26 2018 +0800
> > 
> >     perf cs-etm: Treat NO_SYNC element as trace discontinuity
> >     
> >     The CoreSight tracer driver might insert a barrier packets between
>                                                          packet

                                             I'll remove the 'a' instead, ok?


> >     different buffers, thus the decoder can spot the boundaries based on the
> >     barrier packet; it is possible for the decoder to hit a barrier packet
> >     and emit a NO_SYNC element, then the decoder will find a periodic
> >     synchronisation point inside that next trace block that starts the trace
> >     again but does not have the TRACE_ON element as indicator - usually
> >     because this trace block has wrapped the buffer so we have lost the
> >     original point when the trace was enabled.
> >     
> >     In the first case it causes the insertion of a OCSD_GEN_TRC_ELEM_NO_SYNC
>              former
> >     in the middle of the the tracing stream, but as we were npt handling the
>                                                               not
> >     NO_SYNC element properly which ends up making users miss the
> >     discontinuity indication"?
>                               s/?/.
> 
> Thanks a lot for helping.  If you prefer me to resend the patch set,
> also let me know.

I can fix it, here.
 
> >     Though OCSD_GEN_TRC_ELEM_NO_SYNC is different from CS_ETM_TRACE_ON when
> >     output from the decoder, both indicate that the trace data is
> >     discontinuous; this patch treats OCSD_GEN_TRC_ELEM_NO_SYNC as a trace
> >     discontinuity and generates a CS_ETM_DISCONTINUITY packet for it, so
> >     cs-etm can handle the discontinuity for this case, finally it saves the
> >     last trace data for the previous trace block and restart samples for the
> >     new block.
> >     
> >     Signed-off-by: Leo Yan <leo.yan@linaro.org>
> >     Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> >     Cc: Jiri Olsa <jolsa@redhat.com>
> >     Cc: Mike Leach <mike.leach@linaro.org>
> >     Cc: Namhyung Kim <namhyung@kernel.org>
> >     Cc: Robert Walker <robert.walker@arm.com>
> >     Cc: coresight ml <coresight@lists.linaro.org>
> >     Cc: linux-arm-kernel@lists.infradead.org
> >     Link: http://lkml.kernel.org/r/1544513908-16805-7-git-send-email-leo.yan@linaro.org
> >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > index 1039f364f4cc..bee026e76a4c 100644
> > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > @@ -410,7 +410,6 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
> >  	case OCSD_GEN_TRC_ELEM_UNKNOWN:
> >  		break;
> >  	case OCSD_GEN_TRC_ELEM_NO_SYNC:
> > -		break;
> >  	case OCSD_GEN_TRC_ELEM_TRACE_ON:
> >  		resp = cs_etm_decoder__buffer_discontinuity(decoder,
> >  							    trace_chan_id);
> > 
> > 

-- 

- Arnaldo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
