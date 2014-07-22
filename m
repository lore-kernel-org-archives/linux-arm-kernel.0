From: mporter@linaro.org (Matt Porter)
Date: Tue, 22 Jul 2014 17:33:50 -0400
Subject: [PATCH v8 00/11] ARM: brcmstb: Add Broadcom STB SoC support
In-Reply-To: <5044348.IEPQPrahyu@wuerfel>
References: <1405976886-27807-1-git-send-email-computersforpeace@gmail.com>
 <5675728.WLk3P96IBM@wuerfel> <20140722204431.GG28323@ld-irv-0074>
 <5044348.IEPQPrahyu@wuerfel>
Message-ID: <20140722213350.GX2593@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 22, 2014 at 10:57:17PM +0200, Arnd Bergmann wrote:
> On Tuesday 22 July 2014 13:44:31 Brian Norris wrote:
> > > For the platform changes in the first patch, I would prefer to have
> > > Matt pick up the first patch, but we can also apply it directly into
> > > arm-soc if he prefers that.
> > 
> > That brings up a question related to PATCH 11 in the series (MAINTAINERS
> > update); who will be maintaining arch/arm/mach-bcm/*brcmstb*, and how
> > will code go upstream? It seems like Matt and Christian are officially
> > mach-bcm maintainers, although I don't know if Christian is still
> > involved.
> 
> You have to solve that question together with Matt. From my perspective
> it would be easier if I only have to deal with one person for mach-bcm,
> but it's really up to you.
>
> 
> > Also, BCM7xxx shares little in common with the rest of mach-bcm, except
> > a company name, so we'd really like at least the 'Maintainer' entries
> > for the CC. I was planning on a separate git tree too, although it could
> > have conflicts if we touch arch/arm/mach-bcm/{Makefile,Kconfig}.
> > 
> > So would we send a separate arm-soc pull request for the arm-soc
> > targeted changes (and all future development)?
> 
> You can definitely have the separate MAINTAINERS entry without necessarily
> becoming a maintainer at the same level. I know Matt is very responsive
> and can forward your patches to arm-soc if that works for you.

We had this discussion wrt Hauke's BCM5301x support. The situation is
basically the same. To date, every instance of a BCM ARM SoC shares
nothing more than the company name and in some rare cases a piece of
licensed IP like the Arasan sdhci or dwc2. I can't recall who asked
for it, but I think Olof asked to have one pull request for all of
mach-bcm to keep things simple. So we ended up with:

BROADCOM BCM5301X ARM ARCHICTURE
M:      Hauke Mehrtens <hauke@hauke-m.de>
L:      linux-arm-kernel at lists.infradead.org
S:      Maintained
F:      arch/arm/mach-bcm/bcm_5301x.c
F:      arch/arm/boot/dts/bcm5301x.dtsi
F:      arch/arm/boot/dts/bcm470*

which could be a model for BCM7xxx maintainership and Christian and I
can aggregate this stuff in the mach-bcm tree for pull requests to the
arm-soc team as we are doing now. bcm2835 is an exception case since
that was living elsewhere before the new platforms colocated in
mach-bcm.

> > For the reset of mach-bcm stuff, I'll just send an arm-soc pull request
> > soon enough, unless Matt/Arnd/Olof object.
> 
> I'll wait for Matt to comment before pulling it, otherwise that sounds
> fine.

I'm fine with it, but we were asked to have one request for bcm5301x to
make life easy for the arm-soc team. If we want each platform to do pull
requests directly with arm-soc we should advise Hauke to do the same as
well with bcm5301x. I think the chances of Kconfig/Makefile conflicts are
relatively low as there's a dwindling amount of code of interest in new
platform mach directories like ours.

I would like to see a consistent path for all BCM platform maintainers.

-Matt
