From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 30 Sep 2015 14:22:39 +0100
Subject: [PATCH 09/14] ARM: dts: ifc6410: Add missing pinctrl to gsbi7 uart
In-Reply-To: <CAMAWPa_7U-PBwsngU+qc5SAt4HcCvPwUGvGY9nPUu+pZtPA7Uw@mail.gmail.com>
References: <1442579371-19822-1-git-send-email-srinivas.kandagatla@linaro.org>	<1442579507-20314-1-git-send-email-srinivas.kandagatla@linaro.org>
 <CAMAWPa_7U-PBwsngU+qc5SAt4HcCvPwUGvGY9nPUu+pZtPA7Uw@mail.gmail.com>
Message-ID: <560BE21F.8090901@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

Thanks for reporting this issue.

On 25/09/15 19:54, Kevin Hilman wrote:
> Hi Srini,
>
> On Fri, Sep 18, 2015 at 5:31 AM, Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>> This patch adds missing 2pin uart pinctrl property to gsbi7 uart on
>> IFC6410.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> kernelci.org found some new boot failures in -next on 8064[1].  I
> bisected it down to this patch, which landed in linux next in the form
> of commit d3a578ed4310 ARM: dts: ifc6410: Add missing pinctrl to gsbi7
> uart.
>
This issue is due to missing CONFIG_PINCTRL_APQ8064 Kconfig in 
multi_v7_defconfig.

In my tests I always enable this config which is why I could not spot 
this breakage.

This patch as it is the right thing to do however we need a fix to 
multi_v7_defconfig. I will send a patch for multi_v7_defconfig to 
address this and add few more missing configs too.


thanks,
--srini
> Kevin
>
> [1] http://kernelci.org/boot/qcom-apq8064-ifc6410/job/next/kernel/next-20150925/defconfig/multi_v7_defconfig/lab/lab-khilman/?_id=5605083c59b51466d26c3250
>
