From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 5 Mar 2011 17:41:11 +0100
Subject: [PATCH 1/3] video: mxsfb: smarten the code a little bit
In-Reply-To: <1299341931-30241-2-git-send-email-shawn.guo@freescale.com>
References: <1299341931-30241-1-git-send-email-shawn.guo@freescale.com>
	<1299341931-30241-2-git-send-email-shawn.guo@freescale.com>
Message-ID: <201103051741.12167.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 05 March 2011 17:18:49 Shawn Guo wrote:
> @@ -882,7 +884,6 @@ static struct platform_device_id mxsfb_devtype[] = {
>         }, {
>                 .name = "imx28-fb",
>                 .driver_data = MXSFB_V4,
> -       }, {
>         },
>  };

This is broken, you need to have an empty entry as the end marker,
otherwise, the match function will interpret whatever comes in 
memory after the last entry as input data, until it hits zeroes.

	Arnd
