From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 25 Aug 2017 10:15:55 +0100
Subject: [GIT PULL] ARM: Xilinx Zynq SoC patches for v4.14
In-Reply-To: <55aac7c8-3a68-082a-6b13-63201670f711@monstr.eu>
References: <8d0c07a6-27e9-e14a-560f-3fc89327f8cd@monstr.eu>
 <CAK8P3a0KttjyxbtP=WyrYdRSV49jr_NMBWfhquxThL-x8wdiXQ@mail.gmail.com>
 <55aac7c8-3a68-082a-6b13-63201670f711@monstr.eu>
Message-ID: <3ae81a59-36ea-280c-627c-792f4f3158e8@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24/08/17 14:34, Michal Simek wrote:
> On 22.8.2017 17:45, Arnd Bergmann wrote:
>> On Mon, Aug 21, 2017 at 3:05 PM, Michal Simek <monstr@monstr.eu> wrote:
>>> Hi,
>>>
>>> please apply these two patches to your tree.
>>>
>>> Thanks,
>>> Michal
>>>
>>>
>>>   The following changes since commit
>>> 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:
>>>
>>>     Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)
>>>
>>>   are available in the git repository at:
>>>
>>>     https://github.com/Xilinx/linux-xlnx.git tags/zynq-soc-for-4.14
>>>
>>>   for you to fetch changes up to b04d4c876b1b7f25cff35b7c26c5b9f518f612b2:
>>>
>>>     ARM: zynq: Add support for Zynq-7000S devices (2017-08-21 14:22:50 +0200)
>>>
>>>   ----------------------------------------------------------------
>>>   arm: Xilinx Zynq patches for v4.14
>>>
>>>   - Add support for 7000s devices
>>>
>>>   ----------------------------------------------------------------
>>>   Michal Simek (2):
>>>         devicetree: ARM: zynq: Add DT binding for eFuse controller
>>>         ARM: zynq: Add support for Zynq-7000S devices
>>>
>>>    Documentation/devicetree/bindings/nvmem/zynq-efuse.txt | 15
>>> +++++++++++++++
>>>    arch/arm/boot/dts/zynq-7000.dtsi                       |  5 +++++
>>>    arch/arm/mach-zynq/Makefile                            |  2 +-
>>>    arch/arm/mach-zynq/common.c                            |  1 +
>>>    arch/arm/mach-zynq/common.h                            |  3 +++
>>>    arch/arm/mach-zynq/efuse.c                             | 75
>>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>    arch/arm/mach-zynq/platsmp.c                           |  3 +++
>>>    7 files changed, 103 insertions(+), 1 deletion(-)
>>
>> Not pulled yet, it looked like you add a driver stub for something
>> that belongs into drivers/nvmem/.
>>
>> Can you consult with Srinivas Kandagatla about what the right
>> approach is for this?
> 
> Srinivas: Any comment?

> We can move it to nvmem and make regular driver from this.
looking at the driver,  I see no reason why this should not be a nvmem 
provider driver.

thanks,
srini
> 
> Thanks,
> Michal
> 
> 
