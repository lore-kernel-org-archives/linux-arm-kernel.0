From: joel@jms.id.au (Joel Stanley)
Date: Wed, 20 Dec 2017 13:51:40 +1030
Subject: [PATCH v2 03/19] ARM: dts: aspeed: Add LPC and child devices
In-Reply-To: <f08188a0-a6dd-a445-340c-eee1ca335865@kaod.org>
References: <20171215062443.23059-1-joel@jms.id.au>
 <20171215062443.23059-4-joel@jms.id.au>
 <f08188a0-a6dd-a445-340c-eee1ca335865@kaod.org>
Message-ID: <CACPK8XdtbpZdB6g5FQ26=eka5nOvPFKXNr2dZEU3niC5ajSLHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

j

On Mon, Dec 18, 2017 at 7:55 PM, C?dric Le Goater <clg@kaod.org> wrote:
> On 12/15/2017 07:24 AM, Joel Stanley wrote:
>> From: Andrew Jeffery <andrew@aj.id.au>
>>
>> Ensure the ordering is correct and add all of the children in the SoC
>> device trees for the ast2400 and ast2500.
>>
>> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>>  arch/arm/boot/dts/aspeed-g4.dtsi | 35 +++++++++++++++++++++++++++++++++++
>>  arch/arm/boot/dts/aspeed-g5.dtsi | 27 +++++++++++++++++----------
>>  2 files changed, 52 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
>> index 100d092e6c07..a3bc5da7d42c 100644
>> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
>> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
>> @@ -226,6 +226,41 @@
>>                               status = "disabled";
>>                       };
>>
>> +                     lpc: lpc at 1e789000 {
>> +                             compatible = "aspeed,ast2400-lpc", "simple-mfd";
>> +                             reg = <0x1e789000 0x1000>;
>> +
>> +                             #address-cells = <1>;
>> +                             #size-cells = <1>;
>> +                             ranges = <0x0 0x1e789000 0x1000>;
>> +
>> +                             lpc_bmc: lpc-bmc at 0 {
>> +                                     compatible = "aspeed,ast2400-lpc-bmc";
>> +                                     reg = <0x0 0x80>;
>> +                             };
>> +
>> +                             lpc_host: lpc-host at 80 {
>> +                                     compatible = "aspeed,ast2400-lpc-host", "simple-mfd", "syscon";
>> +                                     reg = <0x80 0x1e0>;
>> +                                     reg-io-width = <4>;
>> +
>> +                                     #address-cells = <1>;
>> +                                     #size-cells = <1>;
>> +                                     ranges = <0x0 0x80 0x1e0>;
>> +
>> +                                     lpc_ctrl: lpc-ctrl at 0 {
>> +                                             compatible = "aspeed,ast2400-lpc-ctrl";
>> +                                             reg = <0x0 0x80>;
>> +                                             status = "disabled";
>> +                                     };
>> +
>> +                                     lhc: lhc at 20 {
>> +                                             compatible = "aspeed,ast2500-lhc";
>
> aspeed,ast2400-lhc
>
> The layout of the registers are the same but there a couple of differences
> in the bit definitions between the two SoCs.
>
> a part from that :
>
> Reviewed-by: C?dric Le Goater <clg@kaod.org>

Good catch. Fixed in v3.

Cheers,

Joel
