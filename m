From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 29 Oct 2013 14:22:28 +0100
Subject: [PATCH 00/19] Enable various Renesas drivers on all ARM platforms
In-Reply-To: <1383051980.29619.33.camel@sauron.fi.intel.com>
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <Pine.LNX.4.64.1310291009121.8404@axis700.grange>
 <1383051980.29619.33.camel@sauron.fi.intel.com>
Message-ID: <1844190.ApyucSZX8W@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Artem,

On Tuesday 29 October 2013 15:06:20 Artem Bityutskiy wrote:
> On Tue, 2013-10-29 at 10:12 +0100, Guennadi Liakhovetski wrote:
> > On Tue, 29 Oct 2013, Laurent Pinchart wrote:
> > > Hello,
> > > 
> > > This patch series, based on v3.12-rc7, prepares various Renesas drivers
> > > for migration to multiplatform kernels by enabling their compilation or
> > > otherwise fixing them on all ARM platforms. The patches are pretty
> > > straightforward and are described in their commit message.
> > > 
> > > I'd like to get all these patches merged in v3.14. As they will need to
> > > go through their respective subsystems' trees, I would appreciate if all
> > > maintainers involved could notify me when they merge patches from this
> > > series in their tree to help me tracking the merge status. I don't plan
> > > to send pull requests individually for these patches, and I will repost
> > > patches individually if changes are requested during review.
> > > 
> > > If you believe the issue should be solved in a different way (for
> > > instance by removing the architecture dependency completely) please
> > > reply to the cover letter to let other maintainers chime in.
> > 
> > Exactly this was my doubt. If we let these drivers build on all ARM
> > platforms... Maybe we should just let them build everywhere? Unless there
> > are real ARM dependencies. Maybe you could try to remove the restriction
> > and try to build them all on x86?
> 
> If they have never been used on anything but ARM, why would you remove
> ARM dependencies? Just for the sake of compile-checking?
> 
> Also, if ARM dependency is ever removed, all these should become 'n' by
> default in the Kconfig, in order to make sure they do not slip into
> defconfigs of different architectures.

The idea is that, if ARM is neither a compile-time nor runtime dependency, it 
should not be specified in Kconfig. However, if the IP core has never been 
used on anything but SuperH and ARM, I don't think clobbering the config 
process with drivers that can't be used on the target architecture would be a 
really good idea, especially now that we have a COMPILE_TEST Kconfig option. 
My preference does goes to SUPERH || ARM || COMPILE_TEST over no dependency at 
all.

-- 
Regards,

Laurent Pinchart
