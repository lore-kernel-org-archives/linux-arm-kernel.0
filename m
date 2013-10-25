From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 25 Oct 2013 11:24:46 +0200
Subject: ARM topic: Is DT on ARM the solution, or is there something
 better?
In-Reply-To: <CAF6AEGuEho9Ms7ifTE-EmBoQ-=_AXgvGcJxi5qEC0vsZ+H9C+A@mail.gmail.com>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020231134.GR25034@n2100.arm.linux.org.uk>
 <20131021083242.GB30088@pengutronix.de>
 <20131021084854.GV25034@n2100.arm.linux.org.uk>
 <20131021092730.GF30088@pengutronix.de>
 <CAF6AEGtt_2sStiZCNBp9btxevWghSwLZZBdN6ir8eUpX1FXrCQ@mail.gmail.com>
 <20131024072811.GS30088@pengutronix.de>
 <CAF6AEGuEho9Ms7ifTE-EmBoQ-=_AXgvGcJxi5qEC0vsZ+H9C+A@mail.gmail.com>
Message-ID: <20131025092445.GI19622@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 05:21:54PM -0400, Rob Clark wrote:
> On Thu, Oct 24, 2013 at 3:28 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > On Wed, Oct 23, 2013 at 09:14:17PM -0400, Rob Clark wrote:
> >> On Mon, Oct 21, 2013 at 5:27 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >> >> If a subsystem doesn't work well with DT, then the choices are either:
> >> >>
> >> >> (a) don't use DT with the subsystem
> >> >
> >> > The underlying problem has nothing to do with DT. Multi component
> >> > hardware does exist and won't vanish when we stop using DT.
> >> >
> >> >> (b) fix the subsystem
> >> >
> >> > I'd love to do that. Step one to this seems to be to increase the
> >> > awareness that there's something wrong with DRM.
> >>
> >>
> >> Note that I suspect your idea of "fixing drm" is going to break some
> >> userspace assumptions about the hw (ie. userspace isn't expecting
> >> crtcs/encoders/connectors to suddenly appear/disappear.  And the funny
> >> thing is, on all of this hw, that isn't going to happen anyways.
> >
> > I was talking about all SoC DRM drivers implementing variants of the
> > same glue between drm and the multidevice nature of the components.
> >
> > To make that sure: I never had the intention to implement hotplug for
> > drm. Also what the imx-drm driver does is not for hotplug, but only for
> > binding different components together.
> 
> ahh, ok.  Yeah, we do need some way to make this easier, as it is a
> too-common pattern.  I do think we do need a way to know if something
> is missing because it isn't there vs it hasn't been probed yet.  Ie.
> late_initcall() is not the awesome solution.

Yes, that's particularly easy to do with DT because you can walk the
tree looking for status = "okay" to collect which device nodes are
supposed to be enabled and assume that they'll show up eventually. I
have no idea how this could be done without DT, though. Perhaps iterate
over all platform devices and look for matching name.id pairs? Then
again, it seems like this is primarily an issue on ARM, and eventually
all ARM SoCs will move to DT, so perhaps this may become a non-issue.
But it doesn't help with platforms that don't support DT yet.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131025/44eb4bad/attachment.sig>
