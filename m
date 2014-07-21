From: tony@atomide.com (Tony Lindgren)
Date: Mon, 21 Jul 2014 00:01:25 -0700
Subject: [v3 PATCH 2/6] dt: TI: Describe the ti reset DT entries
In-Reply-To: <1405615531-15649-2-git-send-email-dmurphy@ti.com>
References: <1405615531-15649-1-git-send-email-dmurphy@ti.com>
 <1405615531-15649-2-git-send-email-dmurphy@ti.com>
Message-ID: <20140721070125.GM18374@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dan Murphy <dmurphy@ti.com> [140717 09:47]:
> +
> +example:
> +		prm: prm at 4ae06000 {
> +			compatible = "ti,omap5-prm";
> +			reg = <0x4ae06000 0x3000>;
> +
> +			prm_resets: resets {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				#reset-cells = <1>;
> +			};
> +		};

Probably the way to go with mapping various PRCM registers to separate
drivers is to provide one or more syscon entries like we already have
for the SCM. You may want to coordinate this with Tero.

Regards,

Tony
