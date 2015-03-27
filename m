From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 26 Mar 2015 22:48:21 -0700
Subject: [PATCH v2 2/2] watchdog: digicolor: driver for Conexant Digicolor
 CX92755 SoC
In-Reply-To: <CAM=Q2ctS6_=pzW2H+Yd3nEBgF269vfdh8yV3NbnWFP7b-MWLbA@mail.gmail.com>
References: <a4554d0a61c62b85a7d66b6e3d16d07f8a498025.1427356791.git.baruch@tkos.co.il>	<148dd2d6912211bc468c30acf85a463192576039.1427356791.git.baruch@tkos.co.il>
 <CAM=Q2ctS6_=pzW2H+Yd3nEBgF269vfdh8yV3NbnWFP7b-MWLbA@mail.gmail.com>
Message-ID: <5514EF25.4000400@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26/2015 10:40 PM, Shubhrajyoti Datta wrote:
>
>     +
>     +static int dc_restart_handler(struct notifier_block *this, unsigned long mode,
>     +                             void *cmd)
>     +{
>     +       struct dc_wdt *wdt = container_of(this, struct dc_wdt, restart_handler);
>     +
>     +       dc_wdt_set(wdt, 1);
>     +       /* wait for reset to assert... */
>     +       mdelay(500);
>
>
> How is the 500 calculated ?
> Also is it possible to sleep here?
>
sleep: No. It would also be pretty pointless, since this is after all the very last step
of rebooting the system.

Guenter
