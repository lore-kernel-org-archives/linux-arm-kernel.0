Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDA4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:54:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08C4420827
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ntGjsBSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C4420827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=So2NZF3DMX2oew2b24UBwLwohaXGCNrwVVQEpvFvEic=; b=ntGjsBSLv+VrXu
	h49yXoGK9CWj3dlfuVSXR93Gl7OSok/CGWqD7CHfxlPbqcJF1cteax6fXxX4R4BfCFEJeLFR5+4y7
	HfMtqqlaPSdYBx1LVTtd+2Tsn05jxVScCEkZvdXIW71Gv4AZ3FvslwqZI4k+R9h355LSqYtsIeSQx
	Fo9z81Kmm8WV9vl8GWNBvGtw8wh8RM6tYlwsu8iMklsSG8l14AFun6gx5/E6F0V/AHvAbQg+YVT4R
	j66A6wSErFM3E65J1JHrEERVmYUa3V/g+MHiIx8W+3wm7pPPbquX5vy0vSsu8Ct0bvaD0MNIiRWH5
	OpN4pVrMjMXC5lescVfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggthc-0002cs-Rz; Tue, 08 Jan 2019 15:54:04 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggthZ-0002bF-9l
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 15:54:03 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 19FC88080;
 Tue,  8 Jan 2019 15:54:04 +0000 (UTC)
Date: Tue, 8 Jan 2019 07:53:54 -0800
From: Tony Lindgren <tony@atomide.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
Message-ID: <20190108155354.GL5544@atomide.com>
References: <20190107233833.GI5544@atomide.com>
 <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_075401_377349_2A9EE4A7 
X-CRM114-Status: GOOD (  15.31  )
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

* Vincent Guittot <vincent.guittot@linaro.org> [190108 08:00]:
> Hi Tony,
> 
> On Tue, 8 Jan 2019 at 00:38, Tony Lindgren <tony@atomide.com> wrote:
> >
> > Hi all,
> >
> > Looks like commit 8234f6734c5d ("PM-runtime: Switch autosuspend
> > over to using hrtimers") caused a regression on at least
> > omap5-uevm where 8250 UART rx wake no longer works. I have not
> > noticed this happening on others so far.
> >
> > The devices I've tested all are using 8250 with dedicated
> > wakeirqs configured for the rx pin. I can see the interrupt
> > increase on omap5-uevm after some one or more keypresses,
> > but then nothing. It seems that the uart just falls back
> > asleep right away or something.
> >
> > Any ideas what might be going wrong?
> 
> What is the autosuspend value ? Can it be that the autosuspend is set
> to a short value but was finally greater than 10-20ms on arm32. And
> now the autosuspend happens before and this has changed the sequence ?

It's set to 3 seconds. The difference between let's say
C-A9 pandaboard (that is working) compared to C-A15 omap5-uevm
is that the C-A15 has arch_timer in use. Other than that things
should behave more or less the same way.

Hmm so could it be that we now rely on timers that that may
not be capable of waking up the system from idle states with
hrtimer?

Regards,

Tony


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
