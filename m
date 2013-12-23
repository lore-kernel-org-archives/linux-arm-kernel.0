From: r.sh.open@gmail.com (Rahul Sharma)
Date: Mon, 23 Dec 2013 10:03:28 +0530
Subject: [PATCH 2/3] ARM: dts: replace clock numbers with macros for
 exynos5420
In-Reply-To: <2478495.7T968MEiJL@flatron>
References: <1387544246-31658-1-git-send-email-rahul.sharma@samsung.com>
 <1387544246-31658-3-git-send-email-rahul.sharma@samsung.com>
 <2478495.7T968MEiJL@flatron>
Message-ID: <CAPdUM4PMY=43PO75NZS6hjcvLnfjwg4bqnEN3+f+DtstQOQQGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz,

On 21 December 2013 03:32, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Rahul,
>
> On Friday 20 of December 2013 18:27:25 Rahul Sharma wrote:
>> DT nodes contain clock numbers which are referred by drivers
>> to get the clocks. These numbers are replaced by MACROs
>> which are defined in the exynos5420-clk.h header file.
>
> This is a good idea, but we already have such conversion scheduled for
> all the existing clock drivers in an automated way. Andrzej Hajda (on CC)
> has a script that automatically converts DTS files and clock drivers from
> enums to defines.
>
> Also such change needs to be done in a timely manner, due to greatly
> increasing chance of conflicting other patches.
>
> My suggestion is to drop this and patch 3/3 from this series and let us
> handle this using Andrzej's script at appropriate point of time.

Looks fine to me. I will drop them. But we have a requirement to keep 5420
up to date in mainline tree. I am hoping you will do it soon for all SoCs. In
case its delaying too much, I will request you to consider these again :).

Regards,
Rahul Sharma.

>
>>
>> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos5420.dtsi |   47 +++++++++++++++++++------------------
>>  1 file changed, 24 insertions(+), 23 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
>> index e552608..db8b2da 100644
>> --- a/arch/arm/boot/dts/exynos5420.dtsi
>> +++ b/arch/arm/boot/dts/exynos5420.dtsi
>> @@ -17,6 +17,7 @@
>>  #include "exynos5420-pinctrl.dtsi"
>>
>>  #include <dt-bindings/clk/exynos-audss-clk.h>
>> +#include <dt-bindings/clk/exynos5420-clk.h>
>
> By the way, this header is added in patch 3/3, so this patch breaks
> bisectability, which is not acceptable.
>
> Best regards,
> Tomasz
>
