Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B2DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:31:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E48C214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kAt/V8k+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="H62fRTUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E48C214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VyWCeAzLn8j1moD3g66KSwpzVjjOGxcbDOmQ3Zutt50=; b=kAt/V8k+MrmZ9H
	1+Ybgc7o6Wb1+6IBVBa46lwDb0VBYog8yrRFbGeU8SOMJVVme1GgQg6H9+30golAuptpC7XHBHknW
	zzY7+BSrb8nSd4hx1S4b8E0+Vx/iriyRM1J2ZrEjKZJgVNnDOA9kXVf7Qd6ynFgfWVMqatWh84sef
	3jIJ8w/cR0K2JmGLHGxh788K61ursLF3K/PSJJyo7NZLZBoxIDM2jeHORWhRAgeX7iMP+zHYhBFuv
	cyBmoVXUO6HRFrOiGCa/wDYdOMREuQUYHUKopdwrLpOKv+jG6U0uRQJA78G59NfjYUVmaJUZr+Rbu
	7fPT6pJum9k7mohsL2fw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvgCu-0006mN-LQ; Mon, 18 Feb 2019 10:31:28 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvgCq-0006lS-At
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 10:31:26 +0000
Received: by mail-it1-x144.google.com with SMTP id x131so38762074itc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 02:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=E4K+axlQA8c9qW9A7SCZFh5VYNX0Ec6cj0z0/zu20AM=;
 b=H62fRTUFF8Q+CI4GjmS0YIljOsab5lJ3FH688pDa6VhuoaYrdKhSx67anDS0sYtpeD
 MPsLTbuncn5R7qWGeAqQdKeCd2Qp6x44qZVW5CD2p3+duHg2Nh/+I5uByMVPDg8tQtRt
 S/bdKNPQYxbynD+XOyFRR6NGSmOO00xFyh4jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E4K+axlQA8c9qW9A7SCZFh5VYNX0Ec6cj0z0/zu20AM=;
 b=JX8jVWlWLW8jxxBhokAXfTnk3pKN0o3GPoiycNmErXGmscwkSUlbY62b7Bf0cuGZDy
 bhFCGKA4ZHtuyIgXaoYXlecwf27iQ0MXC/rdo6JD5DEBoXeN4uJDboSc2nZFx12dtycT
 gzSRPWHMs5N0rDN+vegB86MxDkbt7B/WSY6C2CWzP1giRmyMghC3ejfhM/eO+2U0Nj94
 wNufvRe5ZDlZWZ8z4ee93qYR0arrCDxey6B9ptk+bFG1vjdwAc18jgsrcl43Dl8aV+Vi
 vlj/XBpy6vbzMjE/7hfbU5W2+bLUtJfxLbuPi7Wkj45cVp6yxU8+m2TWrj9Hlt/2vWi9
 q6Aw==
X-Gm-Message-State: AHQUAuaTJtGlMMD6ezlnrqXNNiMbmz+xHLlHOWpHDpWbd4VWRBczxv1d
 K5MQOOxUfF3/r0ikFXwo/toaYti0wubwgtZSn5lA2Q==
X-Google-Smtp-Source: AHgI3IbqiCJnNP7bFyoe2H4kgoUTyM1Jllif+oGLIKbHc7o8Rj5nLhu43E4N8xJgazd6H7fEj/OT9CKvm6NiSfY9UV8=
X-Received: by 2002:a24:6891:: with SMTP id
 v139mr12371868itb.107.1550485881808; 
 Mon, 18 Feb 2019 02:31:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.f28d9994585553a089a519392616b0d26ed54af1.1549896081.git-series.maxime.ripard@bootlin.com>
 <20190215141244.5jrrqkykna6enbtp@flea>
 <CAMty3ZAA90-fHPADJSE3ht9CiYWA3yBoyEy7wVv9=6C5JiaTVw@mail.gmail.com>
 <c46cd50a-3695-ebc8-0cd4-4ddc27fc353b@openedev.com>
 <8d64d043333e3d43c36d60788d6c5b0997bc4e69.camel@bootlin.com>
In-Reply-To: <8d64d043333e3d43c36d60788d6c5b0997bc4e69.camel@bootlin.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 18 Feb 2019 16:01:09 +0530
Message-ID: <CAMty3ZDK4Zw4XnSQFmT9C68Kf1LTshnVfMJOEM3ZbXa0AvJT4A@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] drm/sun4i: dsi: Add burst mode support
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
 Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_023124_867906_9B78D5FA 
X-CRM114-Status: GOOD (  22.55  )
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
 Chen-Yu Tsai <wens@csie.org>, Sean Paul <seanpaul@chromium.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jagan Teki <jagan@openedev.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Paul and Maxime,

On Mon, Feb 18, 2019 at 1:56 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Hi Jagan,
>
> On Fri, 2019-02-15 at 22:37 +0530, Jagan Teki wrote:
> > Hi Maxime,
> >
> > On 15/02/19 8:10 PM, Jagan Teki wrote:
> > >
> > > On Fri, 15 Feb, 2019, 7:43 PM Maxime Ripard, <maxime.ripard@bootlin.com
> > > <mailto:maxime.ripard@bootlin.com>> wrote:
> > >
> > >     On Mon, Feb 11, 2019 at 03:41:21PM +0100, Maxime Ripard wrote:
> > >      > Hi,
> > >      >
> > >      > Here is a series implementing the burst mode support for DSI.
> > >      >
> > >      > It's been tested on an A33 board with the panel supported on the last
> > >      > patch, which should remove all quirks due to a different SoC from the
> > >      > equation.
> > >
> > >     I should have sent that mail yesterday, but patches 1-4 and 6-7 were
> > >     merged. Patch 5 was discarded since it was not consistent with the
> > >     rest of the driver, and 8 had some comments.
> > >
> > >
> > > Are the applied patches from this series or from my v7 series?
> > >
> > >   Would you please point me the branch.
> > >
> >
> > Unfortunately my last mail didn't reach arm mailing list.
> >
> > Just wanted to know are the applied patches from this series or from my
> > v7 series? Would you please point me the repo, I couldn't find it on
> > git://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git
>
> This series is the one that was applied upstream. You can find the
> commits merged at: https://cgit.freedesktop.org/drm/drm-misc/log/

Thanks for sharing the link Paul.

This is really really discouraging.

Don't know whom to ask directly about this, but I am really upset
about this move.

Most of the changes from applied series have similar patches that are
been part of my series of patches. I've been sending this since last
September (which was sent way prior than this series).

How come the same series is recreated and applied with minor changes
while the original series was still in discussion. At least Maxime
should have informed me or he should have rejected my work from
patchwork or atleast NAK in ML?

All these burst changes and random fixes are reviewed in couple of
versions, now the versioning moved to v8[1] [2]. For each and every
versioning I'm trying to fix the previous version comments, code
improvements, commit messages. In fact for each rotation I'm trying to
validate 4 different panels which eventually consume all my 16 hours
in day.

Please let me know to how could we better collaborate?

[2] https://patchwork.kernel.org/cover/10813573/
[1] https://patchwork.kernel.org/cover/10813623/

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
