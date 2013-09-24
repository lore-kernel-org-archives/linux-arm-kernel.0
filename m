From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 24 Sep 2013 11:47:45 +0200
Subject: [PATCH V2 1/6] clk: exynos-audss: convert to platform device
In-Reply-To: <3549301.xmRx49e0Zc@amdc1227>
References: <1379711637-5226-1-git-send-email-abrestic@chromium.org>
 <1379982078-23381-1-git-send-email-abrestic@chromium.org>
 <3549301.xmRx49e0Zc@amdc1227>
Message-ID: <52415FC1.4070400@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/09/13 11:20, Tomasz Figa wrote:
>> +static int exynos_audss_clk_remove(struct platform_device *pdev)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < EXYNOS_AUDSS_MAX_CLKS; i++) {
>> +		if (clk_table[i])
> 
> I believe clk_register_* functions return ERR_PTR() in case of failure,
> not NULL, so this should be accounted for either here or at probe time.
> Possibly checking for registration error in probe() would be the best
> solution, although bloating the code a bit (but what error path isn't?).

After registering all clocks a loop iterating over all entries of the
clk_table[] array could be added and if any of the entries is ERR_PTR()
either an error could be just logged or the successfully registered
clocks could be freed and probe() could fail. It doesn't really seems
much additional code.

--
Thanks,
Sylwester
