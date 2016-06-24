From: megous@megous.com (=?UTF-8?Q?Ond=c5=99ej_Jirman?=)
Date: Sat, 25 Jun 2016 00:51:56 +0200
Subject: [PATCH 06/14] ARM: dts: sun8i: Add cpu0 label to sun8i-h3.dtsi
In-Reply-To: <CAGb2v66eskVAxdz8VtjBJBCO7VV9WL4bdFDVrPWrSmxk4RASCw@mail.gmail.com>
References: <20160623192104.18720-1-megous@megous.com>
 <20160623192104.18720-7-megous@megous.com>
 <CAGb2v66eskVAxdz8VtjBJBCO7VV9WL4bdFDVrPWrSmxk4RASCw@mail.gmail.com>
Message-ID: <adaf7f61-af80-cc02-8c47-af721b86f81e@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

comments below.

On 24.6.2016 05:48, Chen-Yu Tsai wrote:
> On Fri, Jun 24, 2016 at 3:20 AM,  <megous@megous.com> wrote:
>> From: Ondrej Jirman <megous@megous.com>
>>
>> Add label to the first cpu so that it can be referenced
>> from derived dts files.
>>
>> Signed-off-by: Ondrej Jirman <megous@megous.com>
>> ---
>>  arch/arm/boot/dts/sun8i-h3.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
>> index 9938972..82faefc 100644
>> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
>> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
>> @@ -52,7 +52,7 @@
>>                 #address-cells = <1>;
>>                 #size-cells = <0>;
>>
>> -               cpu at 0 {
>> +               cpu0: cpu at 0 {
>>                         compatible = "arm,cortex-a7";
>>                         device_type = "cpu";
>>                         reg = <0>;
> 
> Can you also set the cpu clock here? It is part of the SoC
> and does not belong in the board DTS files.

Do you mean operating-points, or something else? Different SBCs will
probably require different combinations of operating points just for
safety's sake, because they have different regulators and [some have
botched] thermal designs, so it might make sense to customize it for
differnt boards, and I don't feel adventurous enough setting it for all
H3 boards out there.

Or is this comment related to the missing cpu clock rate message I see
on every boot?

[    0.058912] /cpus/cpu at 0 missing clock-frequency property

regards,
  Ondrej

> Otherwise this one looks good.
> 
> ChenYu
> 
>> --
>> 2.9.0
>>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160625/a0c4cba6/attachment.sig>
