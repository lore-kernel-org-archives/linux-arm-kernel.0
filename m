Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62387C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:02:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3666C2081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n+kXEZAg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cJks+EjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3666C2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IvBmXxns53OJadaLcIl60XyaDg9AnuKkQQ0IkXwEG9s=; b=n+kXEZAg6UM1mH
	6UBNlDLftCo6H4jwNQ+MLeIf8DuUHsWBIBAJ3RYIzCMokQ6D3C3CMzKVdOkp3OZWk3UN+njgxlG6C
	fyBfYylLwciGSlcuqSto+4U3TK2cx9Rro0Bqg4cbPth5Gl5VTJ7MdalLsuUrhsQaWZvN+1IIV/sRg
	4Ni0SibeQ1ROFqEnDNaLwaaIQhVNcFnGawzOQhMTRPnqGZPoCRseXbBCgjGXQsgivosi1G4kNTOFx
	C8rK4uegDqr1eb1TPMe3WeuasoP5LFfibbzMUzCgYnAvHJEGc0kAtUaIWesFSOsZTQP95ox13pvFe
	l3Ce8NtSIiXTf1ZzHv3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWPst-0003YR-NS; Mon, 10 Dec 2018 18:02:23 +0000
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWPsp-0003Xt-Gm
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 18:02:21 +0000
Received: by mail-io1-xd42.google.com with SMTP id r200so9461756iod.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 10:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uFl0eEvOtz6Xbs8l1Y5DM+iasxlKYsSMKPkIeA8sg+s=;
 b=cJks+EjDZwnHR/7flcD7RYPJSjn8DabbWevW1W/G1M1c2bpsH0GPRjFHQBm8AskVz7
 aew/ARW+9uczlmltkuzDMEFTb/fWzAXgKd21SGgVIOkHpSgV/bQ4BJbRyk5mkqyocb6v
 IifGCoT+fmAo/m+QBY6GyBMN8NKYSmW2Uj7ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uFl0eEvOtz6Xbs8l1Y5DM+iasxlKYsSMKPkIeA8sg+s=;
 b=fRQ2MhPFpj29ehtQ+4T9Lrv9+RopTMgR5QEKmm2UkcotmBjA08P5DULvFd6Q4QZiNQ
 yd0H6q9TrTdE3ZWUz7qiP77Dm7SJywQg4mupRSIFWHm5hqceZF2SJ7HwNnxz1rrRqUky
 fYjY4swTjpyUTaRoy+aqvp3qe0QtbbvhxAUwmvrcN8E43aJ0GLH96D9S9M0AYaTtEe/6
 A/Tgohfb+ZWFdlRxG2PNaL1vNzJjGtpmBYwJ85tv1h67AvXwNl0BcH6Rp6bvs/+M/onU
 lW+kmenNmeCPlhsrLEnLA8CGGAtu0e4SHv3UCVjjkX7l3yQqzeia+39Uz4Z7HS7jx7Tz
 sElQ==
X-Gm-Message-State: AA+aEWb5FynIePFB3xIA2fOYnzWpj1bAkz95TIlYMmu20tbQabpFQ/9Z
 5Wxe20qtB9uwqDGXqTrI0mB5L0AVHHtQNUqJgjk4pw==
X-Google-Smtp-Source: AFSGD/V3GFJq6AYLrr/5fp/6m4H7/saKQCTN+DonofFNnovuG6SOkiC0sIaPNEuI+xRu18U+lV+Fi8mf8Yak/T/nVK8=
X-Received: by 2002:a5d:9602:: with SMTP id w2mr1512638iol.86.1544464927974;
 Mon, 10 Dec 2018 10:02:07 -0800 (PST)
MIME-Version: 1.0
References: <CALZhoSRaR-eMyr7HKUTDi5oRiJfRZ7x1NRRM49v-nn6U7e9sJg@mail.gmail.com>
In-Reply-To: <CALZhoSRaR-eMyr7HKUTDi5oRiJfRZ7x1NRRM49v-nn6U7e9sJg@mail.gmail.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Mon, 10 Dec 2018 11:01:55 -0700
Message-ID: <CANLsYkzTGnPQ3FUPWYc-DOigvzMuTFTGqbbVTqqtVuCQW3esSA@mail.gmail.com>
Subject: Re: Coresight etmv4 enable over 32bit kernel
To: adrian.wenl@gmail.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_100219_568716_851BC05E 
X-CRM114-Status: GOOD (  16.93  )
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
Cc: leiwen@outlook.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Good day Adrian,

On Sat, 8 Dec 2018 at 05:05, Lei Wen <adrian.wenl@gmail.com> wrote:
>
> Hi Mathieu,
>
> I am enabling etmv4 coresight over one Cortex-A7 soc, using 32bit kernel.
> And I am following [1] to do experiment regarding the addr_range feature.

That wiki is very old and after reading it again I seriously consider
removing it.  It is still accurate but there are better ways to do
things now, i.e perf.  The main openCSD documentation page [2]
contains everything you need to know about the integration with perf.

[2]. https://github.com/Linaro/OpenCSD/blob/master/HOWTO.md

> The default addr_range is set as _stext~_etext, and it works fine with
> etb as sink,
> and etm as source. I could see there are valid kernel addresses using OpenCSD.

I'm really curious about how you use openCSD to validate your traces -
can you  expand more on that?

I think the results are misleading you since the openCSD library can't
readily be used to decode sysfs trace sessions.  The wiki doesn't
mention using openCSD to decode traces either.  The only integrated
way to use openCSD to decode CoreSight traces is via perf.  Again, the
link above will give you all the information you need to do that.

>
> But while I try to store one small range of address pair, which contain only one
> kernel function. It doesn't behavior like what said in [1], the write
> pointer would
> grows rapidly with the read pointer. And I dump the etb buffer and parse it with
> openCSD, finding that there is no I_ASYNC packet in the dump and is fulled with
> I_NOT_SYNC.
>
> So my question is why ETB continue to grow when there is no trigger at all?
> Is it normal? I could provide more info if you need it.

I am dubious about the validation process and as such can't comment on
this.  Please share your results using the perf integration and then
I'll be able to have a better idea of what is going on.

Taking a step back I am curious about the ETMv4/ETB combination...  Is
the ETB the only sink you have to work with?  Moreover, are you sure
it is not a TMC-ETF?  The ETMv4/ETB match seems a little odd to me
since they belong to two different era of the CoreSight architecture.
Usually with an ETMv4 we will see a TMC-ETR, which as a lot more
capabilities.

Regards,
Mathieu

>
> [1]: https://wiki.linaro.org/WorklingGroups/Kernel/Coresight/traceDecodingWithDS5
>
> Thanks,
> Lei

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
