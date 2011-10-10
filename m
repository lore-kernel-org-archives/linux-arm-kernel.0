From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 10 Oct 2011 14:49:14 +0200
Subject: [PATCH 01/13] hwspinlock: OMAP4: Add spinlock support in DT
In-Reply-To: <1317055821-20652-2-git-send-email-b-cousson@ti.com>
References: <1317055821-20652-1-git-send-email-b-cousson@ti.com>
	<1317055821-20652-2-git-send-email-b-cousson@ti.com>
Message-ID: <CAK=WgbYBDPRsknBWiXP_z36bu2U_Y6GLqtCyLuj94YqJNA37mA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

On Mon, Sep 26, 2011 at 7:50 PM, Benoit Cousson <b-cousson@ti.com> wrote:
> +++ b/Documentation/devicetree/bindings/hwspinlock/omap-spinlock.txt
> @@ -0,0 +1,5 @@
> +* HW spinlock on OMAP4 platform:
> +
> +Required properties:
> +- compatible : Must be "ti,omap4-spinlock";
> +- ti,hwmods : "spinlock"
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 4c61c82..7a7f31e 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -99,5 +99,10 @@
> ? ? ? ? ? ? ? ? ? ? ? ?reg = <0x48241000 0x1000>,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?<0x48240100 0x0100>;
> ? ? ? ? ? ? ? ?};
> +
> + ? ? ? ? ? ? ? spinlock {
> + ? ? ? ? ? ? ? ? ? ? ? compatible = "ti,omap4-spinlock";
> + ? ? ? ? ? ? ? ? ? ? ? ti,hwmods = "spinlock";
> + ? ? ? ? ? ? ? };

I think it'd be nice to add the 'baseid' property as we discussed for
dynamic allocation of hwspinlocks.

The patch that adds the hwspinlock groundwork for this is in
linux-next and will hopefully get into 3.2 if everything works out
well:

https://lkml.org/lkml/2011/9/12/194

Of course, as we discussed with Arnd, we will use phandles to the
hwspinlock controller when we'll get to static allocations of
hwspinlock instances.

Thanks,
Ohad.
