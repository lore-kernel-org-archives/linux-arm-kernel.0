From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 10 Apr 2014 10:01:28 +0100
Subject: [PATCH 3/4] arm: add basic support for Mediatek MT6589 boards
In-Reply-To: <CAL_JsqJowqV2bsxE2VeYXQQSj4_L_KcH+C_dD=ZUvC=1crN4dA@mail.gmail.com>
 (Rob Herring's message of "Wed, 9 Apr 2014 22:50:33 +0100")
References: <1397072736-10793-1-git-send-email-matthias.bgg@gmail.com>
 <1397072736-10793-4-git-send-email-matthias.bgg@gmail.com>
 <CAL_JsqJowqV2bsxE2VeYXQQSj4_L_KcH+C_dD=ZUvC=1crN4dA@mail.gmail.com>
Message-ID: <87ha6136dz.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A couple of things on top of Rob's comments:

On Wed, Apr 09 2014 at 10:50:33 pm BST, Rob Herring <robherring2@gmail.com> wrote:
> On Wed, Apr 9, 2014 at 2:45 PM, Matthias Brugger <matthias.bgg@gmail.com> wrote:
>> This adds a generic devicetree board file and a dtsi for boards
>> based on the MT6589 SoCs from Mediatek.
>>
>> Apart from the generic parts (gic, clocks) the only component
>> currently supported are the timers.
>>
>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

[...]

>> diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
>> new file mode 100644
>> index 0000000..c0139ca
>> --- /dev/null
>> +++ b/arch/arm/mach-mediatek/Kconfig
>> @@ -0,0 +1,14 @@
>> +config ARCH_MEDIATEK
>> +       bool "Mediatek MT6589 SoC" if ARCH_MULTI_V7
>> +       select ARCH_REQUIRE_GPIOLIB
>
> Then where is your GPIO driver?
>
>> +       select ARM_GIC
>> +       select CACHE_L2X0
>> +       select HAVE_ARM_TWD if LOCAL_TIMERS

Hell no! ;-) ARM_ARCH_TIMER is the way (please also add the missing
node).

>> +       select HAVE_SMP
>
> Not needed now (going into 3.15).
>
>> +       select LOCAL_TIMERS if SMP

No, A7 always have the arch timers.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
