From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 26 Mar 2012 08:47:37 +0000
Subject: ioremap to a specific virtual address
In-Reply-To: <201203251734.41780.arnd@arndb.de>
References: <CAKON4Ox5YXvbGwbsYRetOPxV+HVDwmEd-mbqj2fyDfnCcBjaRA@mail.gmail.com>
 <CAKON4OwhcFDMC4dWjU7x4u2CPT7C2BxVuCDkTN0j14gTndi3tA@mail.gmail.com>
 <201203251734.41780.arnd@arndb.de>
Message-ID: <201203260847.38176.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 25 March 2012, Arnd Bergmann wrote:
>                         /* mpmc configuration */
>                         mpmc-static-config     = <0x81>;
>                         mpmc-static-wait-wen   = <1>;
>                         mpmc-static-wait-oen   = <1>;
>                         mpmc-static-wait-rd    = <4>;
>                         mpmc-static-wait-page  = <1>;
>                         mpmc-static-wait-write = <1>;
>                         mpmc-static-wait-turn  = <2>;

On second though, I guess you can turn these into a single
property named "mpmc-timings" or such and then just copy
them to the registers.

I also wonder whether the timings are actually correct for your
dm9000 device. Maybe the additional gpio read in there was
just an indication that someone worked around incorrect timings?

	Arnd
