Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DB2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:05:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C167218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CFPONkth";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAdtmd1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C167218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8yqhtd4ohTpoo2iRWooCYSy6kdBJPCmZF+l8eByyvnw=; b=CFPONkthzXvvRp
	YloMbljc9VdonN+HJvvIkwJFC1zg1Y60vqcx7Mw4lJcbxabdAni0ASTlytBUMo3URug+2Pq+6ooEV
	f4llFiBNUx+RtEQWVbHrpnX832UGtTCOIe7U3kEvycE5KZf6pVhP8UR78upKWOoZQh+eBA8xxHvNg
	mmJOO3mzxzC+qiAmXVOwwBzgVOmkFEooz7WcZ8uiizNGBg8Wy/mGnS7zMxqcmFn4bjnXDkn0I7LsS
	3dcq0nuLwQFQJ1i6hPrpmScMDU9dp0CTZVwCr6TwDZLuR0WOqwqlUIq6wd53H4ejgBX8JtkJE9Qk0
	/J2hMhypNDCsEj1HSIfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guNFf-0004Jl-3y; Thu, 14 Feb 2019 20:04:55 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guNFb-0004JK-AM
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 20:04:53 +0000
Received: by mail-ot1-x343.google.com with SMTP id i5so12643829oto.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 12:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OfDoc4m7pRncNWtTdN/7fCZDC9YCjQcZf4QiWnhY1zI=;
 b=PAdtmd1zmWI+5ct+yO9qDLRQw3xVgdfih2uzzJ47Gi7QB8lqFuR7p5NmGqJo9XxQAe
 YSN6wTAACUxprCtjSzKU6pu7o4L1iavjfWjK6jgz0f+eQzCazJcGWzeA2EsRjMNeQ6yx
 I6SWGlvz6bv5NjyRZX3qDo0FiGvmgJkCvCFGEhhl/Rhs2uWXpYCpnCDFt3tSBbacK79M
 Lf3Wpm0MQWzhsgkqIeZBE/WPYWbkyhzohWAsZ6AVzEPtTPSmcwk2cuA4jSyxI1Cn1tGK
 AmSNC95X+SZ6gcxVe2nzB5RAClqMQjpd0dW4rrIaXiprz2d1kcLelTtsVUNck+E0p1tE
 Dj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OfDoc4m7pRncNWtTdN/7fCZDC9YCjQcZf4QiWnhY1zI=;
 b=gR0afkoJ8V7JJK4g2NblI2zzZgjf4N5suRj2UxJtirr/+TGFhv9Bx0yNfMcN6zBpk1
 QJ5srFwSiV2lxCmY//lCSYJbcQTd9sUceHiG8aOahQ0J+ZvGQIClCMvkCE7RsGH1R31j
 y8W2Kx+ES7lTDVTQUBr7tWcICzdrQs+FW6SSxbZCHxTGojA/k3tPhSh59kd9AIUkSPbv
 Tu+8HP0wFAovTuVTIAsjSKwvNbbFUHBgLqeboYpd184trNzhgAL2LOqm1PgFBrIKIAw8
 AVprs+TpjcU1JvVO/enRN91TdfJb000YJmZv1c4PsYYax5BE5v+k0o24I5uPKXxmLSgw
 KpLw==
X-Gm-Message-State: AHQUAuYVXYYmcaa7HC29TnocW3PbdvzCFnP4+RnzlnIwYezU6AiftKJ8
 hjK40iKMp8daQXr1HgLa9pWOXdqYLbiLJXP5Pc8=
X-Google-Smtp-Source: AHgI3Ib9tITggWWMEsrDygTG/RbBG7DgPUtFCZp5HR3wWQTDcJECUB5tgzrZdCJ8W50INI9Vczg+x25ysD31xw9datY=
X-Received: by 2002:a9d:7284:: with SMTP id t4mr3434145otj.64.1550174688237;
 Thu, 14 Feb 2019 12:04:48 -0800 (PST)
MIME-Version: 1.0
References: <20190203185501.8958-1-anarsoul@gmail.com>
 <20190203185501.8958-9-anarsoul@gmail.com>
 <20190204074350.GC16448@ulmo>
 <CA+E=qVecudACOEXt74Kf=UA_F-uuHgEqHzKpYAq1ocMx3Sx+eQ@mail.gmail.com>
 <20190204082353.GE19087@ulmo> <20190204094012.GP3271@phenom.ffwll.local>
 <20190204112218.GB10412@ulmo> <20190204155909.GU3271@phenom.ffwll.local>
 <20190204162258.GB25476@ulmo> <20190205085737.GY3271@phenom.ffwll.local>
 <20190205102419.GA591@ulmo>
In-Reply-To: <20190205102419.GA591@ulmo>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Thu, 14 Feb 2019 12:05:07 -0800
Message-ID: <CA+E=qVcUsz=5s1+RqDdQ4Hm3_Q3jDFuZwuYXUuVx3ubFWmcG7w@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 08/12] dt-bindings: add binding for generic eDP
 panel
To: Thierry Reding <thierry.reding@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_120451_415787_D3F392B5 
X-CRM114-Status: GOOD (  52.44  )
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

On Tue, Feb 5, 2019 at 2:24 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
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
>
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

I spent some time poking drm_connector code and I came to conclusion
that it's not a good idea.
Basically edp-connector driver will duplicate simple-panel code and
will bring extra complexity
into bridge driver for no benefit at all.

Also currently there are no stand-alone connector drivers, they all
are part of display controller
driver.

One more thing to add is that I'm not sure that drm_connector is
suitable for managing power
and backlight -  I can't find appropriate callback in
drm_connector_funcs to enable power and/or
backlight. Basically there's nothing similar to enable() or disable()
from drm_bridge_funcs.

> I'm not sure if that's enough for eDP panels, though. For example the
> AUO B133HTN01 panel, used by the exynos5800-peach-pi, seems to be an eDP
> panel. But the driver also specifies a couple of additional delays which
> suggests that either it violates the eDP specification or that the eDP
> specification doesn't define any power sequencing delays that would've
> been needed. Or perhaps these delays are specified somewhere and the
> driver just doesn't use them?

Sigh. We can't foresee any bizarre behavior some hardware may or may
not have. Anyway,
can you propose something that can handle same hardware with different
edp panels via
single software image (u-boot aka firmware is part of software image)
and is acceptable
upstream?

Regards,
Vasily

> Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
