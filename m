From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 22 Jul 2014 18:30:06 +0100
Subject: [PATCH v2] platform: Make platform_bus device a platform device
In-Reply-To: <20140722171013.GA6605@kroah.com>
References: <20140721184007.GB572@kroah.com>
 <1406023327-18525-1-git-send-email-pawel.moll@arm.com>
 <20140722171013.GA6605@kroah.com>
Message-ID: <1406050206.25343.87.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-07-22 at 18:10 +0100, Greg Kroah-Hartman wrote:
> On Tue, Jul 22, 2014 at 11:02:07AM +0100, Pawel Moll wrote:
> > ... describing the root of the device tree, so one can write
> > a platform driver initializing the platform.
> > 
> > All references to platform_bus device have been fixed up,
> > although in most cases they could be simply removed or
> > replaced by NULL (platform devices with no parent are adopted
> > by main platform_bus device automagically).
> 
> In looking at this some more, I think all of these should be made NULL,
> why are we exporting this symbol at all?

I think there are about 3 non-obvious uses of it, which would probably
need looking into. All other ones that simply do of_platform_populate()
or platform_device_register*() with platform_bus as a parent, which has
exactly the same effect as it was NULL.

I can imagine situations where one would want to walk the device
hierarchy stopping at platform_bus, how I'm not sure how "legitimate"
that would be.

I'll post v3 with NULLs where I think it is enough so we can see the
other cases.

Pawel
