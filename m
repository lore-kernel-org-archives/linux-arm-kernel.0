From: arend@broadcom.com (Arend van Spriel)
Date: Sat, 13 Sep 2014 17:13:18 +0200
Subject: [PATCH 1/2] bcma: register bcma as device tree driver
In-Reply-To: <1410615446-7639-1-git-send-email-hauke@hauke-m.de>
References: <1410615446-7639-1-git-send-email-hauke@hauke-m.de>
Message-ID: <54145F0E.8000506@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/14 15:37, Hauke Mehrtens wrote:
> This driver is used by the bcm53xx ARM SoC code. Now it is possible to
> give the address of the chipcommon core in device tree and bcma will
> search for all the other cores.
>
> Signed-off-by: Hauke Mehrtens<hauke@hauke-m.de>
> ---
>   Documentation/devicetree/bindings/bus/bcma.txt | 41 +++++++++++++
>   drivers/bcma/bcma_private.h                    | 16 +++++
>   drivers/bcma/host_soc.c                        | 82 ++++++++++++++++++++++++++
>   drivers/bcma/main.c                            | 10 ++++
>   include/linux/bcma/bcma.h                      |  2 +
>   5 files changed, 151 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/bus/bcma.txt
>
> This is based on wireless-testing and should go into that tree.
>
> changes since:
> RFC:
>   - reworded the irq description
>   - improved the example
>   - hocked into bcma_modeinit() and bcma_modexit()
>
> diff --git a/Documentation/devicetree/bindings/bus/bcma.txt b/Documentation/devicetree/bindings/bus/bcma.txt
> new file mode 100644
> index 0000000..17e095f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/bcma.txt
> @@ -0,0 +1,41 @@
> +Broadcom AIX SoC bcma bus driver

Hi Hauke,

First of all a typo used all over the place: AIX should be AXI.

The backplane in Broadcom SoC is ARM AXI with additional plugin option 
to make it discoverable. Indeed the IRQ info is not included, but I see 
no reason for specifying the register space for the cores in device-tree 
as that is discoverable by bcma.

Regards,
Arend
