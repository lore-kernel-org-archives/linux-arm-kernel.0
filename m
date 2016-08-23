From: robh@kernel.org (Rob Herring)
Date: Tue, 23 Aug 2016 12:48:41 -0500
Subject: [PATCH 5/5] firmware: ti_sci: Add support for reboot core service
In-Reply-To: <20160819225159.10758-6-nm@ti.com>
References: <20160819225159.10758-1-nm@ti.com>
 <20160819225159.10758-6-nm@ti.com>
Message-ID: <20160823174841.GA23677@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2016 at 05:51:59PM -0500, Nishanth Menon wrote:
> Since system controller now has control over SoC power management, it
> needs to be explicitly requested to reboot the SoC. Add support for
> it.
> 
> In some systems however, SoC needs to toggle a GPIO or send event to an
> external entity (like a PMIC) for a system reboot to take place. To
> facilitate that, we allow for a DT property to determine if the reboot
> handler will be registered and further, the service is also made
> available to other drivers (such as PMIC driver) to sequence the
> additional operation and trigger the SoC reboot as the last step.
> 
> Tested-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  .../devicetree/bindings/arm/keystone/ti,sci.txt    |  1 +
>  drivers/firmware/ti_sci.c                          | 85 ++++++++++++++++++++++
>  drivers/firmware/ti_sci.h                          | 12 +++
>  include/linux/soc/ti/ti_sci_protocol.h             | 11 +++
>  4 files changed, 109 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> index 965d45e313b1..ed5b8fc185f1 100644
> --- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> +++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> @@ -38,6 +38,7 @@ Optional Properties:
>  - reg-names:
>  	debug_messages - Map the Debug message region
>  - reg:  register space corresponding to the debug_messages
> +- ti,system-reboot-controller: If system reboot can be triggered by SoC reboot

Don't define bindings incrementally. But all the binding in one patch.

Rob
