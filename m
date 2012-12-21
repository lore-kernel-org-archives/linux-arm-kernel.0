From: martinez.javier@gmail.com (Javier Martinez Canillas)
Date: Fri, 21 Dec 2012 19:10:27 +0100
Subject: [PATCH] arm: omap3: igep0020: Add console default kernel arguments
In-Reply-To: <CAFqH_50ELkdXhVwW8atG0VsXU85S3pZqCVf9cytQRGk5SocFXw@mail.gmail.com>
References: <1356018118-29852-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <CAFqH_50ELkdXhVwW8atG0VsXU85S3pZqCVf9cytQRGk5SocFXw@mail.gmail.com>
Message-ID: <CAAwP0s1snYU7FR-BVM=GLg0oopT6NkBVLOysffia0dadsxW+BQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

Thanks for the patch

On Fri, Dec 21, 2012 at 5:02 PM, Enric Balletbo Serra
<eballetbo@gmail.com> wrote:
> Hi Ezequiel,
>
> Thanks  for the patch.
>
> 2012/12/20 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>:
>> IGEP v2 boards has console as ttyO2,115200n8.
>> It's better so simply set this as the default kernel argument
>> directly in the device tree board file.
>>
>> Cc: Enric Balletbo i Serra <eballetbo@gmail.com>
>> Cc: Javier Martinez Canillas <javier@dowhile0.org>
>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>> ---
>>  arch/arm/boot/dts/omap3-igep0020.dts |    4 ++++
>>  1 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
>> index e2b9849..45ffe21 100644
>> --- a/arch/arm/boot/dts/omap3-igep0020.dts
>> +++ b/arch/arm/boot/dts/omap3-igep0020.dts
>> @@ -15,6 +15,10 @@
>>         model = "IGEPv2";
>>         compatible = "isee,omap3-igep0020", "ti,omap3";
>>
>> +       chosen {
>> +               bootargs = "console=ttyO2,115200n8 earlyprintk";
>> +       };
>> +
>
> The u-boot 'bootargs' env overwrites the one from chosen ?
>

I just tested and U-Boot 'bootargs' has precedence over DT bootargs
but I didn't find a way to append boot parameters from U-Boot. You can
either overwrite it completely or not.

That been said I think that is a good idea to have some default
bootargs on the DT but since you can't append any boot option from
U-Boot I would also add root=/dev/mmcblk0p2 rw rootwait so at least it
will be able to mount the rootfs from the uSD/MMC.

Also, many IGEP COM Module base boards also have serial consoles that
are connected to the OMAP3 UART3 (ttyO2), so maybe is better to add
this to omap3-igep.dtsi instead of omap3-igep0020.dts to avoid future
duplication.

Best regards,
Javier
