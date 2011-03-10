From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Mar 2011 15:29:25 +0100
Subject: [RFC PATCHv1 1/2] Export SoC info through sysfs
In-Reply-To: <20110310140807.GB7411@sirena.org.uk>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<AANLkTikFCAC-hdv0Q_9eQs31XHHEc4wYqRjfY0S=FYcz@mail.gmail.com>
	<20110310140807.GB7411@sirena.org.uk>
Message-ID: <201103101529.25661.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 March 2011, Mark Brown wrote:
> On Thu, Mar 10, 2011 at 02:25:19PM +0100, Linus Walleij wrote:
> 
> > "platform" means "platform bus" in this context, does it not?
> > So your reasoning is that since on SoC:s there is one dominant
> > bus called the platform bus that should also hold a reference to the
> > SoC-specific stuff.
> 
> Lots of stuff (like the MFD children of I2C devices) gets shoved on the
> platform bus on Linux - every time someone considers creating a new bus
> type for trivial devices the discussion ends up saying that the code
> will end up being pretty much identical to the platform bus as it's so
> straightforward so there's no point in cut'n'pasting the code.

Note that there is a difference between using top-level platform
devices (the ones that show up in /sys/devices/platform/) and platform
devices that are children of others (all the others that are in
/sys/bus/platform).

Creating a new bus_type for trivial things is rather pointless,
so using a platform device is fine for MFD, since the child devices
just show up in the hierarchy.

What some broken drivers do is to create platform devices ad hoc
and just put them into /sys/platform/ directly although the
devices clearly have a parent somewhere. These are bugs that should
be fixed.

	Arnd
