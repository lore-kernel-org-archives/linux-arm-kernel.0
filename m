Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE0CC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:37:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB2620818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IQkCvyx+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="RbWgzM3m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB2620818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GhTWtkgdo1FmvqlgAThJCkUxDrcvSyAUg1qrewacW60=; b=IQkCvyx+TQv8Sv
	3FCiS2C1sQuxm1E+DiFrX/PWcTivRglwNmIrajI/eyqXSwsxUt1g27e+uZc9W3DJHWm0hPjTOi7Gu
	hyKnAHIWQLH1zEOtkhQRkUuaFCTd6ZloWPdCXh0YZrTb2ZNyMEU9Ic4w1eSUjG8Cjzb4UjPkdgXeL
	6XevEwpADiQWQNyskixoSKm1rEUF4EHtE4eRTrnDyfmTEWoZxRW+c+EZ65p4WyjHOJOOs1ZYq4ZWb
	q9/RZw8OXHlqHSL+LQPL668zMSdeEPtkSkwKDz3X8SQbsFbv/2ktJAkf2qm9zbpTYNR4VAisuY0mP
	AI5zMPPeQ2Gbc2CkG4IA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr3iV-0008GU-EE; Tue, 05 Feb 2019 16:36:59 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr3iR-00086E-FX
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 16:36:58 +0000
Received: by mail-ed1-x541.google.com with SMTP id t6so2125048edw.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 08:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=NCWl2rZuNpmuusiByoU99JE1aHjQzvnYqy/GbvIQvoA=;
 b=RbWgzM3mDmGqXDOz0+0PTRedcCYRzi3bdd808ItyyvzujLq8PEb5ThuiydoHwnnqIz
 ieTq1qEkuAyI90wmc9DjSw1SYh3otPBW89TBw9aiD2s+USkkDFOYCUMkEEd1/agQt+ic
 AA/sWicjoIoT6tQRKrnTcMCqbD5NFlSO6vJQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=NCWl2rZuNpmuusiByoU99JE1aHjQzvnYqy/GbvIQvoA=;
 b=JdX306DWXNVMdND3zq49+IweHvYU2D0gjJmeUPp+i+MZ2/gH+2ncOrgyIVJGym15vS
 EDyHBvpUNRRGZkxoH2VytudQFG0n1iEXyUSpRJZqbtUEEeBg6f8ADZBxcmF9K/5xZaov
 ysbX1dCRZYANMP6tmQk4GUMm+H3dKpA8RlysbiPFzFWPuEsRujvp5fcaj/pfrKlcX3uI
 9nrQtpLUOHnII0O3cE2X/ji0VWxfw8L3mNzWdqIhRhK0RB62oS4mBVhAMCy5vygvo+lR
 +95aarj5bTcvZNyKOMgoXA2gU3wzv3yl4hFviNQ1/RE3peMXQNtdZC84gBpH+GnWHwPY
 XYzA==
X-Gm-Message-State: AHQUAubGbIhsiKblcBCQ+KUEwzfR/biskjTRmi48CwH/DCYgqRW1LfI3
 W9KM+F+w0x6WFaJDk0+SBnzTKQ==
X-Google-Smtp-Source: AHgI3IbOwL8i3nelCsc5CZiGfI797G8earx/7I4na0s3SjRSA96IVDpC5VPuwcCKoeAdl2aX3XfQiQ==
X-Received: by 2002:a50:ad55:: with SMTP id z21mr4665294edc.74.1549384613001; 
 Tue, 05 Feb 2019 08:36:53 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
 by smtp.gmail.com with ESMTPSA id e35sm5213751eda.13.2019.02.05.08.36.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 05 Feb 2019 08:36:51 -0800 (PST)
Date: Tue, 5 Feb 2019 17:36:49 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH RESEND v2 08/12] dt-bindings: add binding for generic eDP
 panel
Message-ID: <20190205163649.GG3271@phenom.ffwll.local>
References: <20190203185501.8958-9-anarsoul@gmail.com>
 <20190204074350.GC16448@ulmo>
 <CA+E=qVecudACOEXt74Kf=UA_F-uuHgEqHzKpYAq1ocMx3Sx+eQ@mail.gmail.com>
 <20190204082353.GE19087@ulmo>
 <20190204094012.GP3271@phenom.ffwll.local>
 <20190204112218.GB10412@ulmo>
 <20190204155909.GU3271@phenom.ffwll.local>
 <20190204162258.GB25476@ulmo>
 <20190205085737.GY3271@phenom.ffwll.local>
 <20190205102419.GA591@ulmo>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190205102419.GA591@ulmo>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_083655_755633_0BB963A6 
