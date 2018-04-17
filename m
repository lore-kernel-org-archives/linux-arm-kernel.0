From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 17 Apr 2018 13:20:38 +0200
Subject: [PATCH v6 09/11] ARM: sun8i: smp: Add support for A83T
In-Reply-To: <20180416215032.5023-10-mylene.josserand@bootlin.com>
References: <20180416215032.5023-1-mylene.josserand@bootlin.com>
 <20180416215032.5023-10-mylene.josserand@bootlin.com>
Message-ID: <20180417112038.mw7bfhqw4xwvzxcw@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2018 at 11:50:30PM +0200, Myl?ne Josserand wrote:
> @@ -535,8 +599,12 @@ static int sunxi_mc_smp_cpu_kill(unsigned int l_cpu)
>  	return !ret;
>  }
>  
> -static bool sunxi_mc_smp_cpu_can_disable(unsigned int __unused)
> +static bool sunxi_mc_smp_cpu_can_disable(unsigned int cpu)
>  {
> +	/* CPU0 hotplug not handled for sun8i-a83t */
> +	if (is_sun8i)
> +		if (cpu == 0)
> +			return false;
>  	return true;

I think Chen-Yu told you how to implement the hotplug in the previous
iteration, did you have time to test it?

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180417/7a427abf/attachment.sig>
