From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 4 Aug 2015 10:18:54 +0200
Subject: [RFCv3 1/4] docs: dts: Added documentation for Xilinx Zynq Reset
 Controller bindings.
In-Reply-To: <1438675772.3793.18.camel@pengutronix.de>
References: <1438305237-18497-1-git-send-email-moritz.fischer@ettus.com>
 <1438305237-18497-2-git-send-email-moritz.fischer@ettus.com>
 <1438675772.3793.18.camel@pengutronix.de>
Message-ID: <55C0756E.8050003@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04/2015 10:09 AM, Philipp Zabel wrote:
> Hi Moritz,
> 
> Am Donnerstag, den 30.07.2015, 18:13 -0700 schrieb Moritz Fischer:
>> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
>> ---
>>  .../devicetree/bindings/reset/zynq-reset.txt       | 68 ++++++++++++++++++++++
>>  1 file changed, 68 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/reset/zynq-reset.txt
>>
>> diff --git a/Documentation/devicetree/bindings/reset/zynq-reset.txt b/Documentation/devicetree/bindings/reset/zynq-reset.txt
>> new file mode 100644
>> index 0000000..498c037a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reset/zynq-reset.txt
>> @@ -0,0 +1,68 @@
>> +Xilinx Zynq Reset Manager
>> +
>> +The Zynq AP-SoC has several different resets.
>> +
>> +See Chapter 26 of the Zynq TRM (UG585) for more information about Zynq resets.
>> +
>> +Required properties:
>> +- compatible: "xlnx,zynq-reset"
>> +- reg: SLCR offset and size taken via syscon <0x200 0x48>
>> +- syscon: <&slcr>
>> +  This should be a phandle to the Zynq's SLCR register.
> 
>                                                  ^ register singular?
> 
> I still think the syscon phandle property is superfluous,
> but I'm fine with keeping it for consistency.
> It could always be made optional later.

Great.

Philipp: I expect you want to take at least 1/4 and 3/4 via your tree.
I am fine if you also want to add 2/4 and 4/4 via your tree.
If you think that they should go via arm-soc please let me know and I
will add them to the queue.

Thanks,
Michal
