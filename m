From: mw@semihalf.com (Marcin Wojtas)
Date: Sun, 22 Nov 2015 22:04:38 +0100
Subject: [PATCH 02/13] net: mvneta: enable IP checksum with jumbo frames
 for Armada 38x on Port0
In-Reply-To: <4040597.3hXVb3XDMS@wuerfel>
References: <1448178839-3541-1-git-send-email-mw@semihalf.com>
 <1448178839-3541-3-git-send-email-mw@semihalf.com>
 <4040597.3hXVb3XDMS@wuerfel>
Message-ID: <CAPv3WKdOVf4kXHfrawgybggHggAEJ9wJh=8gyp_mEhWp2i=YFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

2015-11-22 21:00 GMT+01:00 Arnd Bergmann <arnd@arndb.de>:
> On Sunday 22 November 2015 08:53:48 Marcin Wojtas wrote:
>> The Ethernet controller found in the Armada 38x SoC's family support
>> TCP/IP checksumming with frame sizes larger than 1600 bytes, however
>> only on port 0.
>>
>> This commit enables this feature by using 'marvell,armada-xp-neta' in
>> 'ethernet at 70000' node.
>>
>> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
>> Cc: <stable@vger.kernel.org> # v3.18+
>> ---
>>  arch/arm/boot/dts/armada-38x.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
>> index c6a0e9d..b7868b2 100644
>> --- a/arch/arm/boot/dts/armada-38x.dtsi
>> +++ b/arch/arm/boot/dts/armada-38x.dtsi
>> @@ -494,7 +494,7 @@
>>                         };
>>
>>                         eth0: ethernet at 70000 {
>> -                               compatible = "marvell,armada-370-neta";
>> +                               compatible = "marvell,armada-xp-neta";
>>                                 reg = <0x70000 0x4000>;
>>                                 interrupts-extended = <&mpic 8>;
>>                                 clocks = <&gateclk 4>;
>>
>
> As it's clear that they are not 100% backwards compatible, please
> add a SoC specific compatible string here as well, like
>
>         compatible = "marvell,armada-380-neta", "marvell,armada-xp-neta";
>

Wouldn't be one sufficient ("marvell,armada-380-neta")?

> Maybe also leave the 370 string in place.
>

Now 370 string disables ip checksum for jumbo frames, so I don't think
it's appropriate to keep it for port 0.

Best regards,
Marcin
