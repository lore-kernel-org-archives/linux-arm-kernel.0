From: bhupesh.linux@gmail.com (Bhupesh SHARMA)
Date: Mon, 14 Dec 2015 15:30:10 +0530
Subject: [PATCH v2 1/2] Documentation: DT: Add entry for ARM SP805-WDT
In-Reply-To: <20151214010619.GA848@rob-hp-laptop>
References: <1449834467-30283-1-git-send-email-bhupesh.sharma@freescale.com>
 <1449834467-30283-2-git-send-email-bhupesh.sharma@freescale.com>
 <20151214010619.GA848@rob-hp-laptop>
Message-ID: <CAFTCetRn17yk6g=iYZvat6SE=TApwcfPbt72JFjQfzU2bPrEwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 6:36 AM, Rob Herring <robh@kernel.org> wrote:
> On Fri, Dec 11, 2015 at 05:17:46PM +0530, Bhupesh Sharma wrote:
>> This patch adds a devicetree binding documentation for ARM's
>> SP805 WatchDog Timer.
>>
>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
>> ---
>>  .../devicetree/bindings/watchdog/sp805-wdt.txt     |   29 ++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt b/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
>> new file mode 100644
>> index 0000000..45b5afc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
>> @@ -0,0 +1,29 @@
>> +* ARM SP805 Watchdog Timer (WDT) Controller
>> +
>> +SP805 WDT is a ARM Primecell Peripheral and has a standard-id register that
>> +can be used to identify the peripheral type, vendor, and revision.
>> +This value can be used for driver matching.
>> +
>> +As SP805 WDT is a primecell IP, it follows the base bindings specified in
>> +'arm/primecell.txt'
>> +
>> +Required properties:
>> +- compatible : Should be "arm,sp805-wdt", "arm,primecell"
>> +- reg : Base address and size of the watchdog timer registers.
>> +- clocks : From common clock binding.
>> +           First clock is PCLK and the second is WDOGCLK.
>> +           WDOGCLK can be equal to or be a sub-multiple of the PCLK frequency.
>> +- clock-names : From common clock binding. Shall be "apb_pclk" for first clock.
>
> And for the 2nd clock?

Right. Although the current amba driver framework and the sp805_wdt
driver doesn't handle
the 2nd clock correctly, the documentation should specify the 2nd
clock properly.
Does the name "wdog_clk" seems appropriate for the same?

>> +
>> +Optional properties:
>> +- interrupts : Should specify WDT interrupt number.
>> +
>> +Examples:
>> +
>> +             cluster1_core0_watchdog: wdt at c000000 {
>> +                     compatible = "arm,sp805-wdt", "arm,primecell";
>> +                     reg = <0x0 0xc000000 0x0 0x1000>;
>> +                     clocks = <&clockgen 4 3>, <&clockgen 4 3>;
>> +                     clock-names = "apb_pclk", "wdog_clk";
>> +             };
>> +
>> --
>> 1.7.9.5
>>
>>

Regards,
Bhupesh
