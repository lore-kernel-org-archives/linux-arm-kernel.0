From: olof@lixom.net (Olof Johansson)
Date: Mon, 5 Nov 2012 09:48:41 -0800
Subject: [PATCH v2] arm: mvebu: support for the PlatHome OpenBlocks AX3-4
 board
In-Reply-To: <1351107203-31808-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1350980365-6698-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1351107203-31808-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20121105174841.GA20194@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 09:33:23PM +0200, Thomas Petazzoni wrote:

> +	compatible = "plathome,openblocks-ax3-4", "marvell,armadaxp-mv78260", "marvell,armadaxp", "marvell,armada-370-xp";

[...]

> diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
> index 49d7915..68f1483 100644
> --- a/arch/arm/mach-mvebu/armada-370-xp.c
> +++ b/arch/arm/mach-mvebu/armada-370-xp.c
> @@ -49,6 +49,7 @@ static void __init armada_370_xp_dt_init(void)
>  static const char * const armada_370_xp_dt_board_dt_compat[] = {
>  	"marvell,a370-db",
>  	"marvell,axp-db",
> +	"plathome,openblocks-ax3-4",
>  	NULL,
>  };

Hi,

One of the big benefits of device trees is to, in a perfect world, having to avoid
adding new C code for a new board.  It seems like this compatible array should
contain one of the more generic compatible fields instead, and you should then
have each board dts specify that as a fallback. It looks like you already list
those in the board dts file, so you're good at that end.

Would that work?

Also, I can't tell for sure but it seems like the list of compatibles in the
board dts go from specific to generic, i.e. if "marvell,armadaxp" is less
generic than "marvell,armada-370-xp".

-Olof
