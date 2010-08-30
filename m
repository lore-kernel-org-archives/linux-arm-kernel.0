From: schen@mvista.com (Steve Chen)
Date: Mon, 30 Aug 2010 08:27:32 -0500
Subject: mmc over SPI on DM6467 based board. card not detected.
In-Reply-To: <BLU124-W40A2B008B886302781867B4870@phx.gbl>
References: <4C516634.5040804@criticallink.com>
	<877hjd106u.fsf@deeprootsystems.com>
	<4C7702EB.8040905@criticallink.com>
	<8762ywrvpt.fsf@deeprootsystems.com>
	<4C77E6BD.4000303@criticallink.com>
	<87fwy0orsg.fsf@deeprootsystems.com>
	<BLU124-W40A2B008B886302781867B4870@phx.gbl>
Message-ID: <AANLkTinZEWUqhV_yVh78hYNA82JbJ8OKYP_UJ2fRD6BA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 28, 2010 at 8:26 AM, Sumesh Kaana <sumeshkkn@hotmail.com> wrote:
> Hi all,
>
>
>
> I am trying to mount SD-Card over SPI on our custom DM6467 board. davinci
> spi controller driver and mmc over spi drver are selected in the menuconfig.
> i am using davinci-PSP.03-XX-00-37 kernel.
>
> I have also edited board initialization file to probe the MMC card under SPI
> as below:
>
>
>
> static struct spi_board_info dm646x_spi_info[] __initconst = {
>
> #ifdef CONFIG_MMC_SPI
>
> ??????? {
>
> ??????????????? .modalias = "mmc_spi",
>
> ??????????????? .max_speed_hz = (750 * 1000 ),???? /* max spi clock (SCK)
> speed in HZ */
>
> ??????????????? .bus_num = 0,
>
> ??????????????? .chip_select = 0,?????????????????????? /* CS0 */
>
> ??????????????? .mode?????????? = SPI_MODE_0,
>
> ??????? },
>
> #endif
>
>
>
> The kernel boots with following log
>
...
> mmc0: Minimum clock frequency too high for identification mode
...

Have you tried lower the clock frequency?

Steve
