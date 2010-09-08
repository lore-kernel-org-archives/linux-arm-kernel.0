From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Sep 2010 17:51:52 +0100
Subject: [PATCH 3/3] ARM: vexpress: add support for CPU hotplug to
	ct-ca9x4 tile
In-Reply-To: <000301cb4f75$52e66570$f8b33050$@deacon@arm.com>
References: <1282060684-27761-1-git-send-email-will.deacon@arm.com>
	<1282060684-27761-2-git-send-email-will.deacon@arm.com>
	<1282060684-27761-3-git-send-email-will.deacon@arm.com>
	<1282060684-27761-4-git-send-email-will.deacon@arm.com>
	<20100908143700.GB32659@n2100.arm.linux.org.uk>
	<000301cb4f75$52e66570$f8b33050$@deacon@arm.com>
Message-ID: <20100908165152.GA4177@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 08, 2010 at 05:46:02PM +0100, Will Deacon wrote:
> Hi Russell,
> 
> > On Tue, Aug 17, 2010 at 04:58:04PM +0100, Will Deacon wrote:
> > > The Versatile Express platform can support a quad-core Cortex-A9 tile running
> > > SMP Linux.
> > >
> > > This patch adds support for CPU hotplug when running in this configuration.
> > 
> > This ties the core tile support into the generic versatile express code,
> > something which the current code structure is careful to avoid.  Please
> > ensure that we continue to avoid making the generic code rely upon
> > CA9x4 code.
> 
> The cpu_{enter,leave}_lowpower functions are implemented in the tile code
> so they should be ok. I suppose the problem is that we might be able to do
> better than a WFI on some tiles. How about this?:

What I was referring to is that generic code _directly_ calls tile code.
That means if you want to build in support for two tiles, you're going
to have symbols clashing as two tiles will define functions called
'cpu_enter_lowpower' etc.
