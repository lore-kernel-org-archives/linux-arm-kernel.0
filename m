From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 30 Jan 2015 13:03:59 +0100
Subject: [PATCH] ARM: dts: mvebu: add ethernet to the cm-a510 board
In-Reply-To: <20150130124144.501cf81d@armhf>
References: <E1YH5bU-0005mG-3L@bombadil.infradead.org>
 <54CB5267.5060004@gmail.com> <20150130113118.5523ed68@armhf>
 <54CB6440.1010002@gmail.com> <20150130124144.501cf81d@armhf>
Message-ID: <54CB732F.7010409@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.01.2015 12:41, Jean-Francois Moine wrote:
> On Fri, 30 Jan 2015 12:00:16 +0100
> Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:
>> Adapting the .config and removing drivers is actually not an option.
>> IMHO, introducing DT was meant for a single multi-arch kernel that
>> can be shipped with common Linux distros. Therefore, DT is the place
>> you enable/disable available resources. You leave most of the SoC (and
>> SoM) nodes disabled as long as you cannot tell if there is a
>> corresponding connector available.
>
> Well, I don't know too much about the hardware, and less about the
> hardware modules (SoM?).

Sorry, SoM is for System-on-Module, i.e. the CM-A510 itself.

You can see from the block diagram that it comprises the Dove SoC,
power circuitry, touch-screen controller, WiFi, GbE PHY for GbE-0, GbE
controller on PCIe for GbE-1, I2S audio codec, RS232 Level Shifter for
UART0, an USB2 Hub, SPI flash, NAND and RAM.

That basically is what will be represented in the som.dtsi. If any of
the functions above and the SoC will be _accessible_ on the baseboard is
another story.

> As seen in the Compulab documents, there are a lot of hardware modules.
> For the DT, do you mean that there would be as many .dts's as the whole
> number of connection possibilities?

Nope. One dove.dtsi, one dove-cm-a510.dtsi, and one baseboard.dts
including dove-cm-a510.dtsi for every baseboard we stumble upon.

> I'd have better seen the inverted case as the actual empty cm-board dts:
> enable every option in the (generic) .dts and let the vendor/user create
> a specific .dts from this one for the board according to the installed
> modules.

That what dtsi's are made for with one exception: the dtsi cannot "run"
on its own but needs at least one baseboard.dts that includes it. We
could create a "bare"-baseboard that represents what is (easily)
accessible on the SoM itself. Given the fact that even UART0 needs a
baseboard that grabs it from the SoM connector, I see no value in that.

> In any case, any real cm-a510 board should work with the
> generic/full .dts even if some hardware modules are lacking. No?

Nope. The cm-a510 is just an add-on for a baseboard, it does not make
a working board. Just think of it as a feature-improved SoC.

Sebastian
