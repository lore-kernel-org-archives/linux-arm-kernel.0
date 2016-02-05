From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 05 Feb 2016 17:03:23 +0100
Subject: [PATCH v2 08/12] devicetree: bindings: add DT binding for the
 Marvell Armada 3700 SoC family
In-Reply-To: <20160203213825.4fa6a0ef@free-electrons.com> (Thomas Petazzoni's
 message of "Wed, 3 Feb 2016 21:38:25 +0100")
References: <1454524889-9207-1-git-send-email-gregory.clement@free-electrons.com>
 <1454524889-9207-9-git-send-email-gregory.clement@free-electrons.com>
 <20160203213825.4fa6a0ef@free-electrons.com>
Message-ID: <87r3gr2lh0.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On mer., f?vr. 03 2016, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> Hello,
>
> On Wed,  3 Feb 2016 19:41:25 +0100, Gregory CLEMENT wrote:
>> The Marvell Armada 3700 is a family of ARMv8 CA53 SoCs. This commit
>> introduces the Device Tree binding that documents the top-level
>> compatible strings for Armada 3700 based platforms.
>> 
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  .../devicetree/bindings/arm/marvell/armada-37xx.txt      | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
>> 
>> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
>> new file mode 100644
>> index 000000000000..17e90e8b5f76
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
>> @@ -0,0 +1,16 @@
>> +Marvell Armada 37xx Platforms Device Tree Bindings
>> +--------------------------------------------------
>> +
>> +Boards using a SoC of the Marvell Armada 37xx family must carry the
>> +following root node property:
>> +
>> + - compatible: must contain "marvell,armada3710"
>
> Are we sure at this point that the 3720 is a strict super-set of the
> 3710 ?

I think we are in the same situation with the Armada 380 with the other
Armada 38x. At this point the 3720 is a super-set of the 3710.

>
> If that's not the case, then it would be somewhat weird for a platform
> using the 3720 platform to carry the marvell,armada3710 compatible
> string, no?

Actually, we only said that the 3720 is compatible with the 3710 not
really a strict super-set. More over, for a 3720 we must use
marvell,armada3720 _and_ marvell,armada3710, and in case of conflict
marvell,armada3720 must be used.

I really prefer using marvell,armada3710 as common compatible for all
the Armada 3700 SoCs, that having no common compatible at all.

Thanks,

Gregory

>
> Thomas
> -- 
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
