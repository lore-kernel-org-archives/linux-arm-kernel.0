From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 May 2011 00:01:18 +0100
Subject: [RFC PATCH 4/4] ARM: Xilinx: Adding Xilinx board support
In-Reply-To: <1319927287.2232106.1304373011082.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
References: <90477150.2231869.1304372815517.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
	<1319927287.2232106.1304373011082.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
Message-ID: <20110502230118.GE28001@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 02, 2011 at 09:50:11PM +0000, johnlinn at comcast.net wrote:
> Seems easy enough assuming we don't need the SCU early for the core count
> and can get that from the device tree.

Beware.  Things may not be that trivial when you start considering some
of the weirdnesses that some vendors start coming out with.

> Since the SCU and part of the GIC end up in the same 4K page they need to be
> together (unless I'm thinking about that wrong).
> 
> SCU 0xF8000000
> GIC_CPU 0xF8000100
> GIC_DIS 0xF8001000

It is preferable to use the same mapping, as it ensures that you're not
going to create incompatible aliases.

But, before we get too bogged down with this, please realise that it is
possible to setup early mappings from the device tree for things like the
SCU.  Maybe not using ioremap(), but I'm sure we can find some way to use
the iotable_init() stuff to setup some early mappings from DT for this
stuff.
