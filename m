From: daniel@zonque.org (Daniel Mack)
Date: Sat, 06 Sep 2014 17:55:34 +0200
Subject: [PATCH 1/2] ARM: pxa: dts: fix mmc controller compatible string
In-Reply-To: <CAOesGMh6sc7U6XRjGWBUPszaD9K66Ek=3xdMyGdh7bEAMXVG4g@mail.gmail.com>
References: <1408009573-24523-1-git-send-email-zonque@gmail.com>
 <CAOesGMh6sc7U6XRjGWBUPszaD9K66Ek=3xdMyGdh7bEAMXVG4g@mail.gmail.com>
Message-ID: <540B2E76.9000105@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

Sorry for the late reply.

On 08/28/2014 12:01 AM, Olof Johansson wrote:
> On Thu, Aug 14, 2014 at 2:46 AM, Daniel Mack <zonque@gmail.com> wrote:
>> The vendor prefix was renamed from "mrvl" to "marvell". Follow this
>> change in the dts file.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>> ---
>>  arch/arm/boot/dts/pxa2xx.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/pxa2xx.dtsi b/arch/arm/boot/dts/pxa2xx.dtsi
>> index febd391..f188f8c 100644
>> --- a/arch/arm/boot/dts/pxa2xx.dtsi
>> +++ b/arch/arm/boot/dts/pxa2xx.dtsi
>> @@ -128,7 +128,7 @@
>>                 };
>>
>>                 mmc0: mmc at 41100000 {
>> -                       compatible = "mrvl,pxa-mmc";
>> +                       compatible = "marvell,pxa-mmc";
> 
> It seems that the driver was changed without consideration to
> backwards compatibility. The driver should still handle both the old
> and the new prefix (since we keep this a stable ABI). The old one
> should be deprecated but still accepted.
>
> I.e. this is an OK change, but it's fine to hold off as a cleanup
> until 3.18. The driver has a regression though, that needs to be fixed
> for 3.17.

Hmm, no. The driver never actuall supported that string. It was my bad
when I submitted the original version of pxa2xx.dtsi. Still, given that
it went unnoticed for so long, it can well wait for 3.18.

Thanks,
Daniel
