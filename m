Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BF4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:55:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7715720685
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FijKcoNY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7715720685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7i7RhfSdGAkRCvx416bnPZaNG8Zeim5iRRl6Asec0DA=; b=FijKcoNYBdQ/7g
	OwqPYncOUkIIchYUXDwtlcngrGr4CvLUh5RqcnC+4d9N1GTYEtdNXPfjYrJJwERywcT5UBB2A47/4
	jukuYmVKgzH7HrB/vea2Gx6kZiQkIqTsuDLxHbMgUT4sBD8hVrUI1wnEoZg2WdfNmQNSHGMesqRR/
	InRv0DnGyueMXkDw/Ad+Heq/tSWJk6A1k/qTnxARWA816qlAZiDkcKdbDkpyGvkvB1slD/rfavV0D
	NAmquHdOrCSFBqwpiFbXVlpN7YnM31h3kron+BivR9WVMoPUeByDkJXij3XAeyBPs3g6+OrwGQPE1
	AYGzfhFBDOiOCYzXkkOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghVAz-0003Oh-DP; Thu, 10 Jan 2019 07:54:53 +0000
Received: from eddie.linux-mips.org ([148.251.95.138] helo=cvs.linux-mips.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghVAw-0003OG-7H
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 07:54:51 +0000
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23990945AbfAJHysH0baQ (ORCPT
 <rfc822;linux-arm-kernel@lists.infradead.org>);
 Thu, 10 Jan 2019 08:54:48 +0100
Date: Thu, 10 Jan 2019 08:54:44 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
Message-ID: <20190110075444.GA26920@lenoch>
References: <CAKfTPtAAgYYW8A1LDg18bM=5vCAMDbQ05APp9QWSaifW=F0SgQ@mail.gmail.com>
 <20190109133337.GA13579@lenoch>
 <CAKfTPtAsENRKh_wTFXCLW2_MdMBug+tV2KtjC7x6RigN7hgPmw@mail.gmail.com>
 <20190109160736.GA7416@lenoch>
 <CAKfTPtBnNA6knrsHsZXeaotBSn5mS12xNWNUKdSwZ1EUvueQkA@mail.gmail.com>
 <20190109172623.GB1711@lenoch>
 <CAKfTPtBGh+ShbNCZLiYr4PZJooun7uctuQaomc40czvAk5Yizg@mail.gmail.com>
 <CAJZ5v0jPJYyszAs4qJhqX+5RGwzJoo=+reTS__buoCrfTeYY8Q@mail.gmail.com>
 <20190110074558.GA26167@lenoch>
 <CAKfTPtA53BS0MTW7SaiC7B+KsGmWCiUJW+PzT57CUN5YpGN5vA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKfTPtA53BS0MTW7SaiC7B+KsGmWCiUJW+PzT57CUN5YpGN5vA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_235450_265510_6FF574F3 
X-CRM114-Status: GOOD (  18.26  )
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
 Tony Lindgren <tony@atomide.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 08:50:14AM +0100, Vincent Guittot wrote:
> On Thu, 10 Jan 2019 at 08:46, Ladislav Michl <ladis@linux-mips.org> wrote:
> >
> > On Wed, Jan 09, 2019 at 11:06:34PM +0100, Rafael J. Wysocki wrote:
> > > On Wed, Jan 9, 2019 at 7:05 PM Vincent Guittot
> > > <vincent.guittot@linaro.org> wrote:
> > > >
> > > > On Wed, 9 Jan 2019 at 18:26, Ladislav Michl <ladis@linux-mips.org> wrote:
> > > > >
> > > > > On Wed, Jan 09, 2019 at 05:32:31PM +0100, Vincent Guittot wrote:
> > > > > > On Wed, 9 Jan 2019 at 17:07, Ladislav Michl <ladis@linux-mips.org> wrote:
> > > > > > >
> > > > > > > On Wed, Jan 09, 2019 at 03:12:25PM +0100, Vincent Guittot wrote:
> > > > > > > > Please keep all thread list when replying :-)
> > > > > > >
> > > > > > > Ahh, sorry for that...
> > > > > > > [snip]
> > > > > > > > On Wed, 9 Jan 2019 at 14:33, Ladislav Michl <ladis@linux-mips.org> wrote:
> > > > > > > > > I agree, but it doea all the magic correctly, so you won't need
> > > > > > > > > to touch that code is ktime_t changes (I know, unlikely..)
> > > > > > > >
> > > > > > > > But the current implementation doesn't care of any changes in ktime_t
> > > > > > > > as it uses raw ns
> > > > > > >
> > > > > > > Fair enough, so let's go back to:
> > > > > >
> > > > > > This one looks good for me
> > > > >
> > > > > Lets split is for 'comments fix' patch, which was just send and 'the rest'.
> > > > > Now, 'the rest' can either be v2 of your "PM/runtime: Fix autosuspend_delay on
> > > > > 32bits arch" or will wait for 5.1. You decide :)
> > > >
> > > > I don't really mind.
> > > >
> > > > Rafael,
> > > > Do you prefer to only take the fix for u64 casting problem or do you
> > > > prefer to also take the optimization below in one single patch ?
> > >
> > > The casting problem is a bug and the optimization is next release
> > > material in my view.  Please send the optimization separately.
> >
> > Ok, will send that separately in a few moments...
> > Btw, u64 casting problem seems to be still present in rpm_suspend while
> > computing slack for autosuspend delay greater than 25% of 2^31 (2^33) ns.
> 
> Good point. I will add it to the fix as well

Another nit then, for (u64)(autosuspend_delay) is (u64)autosuspend_delay
enough :)

I'll wait for your v2 before sending optimization patch.

> > Not sure if that triggers any real bug.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
