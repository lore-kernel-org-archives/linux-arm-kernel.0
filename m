From: megous@megous.com (=?UTF-8?Q?Ond=c5=99ej_Jirman?=)
Date: Thu, 30 Jun 2016 16:19:34 +0200
Subject: [linux-sunxi] [PATCH v2 14/14] ARM: dts: sun8i: Enable DVFS on
 Orange Pi One
In-Reply-To: <CAOMqctTe==M1SXxbdR8y33yh51fiFGn+oSaKJXhbnpLVTn-New@mail.gmail.com>
References: <20160625034511.7966-1-megous@megous.com>
 <20160625034511.7966-15-megous@megous.com>
 <CAOMqctTe==M1SXxbdR8y33yh51fiFGn+oSaKJXhbnpLVTn-New@mail.gmail.com>
Message-ID: <834b8045-d99f-74a3-0353-aa84b897351d@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 30.6.2016 13:13, Michal Suchanek wrote:
> Hello,
> 
> On 25 June 2016 at 05:45,  <megous@megous.com> wrote:
>> From: Ondrej Jirman <megous@megous.com>
>>
>> Use Xulong Orange Pi One GPIO based regulator for
>> passive cooling and thermal management.
>>
>> Signed-off-by: Ondrej Jirman <megous@megous.com>
>> ---
>>  arch/arm/boot/dts/sun8i-h3-orangepi-one.dts | 39 +++++++++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
>> index b1bd6b0..a38d871 100644
>> --- a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
>> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
>> @@ -109,6 +109,45 @@
>>         };
>>  };
>>
>> +&cpu0 {
>> +       operating-points = <
>> +               /* kHz    uV */
>> +               1296000 1300000
>> +               1200000 1300000
> 
> First problem is that the board boots at 1008000 which is not listed
> and the kernel complains.
> 
> Second problem is that the board locks up during boot with this enabled.
> 
> Do you have some suggestion for alternate configuration to test?

Just to verify, did you test with the entire series applied? (especially
the PLL1 clk application changes)

You may try dropping the highest operating point, it's probably overly
optimistic for Orange Pi One.

Is the power supply/cable you're using hard enough?

Where during the boot process does it lock up?

regards,
  Ondrej

> Thanks
> 
> Michal
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160630/cf58b266/attachment-0001.sig>
