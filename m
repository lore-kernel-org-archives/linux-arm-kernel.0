From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 13 Feb 2013 20:12:24 -0800 (PST)
Subject: [PATCH] ARM: shmobile: r8a7779: Correct TMU clock support again
In-Reply-To: <CANqRtoQtROi1cD3MmykhKLqY+1Y2=f+1Qkmw2bjAaP6yZRPW=Q@mail.gmail.com>
References: <1360813381-3416-1-git-send-email-horms+renesas@verge.net.au>
 <87a9r7v8xd.wl%kuninori.morimoto.gx@renesas.com>
 <CANqRtoQtROi1cD3MmykhKLqY+1Y2=f+1Qkmw2bjAaP6yZRPW=Q@mail.gmail.com>
Message-ID: <878v6rv8ij.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Magnus, Simon

Thank you for your explain

> >> --- a/arch/arm/mach-shmobile/clock-r8a7779.c
> >> +++ b/arch/arm/mach-shmobile/clock-r8a7779.c
> >> @@ -161,7 +161,7 @@ static struct clk_lookup lookups[] = {
> >>       CLKDEV_DEV_ID("ehci-platform.0", &mstp_clks[MSTP100]), /* USB EHCI port0/1 */
> >>       CLKDEV_DEV_ID("ohci-platform.0", &mstp_clks[MSTP100]), /* USB OHCI port0/1 */
> >>       CLKDEV_DEV_ID("sh_tmu.0", &mstp_clks[MSTP016]), /* TMU00 */
> >> -     CLKDEV_DEV_ID("sh_tmu.1", &mstp_clks[MSTP015]), /* TMU01 */
> >> +     CLKDEV_DEV_ID("sh_tmu.1", &mstp_clks[MSTP016]), /* TMU01 */
> >>       CLKDEV_DEV_ID("sh_tmu.2", &mstp_clks[MSTP014]), /* TMU02 */
> >>       CLKDEV_DEV_ID("i2c-rcar.0", &mstp_clks[MSTP030]), /* I2C0 */
> >>       CLKDEV_DEV_ID("i2c-rcar.1", &mstp_clks[MSTP029]), /* I2C1 */
> >
> > Really ???
> > Is MSTP value of TMU01 same as TMU00 ?
> 
> Usually, the TMU channels are bundled together. So TMU00 may be for
> channel 0->3 and TMU01 for 4->6.

This means that current TMU02 numbering seems doubtful too ?
How about just rever 58079fa7d54a0929d304054ee759187a2ccd3cdf ?

Best regards
---
Kuninori Morimoto
