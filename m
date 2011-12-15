From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Thu, 15 Dec 2011 07:36:23 +0000
Subject: [RFC PATCH v2 3/4] ARM: imx6q: using pinmux subsystem
In-Reply-To: <CACRpkdZhj2cqPL4yt+Xg7vy4jg-eauNzZFBUw2aSfvAauTqP0A@mail.gmail.com>
References: <1323878622-26602-1-git-send-email-b29396@freescale.com>
 <1323878622-26602-4-git-send-email-b29396@freescale.com>
 <CACRpkdZhj2cqPL4yt+Xg7vy4jg-eauNzZFBUw2aSfvAauTqP0A@mail.gmail.com>
Message-ID: <7FE21149F4667147B645348EC6057885056286@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Linus Walleij [mailto:linus.walleij at linaro.org]
> Sent: Thursday, December 15, 2011 2:03 AM
> To: Dong Aisheng-B29396
> Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linus.walleij at stericsson.com; s.hauer at pengutronix.de; Guo Shawn-R65073;
> kernel at pengutronix.de; grant.likely at secretlab.ca; rob.herring at calxeda.com
> Subject: Re: [RFC PATCH v2 3/4] ARM: imx6q: using pinmux subsystem
> Importance: High
> 
> On Wed, Dec 14, 2011 at 5:03 PM, Dong Aisheng <b29396@freescale.com>
> wrote:
> 
> > From: Dong Aisheng <dong.aisheng@linaro.org>
> >
> > Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Shawn Guo <shanw.guo@freescale.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> > +static struct pinmux_map imx6q_pinmux_map[] = {
> > + ? ? ? PINMUX_MAP_PRIMARY("usdhc4", "sd4", "219c000.usdhc"), };
> > +
> > ?static void __init imx6q_init_machine(void)
> > ?{
> > ? ? ? ?of_platform_populate(NULL, of_default_bus_match_table, NULL,
> > NULL);
> > -
> > + ? ? ? pinmux_register_mappings(imx6q_pinmux_map,
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?ARRAY_SIZE(imx6q_pinmux_map));
> > ? ? ? ?imx6q_pm_init();
> > ?}
> 
> So ideally this bit of code should also go into the device tree and we
> should add a DT hook inside drivers/pinctrl/pinmux.c
> 
> Please make a patch for this if you have a clear idea on how it should
> work!
> 
Yes, I will try to see that and will discuss with you once got an idea.

Regards
Dong Aisheng
