Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5222C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:54:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A03712147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ieY35deT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYht9W/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A03712147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/PiTlIMQZsExuM+USqyBBsK6v43MMqd3roUQslOQqvw=; b=ieY35deTCpMl08
	RwRu07/jpNKnkhicrnQgbx2dSoSKgHPqAXv/KC+N7IyZ++0KjhrnGhhh1OAxCc608fkzqePjgRZlz
	MVmvbj0rGS5WI0cIsErr29QE0a/pKBQ8+tOlCwNtxpY0EqbUCe5bfV2X7d1sbl7XmDk9a3+xdmH+4
	sl2aaWR2pTQuRTfxMkJW5TcFgE1Fx5YUcnPhJy8fQNxQvAYfzsmE9/FolluKtiqUJemWl6IYenAGe
	wAFiqGvrELxH53ID9un53XJAbCfdIaSs6CO5f1+vu6upmnYJXrJXTwueIsqNrCK844gXsPa1QwGCY
	J/wAhqme1l/hd1c3a5/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guO1J-0000Xe-Vl; Thu, 14 Feb 2019 20:54:09 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guO1G-0000XD-91
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 20:54:08 +0000
Received: by mail-ot1-x341.google.com with SMTP id u16so12901481otk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 12:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8WhWTvDPALPcsS4Z5oPrAbLDHpvz4PaoO+zoGa92B18=;
 b=eYht9W/JgNyuEHNTArT3vpCagRdk1epBSfX0o9z9+ZwzSNHzbqCRO8emQP4F6cq0qI
 XgFr1NucZODoe5yffgaCiEuGwxmNH/5vJctSsI53VVuQGO/pcvx+Oc/YBE29SZ+Hv8Nx
 csiH/0mnMeNh0C8U3HKgvnP8PVywoTUvkbMqwGtjKpPHXTGiPKuwSs6x79ZX9ipEU8EK
 bxvbXm/phP4s9LFnl9SbZz8JrJ0wpJ4F+o4TJkHsd28XqVDYPV3i/DJg3lK9HExnFo8P
 rTXtKRQE0sp2iOtpuSB+Am2JzBIN0J2M4OHbWNWHEuuNlGfIh6L/MLFEqweVyohYDw/F
 Z2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8WhWTvDPALPcsS4Z5oPrAbLDHpvz4PaoO+zoGa92B18=;
 b=elPVvDklRQdwFSlimsmoCsNB6nwVfoo8WMBdB1q46X+wjYDAmanRniQaFaBvzjxyqa
 MpPVFpYv8cvOTJoG9I123GF6EZFOydemhLsotYmy3RCgHvqcyG6CnMUv9FoPF2r1Wyr6
 axgn0rFxciXl+qzEvowIQunNokneCUE++yXSByFD12xb4l5p07V2sHJ5mbvIgL27eKNl
 PsOpclaIqlvzv375+wKEYc+t/1GvMAqTHxdq57FPVIvvvNI6Brt2lda4Vh/ycueoA9Rd
 vgU1ifrdxLSFf7ENv94Oj0aoMLkT9FzAO4WSqxoAD9RtqE5tG2sa0XYj3JIrXkyxV0OM
 azMQ==
X-Gm-Message-State: AHQUAuYKiEYYcmLmuz+JmRu7A4eq93p+/s9g4YOsthQa6imvpllPr8hk
 jvIC1sug4U5zfVpOJred6EIOxKbtwb2e7cjDhdw=
X-Google-Smtp-Source: AHgI3IaZkysrA5IBf/WLk7P98J0pXgpI3oza6DGqrB4ZCdRLO7U1ctzNZkucK/7JaTf2xnn4Y2re5PAS/FXEtT81wgA=
X-Received: by 2002:aca:e302:: with SMTP id a2mr3816233oih.45.1550177644560;
 Thu, 14 Feb 2019 12:54:04 -0800 (PST)
