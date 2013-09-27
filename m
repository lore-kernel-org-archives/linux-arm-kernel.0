From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Fri, 27 Sep 2013 09:42:49 -0400
Subject: [PATCHv4 11/18] arm: dts: add omap4430 thermal data
In-Reply-To: <CAGo_u6p3pp2EBo_fJE_RJOdrc05OHM-QFgCZFBUW+duhPgOYpw@mail.gmail.com>
References: <1380251605-3804-1-git-send-email-eduardo.valentin@ti.com>
 <1380251605-3804-12-git-send-email-eduardo.valentin@ti.com>
 <20130927122439.GA8360@kahuna> <5245861F.7000109@ti.com>
 <CAGo_u6p3pp2EBo_fJE_RJOdrc05OHM-QFgCZFBUW+duhPgOYpw@mail.gmail.com>
Message-ID: <52458B59.8070703@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27-09-2013 09:26, Nishanth Menon wrote:
> On Fri, Sep 27, 2013 at 8:20 AM, Eduardo Valentin
> <eduardo.valentin@ti.com> wrote:
>> On 27-09-2013 08:24, Nishanth Menon wrote:
>>> On 23:13-20130926, Eduardo Valentin wrote:
>>>> This patch changes the dtsi entry on omap4430 to contain
>>>> the thermal data. This data will enable the passive
>>>> cooling with CPUfreq cooling device at 100C and the
>>>> system will do a thermal shutdown at 125C.
>>>>
>>>> Cc: "Beno?t Cousson" <bcousson@baylibre.com>
>>>> Cc: Tony Lindgren <tony@atomide.com>
>>>> Cc: Russell King <linux@arm.linux.org.uk>
>>>> Cc: linux-omap at vger.kernel.org
>>>> Cc: devicetree-discuss at lists.ozlabs.org
>>>> Cc: linux-arm-kernel at lists.infradead.org
>>>> Cc: linux-kernel at vger.kernel.org
>>>> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
>>>> ---
>>>>  arch/arm/boot/dts/omap443x.dtsi | 10 ++++++++--
>>>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap443x.dtsi
>>>> index bcf455e..e9c97d6 100644
>>>> --- a/arch/arm/boot/dts/omap443x.dtsi
>>>> +++ b/arch/arm/boot/dts/omap443x.dtsi
>>>> @@ -12,7 +12,7 @@
>>>>
>>>>  / {
>>>>      cpus {
>>>> -            cpu at 0 {
>>>> +            cpu0: cpu at 0 {
>>>>                      /* OMAP443x variants OPP50-OPPNT */
>>>>                      operating-points = <
>>>>                              /* kHz    uV */
>>>> @@ -25,9 +25,15 @@
>>>>              };
>>>>      };
>>>>
>>>> -    bandgap {
>>>> +    thermal-zones{
>>>> +            #include "omap4-cpu-thermal.dtsi"
>>>> +    };
>>>> +
>>>> +    bandgap: bandgap {
>>>>              reg = <0x4a002260 0x4
>>>>                     0x4a00232C 0x4>;
>>>>              compatible = "ti,omap4430-bandgap";
>>>> +
>>>> +            #thermal-sensor-cells = <0>;
>>> 2 cents:
>>> we might want to move bandgap under ocp?
>>>
>>
>> Yes, agreed. But I don't think this change is related to this patch or
>> to this series.
> 
> Correct - this comment is not related to the current patch, hence my 2
> cents ;) - will be nice to have it cleaned up though..

Yes, it will be cleaned. ;-) Tks.

> 
> Regards,
> Nishanth Menon
> 
> 


-- 
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 295 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130927/cc2729b9/attachment.sig>
