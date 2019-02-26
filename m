Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E926BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:49:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B753220684
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fau2Mqbl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="EycbhnqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B753220684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GyIBHxo7+jPIIED4G12LGTFkT6tt3aCcGN8T7L3ivXs=; b=fau2MqblZ+xn76
	q0Xof2OUj9VSSDdWbyyNjOmj1Ssg3DqB0mE72UVIxHmNzJz/opBYCpanPrDZ1zmGYVqR6L1yIL+uF
	rIWh8KvTsCWb/6akeSV47JXSAwoz2siYkTAI0nW8IVbsGshm5VS4y/62uJKOULLgZVEulaF1QEIaO
	h0lTldh2PYzkhVOA6rzKZawDdHOzeDDV8uGxJ/KOag7IY3+wEIqt6Lj2Ryuto3txuHoxp43o57ePC
	1i2XeMnZ8ofuVFjF2DHW9wfxpQ6K+qakqZjc+brdQMj96QtqupzbakyiZC8tkDhyW8yPTSpcWKPpM
	7VVt7uh9PQKM3ing1z2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyWYB-0001Ob-O1; Tue, 26 Feb 2019 06:49:11 +0000
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyWY7-0001OF-A6
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 06:49:10 +0000
Received: by mail-io1-xd42.google.com with SMTP id y13so9644401iop.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 22:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sVHAZ/egTlBNh7OvJT0sp5IVENLITBgL0jas/C8BVGc=;
 b=EycbhnqVN8yc4JLjdWjegehW8f72UaiMHMQOlzuSurKHQs9vfFnOWACrBhVRsXf0hO
 fSz1fWM2/3yTVWrGYqh0C4WdFsHIANHXImpJV3rpSmWTsKvxOAQqIjlj/AdjHKuX0fe1
 1ZoTR1exsHETMprR4IpBA4Ho4cL+fBc9jo3yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sVHAZ/egTlBNh7OvJT0sp5IVENLITBgL0jas/C8BVGc=;
 b=E33HywYWWsNdKmH5+4Cq1VJAMVLZGI/wrc20wXSxlUrvuTnNZ9dwK0Tkny6cP+7NGL
 6Y3HHOAt2VLbf3f65qXsrMxxNi53DObzlDenwA9Atzk5lQjCPb5lZ0K/Zy3vQdRU4j82
 zfO8nY+pd83JIiJRL6NiUs1ET8/5VwfmlcGoxH9pzV7zlXUf/DaDbFZZlXusze1ioNTn
 TcgLAnDKZvlWBoi9AdHxK8th0w4BSZnVTxY56VilnqdWXBUev/lqqIs7L9HMzVG7S4sY
 3PpLN+7AO5QvyOgru6PrgFQmn9j5Cupz7Rp03DVAHeAnLexMHbnksd18cassx+zS8yrF
 tbgg==
X-Gm-Message-State: AHQUAuYrhrHXskW9G7J6t3eD0uwIjJSm/aqbmCQNqLXLZ2ia6BDTmD71
 7fALX6XfymfcSRpZQjrENZ6K/6R4fYbCwfsEIQ2FvA==
X-Google-Smtp-Source: AHgI3IZF6OgObDxAT9aZVWY2ulYriUr6wXkau0e4mtGJqjMyaR0782poxfPLGCq/1o9KDhm1rLsyKC3g6Khz4e3cA7o=
X-Received: by 2002:a5d:97c8:: with SMTP id k8mr12225187ios.267.1551163745890; 
 Mon, 25 Feb 2019 22:49:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.f28d9994585553a089a519392616b0d26ed54af1.1549896081.git-series.maxime.ripard@bootlin.com>
 <20190215141244.5jrrqkykna6enbtp@flea>
 <CAMty3ZAA90-fHPADJSE3ht9CiYWA3yBoyEy7wVv9=6C5JiaTVw@mail.gmail.com>
 <c46cd50a-3695-ebc8-0cd4-4ddc27fc353b@openedev.com>
 <8d64d043333e3d43c36d60788d6c5b0997bc4e69.camel@bootlin.com>
 <CAMty3ZDK4Zw4XnSQFmT9C68Kf1LTshnVfMJOEM3ZbXa0AvJT4A@mail.gmail.com>
 <20190220163533.cehatadivjolo7sk@flea>
