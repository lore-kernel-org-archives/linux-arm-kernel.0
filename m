From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 9 Jan 2013 22:13:26 -0500
Subject: [PATCH v2] Device Tree binding for the mvsdio driver and
 related changes
In-Reply-To: <1356101359-6054-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1356101359-6054-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130110031326.GI5075@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

Thanks for the patches, I've merged them as follows:

  * note, I've sorted them below in the order they will be merged

On Fri, Dec 21, 2012 at 03:48:59PM +0100, Thomas Petazzoni wrote:
> Hello,
> 
> This series of patches adds a Device Tree binding to the mvsdio driver
> (the driver for the SDIO interface found in many Marvell SoCs), and
> uses this binding to enable the SDIO interface on Armada 370 and
> Armada XP platforms, as well as converting the Kirkwood platforms to
> using the Device Tree to probe the SDIO interface.
> 
> The series has been tested on Kirkwood Topkick, Armada 370 Mirabox,
> Armada XP OpenBlocks, Armada 370 DB and Armada XP DB. The changes on
> the Dreamplug and MPLCEC4 boards should be tested by their respective
> maintainers if possible.
> 
> This series is obviously 3.9 material.
> 
> Here is a short description of the patches:

mvebu/cleanup

>  * Patch 17 removes a useless header inclusion related to the SDIO
>    interface to the Kirkwood Dockstar platform.

mvebu/drivers

>  * Patches 1 and 2 cleanup the mvsdio driver initialization by using
>    the slot-gpio helpers for the card-detect and write-protect GPIOs
> 
>  * Patch 3 adds the Device Tree binding itself to the mvsdio driver
> 
>  * Patch 4 adds pinctrl integration to the mvsdio driver

mvebu/boards

>  * Patches 18, 19 and 20 update the mvebu_defconfig to enable the
>    mvsdio driver, as well as Wifi/Bluetooth drivers needed for the
>    SD8787 chip connected over SDIO on the Globalscale Mirabox.

mvebu/dt

>  * Patch 5 adds Device Tree information to describe the SDIO interface
>    on the Armada 370 and Armada XP SoCs.
> 
>  * Patches 6 and 7 add pin muxing options for the SDIO interface on
>    Armada 370 and Armada XP SoCs.
> 
>  * Patches 8, 9, 10 enable the SDIO interface on the Armada XP DB,
>    Armada 370 DB and Globalscale Mirabox platforms.
> 
>  * Patch 11 adds Device Tree information to describe the SDIO
>    interface on the Kirkwood SoCs.
> 
>  * Patches 12 and 13 convert the Dreamplug and mplcec4 Kirkwood
>    platforms to use the Device Tree to probe their SDIO interface and
>    mux the corresponding pins.
> 
>  * Patch 14 adds a pin mux option for the SDIO interface on the
>    88F6282 SoC, which is used in the Topkick platform.

Dropped (see my reply to the individual patch):

>  * Patch 15 makes the Topkick DTS file inherit the kirkwood-8262.dtsi,
>    so that it gets the pinctrl definition.
> 
>  * Patch 16 converts the Kirkwood Topkick platform to use the Device
>    Tree to probe its SDIO interface and mux the corresponding pins.

To give an idea of how it all pulls together so far, I have created a
(prone to rebasing!) branch, mvebu/for-next in which I have done the
following:

git checkout v3.8-rc2
git merge arm-soc/for-next
git merge mvebu/fixes
git merge mvebu/cleanup
git merge mvebu/drivers
git merge mvebu/boards
git merge mvebu/dt

So everything I've merged so far is in there, ready for testing.

thx,

Jason.
