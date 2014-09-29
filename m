From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 29 Sep 2014 12:52:15 +0530
Subject: [PATCH 1/2] clk: samsung: exynos3250: add uart2/3 related clocks
In-Reply-To: <CAH9JG2UFFHwA=5g5Dg66A5gniPw+mEiVJCd=nZYLWgtLZ1R9zg@mail.gmail.com>
References: <1411793928-32692-1-git-send-email-pankaj.dubey@samsung.com>
 <1411793928-32692-2-git-send-email-pankaj.dubey@samsung.com>
 <5428BFFE.9090002@samsung.com> <001201cfdb8f$b9dae350$2d90a9f0$@samsung.com>
 <CAH9JG2UFFHwA=5g5Dg66A5gniPw+mEiVJCd=nZYLWgtLZ1R9zg@mail.gmail.com>
Message-ID: <000001cfdbb6$1aef87b0$50ce9710$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday, September 29, 2014 9:07 AM, Kyungmin Park wrote,
> To: Pankaj Dubey
> Cc: Chanwoo Choi; Kukjin Kim; Russell King - ARM Linux;
naushad at samsung.com;
> Tomasz Figa; linux-samsung-soc; robh+dt at kernel.org; Sylwester Nawrocki;
Mike
> Turquette; arm-linux
> Subject: Re: [PATCH 1/2] clk: samsung: exynos3250: add uart2/3 related
clocks
> 
> On Mon, Sep 29, 2014 at 11:47 AM, Pankaj Dubey <pankaj.dubey@samsung.com>
> wrote:
> > Hi Chanwoo,
> >
> > On Monday, September 29, 2014 7:42 AM, Chanwoo Choi wrote,
> >> To: Pankaj Dubey
> >> Cc: linux-arm-kernel at lists.infradead.org;
> > linux-samsung-soc at vger.kernel.org;
> >> kgene.kim at samsung.com; tomasz.figa at gmail.com; robh+dt at kernel.org;
> >> linux at arm.linux.org.uk; naushad at samsung.com; Mike Turquette;
> >> Sylwester Nawrocki
> >> Subject: Re: [PATCH 1/2] clk: samsung: exynos3250: add uart2/3
> >> related
> > clocks
> >>
> >> Hi Pankaj,
> >>
> >> On 09/27/2014 01:58 PM, Pankaj Dubey wrote:
> >> > Exynos3250 has four UART channels UART0,1,2 and 3. This patch adds
> >> > missing clock entries for UART2 and UART3.
> >> >
> >> > CC: Mike Turquette <mturquette@linaro.org>
> >> > CC: Sylwester Nawrocki <s.nawrocki@samsung.com>
> >> > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> >> > ---
> >> >  drivers/clk/samsung/clk-exynos3250.c   |   11 +++++++++++
> >> >  include/dt-bindings/clock/exynos3250.h |   10 +++++++++-
> >> >  2 files changed, 20 insertions(+), 1 deletion(-)
> >>
> >> Exynos3250 has only two UART(0,1) port. Exynos3250 don't support UART
> 2,3.
> >>
> >
> > As per Exynos3250 user manual that I have with me it supports
UART(0,1,2,3).
> > It has been mentioned
> which UM do you use? There are two UARTs at rev0.01
> 

I am using Rev 2.0.

Thanks,
Pankaj Dubey


