From: tony@atomide.com (Tony Lindgren)
Date: Thu, 4 Oct 2018 07:30:22 -0700
Subject: [PATCH] ARM: OMAP1: ams-delta: Fix impossible .irq < 0
In-Reply-To: <20181002174745.GG3461@darkstar.musicnaut.iki.fi>
References: <20181001102453.GA18947@mwanda>
 <20181002094529.30564-1-jmkrzyszt@gmail.com>
 <20181002174745.GG3461@darkstar.musicnaut.iki.fi>
Message-ID: <20181004143021.GC5662@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [181002 17:52]:
> Hi,
> 
> On Tue, Oct 02, 2018 at 11:45:29AM +0200, Janusz Krzysztofik wrote:
> > Since the very beginning, unsigned int .irq member of struct
> > plat_serial8250_port introduced by commit eff443df679e ("OMAP1:
> > AMS_DELTA: add modem support") was statically initialized to a negative
> > value -EINVAL.  Moreover, commit 0812db943748 ("ARM: OMAP1: ams-delta:
> > assign MODEM IRQ from GPIO descriptor") has introduced some new code
> > which checks for that member carrying a negative value which is
> > impossible.
> > 
> > Use IRQ_NOTCONNECTED instead of -EINVAL. Also, drop the valueless check
> > and let the modem device be registered regardless of .irq value, and
> > the value handled by "serial8250" driver.
> > 
> > Fixes: 0812db943748 ("ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO descriptor")
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> 
> Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Applying into omap-for-v4.20/omap1 thanks.

Regards,

Tony
