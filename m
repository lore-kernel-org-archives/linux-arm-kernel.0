From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 22 Nov 2016 21:43:52 -0800
Subject: [PATCH 2/4] ARM: dts: davinci: da850: add VPIF
In-Reply-To: <51071aa1-50c5-1121-3e64-018edaf544bf@lechnology.com> (David
 Lechner's message of "Tue, 22 Nov 2016 14:00:29 -0600")
References: <20161122194551.3420-1-khilman@baylibre.com>
 <20161122194551.3420-3-khilman@baylibre.com>
 <51071aa1-50c5-1121-3e64-018edaf544bf@lechnology.com>
Message-ID: <7hh96yiwdj.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Lechner <david@lechnology.com> writes:

> On 11/22/2016 01:45 PM, Kevin Hilman wrote:
>> Add VPIF and VPIF capture nodes to da850.  VPIF capture has two input
>> channels describe using the standard DT ports and enpoints.
>>
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>> ---
>>  arch/arm/boot/dts/da850.dtsi | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
>> index 6205917b4f59..e05e2bb834e8 100644
>> --- a/arch/arm/boot/dts/da850.dtsi
>> +++ b/arch/arm/boot/dts/da850.dtsi
>> @@ -453,7 +453,35 @@
>>  			interrupts = <52>;
>>  			status = "disabled";
>>  		};
>> +
>> +		vpif: video at 0x00217000 {
>
> Should be @217000
>
>> +			compatible = "ti,da850-vpif";
>> +			reg = <0x00217000 0x1000>;
>
> Could omit leading 0's to be consistent with existing entries.
>
> 	reg = <0x217000 0x1000>;

Ugh, yeah. I hate that convention, but better to be consistent, I guess.

>> +			status = "disabled";
>> +		};
>> +
>> +		vpif_capture: video-capture at 0x00217000 {
>
> Again, @217000. But it seems odd to have two device nodes with the
> same address. Is enabling these mutually exclusive?

They're not mutually exclusive because the vpif is the one that actually
maps the register range (since it's shared between vpif_display and
vpif_capture) so I guess I should just drop the reg property from the
vpif_capture node.

>> +			compatible = "ti,da850-vpif-capture";
>> +			reg = <0x00217000 0x1000>;
>
> Ditto on the leading 0's.
>

Thanks for the review,

Kevin
