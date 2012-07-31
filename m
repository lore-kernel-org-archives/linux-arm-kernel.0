From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 31 Jul 2012 11:27:36 +0000
Subject: [PATCH 1/6] Initial csb1724 board support (FDT)
In-Reply-To: <5016B619.7030602@codethink.co.uk>
References: <1343661359-10150-1-git-send-email-ian.molton@codethink.co.uk>
 <20120730152829.GJ18016@lunn.ch> <5016B619.7030602@codethink.co.uk>
Message-ID: <201207311127.37094.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 July 2012, Ian Molton wrote:
> On 30/07/12 16:28, Andrew Lunn wrote:
> > Hi Ian
> >
> >> diff --git a/arch/arm/configs/csb1724_defconfig
> >> b/arch/arm/configs/csb1724_defconfig new file mode 100644 index
> >> 0000000..927b269 --- /dev/null +++
> >> b/arch/arm/configs/csb1724_defconfig @@ -0,0 +1,47 @@
> >> +CONFIG_ARCH_KIRKWOOD=y +CONFIG_ARCH_KIRKWOOD_DT=y
> >> +CONFIG_MACH_CSB1724_DT=y
> > Do you really need this? Its the only kirkwood board with its on
> > _defconfig file. What makes this board special?
> 
> Nothing. defconfigs are just there to make configuring your kernel easy.
> 
> The kirkwood defconfig doesnt fit the currently supported hardware
> set on the csb1724 very well. Why build stuff you dont need?

The defconfig files serve a number of purposes. One of them is for
build regression testing, and for that reason we try to enable as
many boards as possible with a small number of defconfig files.

It's very rare that we have a board specific defconfig file, and
I would also ask you to just enable the hardware you need in the
kirkwood defconfig. It should not be hard for you to create
your own configuration by starting with that and disabling everything
you don't need.

	Arnd
