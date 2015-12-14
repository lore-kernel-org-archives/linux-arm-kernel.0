From: codekipper@gmail.com (Code Kipper)
Date: Mon, 14 Dec 2015 08:51:23 +0100
Subject: [linux-sunxi][PATCH 1/2] ARM: dts: sun7i: Add Itead Ibox support
In-Reply-To: <20151211105930.GM27957@lukather>
References: <1449599344-15544-1-git-send-email-codekipper@gmail.com>
 <20151211105930.GM27957@lukather>
Message-ID: <CAEKpxBmopZ7+SONFSkVE72RGx=ncQHCZvv_bMJsfkWEHJBpnjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 December 2015 at 11:59, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Tue, Dec 08, 2015 at 07:29:03PM +0100, codekipper at gmail.com wrote:
>> From: Marcus Cooper <codekipper@gmail.com>
>>
>> The Itead Ibox is a multi board device based on the Allwinner A20 SoC.
>> It contains the A20 Itead Core module and a base board for the external
>> interfaces.
>>
>> The core module comes with 4GB NAND and 1GB DDR RAM.
>>
>> The base board to which the core board is connected provides 3 USB 2.0 Host
>> ports, 1 USB 2.0 OTG, 1 uSD slot, 10/100 Ethernet port, HDMI, IR receiver,
>> SPDIF and a 32-pin GPIO header. This header expands the features of core
>> board by exposing the VGA pins, audio In/Out pins, SATA, SPI, I2C, UARTS,
>> USB-OTG and power.
>>
>> As there is an A10 version of the Itead Core Module and at least one other
>> base board to support then this patch partitions the device tree files with
>> some consideration that these variants may be added later.
>>
>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>> ---
>>  arch/arm/boot/dts/Makefile                     |   1 +
>>  arch/arm/boot/dts/sun7i-a20-itead-core.dtsi    |  83 ++++++++++++++++++
>>  arch/arm/boot/dts/sun7i-a20-itead-ibox.dts     |  98 ++++++++++++++++++++++
>>  arch/arm/boot/dts/sunxi-itead-core-common.dtsi | 111 +++++++++++++++++++++++++
>>  4 files changed, 293 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/sun7i-a20-itead-core.dtsi
>>  create mode 100644 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
>>  create mode 100644 arch/arm/boot/dts/sunxi-itead-core-common.dtsi
>
> So, it looks like you're doing several things in this patch:
>
> 1) Create a common DTSI for all itead core variants
>    (sunxi-itead-core-common.dtsi)
>
> 2) Create an A20 variant of the itead core
> 3) Add support for a board using the A20 itead core.
>
> Please make three different patches for this, and converting the A10
> itead board would be a good idea too.

Sure, I will split this into four(or five) patches and include the A10
variant. I haven't got a A10 Itead board but I've seen that someone
has just popped on irc asking questions about it. I will ping them to
see if they can verify it for me.
CK
>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
