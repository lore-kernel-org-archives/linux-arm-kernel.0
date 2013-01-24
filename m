From: florian@openwrt.org (Florian Fainelli)
Date: Thu, 24 Jan 2013 14:43:15 +0100
Subject: [RFC PATCH 3/6] ARM: kirkwood: nsa310: cleanup includes and
 unneeded code
In-Reply-To: <20130124055052.GA21297@lunn.ch>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <28ae8033afa32ea4ea298ba63e1d5b2a1f4e18f9.1358983578.git.jason@lakedaemon.net>
 <20130124055052.GA21297@lunn.ch>
Message-ID: <51013A73.4090400@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/24/2013 06:50 AM, Andrew Lunn wrote:
> On Wed, Jan 23, 2013 at 11:34:21PM +0000, Jason Cooper wrote:
>> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
>> ---
>>   arch/arm/mach-kirkwood/board-nsa310.c | 9 +--------
>>   1 file changed, 1 insertion(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/mach-kirkwood/board-nsa310.c b/arch/arm/mach-kirkwood/board-nsa310.c
>> index 1bd328d..0b99533 100644
>> --- a/arch/arm/mach-kirkwood/board-nsa310.c
>> +++ b/arch/arm/mach-kirkwood/board-nsa310.c
>> @@ -10,11 +10,8 @@
>>
>>   #include <linux/kernel.h>
>>   #include <linux/init.h>
>> -#include <linux/i2c.h>
>> -
>> -#include <asm/mach-types.h>
>> -#include <asm/mach/arch.h>
>>   #include <mach/kirkwood.h>
>> +#include <linux/of.h>
>>   #include "common.h"
>>   #include "mpp.h"
>>
>> @@ -40,11 +37,7 @@ static unsigned int nsa310_mpp_config[] __initdata = {
>>
>>   void __init nsa310_init(void)
>>   {
>> -	u32 dev, rev;
>> -
>>   	kirkwood_mpp_conf(nsa310_mpp_config);
>> -
>> -	kirkwood_pcie_id(&dev, &rev);
>>   }
>>
>>   static int __init nsa310_pci_init(void)
>> --
>> 1.8.1.1
>>
>
> Hi Jason, Tero
>
> This board is rather unusual for a Kirkwood. It has no Ethernet
> interfaces. Is this correct?

It seems like it really has an Gigabit Ethernet interface:
http://www.clubic.com/disque-dur-memoire/nas/article-465814-1-zyxel-nsa-310.html

(in french, but the pictures show a Gigabit Ethernet).
--
Florian
