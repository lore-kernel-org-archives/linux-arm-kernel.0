Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AF9C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:24:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3A8720870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ptjN83bm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eEVGDG2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A8720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=klVc+VTHy1fWmhW+VojBduBNJBSYcHKdWxwRrRP73is=; b=ptjN83bmLcMHT6
	ZmfCxGai0PblKP/po6v+IW7/RltNMUmoAMItKo+D1zO8zEUydYWuecCVxT5Y3/kiwJuUjOk/cvkHr
	EZcEuTImW957pPNGEW3nfV8j4lhkAZQRmZpVGHQ/zy/M9/MnW5Ww3Mhvl4IM+/k5hdHzU7Lxh/haG
	J1/qQFkUxDq2fIjSfhK494iT+mgFxy14QZyOB+6qzNMwr4HdO46ozTP/sf+iZMRfHXNsObibwwXhH
	OwBwQoGJx3llbP+QcyYq9Q876V7Dbz3L+zbh21GThsJB4oEWMGLeoF6kDwc40ygKrz00XtVWalw+I
	ae4p9P35csGgjA6fygpw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXQyC-0001Ef-VG; Thu, 13 Dec 2018 13:24:04 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQy9-0001DD-Js
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 13:24:03 +0000
Received: by mail-wm1-x344.google.com with SMTP id g67so2379284wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 05:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=mUJDGb3j8mgfr9OUxKwbLGWVKSmeSht45XUpgDFnH8k=;
 b=eEVGDG2k5fyXu7Amxoylg3M4fDQ3Goq066JaGSqReXkSZBw7gHsI/hBCfMWDjLSwnJ
 GXBCrY5OeUFN3TQ0kl2cMQXpxO/ifVVLhliGM0BQg+fxIzy7yzUr3CB/6T6g8nrmAaSw
 4NYxcIp5HxzmTbs6zjZIQCMR+H11rkvovlvEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=mUJDGb3j8mgfr9OUxKwbLGWVKSmeSht45XUpgDFnH8k=;
 b=l3AoY4s+yXjucfuDQbx7/laE9JkeOXKfIKZEF7wqac84d2D2Zl+o+OA+qSt3e10Wg3
 td0yDwsXxBjUgNlgJI3YMKfbipruQld/7fdpLiYfvtYCt+/ZkdnNIwMxUXUcCZ5l/WN+
 mGKZXk6ET+GICzL9zZd6X9RL7cV09vOfuVG9RZO+aiWdiL/O6uOZkAu0QMkYJv4R13rY
 7HNZ2WPN8xJ3ueL8EeBxZF6G7EZC7rhYMxeN2T70aTo3hRkJ10qox4WUrInuFtwJsTvu
 zkOOdr6vii5PJLK+Wi7Sk+zUXhGAPHHivsOXP9pNgEmftbRr2L+5hTcm9aqa0B8m/+KH
 MnNw==
X-Gm-Message-State: AA+aEWao4s2ovykEED/mqNOzf+NOsXK9uFlTsmpJMFy2xkgwb10JOaqL
 V+VzpT2Kjf1tWwRXmO1HjPwj8w==
X-Google-Smtp-Source: AFSGD/UWx+FWz8MIYSDKKxn9upjV/fwmTtsn22qpAhzUeOF055wfXuZl/0eGCOHlMABLXl2sNnW3NQ==
X-Received: by 2002:a1c:b94b:: with SMTP id j72mr10133416wmf.11.1544707430043; 
 Thu, 13 Dec 2018 05:23:50 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
 by smtp.gmail.com with ESMTPSA id x15sm2737297wrs.27.2018.12.13.05.23.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Dec 2018 05:23:49 -0800 (PST)
Date: Thu, 13 Dec 2018 21:23:40 +0800
From: leo.yan@linaro.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3 6/8] perf cs-etm: Treat NO_SYNC element as trace
 discontinuity
Message-ID: <20181213132340.GC17663@leoy-ThinkPad-X240s>
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
 <1544513908-16805-7-git-send-email-leo.yan@linaro.org>
 <20181213123854.GE21027@kernel.org>
 <20181213124154.GF21027@kernel.org>
 <20181213130949.GB17663@leoy-ThinkPad-X240s>
 <20181213132126.GI21027@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181213132126.GI21027@kernel.org>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_052401_649301_A620DAC6 
X-CRM114-Status: GOOD (  23.49  )
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

On Thu, Dec 13, 2018 at 10:21:26AM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > > commit 148068b45fe2e93b19c06cfc1140ea12ca72eb59
> > > Author: Leo Yan <leo.yan@linaro.org>
> > > Date:   Tue Dec 11 15:38:26 2018 +0800
> > > 
> > >     perf cs-etm: Treat NO_SYNC element as trace discontinuity
> > >     
> > >     The CoreSight tracer driver might insert a barrier packets between
> >                                                          packet
> 
>                                              I'll remove the 'a' instead, ok?

Yeah.

> > >     different buffers, thus the decoder can spot the boundaries based on the
> > >     barrier packet; it is possible for the decoder to hit a barrier packet
> > >     and emit a NO_SYNC element, then the decoder will find a periodic
> > >     synchronisation point inside that next trace block that starts the trace
> > >     again but does not have the TRACE_ON element as indicator - usually
> > >     because this trace block has wrapped the buffer so we have lost the
> > >     original point when the trace was enabled.
> > >     
> > >     In the first case it causes the insertion of a OCSD_GEN_TRC_ELEM_NO_SYNC
> >              former
> > >     in the middle of the the tracing stream, but as we were npt handling the
> >                                                               not
> > >     NO_SYNC element properly which ends up making users miss the
> > >     discontinuity indication"?
> >                               s/?/.
> > 
> > Thanks a lot for helping.  If you prefer me to resend the patch set,
> > also let me know.
> 
> I can fix it, here.

Thanks a lot!

> > >     Though OCSD_GEN_TRC_ELEM_NO_SYNC is different from CS_ETM_TRACE_ON when
> > >     output from the decoder, both indicate that the trace data is
> > >     discontinuous; this patch treats OCSD_GEN_TRC_ELEM_NO_SYNC as a trace
> > >     discontinuity and generates a CS_ETM_DISCONTINUITY packet for it, so
> > >     cs-etm can handle the discontinuity for this case, finally it saves the
> > >     last trace data for the previous trace block and restart samples for the
> > >     new block.
> > >     
> > >     Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > >     Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > >     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > >     Cc: Jiri Olsa <jolsa@redhat.com>
> > >     Cc: Mike Leach <mike.leach@linaro.org>
> > >     Cc: Namhyung Kim <namhyung@kernel.org>
> > >     Cc: Robert Walker <robert.walker@arm.com>
> > >     Cc: coresight ml <coresight@lists.linaro.org>
> > >     Cc: linux-arm-kernel@lists.infradead.org
> > >     Link: http://lkml.kernel.org/r/1544513908-16805-7-git-send-email-leo.yan@linaro.org
> > >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > 
> > > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > index 1039f364f4cc..bee026e76a4c 100644
> > > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > @@ -410,7 +410,6 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
> > >  	case OCSD_GEN_TRC_ELEM_UNKNOWN:
> > >  		break;
> > >  	case OCSD_GEN_TRC_ELEM_NO_SYNC:
> > > -		break;
> > >  	case OCSD_GEN_TRC_ELEM_TRACE_ON:
> > >  		resp = cs_etm_decoder__buffer_discontinuity(decoder,
> > >  							    trace_chan_id);
> > > 
> > > 
> 
> -- 
> 
> - Arnaldo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
