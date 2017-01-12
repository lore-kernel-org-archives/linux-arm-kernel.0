From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 12 Jan 2017 17:19:00 +0000
Subject: [PATCH v3 2/3] arm64: dts: juno: fix CoreSight support for Juno
 r1/r2 variants
In-Reply-To: <CANLsYkymGdrM8z-ZWan0Fn+Ymq97oHAJtW3G0YdUAxpWSf+aaw@mail.gmail.com>
References: <1484234410-7670-1-git-send-email-sudeep.holla@arm.com>
 <1484234410-7670-3-git-send-email-sudeep.holla@arm.com>
 <CANLsYkymGdrM8z-ZWan0Fn+Ymq97oHAJtW3G0YdUAxpWSf+aaw@mail.gmail.com>
Message-ID: <f585cc88-1601-4bd7-5992-e6c220577c0b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/01/17 16:51, Mathieu Poirier wrote:
> On 12 January 2017 at 08:20, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> From: Mike Leach <mike.leach@linaro.org>
>>
>> The CoreSight support added for Juno is valid for only Juno r0.
>> The Juno r1 and r2 variants have additional components and alternative
>> connection routes between trace source and sinks.
>>
>> This patch builds on top of the existing r0 support and extends it to
>> Juno r1/r2 variants.
>>
>> Signed-off-by: Mike Leach <mike.leach@linaro.org>
>> [sudeep.holla at arm.com: minor changelog update and reorganising the common
>>         coresight components back into juno-base.dtsi to avoid duplication]
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi | 102 ++++++++++++++++++++++++++++++
>>  arch/arm64/boot/dts/arm/juno-r1.dts       |   9 +++
>>  arch/arm64/boot/dts/arm/juno-r2.dts       |   9 +++
>>  3 files changed, 120 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
>> new file mode 100644
>> index 000000000000..89fcef366ff9
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
>> @@ -0,0 +1,102 @@
>> +       csys1_funnel at 20130000 {
>> +               compatible = "arm,coresight-funnel", "arm,primecell";
>> +               reg = <0 0x20130000 0 0x1000>;
>> +
>> +               clocks = <&soc_smc50mhz>;
>> +               clock-names = "apb_pclk";
>> +               power-domains = <&scpi_devpd 0>;
>> +               ports {
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +
>> +                       /* input port */
>> +                       port at 0 {
>> +                               reg = <0>;
>> +                               csys1_funnel_out_port: endpoint {
>> +                                       remote-endpoint =
>> +                                               <&etf1_in_port>;
>> +                               };
>> +                       };
>> +
>> +                       /* output port */
>> +                       port at 1 {
>> +                               reg = <0>;
>> +                               csys1_funnel_in_port0: endpoint {
>> +                                       slave-mode;
>> +                               };
>> +                       };
> 
> The comments related to the input and output port are reversed.
> 

Fixed locally.

-- 
Regards,
Sudeep
