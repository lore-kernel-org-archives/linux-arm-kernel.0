From: tyler.baker@linaro.org (Tyler Baker)
Date: Fri, 5 Dec 2014 08:49:41 -0800
Subject: [PATCH] ARM: multi_v7_defconfig: enable MAX77686 PMIC drivers for
 exynos4412-prime based SoCs
In-Reply-To: <20141205071717.GA29274@quad.lixom.net>
References: <1417728264-7268-1-git-send-email-tyler.baker@linaro.org>
 <20141205071717.GA29274@quad.lixom.net>
Message-ID: <CANMBJr54f3_DfK2pJBsx=LR8ZmM36yDCterpn5XxYSU-FYKPPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 December 2014 at 23:17, Olof Johansson <olof@lixom.net> wrote:
> On Thu, Dec 04, 2014 at 01:24:24PM -0800, Tyler Baker wrote:
>> This patch enables the MAX77686 PMIC drivers in the multi_v7_defconfig used
>> on exynos4412-prime family of SoCs [1]. The exynos4412-prime based boards
>> are producing the following runtime errors only on the multi_v7_defconfig [2]:
>>
>> kern.err: deviceless supply vdd_arm not found, using dummy regulator
>> kern.err: exynos-cpufreq exynos-cpufreq: failed to set cpu voltage to 1287500
>> kern.err: cpufreq: __target_index: Failed to change cpu frequency: -22
>>
>> I reviewed the exynos_defconfig, which does not produce these runtime
>> errors. It was obvious that the exynos_defconfig has the PMIC drivers
>> enabled, whereas the multi_v7_defconfig does not. This patch has been tested
>> on a odroid-u2 and a odroid-u3 board. It has resolved the runtime errors.
>> Therefore, I purpose we enabled these drivers in the multi_v7_defconfig.
>>
>> [1] http://www.hardkernel.com/main/products/prdt_info.php?g_code=G135270682824
>> [2] http://storage.armcloud.us/kernel-ci/mainline/v3.18-rc7-48-g7cc78f8/arm-multi_v7_defconfig/lab-tbaker-00/boot-exynos4412-odroidu3.html
>>
>
> FWIW, the 5250-based Samsung Chromebook also uses 77686.

After you pointed this out, I took a look at your boot logs for snow
[1] and indeed it does show the same runtime errors described in this
patch.

>
> Applied to next/defconfig for 3.19 after fixing up some fuzz.

Thanks!

>
>
> -Olof

Tyler

[1] http://arm-soc.lixom.net/bootlogs/arm-soc/v3.18-rc7-1140-g9c6e242/snow-arm-multi_v7_defconfig.html
