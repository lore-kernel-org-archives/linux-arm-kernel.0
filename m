From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 6 Jan 2014 01:17:09 +0100
Subject: [PATCH v2 1/2] ARM: mvebu: Add support to get the ID and the
 revision of a SoC
In-Reply-To: <52C9F32D.5080007@gmail.com>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com>
 <1388743185-24822-2-git-send-email-gregory.clement@free-electrons.com>
 <201401051525.52459.arnd@arndb.de> <20140105154023.GA2048@lunn.ch>
 <20140105172756.GA11280@obsidianresearch.com>
 <52C99851.70806@gmail.com>
 <20140105230746.GB11280@obsidianresearch.com>
 <52C9E6D0.3000406@gmail.com>
 <20140105234009.GC11280@obsidianresearch.com>
 <52C9F32D.5080007@gmail.com>
Message-ID: <20140106001709.GD4093@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>Does that power down really disable reading from PCIe controller
> >>registers or is it just PHY power down?
> >
> >I haven't experimented with it, but every block that has a clock gate
> >has a power down, so I doubt it is just a phy power down.
> 
> Ok, I see. But it isn't documented in the public FS, is it? If there is
> an extra powerdown register for each ip block, I guess it will also
> break reading from its registers.

Hi Sebastian

The public Kirkwood FS has a memory power management control register,
Offset 0x20118. It is unclear what it actually does, and if you can
still access registers when it is off. We would have to poke it and
see.

	Andrew
