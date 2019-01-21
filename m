Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3036CC3712F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:13:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2AE920861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tpOjC+i4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2AE920861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mq+SzUQ7awDo5Vlykz5zkK0RZAD3mpMQWKvnmLDJAu0=; b=tpOjC+i4jgIiMd
	G28PPyjkS8uslmzC1dSjuapfZa81M8wCSkVLzU3ZgejCVydcEmJs2jLyUNmXOOwxwQMCq5qgML8GA
	wvfzmHe0hetphqiwOTg3fW8bvYEWDKiXfuUA23j61V6Z4H8CRawwNDBpxu9VfP56qHdT179PG7XMb
	gaLgosfHH2arcNoWFbKYWIjcU3kPb/chKDXLf6o9w2E3d2T4pWOWPp5o0E54bCxwm+UBixap/G22O
	sBq85cZl2rTnwt59JA1g3VqvMGR2fQvpg+YVOtbBf3Crbh39n/o17q/zx37TEruIJe3yZH3wlUGKt
	gLKTZdr0mGhH6J+7iBKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glhp9-0000kS-Th; Mon, 21 Jan 2019 22:13:43 +0000
Received: from asavdk4.altibox.net ([109.247.116.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glhp5-0000jZ-2u; Mon, 21 Jan 2019 22:13:41 +0000
Received: from ravnborg.org (unknown [158.248.194.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by asavdk4.altibox.net (Postfix) with ESMTPS id 41C438032F;
 Mon, 21 Jan 2019 23:13:32 +0100 (CET)
Date: Mon, 21 Jan 2019 23:13:29 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm: Split out drm_probe_helper.h
Message-ID: <20190121221329.GA6512@ravnborg.org>
References: <20190116163442.12622-1-daniel.vetter@ffwll.ch>
 <20190116181018.GA27364@ravnborg.org>
 <20190117164541.GE3271@phenom.ffwll.local>
 <20190117174531.GA14041@ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190117174531.GA14041@ravnborg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
 a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
 a=kj9zAlcOel0A:10 a=HoD5qxnl0p1esR3YI2YA:9 a=CjuIK1q_8ugA:10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_141339_480126_BC961E3D 
X-CRM114-Status: GOOD (  25.13  )
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
Cc: Neil Armstrong <narmstrong@baylibre.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Liviu Dudau <liviu.dudau@arm.com>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 virtualization@lists.linux-foundation.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel.vetter@intel.com>,
 linux-stm32@st-md-mailman.stormreply.com, linux-samsung-soc@vger.kernel.org,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 amd-gfx@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 nouveau@lists.freedesktop.org, spice-devel@lists.freedesktop.org,
 Jani Nikula <jani.nikula@intel.com>, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 linux-tegra@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, xen-devel@lists.xen.org,
 linux-renesas-soc@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
 freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Daniel et al.

> > 
> > Yeah the drm_crtc_helper.h header is a bit the miniature drmP.h for legacy
> > kms drivers. Just removing it from all the atomic drivers caused lots of
> > fallout, I expect even more if you entirely remove the includes it has.
> > Maybe a todo, care to pls create that patch since it's your idea?
> 
> The main reason I bailed out initially was that this would create
> small changes to several otherwise seldomly touched files.
> And then we would later come and remove drmP.h - so lots of
> small but incremental changes to the same otherwise seldomly
> edited files.
> And the job was only partially done.
> 
> I will try to experiment with an approach where I clean up the
> include/drm/*.h files a little (like suggested above, +delete drmP.h
> and maybe a bit more).
> 
> Then to try on a driver by driver basis to make it build with a
> cleaned set of include files.
> I hope that the cleaned up driver can still build without the
> cleaned header files so the changes can be submitted piecemal.
> 
> Will do so with an eye on the lesser maintained drivers to try it
> out to avoid creating too much chrunch for others.

I have now a few patches queued, but the result is not too pretty.
I did the following:

- For all files in include/drm/*.h the set of include files
  were adjusted to the minimum number of files required to make
  them build without any other files included first.

  Created one .c file for each .h file. Then included the .h
  file and adjusted to the minimal set of include files.
  In the process a lot of forwards were added.

- Deleted drmP.h

- Fixed build of a few drivers: sti, tilcdc, gma500, tve200, via

Some observations:

- Killing all the includes not needed in the headers files
  results in a a lot of extra changes.
  Examples:
    drm_modseset_helper_vtables.h is no longer
    included by anyone, so needs to be added in many files

    drm_atomic_state_helper.h is no longer included
    by anyone so likewise needs to be added in many files

- It is very tedious to do this properly.
  The process I followed was:
  - delete / comment out all include files
  - add back the obvious from a quick scan of the code
  - build - fix - build - fix - build - fix ...
  -   next file...

- The result is errorprone as only the allyesconfig + allmodconfig
  variants are tested. But reallife configurations are more diverse.

Current diffstat:
   111 files changed, 771 insertions(+), 401 deletions(-)

This is for the 5 drivers alone and not the header cleanup.
So long story short - this is not good and not the way forward.

I will try to come up with a few improvements to make the
headers files selfcontained, but restricted to the changes that
add forwards/include to avoid the chrunch in all the drivers.

And then post for review a few patches to clean up some headers.
If the cleanup gets a go I will try to persuade the introduction
of these.
This will include, but will not be limited to, the above mentioned
drm_crtc_helper.h header file.

For now too much time was already spent on this, so it is at the
moment pushed back on my TODO list.
This mail serve also as a kind of "where had I left", when/if I
pick this up again.

If there are anyone that knows some tooling that can help in the
process of adjusting the header files I am all ears.

	Sam

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
