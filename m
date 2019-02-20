Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E17DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:35:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52FA42147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Nt+xcg3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52FA42147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f/H/FwSRl5elP+2ebB5KsOIbS7v8+4vg/lKwVTOhUIU=; b=Nt+xcg3yDJc632
	qFlou2cl5gg/hF3VpqhfpDXl67bF0bEarBF3VMKNyH8A9Rz25msB4FMwEKN+PRN2BlLgRjTMWzjnm
	iu9pFLOEZdx6DnRVyVbrSCUQjhClGTrHV9RiKDJ64OG69tFHuwvYteqyAncpLUpXvYIe8Dn367bYd
	wOIga/4GW6EELCSGBqK8dIKhFP1QT0xiWV4BpwnJuciLtc0ZGJL/M7goFwdMaG4ASdEjtsvTTUqGi
	iXm9jDA6CDZnYoCuvpQy2GWI5Af074GkJJjWNilQbPJ65Vw+s6QesbjqL+g9KukGJ2vFWrWADGTs5
	16033IYMNyFIfRqjTrjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwUqc-0007M4-OV; Wed, 20 Feb 2019 16:35:50 +0000
Received: from relay1-d.mail.gandi.net ([217.70.183.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwUqY-0007LS-EQ
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 16:35:48 +0000
X-Originating-IP: 185.94.189.187
Received: from localhost (unknown [185.94.189.187])
 (Authenticated sender: maxime.ripard@bootlin.com)
 by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id A4480240003;
 Wed, 20 Feb 2019 16:35:34 +0000 (UTC)
Date: Wed, 20 Feb 2019 17:35:33 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v3 0/8] drm/sun4i: dsi: Add burst mode support
Message-ID: <20190220163533.cehatadivjolo7sk@flea>
References: <cover.f28d9994585553a089a519392616b0d26ed54af1.1549896081.git-series.maxime.ripard@bootlin.com>
 <20190215141244.5jrrqkykna6enbtp@flea>
 <CAMty3ZAA90-fHPADJSE3ht9CiYWA3yBoyEy7wVv9=6C5JiaTVw@mail.gmail.com>
 <c46cd50a-3695-ebc8-0cd4-4ddc27fc353b@openedev.com>
 <8d64d043333e3d43c36d60788d6c5b0997bc4e69.camel@bootlin.com>
 <CAMty3ZDK4Zw4XnSQFmT9C68Kf1LTshnVfMJOEM3ZbXa0AvJT4A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMty3ZDK4Zw4XnSQFmT9C68Kf1LTshnVfMJOEM3ZbXa0AvJT4A@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_083546_777850_FC407A8A 
X-CRM114-Status: GOOD (  29.96  )
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

Hi,

On Mon, Feb 18, 2019 at 04:01:09PM +0530, Jagan Teki wrote:
> On Mon, Feb 18, 2019 at 1:56 PM Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> > On Fri, 2019-02-15 at 22:37 +0530, Jagan Teki wrote:
> > > On 15/02/19 8:10 PM, Jagan Teki wrote:
> > > >
> > > > On Fri, 15 Feb, 2019, 7:43 PM Maxime Ripard, <maxime.ripard@bootlin.com
> > > > <mailto:maxime.ripard@bootlin.com>> wrote:
> > > >
> > > >     On Mon, Feb 11, 2019 at 03:41:21PM +0100, Maxime Ripard wrote:
> > > >      > Hi,
> > > >      >
> > > >      > Here is a series implementing the burst mode support for DSI.
> > > >      >
> > > >      > It's been tested on an A33 board with the panel supported on the last
> > > >      > patch, which should remove all quirks due to a different SoC from the
> > > >      > equation.
> > > >
> > > >     I should have sent that mail yesterday, but patches 1-4 and 6-7 were
> > > >     merged. Patch 5 was discarded since it was not consistent with the
> > > >     rest of the driver, and 8 had some comments.
> > > >
> > > >
> > > > Are the applied patches from this series or from my v7 series?
> > > >
> > > >   Would you please point me the branch.
> > > >
> > >
> > > Unfortunately my last mail didn't reach arm mailing list.
> > >
> > > Just wanted to know are the applied patches from this series or from my
> > > v7 series? Would you please point me the repo, I couldn't find it on
> > > git://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git
> >
> > This series is the one that was applied upstream. You can find the
> > commits merged at: https://cgit.freedesktop.org/drm/drm-misc/log/
> 
> Thanks for sharing the link Paul.
> 
> This is really really discouraging.
> 
> Don't know whom to ask directly about this, but I am really upset
> about this move.

I appreciate and understand that, and I feel sorry it ended up like
this.

> Most of the changes from applied series have similar patches that are
> been part of my series of patches. I've been sending this since last
> September (which was sent way prior than this series).

Note that only the burst part has been merged, and the first time you
sent it was in November.

> How come the same series is recreated and applied with minor changes
> while the original series was still in discussion. At least Maxime
> should have informed me or he should have rejected my work from
> patchwork or atleast NAK in ML?

I did, both in private and public. And I've told you on numerous
occasions what was wrong with your series and the way you were pushing
things. But let's break it down:

v8:
  - Chen-Yu and I spent a lot of time (almost two full work days in my
    case, Chen-Yu at least a full evening from what I know) trying to
    make sense of the Allwinner BSP code, and report what was being
    done. This was made public on the mailing lists, and you were in
    cc [1][2]. It happened the week before your submission, yet you
    ignored most of those changes, and I told you so [3], mentionning
    a bunch of other recurring comments I had that were not really
    addressed.
  - This series and the other also had some obvious flaw that had 0
    chance to work properly (which you eventually noticed[4])

v7:
  - Chen-Yu and I were already discussing and pointing out some
    issues, that were not addressed[5]

v6:
  - Reviewing a PLL issue, already mentionned in the v5 and v2 [6]

v5:
  - I mention that the display I have is broken, just like in your v4 [6].
    Just like in the v4, I'm asking for a panel datasheet so
    that I can help you debug this further. This is ignored.
  - I asked for clarifications on that PLL min_rate, just like in the
    previous versions [7]

v4 
 - I mention that the only other DSI display there is is broken
   [8]. I'm again asking for datasheet and better commit logs.

v3
  - Some more ignored comments [9]

A64 DSI v2
  - Asking details on the PLL min_rate, comments ignored [10]
  - Untested code [11]

Burst v2
  - More details asked, obvious flaws [12]

v1
  - Me asking for better commit logs and some justifications [13][14][15]


TL; DR: there's not been any single iteration of those patches where
you wouldn't have ignored some comments made on a previous iteration,
despite for some patches numerous questions around the same points,
and with very significant time invested in this by numerous people
(Chen-Yu, myself and Paul to a lesser extent).

This is what was completely stalling your series, and I'm sure
frustrating both sides. You even acknowledged that in that mail:
http://lists.infradead.org/pipermail/linux-arm-kernel/2019-February/632060.html

Yet, you submitted your v8 versions without taking our comments into
account.

> All these burst changes and random fixes are reviewed in couple of
> versions, now the versioning moved to v8[1] [2]. For each and every
> versioning I'm trying to fix the previous version comments, code
> improvements, commit messages. In fact for each rotation I'm trying to
> validate 4 different panels which eventually consume all my 16 hours
> in day.
> 
> Please let me know to how could we better collaborate?

By listening and addressing the reviews we are making. If you feel
like you're missing something and / or not understanding everything in
a review (which honestly would be pretty understandable with that
sub-par DSI block documentation), then please ask, but ignoring those
comments will just be a waste of time for everyone involved, and will
frustrate everybody (especially when the time spent is this important).

Like I was saying before, I haven't merged any A64 or panel patches,
so this will be a pretty good occasion to test this.

Maxime

1: http://lists.infradead.org/pipermail/linux-arm-kernel/2019-February/630522.html
2: http://lists.infradead.org/pipermail/linux-arm-kernel/2019-February/630772.html
3: http://lists.infradead.org/pipermail/linux-arm-kernel/2019-February/632076.html
4: https://patchwork.freedesktop.org/patch/286191/
5: https://patchwork.freedesktop.org/patch/280045/
6: https://patchwork.freedesktop.org/patch/253495/
7: https://patchwork.freedesktop.org/patch/267373/
8: https://patchwork.freedesktop.org/patch/267362/
9: https://patchwork.freedesktop.org/patch/261779/
10: https://patchwork.freedesktop.org/patch/258921/
11: https://patchwork.kernel.org/patch/10653309/
12: https://patchwork.kernel.org/patch/10653355/
13: https://patchwork.freedesktop.org/patch/262554/
14: https://patchwork.freedesktop.org/patch/253495/
15: https://patchwork.freedesktop.org/patch/253503/
16: https://patchwork.freedesktop.org/patch/253491/

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
