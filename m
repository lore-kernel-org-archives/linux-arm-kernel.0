From: robh@kernel.org (Rob Herring)
Date: Tue, 17 Nov 2015 14:44:57 -0600
Subject: [PATCH 07/13] ARM: Xen: Document UEFI support on Xen ARM virtual
 platforms
In-Reply-To: <1447754231-7772-8-git-send-email-shannon.zhao@linaro.org>
References: <1447754231-7772-1-git-send-email-shannon.zhao@linaro.org>
 <1447754231-7772-8-git-send-email-shannon.zhao@linaro.org>
Message-ID: <20151117204457.GA31871@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 05:57:05PM +0800, shannon.zhao at linaro.org wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Add a "uefi" node under /hypervisor node in FDT, then Linux kernel could
> scan this to get the UEFI information.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/xen.txt | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/xen.txt b/Documentation/devicetree/bindings/arm/xen.txt
> index 0f7b9c2..c375d67 100644
> --- a/Documentation/devicetree/bindings/arm/xen.txt
> +++ b/Documentation/devicetree/bindings/arm/xen.txt
> @@ -15,6 +15,24 @@ the following properties:
>  - interrupts: the interrupt used by Xen to inject event notifications.
>    A GIC node is also required.
>  
> +To support UEFI on Xen ARM virtual platforms, Xen pupulates the FDT "uefi" node
> +under /hypervisor with following parameters:
> +
> +________________________________________________________________________________
> +Name                      | Size   | Description
> +================================================================================
> +xen,uefi-system-table     | 64-bit | Physical address of the UEFI System Table.
> +--------------------------------------------------------------------------------
> +xen,uefi-mmap-start       | 64-bit | Physical address of the UEFI memory map.
> +--------------------------------------------------------------------------------
> +xen,uefi-mmap-size        | 32-bit | Size in bytes of the UEFI memory map
> +                          |        | pointed to in previous entry.
> +--------------------------------------------------------------------------------
> +xen,uefi-mmap-desc-size   | 32-bit | Size in bytes of each entry in the UEFI
> +                          |        | memory map.
> +--------------------------------------------------------------------------------
> +xen,uefi-mmap-desc-ver    | 32-bit | Version of the mmap descriptor format.
> +--------------------------------------------------------------------------------

Why aren't you using what is already populated by UEFI as defined in 
Documentation/arm/uefi.txt? Seems to be about the same thing.

Rob
