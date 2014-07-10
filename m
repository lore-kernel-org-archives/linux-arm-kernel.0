From: bhelgaas@google.com (Bjorn Helgaas)
Date: Thu, 10 Jul 2014 15:39:37 -0600
Subject: [PATCH V9 1/7] pcie: Add designware wrapper driver for SPEAr13xx
In-Reply-To: <9430e4b284928e4919297de5602e803d03f82d7b.1404976058.git.viresh.kumar@linaro.org>
References: <cover.1404976058.git.viresh.kumar@linaro.org>
 <9430e4b284928e4919297de5602e803d03f82d7b.1404976058.git.viresh.kumar@linaro.org>
Message-ID: <20140710213937.GB15190@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I guess I'm obsessive, but I think it's nice when people run
"git log --oneline" on the file or directory they're changing,
and then follow the existing style.

In this case, that would lead to a subject line like:

    PCI: spear: Add PCIe driver for ST Microelectronics SPEAr13xx

On Thu, Jul 10, 2014 at 12:56:32PM +0530, Viresh Kumar wrote:
> From: Pratyush Anand <pratyush.anand@st.com>
> 
> ARM based ST Microelectronics's SPEAr1310 and SPEAr1340 SOCs have onchip
> designware PCIe controller. To make that usable, this patch adds a wrapper
> driver based on existing designware driver.
> 
> Adds bindings for this new driver and update MAINTAINERS as well.
> 
> Cc: linux-pci at vger.kernel.org
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Acked-by: Jingoo Han <jg1.han@samsung.com>
> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> Signed-off-by: Mohit Kumar <mohit.kumar@st.com>
> [viresh: fixed logs/cclist/checkpatch warnings, broken into smaller patches]
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 702ca10..443dd05 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6820,6 +6820,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/host-generic-pci.txt
>  F:	drivers/pci/host/pci-host-generic.c
>  
> +PCIE DRIVER FOR ST SPEAR13XX
> +M:	Mohit Kumar <mohit.kumar@st.com>
> +L:	linux-pci at vger.kernel.org
> +S:	Maintained
> +F:	drivers/pci/host/pcie-spear13xx.c

Wildcards work here, so you could follow the lead of IMX6, MVEBU, RCAR,
and DESIGNWARE and use:

    F:	drivers/pci/host/*spear*

> --- /dev/null
> +++ b/drivers/pci/host/pcie-spear13xx.c
> ...
> +#define PCI_CAP_ID_EXP_OFFSET			0x70

A nit, but I'd use a name like EXP_CAP_ID_OFFSET to make it
more clear that this is specific to SPEAr, not something from
the PCI specs.

Bjorn
