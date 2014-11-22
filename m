From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sat, 22 Nov 2014 10:20:43 +0100
Subject: [PATCH v4 6/7] ARM: mvebu: add PHY support to the dts for the
 USB controllers on Armada 375
In-Reply-To: <20141122020811.GO22670@titan.lakedaemon.net>
References: <1415879269-29711-1-git-send-email-gregory.clement@free-electrons.com>
 <1415879269-29711-7-git-send-email-gregory.clement@free-electrons.com>
 <20141122020811.GO22670@titan.lakedaemon.net>
Message-ID: <5470556B.6080608@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On 22/11/2014 03:08, Jason Cooper wrote:
> On Thu, Nov 13, 2014 at 12:47:48PM +0100, Gregory CLEMENT wrote:
>> Now that the USB cluster node has been added, use it as a PHY provider
>> for the USB controller linked to it: the first EHCI and the xHCI.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  arch/arm/boot/dts/armada-375.dtsi | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
>> index 8f45cf5d2a50..f344ec420c95 100644
>> --- a/arch/arm/boot/dts/armada-375.dtsi
>> +++ b/arch/arm/boot/dts/armada-375.dtsi
>> @@ -14,6 +14,7 @@
>>  #include "skeleton.dtsi"
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>  #include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/phy/phy.h>
> 
> Odd.  The previous patch in this series simply adds a line to phy.h,
> however, I get the following error during 'make dtbs':
> 
> ########
>   DTC     arch/arm/boot/dts/armada-375-db.dtb
> In file included from arch/arm/boot/dts/armada-375-db.dts:17:0:arch/arm/boot/dts/armada-375.dtsi:17:33:
> fatal error: dt-bindings/phy/phy.h: No such file or directory
>  #include <dt-bindings/phy/phy.h>
>                                  ^
> compilation terminated.
> scripts/Makefile.lib:282: recipe for target 'arch/arm/boot/dts/armada-37 5-db.dtb' failed
> ########
> 
> mvebu/dt is based on v3.18-rc1.  Is there a missing dependency
> somewhere?  Perhaps we should let Kishon take the whole series and
> handle the (hopefully trivial) merge conflict?

Actually Kishon asked me to use the dt-bindings/phy/phy.h file which
was introduced by the patch "phy: Add PHY header file for DT x Driver
defines". So indeed I had to have a dependency on the phy_dt_header
branch (which is based on v3.18-rc4 and have only this single commit).
The git tree is located at
git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git


Maybe we could add this branch in mvebu as a dependency as it is done
on arm-soc. I suggest this because I would prefer that we continue to
be the only ones to merge the device tree files in order to reduce the
merge conflict.

Thanks,

Gregory



> 
> thx,
> 
> Jason.
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
