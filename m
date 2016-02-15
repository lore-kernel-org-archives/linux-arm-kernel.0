From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 15 Feb 2016 15:36:18 +0900
Subject: [next] Odroid XU3 easily over-heats
In-Reply-To: <20160215052843.GA6334@vireshk-i7>
References: <56C01963.3080106@gmail.com> <20160215052843.GA6334@vireshk-i7>
Message-ID: <56C171E2.90306@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.02.2016 14:28, Viresh Kumar wrote:
> On 14-02-16, 15:06, Krzysztof Kozlowski wrote:
>> Hi all,
>>
>> With recent addition of cpufreq-dt support to Exynos5422
>> it is very easy to over-heat the Odroid XU3 leading to critical shutdown:
> 
> How were OPPs passed earlier? I failed to see them in kernel somehow.
> You must have been using opp-v1 earlier, right?

Till now there was no support for cpufreq for Exynos542x. For some time
Bartlomiej was developing these patches - using opp-v1 at beginning. I
don't know whether he encountered this before.

> 
> You used boost-freqs then? You used cpufreq as a cooling device then?
> 
>> What about cpufreq as cooling device? Probably that part
>> is missing now, right?
> 
> Maybe, how was that earlier though ?

Bootloader initialized frequency and regulators to some safe defaults. I
think the voltage set by uboot is 1 V (for big and little) which
corresponds to ~800 MHz of frequency (I don't know the exact frequency
because it is hardcoded as divider value...).

However there was no cooling device except fan. This did not change. So
the only difference seems to be that now at critical shutdown moment it
operates at 1300 MHz / 1.275 V (little) and 1800 MHz / 1.250 V (big).

Best regards,
Krzysztof
