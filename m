From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 2 Nov 2009 15:25:00 +0000
Subject: Using statically allocated memory for platform_data.
In-Reply-To: <20091102150525.GB5785@n2100.arm.linux.org.uk>
References: <20091102112316.16163f6a.ospite@studenti.unina.it>
	<20091102150011.GB20341@fluff.org.uk>
	<20091102150525.GB5785@n2100.arm.linux.org.uk>
Message-ID: <20091102152500.GD23772@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 02, 2009 at 03:05:25PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 02, 2009 at 03:00:11PM +0000, Ben Dooks wrote:
> > This looks like something is freeing stuff that it did not allocate in
> > the first place, which is IMHO bad. The call platform_device_alloc()
> > is setting platform_device_release() as the default release function
> > but platform_device_release() releases more than platform_device_alloc()
> > actually created.
> > 
> > My view is that platform_device_alloc()'s default release shouldn't
> > be freeing the platform data, and that using platform_device_add_data()
> > or platform_device_add_resources() should change either the behvaiour 
> > of platform_device_release() or it should change the pointer to a new
> > release function.
> 
> That doesn't work - how do those other functions (adding) know what data
> has also been added by other functions?  That can't work reliably.

You could wrapper platform device, and each of the add functions could
update it, but that would assume the platform device had been allocated
with platform_device_alloc().

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