> > in UART Chapter as well as CMU IP details also mentioned about the
> > clock entries. We have tested it also on Espresso3250 board which is
> > based on Exynos3250 SoC.
> I can't find it at my UM.
> 
> Kyungmin Park
> >
> > Thanks,
> > Pankaj Dubey
> >
> >> Thanks,
> >> Chanwoo Choi
> >>
> >> >
> >> > diff --git a/drivers/clk/samsung/clk-exynos3250.c
> >> > b/drivers/clk/samsung/clk-exynos3250.c
> >> > index dc85f8e..0722fef 100644
> >> > --- a/drivers/clk/samsung/clk-exynos3250.c
> >> > +++ b/drivers/clk/samsung/clk-exynos3250.c
> >> > @@ -357,6 +357,8 @@ static struct samsung_mux_clock mux_clks[]
> > __initdata =
> >> {
> >> >     MUX(CLK_MOUT_MMC0, "mout_mmc0", group_sclk_p, SRC_FSYS, 0,
> 3),
> >> >
> >> >     /* SRC_PERIL0 */
> >> > +   MUX(CLK_MOUT_UART3, "mout_uart3", group_sclk_p, SRC_PERIL0,
> >> 12, 4),
> >> > +   MUX(CLK_MOUT_UART2, "mout_uart2", group_sclk_p, SRC_PERIL0,
> 8,
> >> 4),
> >> >     MUX(CLK_MOUT_UART1, "mout_uart1", group_sclk_p, SRC_PERIL0,
> 4,
> >> 4),
> >> >     MUX(CLK_MOUT_UART0, "mout_uart0", group_sclk_p, SRC_PERIL0,
> 0,
> >> 4),
> >> >
> >> > @@ -439,6 +441,8 @@ static struct samsung_div_clock div_clks[]
> > __initdata = {
> >> >     DIV(CLK_DIV_MMC0, "div_mmc0", "mout_mmc0", DIV_FSYS1, 0, 4),
> >> >
> >> >     /* DIV_PERIL0 */
> >> > +   DIV(CLK_DIV_UART3, "div_uart3", "mout_uart3", DIV_PERIL0, 12,
> 4),
> >> > +   DIV(CLK_DIV_UART2, "div_uart2", "mout_uart2", DIV_PERIL0, 8,
> >> > + 4),
> >> >     DIV(CLK_DIV_UART1, "div_uart1", "mout_uart1", DIV_PERIL0, 4, 4),
> >> >     DIV(CLK_DIV_UART0, "div_uart0", "mout_uart0", DIV_PERIL0, 0,
> >> > 4),
> >> >
> >> > @@ -601,6 +605,10 @@ static struct samsung_gate_clock gate_clks[]
> > __initdata
> >> = {
> >> >             GATE_SCLK_PERIL, 7, CLK_SET_RATE_PARENT, 0),
> >> >     GATE(CLK_SCLK_SPI0, "sclk_spi0", "div_spi0_pre",
> >> >             GATE_SCLK_PERIL, 6, CLK_SET_RATE_PARENT, 0),
> >> > +   GATE(CLK_SCLK_UART3, "sclk_uart3", "div_uart3",
> >> > +           GATE_SCLK_PERIL, 3, CLK_SET_RATE_PARENT, 0),
> >> > +   GATE(CLK_SCLK_UART2, "sclk_uart2", "div_uart2",
> >> > +           GATE_SCLK_PERIL, 2, CLK_SET_RATE_PARENT, 0),
> >> >     GATE(CLK_SCLK_UART1, "sclk_uart1", "div_uart1",
> >> >             GATE_SCLK_PERIL, 1, CLK_SET_RATE_PARENT, 0),
> >> >     GATE(CLK_SCLK_UART0, "sclk_uart0", "div_uart0", @@ -679,6
> >> > +687,7
> >> @@
> >> > static struct samsung_gate_clock gate_clks[] __initdata = {
> >> >     GATE(CLK_USBOTG, "usbotg", "div_aclk_200", GATE_IP_FSYS, 13,
> 0,
> >> 0),
> >> >     GATE(CLK_USBHOST, "usbhost", "div_aclk_200", GATE_IP_FSYS, 12,
> >> 0, 0),
> >> >     GATE(CLK_SROMC, "sromc", "div_aclk_200", GATE_IP_FSYS, 11, 0,
> >> > 0),
> >> > +   GATE(CLK_SDMMC2, "sdmmc2", "div_aclk_200", GATE_IP_FSYS, 7,
> 0,
> >> 0),
> >> >     GATE(CLK_SDMMC1, "sdmmc1", "div_aclk_200", GATE_IP_FSYS, 6,
> 0,
> >> 0),
> >> >     GATE(CLK_SDMMC0, "sdmmc0", "div_aclk_200", GATE_IP_FSYS, 5,
> 0,
> >> 0),
> >> >     GATE(CLK_PDMA1, "pdma1", "div_aclk_200", GATE_IP_FSYS, 1, 0,
> >> > 0),
> >> @@
> >> > -698,6 +707,8 @@ static struct samsung_gate_clock gate_clks[]
> >> > __initdata
> > = {
> >> >     GATE(CLK_I2C2, "i2c2", "div_aclk_100", GATE_IP_PERIL, 8, 0, 0),
> >> >     GATE(CLK_I2C1, "i2c1", "div_aclk_100", GATE_IP_PERIL, 7, 0, 0),
> >> >     GATE(CLK_I2C0, "i2c0", "div_aclk_100", GATE_IP_PERIL, 6, 0, 0),
> >> > +   GATE(CLK_UART3, "uart3", "div_aclk_100", GATE_IP_PERIL, 3, 0,
> 0),
> >> > +   GATE(CLK_UART2, "uart2", "div_aclk_100", GATE_IP_PERIL, 2, 0,
> >> > + 0),
> >> >     GATE(CLK_UART1, "uart1", "div_aclk_100", GATE_IP_PERIL, 1, 0, 0),
> >> >     GATE(CLK_UART0, "uart0", "div_aclk_100", GATE_IP_PERIL, 0, 0,
> >> > 0), }; diff --git a/include/dt-bindings/clock/exynos3250.h
> >> > b/include/dt-bindings/clock/exynos3250.h
> >> > index b535e9d..ffeb695 100644
> >> > --- a/include/dt-bindings/clock/exynos3250.h
> >> > +++ b/include/dt-bindings/clock/exynos3250.h
> >> > @@ -78,6 +78,8 @@
> >> >  #define CLK_MOUT_CORE                      58
> >> >  #define CLK_MOUT_APLL                      59
> >> >  #define CLK_MOUT_ACLK_266_SUB              60
> >> > +#define CLK_MOUT_UART2                     61
> >> > +#define CLK_MOUT_UART3                     62
> >> >
> >> >  /* Dividers */
> >> >  #define CLK_DIV_GPL                        64
> >> > @@ -126,6 +128,8 @@
> >> >  #define CLK_DIV_CORE                       107
> >> >  #define CLK_DIV_HPM                        108
> >> >  #define CLK_DIV_COPY                       109
> >> > +#define CLK_DIV_UART2                      110
> >> > +#define CLK_DIV_UART3                      111
> >> >
> >> >  /* Gates */
> >> >  #define CLK_ASYNC_G3D                      128
> >> > @@ -222,6 +226,8 @@
> >> >  #define CLK_BLOCK_MFC                      219
> >> >  #define CLK_BLOCK_CAM                      220
> >> >  #define CLK_SMIES                  221
> >> > +#define CLK_UART2                  222
> >> > +#define CLK_UART3                  223
> >> >
> >> >  /* Special clocks */
> >> >  #define CLK_SCLK_JPEG                      224
> >> > @@ -248,11 +254,13 @@
> >> >  #define CLK_SCLK_SPI0                      245
> >> >  #define CLK_SCLK_UART1                     246
> >> >  #define CLK_SCLK_UART0                     247
> >> > +#define CLK_SCLK_UART2                     248
> >> > +#define CLK_SCLK_UART3                     249
> >> >
> >> >  /*
> >> >   * Total number of clocks of main CMU.
> >> >   * NOTE: Must be equal to last clock ID increased by one.
> >> >   */
> >> > -#define CLK_NR_CLKS                        248
> >> > +#define CLK_NR_CLKS                        250
> >> >
> >> >  #endif /*
> _DT_BINDINGS_CLOCK_SAMSUNG_EXYNOS3250_CLOCK_H
> >> */
> >> >
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
