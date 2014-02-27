From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Feb 2014 13:43:48 +0000
Subject: [RFC PATCH v4 3/8] staging: imx-drm: Document updated imx-drm
 device tree bindings
In-Reply-To: <530F3A93.501@ti.com>
References: <1393338203-25051-1-git-send-email-p.zabel@pengutronix.de>
 <1393338203-25051-4-git-send-email-p.zabel@pengutronix.de>
 <530F1C4C.2010504@ti.com> <20140227115652.GI21483@n2100.arm.linux.org.uk>
 <530F3A93.501@ti.com>
Message-ID: <20140227134348.GK21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 27, 2014 at 03:16:03PM +0200, Tomi Valkeinen wrote:
> On 27/02/14 13:56, Russell King - ARM Linux wrote:
> 
> >> Is there even need for such a master device? You can find all the
> >> connected display devices from any single display device, by just
> >> following the endpoint links.
> > 
> > Please read up on what has been discussed over previous years:
> > 
> > http://lists.freedesktop.org/archives/dri-devel/2013-July/041159.html
> 
> Thanks, that was an interesting thread. Too bad I missed it, it was
> during the holiday season. And seems Laurent missed it also, as he
> didn't make any replies.
> 
> The thread seemed to go over the very same things that had already been
> discussed with CDF.

That may be - but the problem with CDF solving this problem is that it's
wrong.  It's fixing what is in actual fact a *generic* problem in a much
too specific way.  To put it another way, it's forcing everyone to fix
the same problem in their own separate ways because no one is willing to
take a step back and look at the larger picture.

We can see that because ASoC has exactly the same problem - it has to
wait until all devices (DMA, CPU DAIs, codecs etc) are present before it
can initialise, just like DRM.  Can you re-use the CDF solution for ASoC?
No.  Can it be re-used elsewhere in non-display subsystems?  No.

Therefore, CDF is yet another implementation specific solution to a
generic problem which can't be re-used.

Yes, I realise that CDF may do other stuff, but because of the above, it's
a broken solution.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
