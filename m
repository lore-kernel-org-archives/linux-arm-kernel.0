From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 30 Apr 2014 13:44:37 -0600
Subject: [PATCH 07/15] ARM: dts: kirkwood: consolidate common pinctrl
 settings
In-Reply-To: <5361517D.8000106@gmail.com>
References: <1398862602-29595-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1398862602-29595-8-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140430164236.GC12944@obsidianresearch.com>
 <5361517D.8000106@gmail.com>
Message-ID: <20140430194437.GB17365@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 30, 2014 at 09:39:41PM +0200, Sebastian Hesselbarth wrote:
> On 04/30/2014 06:42 PM, Jason Gunthorpe wrote:
> > On Wed, Apr 30, 2014 at 02:56:34PM +0200, Sebastian Hesselbarth wrote:
> >> All SoCs have the same pinctrl setting for NAND, UART0/1, SPI, TWSI0,
> >> and GBE1. Move it to the common pinctrl node that we now have.

> Yes, there are already some boards (e.g. t5325 with spi0) overwriting
> pinctrl settings instead of overwriting the pinctrl-0 property. I
> thought, I keep this behavior and note it above each pinctrl node in
> some of the following patches.

That all makes sense, I think the commit message just seemed to say
something else.

Maybe more like:

NAND and TWSI0 have only one valid pin control choice on Kirkwood,
move those definitions into the common dtsi.

For UART0/1 and SPI, which have two choices, move the definition that
is used in the majority of the board files into the common dtsi.
Board files that are different will override.

Regards,
Jason