X-CRM114-Status: GOOD (  51.95  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Archit Taneja <architt@codeaurora.org>, Andrzej Hajda <a.hajda@samsung.com>,
 David Airlie <airlied@linux.ie>, linux-sunxi <linux-sunxi@googlegroups.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Sean Paul <seanpaul@chromium.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 arm-linux <linux-arm-kernel@lists.infradead.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 05, 2019 at 11:24:19AM +0100, Thierry Reding wrote:
> On Tue, Feb 05, 2019 at 09:57:37AM +0100, Daniel Vetter wrote:
> > On Mon, Feb 04, 2019 at 05:22:58PM +0100, Thierry Reding wrote:
> > > On Mon, Feb 04, 2019 at 04:59:09PM +0100, Daniel Vetter wrote:
> > > > On Mon, Feb 04, 2019 at 12:22:18PM +0100, Thierry Reding wrote:
> > > > > On Mon, Feb 04, 2019 at 10:40:12AM +0100, Daniel Vetter wrote:
> > > > > > On Mon, Feb 04, 2019 at 09:23:59AM +0100, Thierry Reding wrote:
> > > > > > > On Mon, Feb 04, 2019 at 12:13:55AM -0800, Vasily Khoruzhick wrote:
> > > > > > > > On Sun, Feb 3, 2019 at 11:43 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Sun, Feb 03, 2019 at 10:54:57AM -0800, Vasily Khoruzhick wrote:
> > > > > > > > > > eDP panels usually have EDID EEPROM, so there's no need to define panel
> > > > > > > > > > width/height or any modes/timings in dts. But this panel still may have
> > > > > > > > > > regulator and/or backlight.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > > > > > > > > ---
> > > > > > > > > >  .../devicetree/bindings/display/panel/panel-edp.txt        | 7 +++++++
> > > > > > > > > >  1 file changed, 7 insertions(+)
> > > > > > > > > >  create mode 100644 Documentation/devicetree/bindings/display/panel/panel-edp.txt
> > > > > > > > >
> > > > > > > > > Please don't try to make panels look more generic than they really are.
> > > > > > > > > You're going to have to provide a compatible string for your device that
> > > > > > > > > is more specific than "panel-edp". You claim that you don't need any
> > > > > > > > > extra information that is panel specific, but you don't know that now.
> > > > > > > > > We have in the past thought that we didn't need things like prepare
> > > > > > > > > delay, but then we ran into situations where we did need them.
> > > > > > > > >
> > > > > > > > > Just do what everybody else does. Provide a specific compatible string
> > > > > > > > > and match on that in the panel-simple driver. Even if you can read all
> > > > > > > > > the video timings from an EDID EEPROM, you can still provide a mode in
> > > > > > > > > the panel descriptor to serve as a fallback if for example the EEPROM
> > > > > > > > > is faulty on some device.
> > > > > > > > 
> > > > > > > > Pinebook used several 768p panels that have slightly different timings
> > > > > > > > and recent batch uses 1080p panel.
> > > > > > > > 
> > > > > > > > What panel descriptor should I use as fallback?
> > > > > > > 
> > > > > > > You don't use panel descriptors as fallback. The simple-panel driver
> > > > > > > will bind to a panel device and use the corresponding descriptor. If
> > > > > > > your device tree contains the correct information, the descriptor is
> > > > > > > correct for the panel you have.
> > > > > > > 
> > > > > > > In other words you need to ensure that you have the correct panel in
> > > > > > > device tree for the board that you're using. This is exactly the same
> > > > > > > thing as for other devices.
> > > > > > > 
> > > > > > > One way to to this is to have separate device trees for each variant
> > > > > > > of the board that you want to support. Another variant may be to have
> > > > > > > a common device tree and then have some early firmware update the DTB
> > > > > > > with the correct panel information.
> > > > > > 
> > > > > > This would defeat the point of edp, which is to standardize the mess of
> > > > > > panels (at least somewhat) and avoid having to change the DT/ACPI
> > > > > > tables/firmware for every board you ship. Also, we do have DP quirking
> > > > > > infrastructure already (using the OUI), I think if there's something that
> > > > > > doesn't work then we should quirk it there.
> > > > > 
> > > > > The problem is that while the attempt may have been to standardize, it
> > > > > failed. It doesn't take into account any of the details such as timing
> > > > > between things like powering up the display and enabling the backlight
> > > > > or similar. I don't know how you'd want to "quirk" those kinds of
> > > > > requirements because they are highly panel specific.
> > > > 
> > > > Hm right, we get these from some firmware tables (and mix them with the
> > > > spec one, since some of the firmware values are nonsense). I don't even
> > > > know whether we can read the timings over dp aux somehow (you can power up
> > > > the panel with some pessimistic values to figure those out, and you only
> > > > need dp aux to work, which is much simpler than the entire panel).
> > > > 
> > > > > > What does make sense though imo is if we try not to stuff the edp panel
> > > > > > into panel-simple, because it's anything like a simple dumb panel. There's
> > > > > > also some integration awkwardness since with this panel you need to do dp
> > > > > > aux/i2c transactions to get at the information (edid alone isn't good
> > > > > > enough for edp), and I'm not sure how exactly that's supposed to be
> > > > > > instantiated. Maybe a special function to instantiate an edp panel, which
> > > > > > takes both a DT node and the dp_aux controller would be much better,
> > > > > > instead of trying to auto-match against a DT compatible string and load a
> > > > > > panel driver which is almost all fake.
> > > > > > 
> > > > > > Or we teach dp_aux to register itself and somehow teach panel-edp how it
> > > > > > can get hold of the dp_aux channel it needs.
> > > > > 
> > > > > We already do that. drm_dp_aux registers as an I2C adapter that can be
> > > > > used to read EDID EEPROMs using I2C-over-AUX transactions. We already
> > > > > use that on some platforms.
> > > > > 
> > > > > Also note that simple-panel already supports getting video timings from
> > > > > EDID. If a DDC link is present in DT, the driver will load the modes
> > > > > from EDID and use them.
> > > > 
> > > > Could we extend this to dp aux somehow? For edp you need the dp aux (which
> > > > then gives you the ddc link automatically).
> > > 
> > > I suppose we could do that. We could introduce a new property that would
> > > allow the panel driver to get at the struct drm_dp_aux that can access
> > > the panel. I'm not sure how much that would buy us. I suppose the driver
> > > could go and use that drm_dp_aux to do I2C-over-AUX and ignore any
> > > ddc-bus property in device tree. A drm_dp_aux object could also be used
> > > to access DPCD if that's helpful.
> > > 
> > > The driver proposed here doesn't need access to DPCD, so I'm not sure
> > > that would immediately help.
> > 
> > You definitely need dp aux to drive edp. That's where a lot of the really
> > important stuff is stored, and it sounds like on non-broken panels even
> > the timings (we've never implemented that on i915 somehow).
> 
> I'm not sure I understand what you're saying here. I haven't worked with
> eDP panels in a while, but my recollection is that you can use DP AUX to
> read video timings over EDID. We provide support for that by exporting a
> DP AUX controller as I2C adapter (i.e. register with the I2C subsystem)
> and then that I2C adapter can be used to read the EDID. I wasn't aware
> that eDP panels additionally stored the video timings somewhere else.

I didn't know either, but understood Vasily's comment that this is
possible. Haven't dug around in the specs though.

> What I meant above was that aside from the I2C-over-AUX for reading the
> EDID, this driver doesn't do anything else with DP AUX in order to turn
> the panel on. Looking at the eDP support we have on Tegra, there's a
> DPCD register (DP_SET_POWER) that needs to be written in order to take
> the sink device (i.e. panel) out of the power saving state. We do that
> as part of the connector implementation rather than within the panel
> driver. There are also additional registers such as DP_LINK_BW_SET that
> need to be programmed. I think this is also relevant to regular DP and
> detailed in the specification.
> 
> Given all the above, I'm beginning to think that Rob's right in that
> perhaps we shouldn't be treating eDP panels as panels, but rather to
> make them look more like DP monitors and make all this code part of the
> connector implementation. I think pretty much the only differences to
> regular DP are that we might require some lower-level resources that a
> DP monitor would usually have built-in (reset or power GPIOs, power
> supplies, backlight, ...).
> 
> I'm not sure if that's enough for eDP panels, though. For example the
> AUO B133HTN01 panel, used by the exynos5800-peach-pi, seems to be an eDP
> panel. But the driver also specifies a couple of additional delays which
> suggests that either it violates the eDP specification or that the eDP
> specification doesn't define any power sequencing delays that would've
> been needed. Or perhaps these delays are specified somewhere and the
> driver just doesn't use them?

I honestly don't know, but gut feeling also goes towards making edp
something else than a dumb panel. There's a lot of stuff you need to do
that overlaps with normal DP sinks, plus there's a lot of stuff (but not
everything, or at least it needs some quirking sometimes) that you're
supposed to autodiscover. But I'm not sure what's the best solution really
is, since for i915 all the quirking we need is in some i915-specific
tables (and I'm not even sure how much of that quirking is really
necessary, and how much just convenience for us because the fw already did
the hard work of poking the information out of the panel).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
