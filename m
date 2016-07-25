From: mirza.krak@gmail.com (Mirza Krak)
Date: Mon, 25 Jul 2016 14:28:48 +0200
Subject: [RFC 1/6] clk: tegra: add TEGRA20_CLK_NOR to init table
In-Reply-To: <20160725111735.GC21170@ulmo.ba.sec>
References: <1468935397-11926-1-git-send-email-mirza.krak@gmail.com>
 <1468935397-11926-2-git-send-email-mirza.krak@gmail.com>
 <20160725111735.GC21170@ulmo.ba.sec>
Message-ID: <CALw8SCUPn2xzToHbPC2FPr7rVutcFOq7dwhqREmxoG=L4gT5ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-07-25 13:17 GMT+02:00 Thierry Reding <thierry.reding@gmail.com>:
> On Tue, Jul 19, 2016 at 03:36:32PM +0200, Mirza Krak wrote:
>> From: Mirza Krak <mirza.krak@gmail.com>
>>
>> Add TEGRA20_CLK_NOR to init tabel and set a "sane" default rate.
>>
>> Signed-off-by: Mirza Krak <mirza.krak@gmail.com>
>> ---
>>  drivers/clk/tegra/clk-tegra20.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
>> index 837e5cb..aefc044 100644
>> --- a/drivers/clk/tegra/clk-tegra20.c
>> +++ b/drivers/clk/tegra/clk-tegra20.c
>> @@ -1047,6 +1047,7 @@ static struct tegra_clk_init_table init_table[] __initdata = {
>>       { TEGRA20_CLK_SDMMC3, TEGRA20_CLK_PLL_P, 48000000, 0 },
>>       { TEGRA20_CLK_SDMMC4, TEGRA20_CLK_PLL_P, 48000000, 0 },
>>       { TEGRA20_CLK_SPI, TEGRA20_CLK_PLL_P, 20000000, 0 },
>> +     { TEGRA20_CLK_NOR, TEGRA20_CLK_PLL_P, 86500000, 0 },
>
> Yay for inconsistent naming in the hardware. It would've been nice if
> this clock was called GMI. Oh well...

I am allowed to change clk name? Can do that when I re-spin this series.

>
> Could you perhaps explain in the commit message why 86.5 MHz is a sane
> default? I'm totally unfamiliar with this controller, so maybe it's
> self-explanatory, but it seems a rather odd value for a clock frequency.

I used a value that I have in a downstream kernel based on the L4T.
This frequency is well tested and has worked for me, and wanted to
avoid setting it to maximum rate. My guess is that they used 86.5 MHz
because 92 MHz is max rate on Tegra2 and they put it slightly below
that.

What is otherwise recommended when initializing clocks? The rate could
depend on the chip that is attached but otherwise I would like to set
it close to max (or max) rate for performance.

Best Regards,
Mirza
