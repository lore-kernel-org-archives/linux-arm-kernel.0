From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Aug 2015 13:57:58 +0100
Subject: [PATCH v3 06/14] Documentation: drm/bridge: add document for
 analogix_dp
In-Reply-To: <CAL_JsqLz+8RtBucctUj4euXZ3Ac0DvB52N9ONpAerh5T9BiTJg@mail.gmail.com>
References: <1439995728-18046-1-git-send-email-ykk@rock-chips.com>
 <1439995834-18363-1-git-send-email-ykk@rock-chips.com>
 <CAL_JsqLz+8RtBucctUj4euXZ3Ac0DvB52N9ONpAerh5T9BiTJg@mail.gmail.com>
Message-ID: <20150824125758.GA7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 23, 2015 at 06:23:14PM -0500, Rob Herring wrote:
> On Wed, Aug 19, 2015 at 9:50 AM, Yakir Yang <ykk@rock-chips.com> wrote:
> > +       -analogix,color-depth:
> > +               number of bits per colour component.
> > +                       COLOR_6 = 0, COLOR_8 = 1, COLOR_10 = 2, COLOR_12 = 3
> 
> This seems pretty generic. Just use 6, 8, 10, or 12 for values. And
> drop the vendor prefix.

Please think about this some more.  What does "color-depth" mean?  Does it
mean the number of bits per colour _component_, or does it mean the total
number of bits to represent a particular colour.  It's confusing as it
stands.

> > +Optional properties for dp-controller:
> > +       -analogix,hpd-gpio:
> > +               Hotplug detect GPIO.
> > +                       Indicates which GPIO should be used for hotplug
> > +                       detection
> 
> We should align with "hpd-gpios" used by HDMI connector binding. Or do
> we need a DP connector binding that this should be defined in?
> Probably so.
> 
> The DRM related bindings are such a cluster f*ck with everyone picking
> their own way to do things. Just grep hpd in bindings for starters.
> That is just the tip.

I'm not surprised one iota that DRM bindings are a mess.  There's no one
overlooking the adoption of DRM bindings, so surprise surprise, everyone
does their own thing.  This is exactly what happens every time in that
scenario.  It's not a new problem.

When we adopted the graph bindings for iMX DRM, I thought exactly at that
time "it would be nice if this could become the standard for binding DRM
components together" but I don't have the authority from either the DT
perspective or the DRM perspective to mandate that.  Neither does anyone
else.  That's the _real_ problem here.

I've seen several DRM bindings go by which don't use the of-graph stuff,
which means that they'll never be compatible with generic components
which do use the of-graph stuff.

Like you say, it's a mess, but it's a mess of our own making, because no
one has the authority to regulate this.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
