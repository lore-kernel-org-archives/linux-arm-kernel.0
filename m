From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Nov 2014 12:50:53 +0100
Subject: [GIT PULL] ARM: BCM5301X: SoC changes for v3.19
In-Reply-To: <546E53A3.3050005@openwrt.org>
References: <546298D9.7080800@hauke-m.de> <546E52E9.3040301@hauke-m.de>
 <546E53A3.3050005@openwrt.org>
Message-ID: <8711128.k3FfmmMqrE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 November 2014 12:48:35 Florian Fainelli wrote:
> On 11/20/2014 12:45 PM, Hauke Mehrtens wrote:
> > On 11/20/2014 10:27 AM, Arnd Bergmann wrote:
> >> On Wednesday 12 November 2014, Hauke Mehrtens wrote:
> >>> ----------------------------------------------------------------
> >>> ARM: BCM5301X: SoC: two patches for the SoC part
> >>>
> >>> These patches were all send to the arm list and I haven't got any
> >>> negative responses.
> >>>
> >>> ----------------------------------------------------------------
> >>> Hauke Mehrtens (1):
> >>>       ARM: BCM5301X: fix early serial console
> >>>
> >>> Rafa? Mi?ecki (1):
> >>>       ARM: BCM5301X: select GPIOLIB as optional
> >>
> >> Hi Hauke and Florian,
> >>
> >> sorry for the late reply. The patches are both good and I want to merge them,
> >> but I have two problems with your pull request:
> >>
> >> - I'm unsure about who is sending us patches for mach-bcm. I was under the
> >>   assumption that Florian would now handle all of them and pick up your
> >>   patches to forward them to arm at kernel.org together with the other mach-bcm
> >>   platforms. I'd much rather get only patches from one person per platform
> >>   directory, though we can have multiple people if that's what you all want.
> > 
> > I talked to Florian and he suggested me that I should send patches
> > directly to you. There could be some stuff shared with the other network
> > SoCs, there is nothing shared with the mobile SoCs.
> > We thought that it would be easier for us (Florian and me) if you pull
> > directly from me.
> 
> Absolutely, I did it differently for the Cygnus SoC to help Scott with
> his initial submission, but in the future, I would rather have Hauke,
> Scott and myself send separate pull requests, leaving you with just
> potential conflicts for arch/arm/mach-bcm/{Makefile,Kconfig}.
> 
> If this model is not desirable, I have no problems aggregating all
> mach-bcm changes to appropriate pull requests, whether that means
> pulling from Hauke and Scott directly, or compiling pull requests myself
> as long as you guys CC me on your patches.

My preference is definitely to get fewer pull requests, and to get them
from fewer people. There are so many details that each maintainer needs
to know about to make the arm-soc workflow efficient, I mainly want to
avoid teaching more people about it. I've also discussed this with Lee
Jones yesterday, since he just took over maintenance for bcm2835.

We now have between five and seven platforms (depending how you count)
under mach-bcm that are mostly unrelated, so I can understand the desire
to keep them maintained separately on your end. From my perspective,
these are all 'small' platforms in the sense that I get very few patches
for each one, but they occasionally conflict on Makefile or Kconfig
changes, and I'd appreciate these all to be consolidated in common
pull requests.

	Arnd
