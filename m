From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Apr 2014 09:36:40 +0200
Subject: [PATCH 3/4] arm: add basic support for Mediatek MT6589 boards
In-Reply-To: <1397072736-10793-4-git-send-email-matthias.bgg@gmail.com>
References: <1397072736-10793-1-git-send-email-matthias.bgg@gmail.com>
 <1397072736-10793-4-git-send-email-matthias.bgg@gmail.com>
Message-ID: <4752537.la6uZladzC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 April 2014 21:45:35 Matthias Brugger wrote:
> This adds a generic devicetree board file and a dtsi for boards
> based on the MT6589 SoCs from Mediatek.
> 
> Apart from the generic parts (gic, clocks) the only component
> currently supported are the timers.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

Hi Matthias,

First of all, I'm really glad to see this get started, thanks for looking
into these!

Do you know how similar the MT6589 is to the later chips like MT65x2
and MT6588? What are the on-chip devices like, is it mostly licensed
IP blocks from designware and others that we already have drivers for,
or all new drivers?

> +#include <asm/hardware/cache-l2x0.h>
> +
> +static void __init mediatek_dt_init(void)
> +{
> +	l2x0_of_init(0, ~0);
> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +}

I hope that with all the cleanup work that Russell has done in the
past few weeks, we can manage to kill off the call to l2x0_of_init()
here and have it done by core architecture code instead. That would
let you have an empty machine file, unless you have other things you
will need to add in the future.

	Arnd
