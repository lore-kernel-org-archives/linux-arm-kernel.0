From: robh@kernel.org (Rob Herring)
Date: Tue, 12 Jun 2018 15:39:22 -0600
Subject: [RFC PATCH 1/3] Documentation: dt: keystone: ti-sci: Add
 optional host-id parameter
In-Reply-To: <20180605062640.3356-2-nm@ti.com>
References: <20180605062640.3356-1-nm@ti.com> <20180605062640.3356-2-nm@ti.com>
Message-ID: <20180612213922.GA26791@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2018 at 01:26:38AM -0500, Nishanth Menon wrote:
> Texas Instrument's System Control Interface (TISCI) permits the
> ability for Operating Systems to running in virtual machines to be

...for OSs running in virtual...

> able to independently communicate with the firmware without the need
> going through an hypervisor.
> 
> The "host-id" in effect is the hardware representation of the
> host (example: VMs locked to a core) as identified to the System
> Controller.

So the hypervisor will fill in host-id's for each VM instance?

> 
> This is introduced as an optional parameter to maintain consistency
> with legacy device tree blobs.
> 
> We call this with a vendor prefix to prevent any possible confusion
> with SCSI ID (m68k) kernel option.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/keystone/ti,sci.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> index 31f5f9a104cc..b56a02c10ae6 100644
> --- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> +++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> @@ -45,11 +45,15 @@ Optional Properties:
>  	debug_messages - Map the Debug message region
>  - reg:  register space corresponding to the debug_messages
>  - ti,system-reboot-controller: If system reboot can be triggered by SoC reboot
> +- ti,host-id: Integer value corresponding to the host ID assigned by Firmware
> +	for identification of host processing entities such as virtual
> +	machines
>  
>  Example (K2G):
>  -------------
>  	pmmc: pmmc {
>  		compatible = "ti,k2g-sci";
> +		ti,host-id = <2>;
>  		mbox-names = "rx", "tx";
>  		mboxes= <&msgmgr &msgmgr_proxy_pmmc_rx>,
>  			<&msgmgr &msgmgr_proxy_pmmc_tx>;
> -- 
> 2.15.1
> 
