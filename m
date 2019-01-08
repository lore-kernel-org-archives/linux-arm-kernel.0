Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D43CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:42:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF2A92087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jFTlwc0p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UsGIUpO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF2A92087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LjwTervISUlogc4+xdcnhNQx4Eh+XCd2KdLh752UTn0=; b=jFTlwc0pfzsYME
	U/qGll/NIxBvvQ3KxO/pZDyQAuTCTjjlXzXuwxUwk9n8yyZIvsCmpDf8+YGtnxgqn6n+t3Ju22Xui
	rXTXefxtB7f3SJaTLXUDZxaZqVXNArMjGW59EKGAg3vx7hNwBb9lnT/faO+11AbWG0Bv6EBvAZesh
	6qWKMJT+f2QG7H1MnjFuYkJ/gQP45h9EIp7dr88KURo4r+oaWq6A0tartMPSXxwmWirJTITgoOI0n
	aWHnk7LpyJOnJUOW7S9iURtfGti1NXzuv2EA4qCGaAZlRgta9Q7wTYG3w24irKuNyeIDvY59JD/up
	HfEDavBhc1Lyt6TUrCzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gguSW-0005Rs-V8; Tue, 08 Jan 2019 16:42:32 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gguSL-0005E7-U7
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 16:42:30 +0000
Received: by mail-it1-x141.google.com with SMTP id m8so10421782itk.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 08:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=T77jOpgl5kT9nsJy++gxqYvIqefMlA9GSijxs1pT/Wg=;
 b=UsGIUpO+pD7kOlewF36d5G4TyyYE5FO+ZOSdX+U84B8FptCA8y9qf45KISLT6lSGay
 4dWiWRMWrovQ3OLKBTsPSLwyrff2S66LvaP0lk55hunhTxMEO34/1BIL+gB8y82xFpaH
 gAKqC/x8LGRkTGv4XqxXcoAFae6c3ptqQ5ASo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T77jOpgl5kT9nsJy++gxqYvIqefMlA9GSijxs1pT/Wg=;
 b=KL/aZiyC00WVtQipbbkO7wbFipSAr+KegrCk2YqevfyEL4snaKC+UY042Rbnd9IGEu
 8j+DoJHZWNMiL8UqiTVKlWy80oUZxlI8ydAR6nI4tzEkDIqBwBSdqAjX3fDywU6MESo2
 6KubbN/nNr0P5EhMglBGdWP9MUCzhpboNnYxjLjMycCTEplC4yJk7RRN4oukn9aw7ZJ/
 qODcPh0GzHh40wJdgSCaH0517Rt0Dk8h0zOMRIY1l5AQLzXmZ4Eu3s/Jy3hvBQYSCXmu
 CfqqvcG4t58jo2+Fg6TbkAZmb8MGPXhFUcAW/r9HOI+rXMQj5X/cPueA0fkEJZwxrbwZ
 J+0Q==
X-Gm-Message-State: AJcUukfvPZlKcvE8XSouKIJo2ovZFuhdmafAEjX7RXBV4y8vsZ0Zk14N
 /WchVGUeW468Nlztl6RV48k0AJgSZgjFQN7MniM4LQ==
X-Google-Smtp-Source: ALg8bN6sUDFH6KY+3686EvHTI7eBltskRImQF9pWoUDC40g+tyMtE62dltvynnZjCHtIeLooeCD66UjdGTanvqRjfyE=
X-Received: by 2002:a05:660c:a8f:: with SMTP id
 m15mr1741799itk.114.1546965740395; 
 Tue, 08 Jan 2019 08:42:20 -0800 (PST)
MIME-Version: 1.0
References: <20190107233833.GI5544@atomide.com>
 <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
 <20190108155354.GL5544@atomide.com>
In-Reply-To: <20190108155354.GL5544@atomide.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 8 Jan 2019 17:42:09 +0100
Message-ID: <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
To: Tony Lindgren <tony@atomide.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_084222_556543_3A85ECFF 
X-CRM114-Status: GOOD (  19.70  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org,
 LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 8 Jan 2019 at 16:53, Tony Lindgren <tony@atomide.com> wrote:
>
> * Vincent Guittot <vincent.guittot@linaro.org> [190108 08:00]:
> > Hi Tony,
> >
> > On Tue, 8 Jan 2019 at 00:38, Tony Lindgren <tony@atomide.com> wrote:
> > >
> > > Hi all,
> > >
> > > Looks like commit 8234f6734c5d ("PM-runtime: Switch autosuspend
> > > over to using hrtimers") caused a regression on at least
> > > omap5-uevm where 8250 UART rx wake no longer works. I have not
> > > noticed this happening on others so far.
> > >
> > > The devices I've tested all are using 8250 with dedicated
> > > wakeirqs configured for the rx pin. I can see the interrupt
> > > increase on omap5-uevm after some one or more keypresses,
> > > but then nothing. It seems that the uart just falls back
> > > asleep right away or something.
> > >
> > > Any ideas what might be going wrong?
> >
> > What is the autosuspend value ? Can it be that the autosuspend is set
> > to a short value but was finally greater than 10-20ms on arm32. And
> > now the autosuspend happens before and this has changed the sequence ?
>
> It's set to 3 seconds. The difference between let's say
> C-A9 pandaboard (that is working) compared to C-A15 omap5-uevm
> is that the C-A15 has arch_timer in use. Other than that things
> should behave more or less the same way.
>
> Hmm so could it be that we now rely on timers that that may
> not be capable of waking up the system from idle states with
> hrtimer?

With nohz and hrtimer enabled,  timer relies on hrtimer to generate
the tick so you should use the same interrupt.

>
> Regards,
>
> Tony
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