In-Reply-To: <20190220163533.cehatadivjolo7sk@flea>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Tue, 26 Feb 2019 12:18:54 +0530
Message-ID: <CAMty3ZDoQNnLAP9fBfEsdUb2ZPyfrATaw-2-FDUgyUO=Rdt_CA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] drm/sun4i: dsi: Add burst mode support
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_224907_821907_30CAD1B8 
X-CRM114-Status: GOOD (  40.91  )
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
Cc: bbrezillon@kernel.org, dri-devel <dri-devel@lists.freedesktop.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Sean Paul <seanpaul@chromium.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jagan Teki <jagan@openedev.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 20, 2019 at 10:05 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> On Mon, Feb 18, 2019 at 04:01:09PM +0530, Jagan Teki wrote:
> > On Mon, Feb 18, 2019 at 1:56 PM Paul Kocialkowski
> > <paul.kocialkowski@bootlin.com> wrote:
> > > On Fri, 2019-02-15 at 22:37 +0530, Jagan Teki wrote:
> > > > On 15/02/19 8:10 PM, Jagan Teki wrote:
> > > > >
> > > > > On Fri, 15 Feb, 2019, 7:43 PM Maxime Ripard, <maxime.ripard@bootlin.com
> > > > > <mailto:maxime.ripard@bootlin.com>> wrote:
> > > > >
> > > > >     On Mon, Feb 11, 2019 at 03:41:21PM +0100, Maxime Ripard wrote:
> > > > >      > Hi,
> > > > >      >
> > > > >      > Here is a series implementing the burst mode support for DSI.
> > > > >      >
> > > > >      > It's been tested on an A33 board with the panel supported on the last
> > > > >      > patch, which should remove all quirks due to a different SoC from the
> > > > >      > equation.
> > > > >
> > > > >     I should have sent that mail yesterday, but patches 1-4 and 6-7 were
> > > > >     merged. Patch 5 was discarded since it was not consistent with the
> > > > >     rest of the driver, and 8 had some comments.
> > > > >
> > > > >
> > > > > Are the applied patches from this series or from my v7 series?
> > > > >
> > > > >   Would you please point me the branch.
> > > > >
> > > >
> > > > Unfortunately my last mail didn't reach arm mailing list.
> > > >
> > > > Just wanted to know are the applied patches from this series or from my
> > > > v7 series? Would you please point me the repo, I couldn't find it on
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git
> > >
> > > This series is the one that was applied upstream. You can find the
> > > commits merged at: https://cgit.freedesktop.org/drm/drm-misc/log/
> >
> > Thanks for sharing the link Paul.
> >
> > This is really really discouraging.
> >
> > Don't know whom to ask directly about this, but I am really upset
> > about this move.
>
> I appreciate and understand that, and I feel sorry it ended up like
> this.
>
> > Most of the changes from applied series have similar patches that are
> > been part of my series of patches. I've been sending this since last
> > September (which was sent way prior than this series).
>
> Note that only the burst part has been merged, and the first time you
> sent it was in November.

at least those were prior to the applied series.

>
> > How come the same series is recreated and applied with minor changes
> > while the original series was still in discussion. At least Maxime
> > should have informed me or he should have rejected my work from
> > patchwork or atleast NAK in ML?
>
> I did, both in private and public. And I've told you on numerous
> occasions what was wrong with your series and the way you were pushing
> things. But let's break it down:
>
> v8:
>   - Chen-Yu and I spent a lot of time (almost two full work days in my
>     case, Chen-Yu at least a full evening from what I know) trying to
>     make sense of the Allwinner BSP code, and report what was being
>     done. This was made public on the mailing lists, and you were in
>     cc [1][2]. It happened the week before your submission, yet you

I really missed this, since I don't have any information from you
about sending my burst changes on behalf of other series. This is
something that I couldn't aware in community project where someone
sent the existing changes w/o informing the real author.

