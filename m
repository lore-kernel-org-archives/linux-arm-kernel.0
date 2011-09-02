From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 2 Sep 2011 20:30:07 +0200
Subject: [PATCH] at91/usb: always provide all the clocks
In-Reply-To: <CAAe_U6KoTmjXS5aH-FJBZiHVSPiKVB-poSx0mXdZyUJbNtdVzA@mail.gmail.com>
References: <1314667768-14129-1-git-send-email-plagnioj@jcrosoft.com>
	<CAAe_U6KoTmjXS5aH-FJBZiHVSPiKVB-poSx0mXdZyUJbNtdVzA@mail.gmail.com>
Message-ID: <20110902183007.GM20128@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:18 Tue 30 Aug     , ABRAHAM, KISHON VIJAY wrote:
> On Tue, Aug 30, 2011 at 6:59 AM, Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com> wrote:
> > drop the cpu_is in the driver
> > at91sam9261 and at91sam9g10 expect 3 clocks
> >
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> > ---
> > ?arch/arm/mach-at91/at91cap9.c ? ?| ? ?2 ++
> > ?arch/arm/mach-at91/at91rm9200.c ?| ? ?2 ++
> > ?arch/arm/mach-at91/at91sam9260.c | ? ?2 ++
> > ?arch/arm/mach-at91/at91sam9261.c | ? 29 +++++++++++++++--------------
> > ?arch/arm/mach-at91/at91sam9263.c | ? ?2 ++
> > ?arch/arm/mach-at91/at91sam9g45.c | ? ?2 ++
> > ?drivers/usb/host/ohci-at91.c ? ? | ? 15 +++++----------
> > ?7 files changed, 30 insertions(+), 24 deletions(-)
> >
> > diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
> > index bfc6844..ecdd54d 100644
> > --- a/arch/arm/mach-at91/at91cap9.c
> > +++ b/arch/arm/mach-at91/at91cap9.c
> > @@ -219,6 +219,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
> > ? ? ? ?CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.0", &tcb_clk),
> > ? ? ? ?CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc0_clk),
> > ? ? ? ?CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
> > + ? ? ? /* fake hclk clock */
> why is it a fake clock??
because we do have the hclk only on 9261 and 9g10

Best Regards,
J.
