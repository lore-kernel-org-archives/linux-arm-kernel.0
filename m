From: sr@denx.de (Stefan Roese)
Date: Thu, 24 Mar 2016 18:30:22 +0100
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <3107533.ZIfFo6QAv3@wuerfel>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <3250653.vvT0RgK8yg@wuerfel> <56F412B5.2080200@denx.de>
 <3107533.ZIfFo6QAv3@wuerfel>
Message-ID: <56F4242E.70501@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24.03.2016 17:42, Arnd Bergmann wrote:
> On Thursday 24 March 2016 17:15:49 Stefan Roese wrote:
>>> but then we have a
>>> problem with how it uses both internal-regs and and its own mbus
>>> based reg, so we probably have to move the spi node outside of
>>> the internal-regs node to achieve that, similar to how we handle
>>> the devbus devices:
>>>
>>>
>>>        soc@ {
>>>                spi0 {
>>>                          compatible = "marvell,armada-370-spi",
>>>                                       "marvell,orion-spi";
>>>                        reg = <MBUS_ID(0xf0, 0x01) 0x10600 0x28>,
>>>                              <MBUS_ID(0x01, 0x5e) 0 0x100000>;
>>>                          #address-cells = <1>;
>>>                          #size-cells = <0>;
>>>                          pinctrl-0 = <&spi0_pins1>;
>>>                          pinctrl-names = "default";
>>>                          cell-index = <0>;
>>>                          interrupts = <30>;
>>>                          clocks = <&coreclk 0>;
>>>                          status = "disabled";
>>>                };
>>>        };
>>
>> Do I understand this correctly, that you suggest to list all MBus
>> windows here, that the SoC supports (e.g. 8 for the Armada XP).
>> And let the SPI driver then extract and dynamically enable (map)
>> the one that is currently used?
>
> I had not realize that there is more than one per controller.
> Is it one per chip-select, or how do you pick the right ones?

Yes, its one per chip-select (SPI device).

Thanks,
Stefan
