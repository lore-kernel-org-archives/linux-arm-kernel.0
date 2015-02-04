From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Feb 2015 11:26:41 +0100
Subject: [PATCH] ARM: berlin: add a defconfig
In-Reply-To: <20150204085404.GB12908@kwain>
References: <1422962932-12603-1-git-send-email-antoine.tenart@free-electrons.com>
 <54D14B26.4050406@gmail.com> <20150204085404.GB12908@kwain>
Message-ID: <4559568.VT3alPUddY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 February 2015 09:54:04 Antoine Tenart wrote:
> Hi Sebastian,
> 
> On Tue, Feb 03, 2015 at 11:26:46PM +0100, Sebastian Hesselbarth wrote:
> > On 03.02.2015 13:54, Arnd Bergmann wrote:
> > >On Tuesday 03 February 2015 12:28:52 Antoine Tenart wrote:
> > >>Marvell Berlin SoCs did not have a custom defconfig and were only
> > >>supported in multi_v7_defconfig.
> > >>
> > >>Adds a proper defconfig, allowing to boot a Berlin SoC with all the
> > >>currently supported features: SMP, Pinmux, AHCI, Ethernet, I2C, GPIO,
> > >>USB, SDHCI.
> > >>
> > >>
> > >
> > >Are there any features that are not currently supported by
> > >multi_v7_defconfig? If so, please also add them there as
> > >loadable modules.
> > 
> > do we really need two potentially diverging defconfigs?
> > 
> > I am aware that multi_v7_defconfig adds a lot of stuff that is
> > not required for Berlin, but still I think in terms of coverage
> > (both Berlin and non-Berlin stuff) multi_v7 is sufficient, isn't
> > it?
> 
> In term of coverage, multi_v7_defconfig should be sufficient. The main
> advantage of having a custom Berlin defconfig would be for me to have a
> small kernel image and a configuration to start with without having to
> maintain it out of tree, for Berlin related developments.
> 
> It's not mandatory, but it's useful at least for me. So the question
> is whether we want this defconfig mainlined or out of tree.
 
I would prefer to have fewer defconfigs in general, but we generally
tend to do one defconfig per mach directory because it's always been
that way. Older platforms have more than one, and we try to cut them
down.

If all platform specific drivers were loadable modules or had an
explicit dependency on the platform, you could trivially turn the
multi_v7_defconfig into a platform specific one by turning off the
other platforms, but at the moment it's not that easy.

	Arnd
