From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 31 Jan 2013 17:27:02 +0100
Subject: Failure to boot...
In-Reply-To: <20130131161823.GT2637@n2100.arm.linux.org.uk>
References: <20130131092024.GN2637@n2100.arm.linux.org.uk>
 <CAOMZO5BrGcffzd2YBrF6YQTs7X38RuniYhm010fpLMnigecnTw@mail.gmail.com>
 <20130131161823.GT2637@n2100.arm.linux.org.uk>
Message-ID: <1731670.s76EGcEZ7m@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 31 January 2013 16:18:23 Russell King - ARM Linux wrote:
> On Thu, Jan 31, 2013 at 02:01:14PM -0200, Fabio Estevam wrote:
> > On Thu, Jan 31, 2013 at 12:27 PM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > 
> > > too.  It also looks like Versatile Express support _can't_ be disabled in
> > > a multiplatform kernel, which is ludicrous.
> > 
> > Should we go with this approach?
> > https://patchwork.kernel.org/patch/1774521/
> 
> We need to go with an approach which isn't going to break allnoconfig
> and randconfig.
> 
> I've suggested that we should have a basic, minimalist platform always
> built in for DT supporting kernels.  I've actually suggested that we
> should end up not having a machine_desc at all once the DT conversion
> is complete.  Either of those solves the problem of us ending up with
> no platform support built with these configurations.

Yes, I like the idea a lot. I think we should be pretty close to
being able to do that just now, with generic hooks to initialize
the interrupt controller and clocksouroce drivers.

> The alternative is we end up with quite a long disgusting Kconfig
> option which becomes enabled when everything but Versatile Express
> is disabled...

Yes, I've tried that in the past, it wasn't nice. It also gets
much more complex if you want to do it for all configurations instead
of just those that enable ARMv7.

	Arnd
