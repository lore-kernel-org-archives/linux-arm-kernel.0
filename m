Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEEEC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:22:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C7AA218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A2KbztkK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOveH2jx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7AA218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I99+mbmsmxNQGxs+1ce2pDB0hRE5D5vPNx8f457mfIc=; b=A2KbztkKU+oRDi
	mwosf3UvWDCl5L32r+BcSK3D20E2I/uaKe0nZFp51yKSeDJ02SXaFKQRXZIEs4jI7xeFVEw+NTQxm
	wof00XnR+ms4d7mpEEI4m/q8LA066QfxpPa2OM7Ug9lazBlAbt+ychW2DT77dhqSmvbtw70NlhnU9
	F/DQpoOq1yHwfySMn9HGQkxFxcPcVDqY2DwLWDlHcGrQbJrvS2/UJ0mQiUwCHUON+Z5T+8oQuBZON
	Tde5aOaK6z3DoEQ7qDEXc2wKVNkhsDQkAlSAmW0j6jUwpPH7NJ3onrd1Oqeummffr2ukhn2n6D4oy
	wwTRRS+4/hq3eBbg6dXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCIE-00057i-KB; Thu, 31 Jan 2019 13:22:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCIA-00057J-R2
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:22:08 +0000
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6E61C218D3;
 Thu, 31 Jan 2019 13:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548940926;
 bh=lFyWlFY3OTw7YfcaS/SfOtQGEx6mDWcLEh4xCRpKnZE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=sOveH2jxkiRTBgu/9fR9BcYqjlUKuUrgWFO/CsbYKTkRvtZ5MqnEZtojSfjWiqXex
 zMC5qJhZtvlyd5TACGbr8BP65Z4B72MLyBvo58mi8LWxfHpXz1N88rrhWfzTv4pZEV
 M4+9bx10afpjJ0yq6WnTrmeuVxvoqCuM/lY3tBpg=
Date: Thu, 31 Jan 2019 14:21:55 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 0/4] drm/atmel-hlcdc: fix plane clipping/rotation issues
Message-ID: <20190131142155.574d1337@bbrezillon>
In-Reply-To: <d2e24b73-dee1-b31a-dc87-02d2e75b6dd2@axentia.se>
References: <20190110151020.30468-1-peda@axentia.se>
 <20190127092709.3863c954@bbrezillon>
 <d2e24b73-dee1-b31a-dc87-02d2e75b6dd2@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_052206_903748_478B3446 
X-CRM114-Status: GOOD (  25.57  )
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 David Airlie <airlied@linux.ie>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 31 Jan 2019 13:13:22 +0000
Peter Rosin <peda@axentia.se> wrote:

> On 2019-01-27 09:27, Boris Brezillon wrote:
> > On Thu, 10 Jan 2019 15:10:28 +0000
> > Peter Rosin <peda@axentia.se> wrote:
> >   
> >> Hi!
> >>
> >> I found an unfortunate issue while recoding plane handling to use
> >> drm_atomic_helper_check_plane_state(). The driver rotates clockwise,
> >> which is not correct. I simply fixed it (patch 1/4), but maybe that
> >> will cause regressions for unsuspecting users who simply assumed
> >> that the clockwise rotation was correct? I don't know what to do
> >> about that? Adding an option to get the old broken behavior seems
> >> useless, wouldn't it be just as easy to just fix whatever app to
> >> rotate the other way instead of adding an option somewhere?
> >>
> >> I have only tested this series on sama5d3, but I did check the docs
> >> for various other chips (sama5d2, sama5d4, sam9n12, sam9g15, sam9g35
> >> and sam9x35) supported by the driver (relevant to patch 4/4).
> >>
> >> Cheers,
> >> Peter
> >>
> >> Peter Rosin (4):
> >>   drm/atmel-hlcdc: rotate planes counterclockwise
> >>   drm/atmel-hlcdc: do not swap w/h of the crtc when a plane is rotated
> >>   drm/atmel-hlcdc: fix clipping of planes  
> > 
> > Queued patches 1-3 to drm-misc-next.  
> 
> Great, thanks.
> 
> >>   drm/atmel-hlcdc: do not immediately disable planes, wait for next
> >>     frame  
> > 
> > Still waiting for Nicolas feedback on this one.  
> 
> [Adding back Nicolas, he seems to have gone missing from the list
> recipients.]
> 
> I have done some testing of that patch and for me it's a definite
> improvement. The test I did was removing a white plane from a white
> background. Without the patch, the driver will output black where
> the plane was for the current frame (since the driver does that
> disc-area thing for the largest hidden part of the background).
> With the patch, I get no visual glitches when removing a plane.
> 
> I use a plane to scroll a text, and if you know what to look for,
> the black rectangle that flickers by as the plane with the scrolling
> text is removed is little bit disturbing. Not a significant problem,
> and maybe only geeks notice it, but still...
> 
> Just wanted to say that the resulting "black hole" mentioned in the
> other thread really does exist and that the patch may make sense
> beyond the fact that it removes usage of undocumented features.
> 
> I have not seen any bad side effects fro the patch, but admittedly
> my testing was very limited and I did not try to remove the plane
> while doing other stuff with the driver. So, there might still be
> reasons for removing planes immediately...

Since everything is now synchronized on vsync events thanks to the
atomic modeset infra (including plane/crtc disable requests), I think
the problem I was trying to fix at the time no longer exists (might
re-appear if we start supporting async plane disable requests which is
anyway not supported by the core). So I think I'll just apply your
patch.

Thanks,

Boris

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
