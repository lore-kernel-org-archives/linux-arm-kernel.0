From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 Nov 2012 22:43:23 -0800
Subject: [PATCH V6] Add support for generic BCM SoC chipsets
In-Reply-To: <1353347170-10257-1-git-send-email-csd@broadcom.com>
References: <1353347170-10257-1-git-send-email-csd@broadcom.com>
Message-ID: <20121120064323.GA18400@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 09:46:10AM -0800, Christian Daudt wrote:
> In order to start upstreaming Broadcom SoC support, create
> a starting hierarchy, arch and dts files.
> The first support SoC family that is planned is the
> BCM281XX (BCM11130/11140/11351/28145/28155) family of dual A9 mobile
> SoC cores.
> This code is just the skeleton code for get the machine upstreamed. It
> has been made MULTIPLATFORM compatible.
> Next steps
> ----------
> Upstream a basic set of drivers - sufficient for a console boot to
> ramdisk. These will includer timer, gpio, i2c drivers.
> After this basic set, we will proceed with a more comprehensive set
> of drivers for the 281XX SoC family.
> 
> v2 patch mods
> --------
>  - Remove l2x0_of_init call as there were problems with the code.
>    A separate patch will be submitted with cache init code
>  - Rename capri files and refs to bcm281xx-based names
>  - Add bcm281xx binding doc
>  - various misc cleanups
> 
> v3 patch mods
> -------------
>  - Remove extra #include lines
>  - Remove remaining references to capri
>  - dt uart chipset string added
>  - cleaned up chip # references
> 
> v4 patch mods
> -------------
>  - swap order of compatible definitions for uart
>  - fix typo
> 
> v5 patch mods
> -------------
>  - Rename bcm281xx to bcm11351 in dts+code,
>    leaving references to bcm281xx only in help+comments.
> 
> v6 patch mods
> -------------
>  - fix typo in uart 'compatible' string
> 
> Signed-off-by: Christian Daudt <csd@broadcom.com>
> Reviewed-by: Stephen Warren <swarren@nvidia.com>

This looks good, and I don't see any outstanding review comments from
anyone. I've applied it to next/soc, so please send incremental patches for
anything new beyond this point.


Thanks!

-Olof