MIME-Version: 1.0
References: <20190203185501.8958-1-anarsoul@gmail.com>
 <20190203185501.8958-9-anarsoul@gmail.com>
 <20190204074350.GC16448@ulmo>
 <CA+E=qVecudACOEXt74Kf=UA_F-uuHgEqHzKpYAq1ocMx3Sx+eQ@mail.gmail.com>
 <20190204082353.GE19087@ulmo> <20190204094012.GP3271@phenom.ffwll.local>
 <20190204112218.GB10412@ulmo> <20190204155909.GU3271@phenom.ffwll.local>
 <20190204162258.GB25476@ulmo> <20190205085737.GY3271@phenom.ffwll.local>
 <20190205102419.GA591@ulmo>
 <CA+E=qVcUsz=5s1+RqDdQ4Hm3_Q3jDFuZwuYXUuVx3ubFWmcG7w@mail.gmail.com>
 <CAL_JsqKQ0EmyYGYvz__ZZGN7_6jLezevHWc+psn82Uy6hWZXMA@mail.gmail.com>
In-Reply-To: <CAL_JsqKQ0EmyYGYvz__ZZGN7_6jLezevHWc+psn82Uy6hWZXMA@mail.gmail.com>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Thu, 14 Feb 2019 12:54:23 -0800
Message-ID: <CA+E=qVe2r0xUvDKkwniEkhO4szKRpyngD4P5mEqvgNJOLOxWHg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 08/12] dt-bindings: add binding for generic eDP
 panel
To: Rob Herring <robh+dt@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_125406_355301_0807FEF9 
X-CRM114-Status: GOOD (  57.98  )
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
 Thierry Reding <thierry.reding@gmail.com>, Sean Paul <seanpaul@chromium.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 arm-linux <linux-arm-kernel@lists.infradead.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 12:38 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Thu, Feb 14, 2019 at 2:04 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> >
