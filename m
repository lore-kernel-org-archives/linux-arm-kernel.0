From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Apr 2010 21:15:16 +0100
Subject: [RFC/PATCH] dns323: Support for HW rev C1
In-Reply-To: <20100421180737.GE4586@mail.wantstofly.org>
References: <1271838486.2330.139.camel@pasglop>
	<20100421180737.GE4586@mail.wantstofly.org>
Message-ID: <20100421201516.GG26616@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 21, 2010 at 08:07:37PM +0200, Lennert Buytenhek wrote:
> On Wed, Apr 21, 2010 at 06:28:06PM +1000, Benjamin Herrenschmidt wrote:
> 
> >  - Identifying the board requires the ethernet PHY ID as far as I can
> > tell (at least that's how d-link userspace tools do it). I've put some
> > code in dns323_setup.c to do it, it's a bit gross but I don't think
> > trying to tie links with the ethernet driver would be any cleaner.
> >
> >  - I'm not totally sure what's the right approach for changing the
> > config of the PHY LEDs... the PHY drivers have no hooks for that and no
> > way that I have in mind to pass some platform data or something driver
> > specific like that over.
> 
> Just register a different machine ID for the rev C1 board and pass
> that in from the boot loader, that'll solve all these problems.

Or use the system_rev for what it's meant for; it was invented to deal
with the differences between rev 3,4,5 netwinders - or more specifically
revision 4 netwinders where the fan control hardware is different from
rev 3 and 5.
