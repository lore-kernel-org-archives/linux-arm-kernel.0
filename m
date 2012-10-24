From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 24 Oct 2012 18:00:37 -0500
Subject: [PATCH V3 1/5] ARM: dts: OMAP: Add timer nodes
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EB49C1B@DBDE01.ent.ti.com>
References: <1350496873-21337-1-git-send-email-jon-hunter@ti.com>
 <1350496873-21337-2-git-send-email-jon-hunter@ti.com>
 <79CD15C6BA57404B839C016229A409A83EB49C1B@DBDE01.ent.ti.com>
Message-ID: <50887315.2000509@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10/24/2012 01:17 PM, Hiremath, Vaibhav wrote:
> On Wed, Oct 17, 2012 at 23:31:09, Hunter, Jon wrote:
>> Add the 12 GP timers nodes present in OMAP2.
>> Add the 12 GP timers nodes present in OMAP3.
>> Add the 11 GP timers nodes present in OMAP4.
>> Add the 7 GP timers nodes present in AM33xx.
>>
>> Add documentation for timer properties specific to OMAP.
>>
>> Please note that for OMAP2/3 devices, there is only one interrupt controller
>> for the ARM CPU (which has the label "intc") and so globally define this as the
>> interrupt parent to save duplicating the interrupt parent for all device nodes.
>>
>> Thanks to Vaibhav Hiremath for creating the AM33xx timer nodes. I have modified
>> Vaibhav's original nodes adding information on which timers support a PWM
>> output.
>>
>> Cc: Benoit Cousson <b-cousson@ti.com>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>> ---
>>  .../devicetree/bindings/arm/omap/timer.txt         |   29 ++++++
>>  arch/arm/boot/dts/am33xx.dtsi                      |   61 +++++++++++++
>>  arch/arm/boot/dts/omap2.dtsi                       |   86 ++++++++++++++++++
>>  arch/arm/boot/dts/omap2420.dtsi                    |    8 ++
>>  arch/arm/boot/dts/omap2430.dtsi                    |    8 ++
>>  arch/arm/boot/dts/omap3.dtsi                       |   96 ++++++++++++++++++++
>>  arch/arm/boot/dts/omap4.dtsi                       |   86 ++++++++++++++++++
>>  7 files changed, 374 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/omap/timer.txt
>>
> 
> Although I have not tested this version of patch series at my end, but 
> whole patch-series Looks ok to me.
> 
> Acked-By: Vaibhav Hiremath <hvaibhav@ti.com>

Thanks. I made a couple cosmetic changes in V4 apart from the
"interrupt-parent" addition which we are now dropping. Care to ACK
patches 2-5 of V4?

Thanks
Jon
