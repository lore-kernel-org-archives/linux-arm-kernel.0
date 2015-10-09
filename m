From: robherring2@gmail.com (Rob Herring)
Date: Fri, 9 Oct 2015 12:49:32 -0500
Subject: [PATCH v2 4/5] arm64: Juno: Add support for the PCIe host bridge
 on Juno R1
In-Reply-To: <20151009170448.GG21629@leverpostej>
References: <1444409849-5685-1-git-send-email-Liviu.Dudau@arm.com>
 <1444409849-5685-5-git-send-email-Liviu.Dudau@arm.com>
 <20151009170448.GG21629@leverpostej>
Message-ID: <CAL_JsqKjXpa7R433MZn9O8XkJcEE9xWp4tYRUox5eSs+Dm+cJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 9, 2015 at 12:04 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Oct 09, 2015 at 05:57:28PM +0100, Liviu Dudau wrote:
>> Juno R1 board sports a functional PCIe host bridge that is
>> compliant with the SBSA standard found [1] here. With the right
>> firmware that initialises the XpressRICH3 controller one can
>> use the generic Host Bridge driver to use the PCIe hardware.
>>
>> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
>>
>> [1] http://infocenter.arm.com/help/topic/com.arm.doc.den0029a/
>> ---
>>  arch/arm64/boot/dts/arm/juno-r1.dts | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
>> index c627511..a702a6b 100644
>> --- a/arch/arm64/boot/dts/arm/juno-r1.dts
>> +++ b/arch/arm64/boot/dts/arm/juno-r1.dts
>> @@ -109,7 +109,26 @@
>>
>>       #include "juno-base.dtsi"
>>
>> +     pcie-controller at 40000000 {
>> +             compatible = "arm,juno-r1-pcie", "plda,xpressrich3", "pci-host-ecam-generic";
>
> Judging by a PLDA press release [1], it looks like Juno uses
> "XpressRICH3-AXI" [2] rather than "XpressRICH3 for ASIC" [3].
>
> So sorry to bikeshed the name I suggested, but it's probably best to
> s/plda,xpressrich3/plda,xpressrich3-axi/
>
> With that:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> I assume that can be fixed up when picking (or prior to a pull) without
> the need to repost.

Also, now these strings need to be documented. :)

I would just adding to the generic host doc.

Rob
