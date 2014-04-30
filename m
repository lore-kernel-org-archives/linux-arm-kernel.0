From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 30 Apr 2014 21:39:41 +0200
Subject: [PATCH 07/15] ARM: dts: kirkwood: consolidate common pinctrl
 settings
In-Reply-To: <20140430164236.GC12944@obsidianresearch.com>
References: <1398862602-29595-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1398862602-29595-8-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140430164236.GC12944@obsidianresearch.com>
Message-ID: <5361517D.8000106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/30/2014 06:42 PM, Jason Gunthorpe wrote:
> On Wed, Apr 30, 2014 at 02:56:34PM +0200, Sebastian Hesselbarth wrote:
>> All SoCs have the same pinctrl setting for NAND, UART0/1, SPI, TWSI0,
>> and GBE1. Move it to the common pinctrl node that we now have.
> 
> There are two possible choices for UART0, UART1, and SPI on kirkwood..
> 
> For instance I use this on my board:
> 
>                                 pmx_spi0: pmx-spi0 {
>                                         marvell,pins = "mpp7", "mpp10", "mpp11", "mpp12";
>                                         marvell,function = "spi";
>                                 };
> 
> vs
> 
>> +
>> +			pmx_spi: pmx-spi {
>> +				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3";
>> +				marvell,function = "spi";
>> +			};
> 
> It looks like all the boards in the kernel use the same choice, so it
> makes some sense to consolidate, but I assume a board file can
> override the marvell,pins?

Yes, there are already some boards (e.g. t5325 with spi0) overwriting
pinctrl settings instead of overwriting the pinctrl-0 property. I
thought, I keep this behavior and note it above each pinctrl node in
some of the following patches.

But your comment reminded me of something more important: there is
one set of boards using kirkwood-lsxl.dtsi which does not explicitly
set spi's pinctrl property. So this consolidation potentially breaks
spi on those boards.

An explicit Tested-by for Buffalo Linkstation LS-CHLv2 and/or LS-XHL
would be good.

> Otherwise the rest of your patchset looked sane to me.

I count that as a

Reviewed-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

Thanks!

Sebastian
