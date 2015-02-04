From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 4 Feb 2015 09:54:04 +0100
Subject: [PATCH] ARM: berlin: add a defconfig
In-Reply-To: <54D14B26.4050406@gmail.com>
References: <1422962932-12603-1-git-send-email-antoine.tenart@free-electrons.com>
 <3962783.sVjmOB1hYm@wuerfel> <54D14B26.4050406@gmail.com>
Message-ID: <20150204085404.GB12908@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Tue, Feb 03, 2015 at 11:26:46PM +0100, Sebastian Hesselbarth wrote:
> On 03.02.2015 13:54, Arnd Bergmann wrote:
> >On Tuesday 03 February 2015 12:28:52 Antoine Tenart wrote:
> >>Marvell Berlin SoCs did not have a custom defconfig and were only
> >>supported in multi_v7_defconfig.
> >>
> >>Adds a proper defconfig, allowing to boot a Berlin SoC with all the
> >>currently supported features: SMP, Pinmux, AHCI, Ethernet, I2C, GPIO,
> >>USB, SDHCI.
> >>
> >>
> >
> >Are there any features that are not currently supported by
> >multi_v7_defconfig? If so, please also add them there as
> >loadable modules.
> 
> do we really need two potentially diverging defconfigs?
> 
> I am aware that multi_v7_defconfig adds a lot of stuff that is
> not required for Berlin, but still I think in terms of coverage
> (both Berlin and non-Berlin stuff) multi_v7 is sufficient, isn't
> it?

In term of coverage, multi_v7_defconfig should be sufficient. The main
advantage of having a custom Berlin defconfig would be for me to have a
small kernel image and a configuration to start with without having to
maintain it out of tree, for Berlin related developments.

It's not mandatory, but it's useful at least for me. So the question
is whether we want this defconfig mainlined or out of tree.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
