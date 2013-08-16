From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 16 Aug 2013 15:50:46 -0400
Subject: [RFC v1 4/5] ARM: mvebu: add Armada 1500 and Sony NSZ-GS7
 device tree files
In-Reply-To: <1376682098-10580-5-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376682098-10580-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376682098-10580-5-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130816195046.GU13964@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 16, 2013 at 09:41:37PM +0200, Sebastian Hesselbarth wrote:
> This adds very basic device tree files for the Marvell Armada 1500 SoC
> and the Sony NSZ-GS7 GoogleTV board. Currently, SoC only has nodes for
> cpus, some clocks, l2 cache controller, local timer, apb timers, uart,
> and interrupt controllers.
> 
> The clocks are fixed-clock placeholders until a real DT clock provider
> is available. Cache controller node may be wrong and was just guessed
> out of Armada 370 and GPL'd 1500 source. Timers except clocksource have
> not really been tested.
> 
> The separation into soc/apb and soc/sm-apb may be removed, but it looks
> like Armada 1500 has a separate peripheral bus for the System Manager
> core that can also been accessed by CPUs. (If you look closely on GTV
> boot logs, you can see SM and CPU fighting for UART ;) )
> 
> The Sony NSZ-GS7 is a GoogleTV consumer device comprising the SoC above.
> Since last week or so, there is a way to install a custom u-boot and
> boot stock, unsigned kernels easily. Just ask Google about it, if you
> are willing to void your warranty.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ian.campbell@citrix.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/boot/dts/Makefile                     |    3 +-
>  arch/arm/boot/dts/armada-1500-sony-nsz-gs7.dts |   29 +++
>  arch/arm/boot/dts/armada-1500.dtsi             |  225 ++++++++++++++++++++++++
>  3 files changed, 256 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/armada-1500-sony-nsz-gs7.dts
>  create mode 100644 arch/arm/boot/dts/armada-1500.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 641b3c9..3186904 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -103,7 +103,8 @@ dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
>  	armada-370-rd.dtb \
>  	armada-xp-db.dtb \
>  	armada-xp-gp.dtb \
> -	armada-xp-openblocks-ax3-4.dtb
> +	armada-xp-openblocks-ax3-4.dtb \
> +	armada-1500-sony-nsz-gs7.dtb

alphabetical.

And now I need to pick up a googleTV... 

thx,

Jason.
