From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 10 Jul 2013 14:29:25 -0300
Subject: [PATCH 3/3] ARM: imx: mm-imx3: Free l2x0_base
In-Reply-To: <CAOMZO5AeJVRL3VhLdYPtAq7-9+Dh3o=ntwhqYOrZZeR7TbBDyQ@mail.gmail.com>
References: <1373306318-15604-1-git-send-email-festevam@gmail.com>
 <1373306318-15604-3-git-send-email-festevam@gmail.com>
 <20130709062414.GG16656@S2101-09.ap.freescale.net>
 <CAOMZO5D4ivbqYovVA2CpXEemrAq8Nyn5By8-iL3SAnw=mpJ+og@mail.gmail.com>
 <20130709182046.GD516@pengutronix.de>
 <CAOMZO5AeJVRL3VhLdYPtAq7-9+Dh3o=ntwhqYOrZZeR7TbBDyQ@mail.gmail.com>
Message-ID: <CAOMZO5DF2bu7CyehQHe671D34DuzuM1uktxbGn+Pw0s5BuQdcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 10, 2013 at 1:53 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Sascha,
>
> On Tue, Jul 9, 2013 at 3:20 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
>> l2x0_base is passed to l2x0_init which uses it for the outer cache
>> maintenance operations. I wonder this doesn't crash your kernel.
>
> l2x0_init() is called from arch/arm/mach-imx/mm-imx3.c first and then
> from arch/arm/mm/cache-l2x0.c
> later.
>
> Why do we need to call it twice?

Understood now, actually l2x0_init() is only called in
arch/arm/mm/cache-l2x0.c for the dt case.

So all is fine with the current code.
