From: megous@megous.com (=?UTF-8?Q?Ond=c5=99ej_Jirman?=)
Date: Fri, 22 Jul 2016 02:41:59 +0200
Subject: [linux-sunxi] [PATCH v2 14/14] ARM: dts: sun8i: Enable DVFS on
 Orange Pi One
In-Reply-To: <CAOMqctTe==M1SXxbdR8y33yh51fiFGn+oSaKJXhbnpLVTn-New@mail.gmail.com>
References: <20160625034511.7966-1-megous@megous.com>
 <20160625034511.7966-15-megous@megous.com>
 <CAOMqctTe==M1SXxbdR8y33yh51fiFGn+oSaKJXhbnpLVTn-New@mail.gmail.com>
Message-ID: <3d218e35-c848-53b3-e65f-df4b70c1e1f8@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Michal,

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

I've identified the problem as incorrectly set up gpio-regulator. During
boot, when it was probed, it would be initiualized with 1.1V for a
moment. This caused random non-specific lockups/crashes afterwards.

Fixed patches are in my branch on github, if you want to try again.

  https://github.com/megous/linux/commits/orange-pi-4.7

regards,
  o.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160722/bcc89923/attachment.sig>
