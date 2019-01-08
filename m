Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C68C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:52:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80E0920827
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CgPD56NL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S7Hcy1Vb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E0920827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-ID:References:From:
	In-Reply-To:To:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r+FYtP5llF+fwXMHPjFf3t4m8tx6/CulNV3CS2OoKpE=; b=CgPD56NLEW4jVy
	NLGLmWvHv1SMPt34EEGMQk6FFYrKynqb02RDCip0d6EOnmaT8zrUZysFb3DaP35+R7pdOvSY8bOt/
	NeJonDXbqg8VcLGoVIKECAqM15boOtUK3xBAUfRNmBnwwTSIOA/h7lzxIBhBaOdNiCRcVhGl34jM2
	6uIJ4oCiQ4v/2pP0KaUyQPvbkv6KZytCwlZhC4guiJ3oGwdRSpIBwTyA1TI/hjGUgLL3nmn7Bvrua
	vSpA20QuGoaWGPUA6wH/yldS8RjyL/NJXjspc27Xxh22PuSgyo9DBzspZSWcjE2Ow3VsMqC3OrX2M
	DzwPPIu9ZVwQmMz3oXRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggwUO-0001Ru-9s; Tue, 08 Jan 2019 18:52:36 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggwUK-0001Gt-Ft
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 18:52:33 +0000
Received: by mail-pg1-x543.google.com with SMTP id j10so2132367pga.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 10:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:content-transfer-encoding:subject:cc:to:in-reply-to
 :from:user-agent:references:message-id:date;
 bh=CZwbN/htHRHZzxXRs1Pr8UB4Vmqq/oNAuuczQzeEzQg=;
 b=S7Hcy1VbYi7dMcqS3COU1x2qHlp9q8BqZKsMuE+Zakvf1LTVUsJr48Ak/YUIBE9+tL
 7aK7C4OSvwFF1zLdTd+zn9092p7+57So/fwfndGAT/epblCCEC6BMRs5NDSs/RqlUAu4
 CrngqgoM7kldSoNSF2fl6WGQUJSu6uLq9VuHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:content-transfer-encoding:subject
 :cc:to:in-reply-to:from:user-agent:references:message-id:date;
 bh=CZwbN/htHRHZzxXRs1Pr8UB4Vmqq/oNAuuczQzeEzQg=;
 b=m+1WsBucqUV0sWWi2XjRRqpxSdySRRoITASjf/FYzy0N/yTXhdD6eS2lIZf5MYb2/U
 qxqfT9cabZUpkP7zq0WnEjaNxlA682Ho4dOH3bEVtf3E+VCDDiEHvASAcAX3DjKLPJDJ
 QzK/nCFpbhiK09pTx0QoRsIEbqTHM3WJANOX1ZIHc+r7I/dZMWUrUZp/9Eosweh9U/fk
 58M072yTjEV62YurPrde9+Jp6X/Dez22ak/IOKLom/RUAEG9G7jD9JOA1eLdQASIbzlJ
 txYM+JAg2tH8hldF13Q/ED0FVYba4r/QQIE4hm/5o+Wc0J2vadnX+r1dtdWeyr/SObYU
 osBQ==
X-Gm-Message-State: AJcUukcHoAj23rKcGa24pzdnS4I+YZmuv4uYgUcWEzDzM8U4HLCyj50G
 BNjDwNRl/mtzjT9Af4ydKok46A==
X-Google-Smtp-Source: ALg8bN7VaArd9TyGYxhgoGC4vY1YqrWhhggm0iEH/+bFdGJ5HWCpjtvFgnJ4Xp1RDU8PJvAZsO435w==
X-Received: by 2002:a63:ef47:: with SMTP id c7mr2587188pgk.386.1546973551377; 
 Tue, 08 Jan 2019 10:52:31 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
 by smtp.gmail.com with ESMTPSA id t87sm227611293pfk.122.2019.01.08.10.52.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 08 Jan 2019 10:52:30 -0800 (PST)
MIME-Version: 1.0
Subject: Re: [PATCH] soc: qcom: rpmh: Avoid accessing freed memory from batch
 API
To: Evan Green <evgreen@chromium.org>, Lina Iyer <ilina@codeaurora.org>
In-Reply-To: <CAE=gft6H29BM5k5q=t-eQ_2LT1GORqqhQReVQZ7VCKn7=Oz=Yg@mail.gmail.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
References: <20190103174657.251968-1-swboyd@chromium.org>
 <20190108174938.GA22547@codeaurora.org>
 <CAE=gft6H29BM5k5q=t-eQ_2LT1GORqqhQReVQZ7VCKn7=Oz=Yg@mail.gmail.com>
Message-ID: <154697354993.15366.3623820425365137828@swboyd.mtv.corp.google.com>
Date: Tue, 08 Jan 2019 10:52:29 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_105232_561041_6F32C133 
X-CRM114-Status: GOOD (  19.78  )
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
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matthias Kaehlcke <mka@chromium.org>, Andy Gross <andy.gross@linaro.org>,
 "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Evan Green (2019-01-08 10:30:04)
> On Tue, Jan 8, 2019 at 9:49 AM Lina Iyer <ilina@codeaurora.org> wrote:
> >
> > diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> > index c7beb6841289..0303a2971d4a 100644
> > --- a/drivers/soc/qcom/rpmh.c
> > +++ b/drivers/soc/qcom/rpmh.c
> > @@ -80,6 +80,7 @@ void rpmh_tx_done(const struct tcs_request *msg, int r)
> >         struct rpmh_request *rpm_msg = container_of(msg, struct rpmh_request,
> >                                                     msg);
> >         struct completion *compl = rpm_msg->completion;
> > +       bool free = rpm_msg->needs_free;
> >
> >         rpm_msg->err = r;
> >
> > @@ -94,7 +95,7 @@ void rpmh_tx_done(const struct tcs_request *msg, int r)
> >         complete(compl);
> >
> >  exit:
> > -       if (rpm_msg->needs_free)
> > +       if (free)
> >                 kfree(rpm_msg);
> >  }
> >
> 
> Hi Lina,
> I think that's a worthy fix, too, and is needed to solve the issue you describe.

Looks like we need both fixes so I can combine them together.

> 
> But I think Stephen's fix is still needed. In the rpmh_write_batch
> scenario, we queue N things into rpmh, but set the same completion for
> all of them. If only the first one completes but not the others, then
> the loop in rpmh_write_batch will call wait_for_completion_timeout N
> times on the same completion, and then goes on to free all N requests,
> even though only the first one is actually done and out of the system
> (well, almost out of the system, with the bug you noticed above).

This code looks an awful lot like kref_put() with a release function
that's a kfree() of the rpm message. Would that simplify the code
somewhat if we made a refcounter (that probably only counted up to 2)
and then properly refcounted the messages? We would have to allocate a
bunch of messages for the batch writing API, but I'm not sure that's a
big deal either.

> 
> We considered having just one completion on the last transfer, but
> then if there's an error part way through you have no way of waiting
> on the transfers that did get submitted. So I think N completions are
> needed.

For that, I'd like to make the batch API know more about the TCS it's
filling so it can know how to unwind the state if something fails. From
what I can tell this function is implemented at the wrong abstraction
level. It should be a lower level function so it can manage the queue
and push multiple messages through.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
