From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Dec 2017 09:24:03 +0100
Subject: [PATCH v3 00/19] ARM: dts: aspeed: updates and new machines
In-Reply-To: <CACPK8Xdf3__yuMEvD0NiZXihU-8F1R15aEwwJueHLZ6Jfs82oQ@mail.gmail.com>
References: <20171220032328.30584-1-joel@jms.id.au>
 <CACPK8Xdf3__yuMEvD0NiZXihU-8F1R15aEwwJueHLZ6Jfs82oQ@mail.gmail.com>
Message-ID: <CAK8P3a2WQ3MDq_49t=uifC8dPVJ2Zgus35QoTBDOCaa3L0DamQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 20, 2017 at 4:37 AM, Joel Stanley <joel@jms.id.au> wrote:
> On Wed, Dec 20, 2017 at 1:53 PM, Joel Stanley <joel@jms.id.au> wrote:
>> This series of device tree patches for the ASPEED BMC machines
>> moves all systems to use the soon to be merged clk driver, and
>> updates machines to use all of the drivers we have upstream.
>>
>>  v3: Address review from Rob and Cedric
>>   - Move aspeed-gpio.h usage out into the patches where use of the GPIO
>>     is added
>>   - Clarify that the aspeed-clock.h patch will be merged as part of
>>     the device tree tree. This is to ensure we don't depend on the clk
>>     tree for building.
>
> Arnd, Michael, Stephen; how do we resolve this? We need the
> dt-bindings header to be present for both the clk driver and the
> device tree to build.
>
> The clk driver is not (yet - soon I hope?) merged by Michael and
> Stephen. I am about to commit the device tree changes that will go
> through the ARM SoC tree.

There are several options:

- avoid the use of the header and redefine the binding to have a
  clear mapping between hardware clock lines and the numeric
  representation. This works better for some SoCs than others,
  YMMV.
- Don't use the constants in the dts files for now, but use the
  numbers directly, and update the dts files for the next merge window
- merge only one side for 4.16, either the driver or the dts files,
  and follow up with the other one in 4.17
- make one shared git branch that contains only the headers
  and base both the driver and the dts files on that branch so you
  get a single shared commit ID.

I'm fine with any of the above, please pick whatever suits you best.

       Arnd
