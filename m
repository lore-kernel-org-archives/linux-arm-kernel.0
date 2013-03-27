From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 27 Mar 2013 10:13:17 +0100
Subject: IMX: board hardware macro
In-Reply-To: <20130327063306.GC2767@r65073-Latitude-E6420>
References: <515221BE.8050808@linaro.org>
 <20130327063306.GC2767@r65073-Latitude-E6420>
Message-ID: <5152B82D.8080505@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27/2013 07:33 AM, Shawn Guo wrote:
> On Tue, Mar 26, 2013 at 11:31:26PM +0100, Daniel Lezcano wrote:
>> HI all,
>>
>> is there a macro to tell if the board is iMX51 and iMX6Q ?
>>
>> I would like to do the same as:
>>
>> static int __init tegra_cpuidle_init(void)
>> {
>> int ret;
>>
>> switch (tegra_chip_id) {
>> case TEGRA20:
>> ret = tegra20_cpuidle_init();
>> break;
>> case TEGRA30:
>> ret = tegra30_cpuidle_init();
>> break;
>> case TEGRA114:
>> ret = tegra114_cpuidle_init();
>> break;
>> default:
>> ret = -ENODEV;
>> break;
>> }
>>
>> return ret;
>> }
>> device_initcall(tegra_cpuidle_init);
> 
> The global initcall is something that we are removing for multiplatform
> build.  Please do not add it back.

Ok, sure. I won't add it back.

Do these macros exist ?

Thanks
  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
