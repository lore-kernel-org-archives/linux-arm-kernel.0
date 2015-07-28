From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 28 Jul 2015 10:25:08 +0200
Subject: [RFCv2 1/3] docs: dts: Added documentation for Xilinx Zynq Reset
 Controller bindings.
In-Reply-To: <1438070702.3193.4.camel@pengutronix.de>
References: <1437783682-13632-1-git-send-email-moritz.fischer@ettus.com>
 <1437783682-13632-2-git-send-email-moritz.fischer@ettus.com>
 <1438070702.3193.4.camel@pengutronix.de>
Message-ID: <55B73C64.5050903@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/28/2015 10:05 AM, Philipp Zabel wrote:
> Am Freitag, den 24.07.2015, 17:21 -0700 schrieb Moritz Fischer:
>> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
>> ---
>>  Documentation/devicetree/bindings/reset/zynq-reset-pl.txt | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/reset/zynq-reset-pl.txt
>>
>> diff --git a/Documentation/devicetree/bindings/reset/zynq-reset-pl.txt b/Documentation/devicetree/bindings/reset/zynq-reset-pl.txt
>> new file mode 100644
>> index 0000000..ac4499e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reset/zynq-reset-pl.txt
>> @@ -0,0 +1,13 @@
>> +Xilinx Zynq PL Reset Manager
>> +
>> +Required properties:
>> +- compatible: "xlnx,zynq-reset-pl"
>> +- syscon <&slcr>;
>> +- #reset-cells: 1
>> +
>> +Example:
>> +	rstc: rstc at 240 {
>> +		#reset-cells = <1>;
>> +		compatible = "xlnx,zynq-reset-pl";
>> +		syscon = <&slcr>;
> 
> Why the syscon phandle if rstc always is the child of slcr? Why not just
> request the syscon for the rstc's parent node.

We are using this description for pincntrl which was properly reviewed
that's why I expect Moritz just use the same style.
But yes also referencing parent should work.

TBH I don't have strong preference but having unified style is something
what I would prefer.

Also I see that using parent is used by others and it looks like that
having something like syscon_regmap_lookup_parent will be worth to have.

Thanks,
Michal
