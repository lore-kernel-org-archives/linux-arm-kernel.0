From: eric@anholt.net (Eric Anholt)
Date: Fri, 09 Sep 2016 14:22:24 -0700
Subject: [PATCH 4/8] ARM: dts: bcm283x: Add a new EMMC pin group from the
 downstream tree.
In-Reply-To: <87650770.23554.026b1e4b-e35d-48e6-9394-7eeea0ff9add.open-xchange@email.1und1.de>
References: <1473244289-20728-1-git-send-email-kraxel@redhat.com>
 <1473244289-20728-5-git-send-email-kraxel@redhat.com>
 <87650770.23554.026b1e4b-e35d-48e6-9394-7eeea0ff9add.open-xchange@email.1und1.de>
Message-ID: <87zing7oq7.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

>> Gerd Hoffmann <kraxel@redhat.com> hat am 7. September 2016 um 12:31
>> geschrieben:
>> 
>> 
>> From: Eric Anholt <eric@anholt.net>
>> 
>> This will be used for having EMMC (sdhci-bcm2835.c) drive the
>> wireless.
>
> sdhci-bcm2835.c has been replaced by sdhci-iproc.c
>
>> 
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>>  arch/arm/boot/dts/bcm283x.dtsi | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
>> index 062d09db..b6b1950 100644
>> --- a/arch/arm/boot/dts/bcm283x.dtsi
>> +++ b/arch/arm/boot/dts/bcm283x.dtsi
>> @@ -257,6 +257,11 @@
>>  				brcm,pins = <32 33>;
>>  				brcm,function = <BCM2835_FSEL_ALT3>;
>>  			};
>> +			emmc_gpio34: emmc_gpio34 {
>> +				brcm,pins = <34 35 36 37 38 39>;
>> +				brcm,function = <BCM2835_FSEL_ALT3>;
>> +				brcm,pull = <0 2 2 2 2 2>;
>
> How about adding pull defines to include/dt-bindings/pinctrl/bcm2835.h?

A fine idea, but it should not be a requirement for this series.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160909/e05f5ac4/attachment.sig>
