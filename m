From: tony@atomide.com (Tony Lindgren)
Date: Fri, 13 Mar 2015 08:27:52 -0700
Subject: [PATCH v6 5/6] ARM: dts: add wl12xx/wl18xx bindings
In-Reply-To: <1426162154-8716-6-git-send-email-eliad@wizery.com>
References: <1426162154-8716-1-git-send-email-eliad@wizery.com>
 <1426162154-8716-6-git-send-email-eliad@wizery.com>
Message-ID: <20150313152751.GK5264@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Eliad Peller <eliad@wizery.com> [150312 05:09]:
> --- a/arch/arm/mach-omap2/pdata-quirks.c
> +++ b/arch/arm/mach-omap2/pdata-quirks.c
>  
> -static void __init omap3_evm_legacy_init(void)
> -{
> -	legacy_init_wl12xx(38400000, 0, 149);
> -}

FYI, at least this part conflicts with the fixes in the arm-soc
tree for the v4.0-rc series as omap3 evm also needs the copy clock
quirk.

> @@ -419,20 +351,9 @@ static struct pdata_init pdata_quirks[] __initdata = {
>  	{ "nokia,omap3-n950", hsmmc2_internal_input_clk, },
>  	{ "isee,omap3-igep0020-rev-f", omap3_igep0020_rev_f_legacy_init, },
>  	{ "isee,omap3-igep0030-rev-g", omap3_igep0030_rev_g_legacy_init, },
> -	{ "ti,omap3-evm-37xx", omap3_evm_legacy_init, },

So this function cannot be yet removed.

With that fixed, I was able to iw dev wlan0 scan with series on
omap3 evm :)

Regards,

Tony
