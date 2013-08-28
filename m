From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 28 Aug 2013 17:28:24 -0600
Subject: 32337ea "ASoC: warn if we will overwrite the DAI stream widgets"
Message-ID: <521E8798.10206@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, if the warning in commit 32337ea "ASoC: warn if we will
overwrite the DAI stream widgets" fires, what do I need to do to the
ASoC driver to fix it? (I'm deliberately ignoring any other issues with
this patch, and looking only to discover what is apparently wrong with
my driver that's triggering this...).

Steev Klimaszewski reported this warning to me, and I've repro'd it
running next-20130827 on a couple of Tegra systems (TrimSlice and
Seaboard at least), using sound/soc/tegra/tegra_{trimslice,wm8903}.c,
and associated ASoC components.

For the record, the commit description is:
>     ASoC: warn if we will overwrite the DAI stream widgets
>     
>     The DAI stream widgets can end up being created multiple times if the
>     CPU DAI and DMA/platform components share the same struct device.  This
>     bug has been reported in various forms to the ASoC maintainer(s) several
>     times, yet they refuse to acknowledge this:
>     
>     > Essentially all the dmaengine based platforms in mainline use a shared
>     > device for DMA and DAI; I'm fairly sure someone would have mentioned if
>     > there were problems.
>     >
>     > As you have been repeatedly told the Kirkwood drivers are the first
>     > drivers submitted to mainline which use DPCM and therefore it is not
>     > surprising that there are a few issues which need to be worked through,
>     > there were a few revisions to the framework which went in as a result of
>     > review during the mainline merge.  The problem you are seeing here is
>     > due to this being the first platform with a *shared* device to use DPCM.
>     
>     This is inspite of stating multiple times that this has nothing to do
>     with DPCM what so ever.  So, having tried to convince them over the
>     last month that this is the case, and them being obstructive and/or
>     obtuse, this is the only way left open to convince them that there is
>     a problem here.
>     
>     It is only through complete frustration over their inability to recognise
>     that there could be a problem that I am putting this into linux-next;
>     this is not something I want to do, but they leave me no other choice.
>     
>     If they are correct, then this patch will have no effect what so ever.
>     If I am correct, there will be warnings produced where a CPU DAI and
>     DMA/platform component shares the same struct device.
>     
>     Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
