From: tbm@cyrius.com (Martin Michlmayr)
Date: Sun, 17 Jan 2016 14:42:41 -0800
Subject: mvsdio not working on OpenRD
In-Reply-To: <20160110153843.GA22229@lunn.ch>
References: <20160110042619.GA22738@jirafa.cyrius.com>
 <20160110153843.GA22229@lunn.ch>
Message-ID: <20160117224241.GD24567@jirafa.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Andrew Lunn <andrew@lunn.ch> [2016-01-10 16:38]:
> Please can you try the following patch. If this works, i can add it to
> mainline. The issue we might run into is that somebody else wants
> serial not MMC....

This works fine on the OpenRD-Base (together with Aaro's patch), as
tested by Rick Thomas.

Reported-by: Rick Thomas <rbthomas@pobox.com>
Tested-by: Rick Thomas <rbthomas@pobox.com>
Reviewed-by: Martin Michlmayr <tbm@cyrius.com>

>        Andrew
> 
> diff --git a/arch/arm/boot/dts/kirkwood-openrd-base.dts b/arch/arm/boot/dts/kirkwood-openrd-base.dts
> index 8af58999606d..883bd416ba0b 100644
> --- a/arch/arm/boot/dts/kirkwood-openrd-base.dts
> +++ b/arch/arm/boot/dts/kirkwood-openrd-base.dts
> @@ -18,11 +18,6 @@
>  / {
>         model = "OpenRD Base";
>         compatible = "marvell,openrd-base", "marvell,openrd", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> -
> -       ocp at f1000000 {
> -               serial at 12100 {
> -                       status = "okay";
> -               };
>         };
>  };

-- 
Martin Michlmayr
http://www.cyrius.com/
