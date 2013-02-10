From: marvin24@gmx.de (Marc Dietrich)
Date: Sun, 10 Feb 2013 22:16:14 +0100
Subject: [PATCH 1/4] ARM: tegra: Unify tegra{20,30,114}_init_early()
In-Reply-To: <51180121.6040803@wwwdotorg.org>
References: <1360308574-19658-1-git-send-email-hdoyu@nvidia.com>
 <2499199.srlLvkihNZ@ax5200p> <51180121.6040803@wwwdotorg.org>
Message-ID: <1828614.u7HcYf891a@ax5200p>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 10 February 2013 13:20:49 Stephen Warren wrote:
> 1On 02/10/2013 10:28 AM, Marc Dietrich wrote:
> > On Friday 08 February 2013 10:09:10 Stephen Warren wrote:
> >> On 02/08/2013 05:29 AM, Marc Dietrich wrote:
> >>> Hiroshi,
> >>> 
> >>> Am Freitag, 8. Februar 2013, 09:29:31 schrieb Hiroshi Doyu:
> >>>> Refactored tegra{20,30,114}_init_early() so that we have the unified
> >>>> tegra_init_early().
> 
> ...
> 
> >>> are these ifdefs really needed? Multisoc kernels will enable them all
> >>> anyway and there is a case structure which protects the assignments.
> >>> Also
> >>> the hotplug functions are very tiny, so there shouldn't be a big loss.
> >> 
> >> The files that contain/implement those functions are separate for each
> >> SoC and only included in the build when the individual SoCs are enabled.
> >> 
> >> While multi-platform SoCs do make sense for distros, we also very
> >> specifically want to support the case where only Tegra, and only a
> >> single Tegra SoC, is enabled, hence this separation.
> > 
> > Huh? so tegra_defconfig is not supported?
> > 
> > grep "TEGRA_.*_SOC" tegra_defconfig:
> > 
> > CONFIG_ARCH_TEGRA_2x_SOC=y
> > CONFIG_ARCH_TEGRA_3x_SOC=y
> 
> I don't understand the question.
> 
> But to be clear. There are now 3 variants of Tegra supported. (Tegra20,
> Tegra30, Tegra114). We want to be able to build a minimal-size kernel
> (e.g. for embedded applications) that supports just one, any combination
> of two, or all three Tegra variants.

ah, ok - I just skipped the "also" in your sentence above. But still, the 
#ifdefs look strange to me and save only a few byte of code. Just me few 
cents.

Marc
