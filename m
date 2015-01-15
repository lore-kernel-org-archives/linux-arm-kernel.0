From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 15 Jan 2015 15:34:25 +0100
Subject: [PATCH v3 1/5] rtc: armada38x: Add the device tree binding
 documentation
In-Reply-To: <20150115113947.GC16217@leverpostej>
References: <1421318826-27268-1-git-send-email-gregory.clement@free-electrons.com>
 <1421318826-27268-2-git-send-email-gregory.clement@free-electrons.com>
 <20150115113947.GC16217@leverpostej>
Message-ID: <54B7CFF1.8080703@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/01/2015 12:39, Mark Rutland wrote:
> On Thu, Jan 15, 2015 at 10:47:02AM +0000, Gregory CLEMENT wrote:
>> The Armada 38x SoCs come with a new RTC which differs from the one
>> used in the other mvebu SoCs until now. This patch describes the
>> binding of this RTC.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  .../devicetree/bindings/rtc/armada-380-rtc.txt     | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/rtc/armada-380-rtc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/rtc/armada-380-rtc.txt b/Documentation/devicetree/bindings/rtc/armada-380-rtc.txt
>> new file mode 100644
>> index 000000000000..e6fe29bda608
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/rtc/armada-380-rtc.txt
>> @@ -0,0 +1,22 @@
>> +* Real Time Clock of the Armada 38x SoCs
>> +
>> +RTC controller for the Armada 38x SoCs
>> +
>> +Required properties:
>> +- compatible : Should be "marvell,armada-380-rtc"
>> +- reg: physical base address of the controller and length of memory
>> +  mapped region, associated to the reg-name "rtc". The other entry is
>> +  related to the interrupt control from the SoC, associated to the
>> +  reg-name "soc-int".
>> +- reg-names: names of the mapped memory regions listed in reg property
>> +    in the same order: "rtc" and "soc-int".
> 
> It would be nicer if reg were defined in terms of reg-names to avoid
> redundancy, e.g.
> 
> - reg: a list of base address and size pairs, one for each entry in
>   reg-names
> - reg names: should contain:
>   * "rtc" for the RTC registers
>   * "soc-int" for the interrutp control registers.

OK

> 
> That said, what are the "soc-int" registers, and why does the RTC driver
> need to poke them? It looks like they're for a separate component (i.e.
> the interrupt controller).

I don't have much information about it but for sure it is not part of the
interrupt controller. It is a range of 3 registers related to the RTC, 2
of them are not documented and the third one is related to the interrupt
management of the RTC. That's why I named this range soc-int(errupt), but
it would more accurate to name it rtc-soc

Gr?gory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
