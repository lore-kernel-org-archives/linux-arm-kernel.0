From: b-cousson@ti.com (Cousson, Benoit)
Date: Tue, 23 Aug 2011 21:03:55 +0200
Subject: [RFC/PATCH v2 10/13] dt: omap4: panda board: set clock freq for
	i2c devices
In-Reply-To: <4E537F6B.4060608@ti.com>
References: <1314074021-25186-11-git-send-email-manjugk@ti.com>
	<4E537F6B.4060608@ti.com>
Message-ID: <4E53F99B.3060308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: G, Manjunath Kondaiah<manjugk@ti.com>
> To: devicetree-discuss at lists.ozlabs.org
> CC: linux-omap at vger.kernel.org, linux-arm-kernel at lists.infradead.org
>
>
> Update omap4 panda dts file with required clock frequencies
> for the i2c client devices existing on panda board.
>
> Signed-off-by: G, Manjunath Kondaiah<manjugk@ti.com>
> ---
>    arch/arm/boot/dts/omap4-panda.dts |   16 ++++++++++++++++
>    1 files changed, 16 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap4-panda.dts
> b/arch/arm/boot/dts/omap4-panda.dts
> index c28aa95..6b831ca 100644
> --- a/arch/arm/boot/dts/omap4-panda.dts
> +++ b/arch/arm/boot/dts/omap4-panda.dts
> @@ -3,4 +3,20 @@
>    / {
>    	model = "TI OMAP4 PandaBoard";
>    	compatible = "ti,omap4-panda", "ti,omap4430";
> +
> +	i2c1 {
> +		clock-frequency =<400000>;
> +	};
> +
> +	i2c2 {
> +		clock-frequency =<400000>;
> +	};
> +
> +	i2c3 {
> +		clock-frequency =<400000>;
> +	};
> +
> +	i2c4 {
> +		clock-frequency =<400000>;
> +	};
>    };

Are you sure that this patch is setting the expected frequency?
I see 100kHz in the boot log even with that patch.

I took me some time to find the proper syntax, but in order to reference 
an existing node, you have to use &i2c1 at the top level of the file. If 
you check the output of the DTC compiler, you will see the property at 
the proper node.

Benoit
