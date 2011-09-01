From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 01 Sep 2011 20:17:09 +0200
Subject: [PATCH 2/7] arm/dts: OMAP3: Add mpu and iva nodes
In-Reply-To: <1314897912-18178-3-git-send-email-b-cousson@ti.com>
References: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
	<1314897912-18178-3-git-send-email-b-cousson@ti.com>
Message-ID: <1377915.IaVE5xAurc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 September 2011 19:25:07 Benoit Cousson wrote:
> 
>         /*
> +        * XXX: The cpus node is mandatory, but since the CPUs are as well part
> +        * of the mpu subsystem below, it is not clear where the information
> +        * should be. Maybe here with a phandle inside the mpu?
> +        */
> +       cpus {
> +       };
> +
> +       /*
>          * The soc node represents the soc top level view. It is uses for IPs
>          * that are not memory mapped in the MPU view or for the MPU itself.
>          */
>         soc {
>                 compatible = "ti,omap-infra";
> +               mpu {
> +                       compatible = "ti,omap3-mpu";
> +                       hwmods = "mpu";
> +                       cpu at 0 {
> +                               compatible = "arm,cortex-a8";
> +                       };
> +               };
> +

I would always put the cpu nodes in the top-level, even if that's
a slight misrepresentation of the truth. The point is basically
that CPU nodes are special (you cannot have device drivers for them)
and that the device tree is basically laid out from the perspective
of the CPU, which may be different from the perspective that a
hardware designer has.

	Arnd
