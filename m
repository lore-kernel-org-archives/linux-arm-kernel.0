From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 08 Mar 2015 12:27:53 +0100
Subject: [linux-sunxi] [PATCH 7/7] ARM: dts: sun7i: Enable cap-sdio-irq
 for bananapro sdio wifi
In-Reply-To: <CAGb2v65tcCrg3njNN0owLrM-MUepRBwjxpU46dpXkLhy9mceEA@mail.gmail.com>
References: <1425754884-7875-1-git-send-email-hdegoede@redhat.com>
 <1425754884-7875-7-git-send-email-hdegoede@redhat.com>
 <CAGb2v65tcCrg3njNN0owLrM-MUepRBwjxpU46dpXkLhy9mceEA@mail.gmail.com>
Message-ID: <54FC3239.5030200@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08-03-15 03:42, Chen-Yu Tsai wrote:
> On Sun, Mar 8, 2015 at 3:01 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> The sdio wifi on the Banana Pro does not appear to have an oob irq hooked
>> up, so enable sdio-irq support to avoid unnecessary polling.
>
> I wonder if this is stable enough to put back into the mmc driver, i.e.
> declare the capability in the driver itself? IIRC at one point it did.

That is a good question, I believe strongly that the sdio wifi issues we've
been seeing which were the reason to disable cap-sdio-irq in the driver are
actually unrelated to the irq delivery mechanism. So IMHO yes we can just enable
this for all devices in the driver, and yes that would be a better solution.

Maxime, if I send a patch to enable cal-sdio-irq at the driver level ( as it
really is a hardware feature not a board feature), will you ack it ?

If the answer is yet, then please do NOT apply this patch and I'll send
a sunxi-mmc.c patch instead.

Regards,

Hans



>
> ChenYu
>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   arch/arm/boot/dts/sun7i-a20-bananapro.dts | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/sun7i-a20-bananapro.dts b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
>> index fb89fe7..d0cd78f 100644
>> --- a/arch/arm/boot/dts/sun7i-a20-bananapro.dts
>> +++ b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
>> @@ -164,6 +164,7 @@
>>          vmmc-supply = <&reg_vmmc3>;
>>          bus-width = <4>;
>>          non-removable;
>> +       cap-sdio-irq;
>>          status = "okay";
>>   };
>>
>> --
>> 2.3.1
>
