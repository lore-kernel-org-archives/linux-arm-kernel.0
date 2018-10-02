From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Tue, 2 Oct 2018 20:47:45 +0300
Subject: [PATCH] ARM: OMAP1: ams-delta: Fix impossible .irq < 0
In-Reply-To: <20181002094529.30564-1-jmkrzyszt@gmail.com>
References: <20181001102453.GA18947@mwanda>
 <20181002094529.30564-1-jmkrzyszt@gmail.com>
Message-ID: <20181002174745.GG3461@darkstar.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 02, 2018 at 11:45:29AM +0200, Janusz Krzysztofik wrote:
> Since the very beginning, unsigned int .irq member of struct
> plat_serial8250_port introduced by commit eff443df679e ("OMAP1:
> AMS_DELTA: add modem support") was statically initialized to a negative
> value -EINVAL.  Moreover, commit 0812db943748 ("ARM: OMAP1: ams-delta:
> assign MODEM IRQ from GPIO descriptor") has introduced some new code
> which checks for that member carrying a negative value which is
> impossible.
> 
> Use IRQ_NOTCONNECTED instead of -EINVAL. Also, drop the valueless check
> and let the modem device be registered regardless of .irq value, and
> the value handled by "serial8250" driver.
> 
> Fixes: 0812db943748 ("ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO descriptor")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.
