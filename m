From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Nov 2016 10:16:15 +0100
Subject: [RFC PATCH] mfd: dt: Add Aspeed LPC binding
In-Reply-To: <20161117060633.3837-1-andrew@aj.id.au>
References: <20161117060633.3837-1-andrew@aj.id.au>
Message-ID: <4751029.AudB7s5avo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, November 17, 2016 4:36:33 PM CET Andrew Jeffery wrote:
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> 
> I'd like to start a discussion about how to handle the LPC register space in
> the Aspeed SoC. There are a number of issues, largely concerned with the layout
> of the registers but also with the fact that LPC register state is used by the
> pinmux to determine some pin functionality.
...
> 
> What is the recommended approach to managing such hardware?

Can you clarify which side of the LPC bus this is? We are currently having
a discussion for how to integrate the LPC master on an ARM64 server that
uses LPC to access an Aspeed LPC slave. For this one we want to use the
traditional ISA DT binding.

I'm guessing that you are interesting in the other side here, for mapping
the registers of the LPC slave on the Aspeed BMC, but that's not clear from
your email, as I'm assuming that the same chip has both master and slave
interfaces.

	Arnd
