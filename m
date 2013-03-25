From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 25 Mar 2013 17:27:51 +0100
Subject: [PATCH 08/10] ARM: sunxi: dt: Update interrupt controller
 compatible string
In-Reply-To: <51505825.2060805@gmail.com>
References: <1364218233-29636-1-git-send-email-maxime.ripard@free-electrons.com>
 <1364218233-29636-9-git-send-email-maxime.ripard@free-electrons.com>
 <51505825.2060805@gmail.com>
Message-ID: <51507B07.4050204@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Le 25/03/2013 14:59, Rob Herring a ?crit :
> On 03/25/2013 08:30 AM, Maxime Ripard wrote:
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ---
>>  arch/arm/boot/dts/sun4i-a10.dtsi |    2 +-
>>  arch/arm/boot/dts/sun5i-a13.dtsi |    2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
>> index be71782..805d704 100644
>> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
>> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
>> @@ -121,7 +121,7 @@
>>  		ranges;
>>  
>>  		intc: interrupt-controller at 01c20400 {
>> -			compatible = "allwinner,sunxi-ic";
>> +			compatible = "allwinner,sun4i-ic";
> 
> Generally speaking, this is a bad thing to do. This breaks compatibility
> between dtb and kernel versions. If that breakage is not yet a concern
> for sunxi, then it is okay.

Yes, I know, but I thought it was okay since sunxi has never been in an
usable state, and it seemed odd to me to begin to maintain an history
for a platform that has never actually been booted by a user.

On the other end, if someone speaks up, I'd be happy to keep the old
compatible around as well.

> Also, I don't see any documentation updates for any of these changes.

Ah, yes, my bad.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
