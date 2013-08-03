From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 3 Aug 2013 14:56:34 -0400
Subject: [PATCHv2 0/9] ARM: kirkwood: convert a few more boards to DT
In-Reply-To: <1375369655-1310-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375369655-1310-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130803185634.GH13555@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 05:07:26PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> Here is a set of patches that converts a few additional Kirkwood
> boards to use the Device Tree. I intend to continue this effort with
> the remaining Kirkwood boards. It is based on the mvebu/boards branch
> of linux-mvebu.git, which allows to use the Ethernet DT bindings.
> 
> Note that I don't have access to any of the platforms that are being
> converted in this patch series, so this means that:
> 
>  - A careful review would be useful
> 
>  - Testing from owners of the boards would be appreciated. The DT
>    conversion of Kirkwood boards is a process that has now been
>    started a while ago, and we would like to finalize it. If board
>    owners don't react by testing the proposed patches, then the
>    support for those boards might be broken.
> 
> To ease testing, the branch containing those changes has been pushed
> to:
> 
>   https://github.com/MISL-EBU-System-SW/mainline-public/tree/kirkwood-dt-conversion-step1-v2
> 
> and kernel images for the affected boards have been uploaded to the
> following locations. They contain the correct appended DTB, and a
> small initramfs to ease testing:
> 
>   http://free-electrons.com/~thomas/pub/kirkwood/uImage.kirkwood-d2net-v2
>   http://free-electrons.com/~thomas/pub/kirkwood/uImage.kirkwood-mv88f6281gtw-ge
>   http://free-electrons.com/~thomas/pub/kirkwood/uImage.kirkwood-net2big-v2
>   http://free-electrons.com/~thomas/pub/kirkwood/uImage.kirkwood-net5big-v2
> 
> In detail:
> 
>  * Patch 1 converts the d2net_v2 board completely to DT.
> 
>  * Patches 2, 3, 4 and 5 remove support for boards that have already
>    been converted to the Deice Tree, but for which the legacy board
>    file was not removed.
> 
>  * Patch 6 converts the mv88f6281gtw_ge board to DT.
> 
>    The remaining devices probed in a legacy way are the mv643xx_eth
>    driver, and the DSA switch (note that I have an Armada 370 platform
>    with a DSA switch, so I'll have to look at how to make this appear
>    in the DT). I've left the Ethernet device not converted to DT
>    because the interaction with the DSA switch is a bit special.
> 
>  * Patch 7 converts the LaCie Net{2,5}Big v2 platforms to DT
> 
>    The remaining device probed is the one managed by the leds-netxbig
>    driver. For Ethernet, see above. For leds-netxbig, Simon Guinot is
>    currently working on this (see the LAKML thread "Location for a
>    kind of GPIO bus driver").
> 
>  * Patch 8 removes some common code for LaCie boards that has become
>    useless after the DT conversions.
> 
>  * Patch 9 adjusts kirkwood_defconfig after the DT conversions.

I've applied patches 2,3,4,5,6 to mvebu/boards,

thx,

Jason.
