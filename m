From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 14 Dec 2015 11:46:13 -0800
Subject: [PATCH/RFC 0/7] ARM: dts: Add compatible property to
 "partitions" node
In-Reply-To: <1450120304-2760-1-git-send-email-geert+renesas@glider.be>
References: <1450120304-2760-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20151214194613.GA126731@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 08:11:37PM +0100, Geert Uytterhoeven wrote:
> 	Hi,
> 
> As of commit e488ca9f8d4f62c2 ("doc: dt: mtd: partitions: add compatible
> property to "partitions" node"), the "partitions" subnode of an SPI
> FLASH device node must have a compatible property. The partitions are no
> longer detected if it is not present.

For all patches:

Acked-by: Brian Norris <computersforpeace@gmail.com>

> I marked this series as "RFC", as the abovementioned commit is not yet
> upstream. Ideally, the users should be fixed first, to avoid breakage.

I'd differ on the last sentence. It's more important to straighten out
the release features for 4.4 than to make sure that linux-next has
perfect DTS files. So I'll submit whenever ready :)

FWIW, I plan to submit my pullreq this week, hopefully by
end-of-Wednesday. (There are other potential MTD fixes that haven't
stabilized. I may just send them separately.)

Regards,
Brian

> Tested on r8a7791/koelsch.
> 
> Thanks!
> 
> Geert Uytterhoeven (7):
>   ARM: dt: mvebu: ix4-300d: Add compatible property to "partitions" node
>   ARM: shmobile: bockw dts: Add compatible property to "partitions" node
>   ARM: shmobile: lager dts: Add compatible property to "partitions" node
>   ARM: shmobile: koelsch dts: Add compatible property to "partitions"
>     node
>   ARM: shmobile: porter dts: Add compatible property to "partitions"
>     node
>   ARM: shmobile: gose dts: Add compatible property to "partitions" node
>   ARM: shmobile: silk dts: Add compatible property to "partitions" node
> 
>  arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts | 1 +
>  arch/arm/boot/dts/r8a7778-bockw.dts             | 1 +
>  arch/arm/boot/dts/r8a7790-lager.dts             | 1 +
>  arch/arm/boot/dts/r8a7791-koelsch.dts           | 1 +
>  arch/arm/boot/dts/r8a7791-porter.dts            | 1 +
>  arch/arm/boot/dts/r8a7793-gose.dts              | 1 +
>  arch/arm/boot/dts/r8a7794-silk.dts              | 1 +
>  7 files changed, 7 insertions(+)
> 
> -- 
> 1.9.1
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
