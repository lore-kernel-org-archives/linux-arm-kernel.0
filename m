From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 24 Oct 2013 11:00:56 +0200
Subject: ARM topic: Is DT on ARM the solution, or is there something
 better?
In-Reply-To: <20131024072811.GS30088@pengutronix.de>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020231134.GR25034@n2100.arm.linux.org.uk>
 <20131021083242.GB30088@pengutronix.de>
 <20131021084854.GV25034@n2100.arm.linux.org.uk>
 <20131021092730.GF30088@pengutronix.de>
 <CAF6AEGtt_2sStiZCNBp9btxevWghSwLZZBdN6ir8eUpX1FXrCQ@mail.gmail.com>
 <20131024072811.GS30088@pengutronix.de>
Message-ID: <20131024090054.GA11296@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 09:28:11AM +0200, Sascha Hauer wrote:
> On Wed, Oct 23, 2013 at 09:14:17PM -0400, Rob Clark wrote:
> > On Mon, Oct 21, 2013 at 5:27 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > >> If a subsystem doesn't work well with DT, then the choices are either:
> > >>
> > >> (a) don't use DT with the subsystem
> > >
> > > The underlying problem has nothing to do with DT. Multi component
> > > hardware does exist and won't vanish when we stop using DT.
> > >
> > >> (b) fix the subsystem
> > >
> > > I'd love to do that. Step one to this seems to be to increase the
> > > awareness that there's something wrong with DRM.
> > 
> > 
> > Note that I suspect your idea of "fixing drm" is going to break some
> > userspace assumptions about the hw (ie. userspace isn't expecting
> > crtcs/encoders/connectors to suddenly appear/disappear.  And the funny
> > thing is, on all of this hw, that isn't going to happen anyways.
> 
> I was talking about all SoC DRM drivers implementing variants of the
> same glue between drm and the multidevice nature of the components.
> 
> To make that sure: I never had the intention to implement hotplug for
> drm. Also what the imx-drm driver does is not for hotplug, but only for
> binding different components together.

I think we should be able to solve that problem generically. Essentially
we need some sort of composite device that subdevices can register with.
The composite device can keep track of what devices are needed (this
works well by walking the device tree, looking for nodes that match by
compatible and see if their status property is set to"okay") and once
all of those have been registered do whatever the specific subsystem
requires.

I'm not familiar with what exactly the requirements are for other SoCs,
so I'd be interested in hearing if there's anything beyond the above.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131024/20e0cd6a/attachment.sig>
