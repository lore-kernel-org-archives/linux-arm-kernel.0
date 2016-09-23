From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 23 Sep 2016 11:04:33 +0300
Subject: [PATCHv2 1/3] Documentation: dt: Add TI SCI clock driver
In-Reply-To: <20160912131038.GA13103@rob-hp-laptop>
References: <1472733635-22661-1-git-send-email-t-kristo@ti.com>
 <1472733635-22661-2-git-send-email-t-kristo@ti.com>
 <20160912131038.GA13103@rob-hp-laptop>
Message-ID: <45d8054d-21cb-c90d-7226-387b97040d83@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/16 16:10, Rob Herring wrote:
> On Thu, Sep 01, 2016 at 03:40:33PM +0300, Tero Kristo wrote:
>> Add a clock implementation, TI SCI clock, that will hook to the common
>> clock framework, and allow each clock to be controlled via TI SCI
>> protocol.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> Tested-by: Dave Gerlach <d-gerlach@ti.com>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>>  .../devicetree/bindings/clock/ti,sci-clk.txt       | 51 ++++++++++++++++++++++
>>  MAINTAINERS                                        |  1 +
>>  2 files changed, 52 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/ti,sci-clk.txt
>>
>> diff --git a/Documentation/devicetree/bindings/clock/ti,sci-clk.txt b/Documentation/devicetree/bindings/clock/ti,sci-clk.txt
>> new file mode 100644
>> index 0000000..231cb80
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/ti,sci-clk.txt
>> @@ -0,0 +1,51 @@
>> +Texas Instruments TI-SCI Clocks
>> +===============================
>> +
>> +All clocks on Texas Instruments' SoCs that contain a System Controller,
>> +are only controlled by this entity. Communication between a host processor
>> +running an OS and the System Controller happens through a protocol known
>> +as TI-SCI[1]. This clock implementation plugs into the common clock
>> +framework and makes use of the TI-SCI protocol on clock API requests.
>> +
>> +[1] Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
>> +
>> +Required properties:
>> +-------------------
>> +- compatible: Must be "ti,sci-clk"
>> +- #clock-cells: Shall be 2.
>> +  In clock consumers, this cell represents the device ID and clock ID
>> +  exposed by the PM firmware. The assignments can be found in the header
>> +  files <dt-bindings/genpd/<soc>.h> (which covers the device IDs) and
>> +  <dt-bindings/clock/<soc>.h> (which covers the clock IDs), where <soc>
>> +  is the SoC involved, for example 'k2g'.
>> +- ti,sci: Phandle to the TI SCI device to use for managing the clocks
>> +
>> +Optional properties:
>> +-------------------
>> +- ti,ssc-clocks: Array of phandle clocks that shall enable spread spectrum
>> +		 clocking while enabled
>> +- ti,allow-freq-change-clocks: Array of phandle clocks that shall allow
>> +			       dynamic clock frequency changes by firmware
>> +- ti,input-term-clocks: Array of phandle clocks that shall enable input
>> +			termination
>
> These seem like a random set of features to control. What determines the
> clocks for these? If it is based on the SoC, then make your compatible
> string SoC specific and don't put this into DT.

Currently nobody seems to be using these flags, so I will just drop the 
support for these from the next rev. If anybody will need them at some 
point, I will figure out how to support these.

-Tero
