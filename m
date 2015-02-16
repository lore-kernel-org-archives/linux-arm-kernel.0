From: tuomas.tynkkynen@iki.fi (Tuomas Tynkkynen)
Date: Mon, 16 Feb 2015 09:11:00 +0200
Subject: [PATCH v7 01/16] clk: tegra: Add binding for the Tegra124 DFLL
 clocksource
In-Reply-To: <20150212224242.GA23500@mithrandir>
References: <1420723339-30735-1-git-send-email-mikko.perttunen@kapsi.fi>
 <1420723339-30735-2-git-send-email-mikko.perttunen@kapsi.fi>
 <20150212224242.GA23500@mithrandir>
Message-ID: <54E19804.9080003@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/2015 12:42 AM, Thierry Reding wrote:
> On Thu, Jan 08, 2015 at 03:22:04PM +0200, Mikko Perttunen wrote:
>> From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
>>
>> The DFLL is the main clocksource for the fast CPU cluster on Tegra124
>> and also provides automatic CPU rail voltage scaling as well. The DFLL
>> is a separate IP block from the usual Tegra124 clock-and-reset
>> controller, so it gets its own node in the device tree.
>>
>> Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
>> Signed-off-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
>> ---
>>   .../bindings/clock/nvidia,tegra124-dfll.txt        | 69 ++++++++++++++++++++++
>>   1 file changed, 69 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
>>
...
>> +Required properties:
>> +- compatible : should be "nvidia,tegra124-dfll-fcpu"
>> +- reg : Defines the following set of registers, in the order listed:
>> +        - registers for the DFLL control logic.
>> +        - registers for the I2C output logic.
>> +        - registers for the integrated I2C master controller.
>> +        - look-up table RAM for voltage register values.
>
> Why do these all need to be separate sets? According to the TRM this is
> a single IP block with a single register region, why the need to split
> them apart?

On Tegra132, some of those register blocks (IIRC the first one) has 
moved to a different place (somewhere in the CAR register area). The TRM 
description indeed gives a single list of registers for the Tegra124 
implementation of the DFLL. The split into 4 blocks was to make the 
binding more future-proof and to be closer to the real hardware design.