>     ignored most of those changes, and I told you so [3], mentionning
>     a bunch of other recurring comments I had that were not really
>     addressed.

On the other hand, I replied about the real reason why I sent this on
[3.1], these changes were generic and doesn't related to clock. You
have been mentioned about the clock but ie not the reason for holding
the generic changes I suppose.

At one point, I felt myself I'm making confusion with big changes, so
I realized and sent the v7 [1] [2] which would eventually break the
changes into sets those are placed generic burst and A64 support. I
don't know I couldn't see any comments.

>   - This series and the other also had some obvious flaw that had 0
>     chance to work properly (which you eventually noticed[4])
>
> v7:
>   - Chen-Yu and I were already discussing and pointing out some
>     issues, that were not addressed[5]
>
> v6:
>   - Reviewing a PLL issue, already mentionned in the v5 and v2 [6]
>
> v5:
>   - I mention that the display I have is broken, just like in your v4 [6].
>     Just like in the v4, I'm asking for a panel datasheet so
>     that I can help you debug this further. This is ignored.
>   - I asked for clarifications on that PLL min_rate, just like in the
>     previous versions [7]
>
> v4
>  - I mention that the only other DSI display there is is broken
>    [8]. I'm again asking for datasheet and better commit logs.
>
> v3
>   - Some more ignored comments [9]
>
> A64 DSI v2
>   - Asking details on the PLL min_rate, comments ignored [10]
>   - Untested code [11]
>
> Burst v2
>   - More details asked, obvious flaws [12]
>
> v1
>   - Me asking for better commit logs and some justifications [13][14][15]
>
>
> TL; DR: there's not been any single iteration of those patches where
> you wouldn't have ignored some comments made on a previous iteration,
> despite for some patches numerous questions around the same points,
> and with very significant time invested in this by numerous people
> (Chen-Yu, myself and Paul to a lesser extent).
>
> This is what was completely stalling your series, and I'm sure
> frustrating both sides. You even acknowledged that in that mail:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2019-February/632060.html
>
> Yet, you submitted your v8 versions without taking our comments into
> account.
>
> > All these burst changes and random fixes are reviewed in couple of
> > versions, now the versioning moved to v8[1] [2]. For each and every
> > versioning I'm trying to fix the previous version comments, code
> > improvements, commit messages. In fact for each rotation I'm trying to
> > validate 4 different panels which eventually consume all my 16 hours
> > in day.
> >
> > Please let me know to how could we better collaborate?
>
> By listening and addressing the reviews we are making. If you feel
> like you're missing something and / or not understanding everything in
> a review (which honestly would be pretty understandable with that
> sub-par DSI block documentation), then please ask, but ignoring those
> comments will just be a waste of time for everyone involved, and will
> frustrate everybody (especially when the time spent is this important).

I did address all your comments as per as generic burst changes, which
were supposed to fixed in initial versions. here are the changelog for
your information.

Changes for v8:
- rebase on master
- rework on commit messages
- include drq changes from previous version
Changes for v7:
- rebase on master
- collect Merlijn Wajer Tested-by credits.
Changes for v6:
- fixed all burst mode patches as per previous version comments
- rebase on master
- update proper commit message
- dropped unneeded comments
- order the patches that make review easy
Changes for v5, v4, v3, v2:
- use proper return value for tcon0 probe
- add logic to get tcon0 divider values
- simplify timings code to support burst mode
- fix drq computation return values
- update proper commit messages
- rebase on master

>
> Like I was saying before, I haven't merged any A64 or panel patches,
> so this will be a pretty good occasion to test this.

Honestly I didn't frustrate about this work, and  I couldn't see any
proper reason for your response on why you send similar burst changes
w/o informing or NAK my changes. I assume you may feel confused or
frustrated about my series (which I didn't intentionally do that
sorry), so you mark the changes from your side and applied.

Anyway, thanks for your support, I will re-spin my changes on top
these applied changes.

[3.1] http://lists.infradead.org/pipermail/linux-arm-kernel/2019-February/632060.html
[2] https://patchwork.kernel.org/cover/10813623//
[1] https://patchwork.kernel.org/cover/10792981/

Jagan.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
