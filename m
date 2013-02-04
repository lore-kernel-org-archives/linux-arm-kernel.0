From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Mon, 04 Feb 2013 11:36:57 +0100
Subject: [PATCH 1/2] ARM: dts: OMAP3: Add GPMC controller
In-Reply-To: <CABxcv=k_gwB3ExQYUeappDZ6FE4L7x8Acer4ZQpDH09BL6LG0Q@mail.gmail.com>
References: <1359395648-2137-1-git-send-email-florian.vaussard@epfl.ch>
 <1359395648-2137-2-git-send-email-florian.vaussard@epfl.ch>
 <CABxcv=k_gwB3ExQYUeappDZ6FE4L7x8Acer4ZQpDH09BL6LG0Q@mail.gmail.com>
Message-ID: <510F8F49.9020800@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On 02/04/2013 10:27 AM, Javier Martinez Canillas wrote:
> Hi Florian,
>
> On Mon, Jan 28, 2013 at 6:54 PM, Florian Vaussard
> <florian.vaussard@epfl.ch> wrote:
>> Add device-tree support for the GPMC controller on the OMAP3.
>>
>> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
>> ---
>>   arch/arm/boot/dts/omap3.dtsi |   11 +++++++++++
>>   1 files changed, 11 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
>> index 6c63118..2ddae38 100644
>> --- a/arch/arm/boot/dts/omap3.dtsi
>> +++ b/arch/arm/boot/dts/omap3.dtsi
>> @@ -403,5 +403,16 @@
>>                          ti,timer-alwon;
>>                          ti,timer-secure;
>>                  };
>> +
>> +               gpmc: gpmc at 6e000000 {
>> +                       compatible = "ti,omap3430-gpmc";
>> +                       ti,hwmods = "gpmc";
>> +                       reg = <0x6e000000 0x1000000>;
>> +                       interrupts = <20>;
>> +                       gpmc,num-cs = <8>;
>> +                       gpmc,num-waitpins = <4>;
>> +                       #address-cells = <2>;
>> +                       #size-cells = <1>;
>> +               };
>>          };
>>   };
>
> I had the same patch on a tree I was working on to add DT support for
> gpmc-smsc911x on an OMAP3 board but I was waiting for Daniel's patches
> to hit mainline before sending the RFC. So please feel free to add:
>
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>

Great, the smsc911x was on my TODO list, I can cross it out :) BTW,
do you have a public git for this, so I can test your work on my setup?

For the GPMC support, I will have to make a few more more as discussed with
Tony, and as I will be away for more than 2 weeks, feel free to go ahead
before me. This patchset was only at an RFC stage.

Regards,

Florian
