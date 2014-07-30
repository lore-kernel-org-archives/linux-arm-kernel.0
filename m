From: olof@lixom.net (Olof Johansson)
Date: Wed, 30 Jul 2014 11:14:23 -0700
Subject: [PATCH 2/5] arm64, thunder: Add initial dts for Cavium Thunder SoC
In-Reply-To: <1406732794-20920-3-git-send-email-rric@kernel.org>
References: <1406732794-20920-1-git-send-email-rric@kernel.org>
 <1406732794-20920-3-git-send-email-rric@kernel.org>
Message-ID: <CAOesGMh9KkdKB_ytJ7CCbkPW7dHTX91NdfDMsMNfbmOBVOJ8PQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 30, 2014 at 8:06 AM, Robert Richter <rric@kernel.org> wrote:
> From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
>
> Add initial device tree nodes for Cavium Thunder SoCs with support of
> 48 cores and gicv3. The dts file requires further changes, esp. for
> pci, gicv3-its and smmu. This changes will be added later together
> with the device drivers.
>
> Signed-off-by: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> ---
>  arch/arm64/boot/dts/Makefile         |   1 +
>  arch/arm64/boot/dts/thunder-88xx.dts | 387 +++++++++++++++++++++++++++++++++++
>  2 files changed, 388 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/thunder-88xx.dts
>
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index c52bdb051f66..f8001a62029c 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -1,3 +1,4 @@
> +dtb-$(CONFIG_ARCH_THUNDER) += thunder-88xx.dtb
>  dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb foundation-v8.dtb
>  dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb

Oh, and:

Let's fix the mistake we made on 32-bit here (that we can't undo
unless we move all dts files now, which is too much churn), and put
each SoC vendor in its own subdirectory.

So, please add a arch/arm64/boot/dts/cavium/ directory, add a Makefile
and the dts there.

We should move vexpress under arm/   and xgene under apm/ too.