> > On Tue, Feb 5, 2019 at 2:24 AM Thierry Reding <thierry.reding@gmail.com> wrote:
> > >
> > > On Tue, Feb 05, 2019 at 09:57:37AM +0100, Daniel Vetter wrote:
> > > > On Mon, Feb 04, 2019 at 05:22:58PM +0100, Thierry Reding wrote:
> > > > > On Mon, Feb 04, 2019 at 04:59:09PM +0100, Daniel Vetter wrote:
> > > > > > On Mon, Feb 04, 2019 at 12:22:18PM +0100, Thierry Reding wrote:
> > > > > > > On Mon, Feb 04, 2019 at 10:40:12AM +0100, Daniel Vetter wrote:
> > > > > > > > On Mon, Feb 04, 2019 at 09:23:59AM +0100, Thierry Reding wrote:
> > > > > > > > > On Mon, Feb 04, 2019 at 12:13:55AM -0800, Vasily Khoruzhick wrote:
> > > > > > > > > > On Sun, Feb 3, 2019 at 11:43 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Sun, Feb 03, 2019 at 10:54:57AM -0800, Vasily Khoruzhick wrote:
> > > > > > > > > > > > eDP panels usually have EDID EEPROM, so there's no need to define panel
> > > > > > > > > > > > width/height or any modes/timings in dts. But this panel still may have
> > > > > > > > > > > > regulator and/or backlight.
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > > > > > > > > > > ---
> > > > > > > > > > > >  .../devicetree/bindings/display/panel/panel-edp.txt        | 7 +++++++
> > > > > > > > > > > >  1 file changed, 7 insertions(+)
> > > > > > > > > > > >  create mode 100644 Documentation/devicetree/bindings/display/panel/panel-edp.txt
> > > > > > > > > > >
> > > > > > > > > > > Please don't try to make panels look more generic than they really are.
> > > > > > > > > > > You're going to have to provide a compatible string for your device that
> > > > > > > > > > > is more specific than "panel-edp". You claim that you don't need any
> > > > > > > > > > > extra information that is panel specific, but you don't know that now.
> > > > > > > > > > > We have in the past thought that we didn't need things like prepare
> > > > > > > > > > > delay, but then we ran into situations where we did need them.
> > > > > > > > > > >
> > > > > > > > > > > Just do what everybody else does. Provide a specific compatible string
> > > > > > > > > > > and match on that in the panel-simple driver. Even if you can read all
> > > > > > > > > > > the video timings from an EDID EEPROM, you can still provide a mode in
> > > > > > > > > > > the panel descriptor to serve as a fallback if for example the EEPROM
> > > > > > > > > > > is faulty on some device.
> > > > > > > > > >
> > > > > > > > > > Pinebook used several 768p panels that have slightly different timings
> > > > > > > > > > and recent batch uses 1080p panel.
> > > > > > > > > >
> > > > > > > > > > What panel descriptor should I use as fallback?
> > > > > > > > >
> > > > > > > > > You don't use panel descriptors as fallback. The simple-panel driver
> > > > > > > > > will bind to a panel device and use the corresponding descriptor. If
> > > > > > > > > your device tree contains the correct information, the descriptor is
> > > > > > > > > correct for the panel you have.
> > > > > > > > >
> > > > > > > > > In other words you need to ensure that you have the correct panel in
> > > > > > > > > device tree for the board that you're using. This is exactly the same
> > > > > > > > > thing as for other devices.
> > > > > > > > >
> > > > > > > > > One way to to this is to have separate device trees for each variant
> > > > > > > > > of the board that you want to support. Another variant may be to have
> > > > > > > > > a common device tree and then have some early firmware update the DTB
> > > > > > > > > with the correct panel information.
> > > > > > > >
> > > > > > > > This would defeat the point of edp, which is to standardize the mess of
> > > > > > > > panels (at least somewhat) and avoid having to change the DT/ACPI
> > > > > > > > tables/firmware for every board you ship. Also, we do have DP quirking
> > > > > > > > infrastructure already (using the OUI), I think if there's something that
> > > > > > > > doesn't work then we should quirk it there.
> > > > > > >
> > > > > > > The problem is that while the attempt may have been to standardize, it
> > > > > > > failed. It doesn't take into account any of the details such as timing
> > > > > > > between things like powering up the display and enabling the backlight
> > > > > > > or similar. I don't know how you'd want to "quirk" those kinds of
> > > > > > > requirements because they are highly panel specific.
> > > > > >
> > > > > > Hm right, we get these from some firmware tables (and mix them with the
> > > > > > spec one, since some of the firmware values are nonsense). I don't even
> > > > > > know whether we can read the timings over dp aux somehow (you can power up
> > > > > > the panel with some pessimistic values to figure those out, and you only
> > > > > > need dp aux to work, which is much simpler than the entire panel).
> > > > > >
> > > > > > > > What does make sense though imo is if we try not to stuff the edp panel
> > > > > > > > into panel-simple, because it's anything like a simple dumb panel. There's
> > > > > > > > also some integration awkwardness since with this panel you need to do dp
> > > > > > > > aux/i2c transactions to get at the information (edid alone isn't good
> > > > > > > > enough for edp), and I'm not sure how exactly that's supposed to be
> > > > > > > > instantiated. Maybe a special function to instantiate an edp panel, which
> > > > > > > > takes both a DT node and the dp_aux controller would be much better,
> > > > > > > > instead of trying to auto-match against a DT compatible string and load a
> > > > > > > > panel driver which is almost all fake.
> > > > > > > >
> > > > > > > > Or we teach dp_aux to register itself and somehow teach panel-edp how it
> > > > > > > > can get hold of the dp_aux channel it needs.
> > > > > > >
> > > > > > > We already do that. drm_dp_aux registers as an I2C adapter that can be
> > > > > > > used to read EDID EEPROMs using I2C-over-AUX transactions. We already
> > > > > > > use that on some platforms.
> > > > > > >
> > > > > > > Also note that simple-panel already supports getting video timings from
> > > > > > > EDID. If a DDC link is present in DT, the driver will load the modes
> > > > > > > from EDID and use them.
> > > > > >
> > > > > > Could we extend this to dp aux somehow? For edp you need the dp aux (which
> > > > > > then gives you the ddc link automatically).
> > > > >
> > > > > I suppose we could do that. We could introduce a new property that would
> > > > > allow the panel driver to get at the struct drm_dp_aux that can access
> > > > > the panel. I'm not sure how much that would buy us. I suppose the driver
> > > > > could go and use that drm_dp_aux to do I2C-over-AUX and ignore any
> > > > > ddc-bus property in device tree. A drm_dp_aux object could also be used
> > > > > to access DPCD if that's helpful.
> > > > >
> > > > > The driver proposed here doesn't need access to DPCD, so I'm not sure
> > > > > that would immediately help.
> > > >
> > > > You definitely need dp aux to drive edp. That's where a lot of the really
> > > > important stuff is stored, and it sounds like on non-broken panels even
> > > > the timings (we've never implemented that on i915 somehow).
> > >
> > > I'm not sure I understand what you're saying here. I haven't worked with
> > > eDP panels in a while, but my recollection is that you can use DP AUX to
> > > read video timings over EDID. We provide support for that by exporting a
> > > DP AUX controller as I2C adapter (i.e. register with the I2C subsystem)
> > > and then that I2C adapter can be used to read the EDID. I wasn't aware
> > > that eDP panels additionally stored the video timings somewhere else.
> > >
> > > What I meant above was that aside from the I2C-over-AUX for reading the
> > > EDID, this driver doesn't do anything else with DP AUX in order to turn
> > > the panel on. Looking at the eDP support we have on Tegra, there's a
> > > DPCD register (DP_SET_POWER) that needs to be written in order to take
> > > the sink device (i.e. panel) out of the power saving state. We do that
> > > as part of the connector implementation rather than within the panel
> > > driver. There are also additional registers such as DP_LINK_BW_SET that
> > > need to be programmed. I think this is also relevant to regular DP and
> > > detailed in the specification.
> > >
> > > Given all the above, I'm beginning to think that Rob's right in that
> > > perhaps we shouldn't be treating eDP panels as panels, but rather to
> > > make them look more like DP monitors and make all this code part of the
> > > connector implementation. I think pretty much the only differences to
> > > regular DP are that we might require some lower-level resources that a
> > > DP monitor would usually have built-in (reset or power GPIOs, power
> > > supplies, backlight, ...).
> >
> > I spent some time poking drm_connector code and I came to conclusion
> > that it's not a good idea.
> > Basically edp-connector driver will duplicate simple-panel code and
> > will bring extra complexity
> > into bridge driver for no benefit at all.
>
> I said this on irc, but for everyone's benefit, what's used in the
> kernel and the binding don't have to be aligned. I still think
> following a connector binding in DT makes sense even if the kernel
> implementation is actually a panel driver. Really, there's no
> difference in bindings between a connector node and panel node.
>
> > Also currently there are no stand-alone connector drivers, they all
> > are part of display controller
> > driver.
>
> Probably that is something to be refactored. I think we have lots of cases of:
>
> if (is_connector)
>     // call connector func
> else
>     // call panel func
>
> Or maybe that was panel vs. bridge (then a connector)? It's been a
> while since I looked at this. In any case, each device in the chain
> shouldn't really have much knowledge as to what it is attached to.
>
> > One more thing to add is that I'm not sure that drm_connector is
> > suitable for managing power
> > and backlight -  I can't find appropriate callback in
> > drm_connector_funcs to enable power and/or
> > backlight. Basically there's nothing similar to enable() or disable()
> > from drm_bridge_funcs.
>
> Nobody has put the 5V supply on HDMI on a switchable regulator? It may
> need to be always on for HPD to work, but I wouldn't expect all board
> designers to get that right.
>
> > > I'm not sure if that's enough for eDP panels, though. For example the
> > > AUO B133HTN01 panel, used by the exynos5800-peach-pi, seems to be an eDP
> > > panel. But the driver also specifies a couple of additional delays which
> > > suggests that either it violates the eDP specification or that the eDP
> > > specification doesn't define any power sequencing delays that would've
> > > been needed. Or perhaps these delays are specified somewhere and the
> > > driver just doesn't use them?
> >
> > Sigh. We can't foresee any bizarre behavior some hardware may or may
> > not have.
>
> Bingo! You just summed up why we have specific compatibles.
>
> > Anyway,
> > can you propose something that can handle same hardware with different
> > edp panels via
> > single software image (u-boot aka firmware is part of software image)
> > and is acceptable
> > upstream?
>
> compatible = "vendor,some-panel", "edp-connector";
>
> Either you have to fixup the first string for the actual panel or have
> some testing up front that you don't need to.

Where do I take actual panel compatible from?

> The kernel can start
> with only using the fallback string and if panel constraints turn out
> to be specified sufficiently, we'll never need to use the panel
> compatible.

So what panel compatible you want me to use if vendor used at least 3
different panels?
Introduce 2 more dts files (3 in total) even if they all work just
fine with a single dts now?
Add one more dts once laptop vendor decides to change panel vendor?

>
> Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
