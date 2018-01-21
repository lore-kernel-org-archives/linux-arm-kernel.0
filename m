From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 21 Jan 2018 19:55:59 +0100
Subject: [net-next: PATCH 0/8] Armada 7k/8k PP2 ACPI support
In-Reply-To: <CAKv+Gu-LCmYnTWfft=ODqY97gNeD+kzJr_Ni88nwQT72eX7XdQ@mail.gmail.com>
References: <CAPv3WKehwsrxuxemgL_5fKtUT2xjqkE6yf9DMcCcO2WRJ6nQaQ@mail.gmail.com>
 <20180109130012.GA27447@lunn.ch>
 <20180118123141.GA2839@e107981-ln.cambridge.arm.com>
 <20180118130026.GG32299@lunn.ch>
 <CAPv3WKcYrbfKjsnwZ39Tyq3HN0aneUQZdbeUzLbFgLUbMc3w8Q@mail.gmail.com>
 <20180120195246.GC27654@lahna.fi.intel.com>
 <20180121010840.GB1217@lunn.ch>
 <20180121102700.GF27654@lahna.fi.intel.com>
 <20180121161319.GA8017@lunn.ch>
 <CAKv+Gu-LCmYnTWfft=ODqY97gNeD+kzJr_Ni88nwQT72eX7XdQ@mail.gmail.com>
Message-ID: <20180121185559.GC9004@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> However interesting as an example, I'm not convinced this is what we
> should aim for.
> 
> ACPI is not a replacement for DT, and it is unlikely that people would
> be interested in running ACPI-only distros such as RHEL on their
> Ethernet switch. DT is excellent at describing this, and there is no
> need to replace it.

I however do know of somebody who is building an industrial wireless
access point, with a Marvell Ethernet switch. They have chosen to use
an Intel CPU, and want to run CentOS on it, because that is what they
know.

So they will be using ACPI whatever, for the basic board support. They
then have a choice of either ACPI for the switch, or having device
tree as well as ACPI for the switch. And it will be interesting to see
how that works. Can DT reference GPIOs and I2C busses in ACPI?

> Also, please bear in mind that the ACPI spec is owned by the UEFI/ACPI
> forum, and only members (who are all under a contract regarding
> reasonable and non-discriminatory (RAND) licensing terms to IP they
> own that is covered by the spec) can contribute. Individuals can
> become members for free AFAIR, but that doesn't mean individuals are
> typically interested in getting involved in a process that is rather
> tedious and bureaucratic.

And this is a bit what i'm worried about. How you represent MDIO
busses, PHYs, Ethernet switches is implemented once in the core Linux
code. So i would be interested in knowing what happens if the Linux
community defines and implements something, boards start using it, but
a year later the tedious and bureaucratic process rejects it,
re-writes it, in an incompatible way.

	     Andrew
