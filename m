From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 23 May 2016 14:52:20 +0200
Subject: [PATCH v2 11/23] ARM: dts: armadillo800eva: Fix W=1 dtc warnings
In-Reply-To: <e0a1fbc1-ac95-2c79-65ed-d0328679bb8a@cogentembedded.com>
References: <1463728214-13838-1-git-send-email-geert+renesas@glider.be>
 <1463728214-13838-12-git-send-email-geert+renesas@glider.be>
 <e0a1fbc1-ac95-2c79-65ed-d0328679bb8a@cogentembedded.com>
Message-ID: <CAMuHMdXPhMToHhZggdKo=i65nS_mQT1o44YBd_Lz-B2Td3Jm9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 20, 2016 at 5:38 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 05/20/2016 10:10 AM, Geert Uytterhoeven wrote:
>> Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
>> Warning (unit_address_vs_reg): Node /regulator at 0 has a unit name, but no reg property
>> Warning (unit_address_vs_reg): Node /regulator at 1 has a unit name, but no reg property
>> Warning (unit_address_vs_reg): Node /regulator at 2 has a unit name, but no reg property
>> Warning (unit_address_vs_reg): Node /regulator at 3 has a unit name, but no reg property
>> Warning (unit_address_vs_reg): Node /i2c at 2 has a unit name, but no reg property
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> v2:
>>   - No changes.
>> ---
>>  arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
>> b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
>> index 2c82dab2b6f45f9c..b3f0ac4b99bd5a3d 100644
>> --- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
>> +++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
>
> [...]
>>
>> @@ -127,7 +127,7 @@
>>                 };
>>         };
>>
>> -       i2c2: i2c at 2 {
>> +       i2c2: i2c2 {
>
>    Not "i2c-2" as in the other patches?

Oops... Thanks for noticing!

Simon: Do you want me to repost the whole series once again, or
can you fix this up while applying?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
