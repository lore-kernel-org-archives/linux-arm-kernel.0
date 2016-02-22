From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 22 Feb 2016 15:57:40 +0000
Subject: [PATCH v2 1/2] drm: Improve drm_of_component_probe() to
 correctly handle ports and remote ports.
In-Reply-To: <20160222155128.GE19428@n2100.arm.linux.org.uk>
References: <1448029325-14602-1-git-send-email-Liviu.Dudau@arm.com>
 <1448029325-14602-2-git-send-email-Liviu.Dudau@arm.com>
 <20160222115147.GR1123@e106497-lin.cambridge.arm.com>
 <20160222155128.GE19428@n2100.arm.linux.org.uk>
Message-ID: <20160222155740.GU1123@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 03:51:29PM +0000, Russell King - ARM Linux wrote:
> On Mon, Feb 22, 2016 at 11:51:47AM +0000, Liviu Dudau wrote:
> > On Fri, Nov 20, 2015 at 02:22:04PM +0000, Liviu Dudau wrote:
> > > Rockchip DRM driver cannot use the same compare_of() function to
> > > match ports and remote ports (aka encoders) as their OF sub-trees
> > > look different. Add a second compare function to be used when encoders
> > > are added to the component framework and patch the existing users of
> > > the function accordingly.
> > > 
> > > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > 
> > Russell,
> > 
> > Resurecting this old patch from around Christmas time (bad time for patch
> > review).
> > 
> > Are you happy enough with this version to re-issue the Ack or do you think
> > I still need to work on it?
> 
> What I'd like to see is the patch reworked, because:
> 
> > > +		component_match_add(dev, &match, compare_port, port);
> > > +		/*
> > > +		 * component_match_add keeps a reference to the port
> > > +		 * variable, so we need to keep the reference count
> > > +		 * increment from of_parse_phandle()
> > > +		 */
> ...
> > > +			component_match_add(dev, &match, compare_encoder, remote);
> > > +			/*
> > > +			 * component_match_add keeps a reference to the port
> > > +			 * variable, so we need to keep the reference count
> > > +			 * increment from of_graph_get_remote_port_parent()
> > > +			 */
> 
> This problem no longer exists.

Fair enough, I will send a v3 version.

Thanks,
Liviu

> 
> -- 
> RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
