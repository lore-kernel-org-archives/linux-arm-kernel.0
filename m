Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAC7C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 02:59:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE92C2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 02:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R7Aujc3b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jd2XerM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE92C2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eufxBZZYx8FK+tE2NX7QPejwTzK9XxFCxVz547tznjo=; b=R7Aujc3b5+fToB
	XHXiBybLZemUHc1l0R3c1FnFRmteuyvuXVdInWT35EonIZd4jbURu6xKfchDd0ww8RcDPnZ4m9VQL
	uAmVGsSCncn73tcHvJWz5sZfopq6+PON6aH/+s7WZQwNB/vv+joulgHWhesPMvq+fA3B1HX2sEIs7
	K6XYmW7JPUXT5yP12gLafT1rSUqWzmt/hMQkMTkPTyaektfXmWKFRpUXP+yGqkvFXpX8T0x5mwfba
	eSDTRXtNVF8TfjV8CfaRI/Ajm6yxgQH8bzQJwpTshdGKUxKvIOSoV26C7TnxSQtyHGiOD8qx89zgH
	uedmlb9Z4lo11OCxD5Hw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUNOs-0004D8-LY; Wed, 05 Dec 2018 02:58:58 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUNOp-0004BQ-1E
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 02:58:56 +0000
Received: by mail-wr1-x444.google.com with SMTP id j2so18064624wrw.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 18:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=JtHvc1wKR8UzHTWCRtECIwbWEcC9WmtTV1sPBssAB/8=;
 b=jd2XerM9WriBcE6UWG5K+DgtOKnCM5pYBNbTHSuHJZt7/xbuBc2ndhYzORMnpLFOkY
 sjHBYAboFCueFIbGZy38z6mkZ8CDt1/3b24ZjbtyoAFhRH9Ci3aO1bBR3o0krWw/us/R
 Y0bXKhiKav/++dV38NcUYRTuUK5ATnRZOf6PQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=JtHvc1wKR8UzHTWCRtECIwbWEcC9WmtTV1sPBssAB/8=;
 b=qEWMAZVR0RhMbx3ir42ib4PXOVd4BM1MacfCubxYyhJgPDQGDY0qWYAu+sa5m9Ujf0
 xoI5mj4cKAh0i8qo7SMMtpM7y60M2HcbXs3ZpiByl7uRfKrs+ub3fVNLoOxE2vlDx7nc
 hsR7D9XuYGzwCDtRDAOIV5EVv4lM1yAp+VxC86I4DH6wtX82NvDlCDvs4XeIQ1ZpfM+f
 Jqn86jTNXADFIWnbCGToIWU/kjSuWP4ywrSwRJi9SbcJOYsS/5tqxc3DmsU6XqaGxSi2
 bSSxnb05ceOqs8e8gmYiDhC/nXuuebEEgm3Xid2uAl8CnLzvEJ1wB4ZyIITJkO+9lrud
 VsJA==
X-Gm-Message-State: AA+aEWYAHvW5Ksr4IOp2kjyJvTCzrCKsx1kzK9XLGhS+kSKk1PGX5z0R
 JOm7+vp0xfERLaMDEh+U3/5anz0PVwYgYw==
X-Google-Smtp-Source: AFSGD/UYNE+Z9Y+lPzomXCXMPB4q8JvtSTdyv/YDAGH96l05K0+ArBt+APEwc4U1f9R3ikyIpNAjgQ==
X-Received: by 2002:adf:c612:: with SMTP id n18mr19396951wrg.174.1543978720427; 
 Tue, 04 Dec 2018 18:58:40 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
 by smtp.gmail.com with ESMTPSA id t6sm16910200wru.11.2018.12.04.18.58.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 18:58:39 -0800 (PST)
Date: Wed, 5 Dec 2018 10:58:32 +0800
From: leo.yan@linaro.org
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v1 2/5] perf cs-etm: Avoid stale branch samples when
 flush packet
Message-ID: <20181205025832.GA13305@leoy-ThinkPad-X240s>
References: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
 <1541912383-19915-3-git-send-email-leo.yan@linaro.org>
 <20181116230511.GB25258@xps15>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181116230511.GB25258@xps15>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_185855_076631_B262CD2A 
X-CRM114-Status: GOOD (  20.86  )
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

On Fri, Nov 16, 2018 at 04:05:11PM -0700, Mathieu Poirier wrote:

[...]

> > -static int cs_etm__flush(struct cs_etm_queue *etmq)
> > +static int cs_etm__flush(struct cs_etm_queue *etmq, bool new_packet)
> >  {
> >  	int err = 0;
> >  	struct cs_etm_auxtrace *etm = etmq->etm;
> > @@ -989,6 +989,20 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
> >  
> >  	}
> >  
> > +	/*
> > +	 * If 'new_packet' is false, this time call has no a new packet
> > +	 * coming and 'etmq->packet' contains the stale packet which is
> > +	 * set at the previous time with packets swapping.  In this case
> > +	 * this function is invoked only for flushing branch stack at
> > +	 * the end of buffer handling.
> > +	 *
> > +	 * Simply to say, branch samples should be generated when every
> > +	 * time receive one new packet; otherwise, directly bail out to
> > +	 * avoid generate branch sample with stale packet.
> > +	 */
> > +	if (!new_packet)
> > +		return 0;
> > +
> >  	if (etm->sample_branches &&
> >  	    etmq->prev_packet->sample_type == CS_ETM_RANGE) {
> >  		err = cs_etm__synth_branch_sample(etmq);
> > @@ -1075,7 +1089,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
> >  					 * Discontinuity in trace, flush
> >  					 * previous branch stack
> >  					 */
> > -					cs_etm__flush(etmq);
> > +					cs_etm__flush(etmq, true);
> >  					break;
> >  				case CS_ETM_EMPTY:
> >  					/*
> > @@ -1092,7 +1106,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
> >  
> >  		if (err == 0)
> >  			/* Flush any remaining branch stack entries */
> > -			err = cs_etm__flush(etmq);
> > +			err = cs_etm__flush(etmq, false);
> 
> I understand what you're doing and it will yield the correct results.  What I'm
> not sure about is if we wouldn't be better off splitting cs_etm__flush()
> in order to reduce the complexity of the main decoding loop.  That is rename
> cs_etm__flush() to something like cs_etm__trace_on() and spin off a new
> cs_etm__end_block().  
> 
> It does introduce a little bit of code duplication but I think we'd win in terms
> of readability and flexibility.

Sorry for long delay, Mathieu.

Agree with the idea of splitting cs_etm__flush() into two functions.
Will spin patch for new version.

Thanks,
Leo Yan

> >  	}
> >  
> >  	return err;
> > -- 
> > 2.7.4
> > 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
