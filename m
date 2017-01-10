From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 10 Jan 2017 16:17:29 +0100
Subject: [PATCH v6 0/2] Support for Axentia TSE-850
In-Reply-To: <1484054314-6244-1-git-send-email-peda@axentia.se>
References: <1484054314-6244-1-git-send-email-peda@axentia.se>
Message-ID: <20170110151729.acper3qneohlfe4z@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2017 at 14:18:32 +0100, Peter Rosin wrote :
> Hi!
> 
> changes v5 -> v6
> - drop the &main clock-frequency
> - add some text to the commit messages
> - make config additions modules
> 
> changes v4 -> v5
> - comment from Rob about the memory node made me look closer and
>   the memory size is actually updated by the bootloader, and that
>   hid the fact that the entry was always faulty. This version
>   specifies the correct memory size from the start, which is 64MB.
> - ack from Rob
> 
> changes v3 -> v4
> - rename files arch/arm/boot/dts/axentia-* to .../at91-*
> - remove bootargs from at91-tse850-3.dts
> - depend on the atmel ssc to register as a sound dai by itself
> - bump copyright years
> 
> changes v2 -> v3
> - document the new compatible strings prefixed with "axentia,".
> 
> changes v1 -> v2
> - squash the fixup into the correct patch, sorry for the noise.
> 
> After finally having all essintial drivers upstreamed I would
> like to have the dts and the defconfig also upstreamed.
> 
> The atmel-ssc/sound-dai change depends on a change that has been
> sitting in the ASoC tree since mid-december, and I have been waiting
> for it to hit linux-next before sending this, but it seems to take
> longer than I anticipated. So, since I do not want this to in
> turn miss the next merge window because of that wait I therefore
> request that this is taken now even though it doesn't really work
> w/o the ASoC "topic/atmel" branch as of 2016-12-15 [1]. It of course
> builds cleanly even w/o those ASoC changes. That effectively means
> that noone besides me should notice the inconsistency (I currently
> have all affected devices under my control).
> 
> Cheers,
> peda
> 
> [1] http://git.kernel.org/cgit/linux/kernel/git/broonie/sound.git/log/?h=topic/atmel
> 
> Peter Rosin (2):
>   ARM: dts: at91: add devicetree for the Axentia TSE-850
>   ARM: sama5_defconfig: add support for the Axentia TSE-850 board
> 
>  Documentation/devicetree/bindings/arm/axentia.txt |  19 ++
>  MAINTAINERS                                       |   8 +
>  arch/arm/boot/dts/Makefile                        |   1 +
>  arch/arm/boot/dts/at91-linea.dtsi                 |  49 ++++
>  arch/arm/boot/dts/at91-tse850-3.dts               | 274 ++++++++++++++++++++++
>  arch/arm/configs/sama5_defconfig                  |   7 +-
>  6 files changed, 357 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/axentia.txt
>  create mode 100644 arch/arm/boot/dts/at91-linea.dtsi
>  create mode 100644 arch/arm/boot/dts/at91-tse850-3.dts
> 

Both applied, thanks!

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
