From: josephl@nvidia.com (Joseph Lo)
Date: Sat, 23 Feb 2013 12:06:20 +0800
Subject: [PATCH 3/3] ARM: tegra: refactor tegra{20,30}_boot_secondary
In-Reply-To: <5127B8CC.3030808@wwwdotorg.org>
References: <1361514267-12111-1-git-send-email-josephl@nvidia.com>
 <1361514267-12111-3-git-send-email-josephl@nvidia.com>
 <5127B8CC.3030808@wwwdotorg.org>
Message-ID: <1361592380.1804.20.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2013-02-23 at 02:28 +0800, Stephen Warren wrote:
> On 02/21/2013 11:24 PM, Joseph Lo wrote:
> > From: Hiroshi Doyu <hdoyu@nvidia.com>
> > 
> > "tegra_boot_secondary()" has many condition branches for some Tegra
> > SoC generations in a single function so that it's not easy to compile
> > a kernel only for a single SoC if one wants with some reason, debug
> > purpose(?). This patch provides SoC specific version of
> > boot_secondary(), tegra{20,30}_boot_secondary(). This could allow
> > any combination of SoC to be built. Those boot_secondary functions can
> > be preparation when we ntroduce chip specific function pointers in the
> > future without having chip dependent branches around.
> > 
> > Also removed unused definition/prototpye.
> 
> That "also" is really something that should be a separate patch, since
> it's not related to the code refactoring that's the main purpose of this
> patch.
> 
> However, I'll let it slide this time, since I think both patches would
> just end up in Tegra's cleanup branch anyway, even though I did already
> point this out (multiple times?) during downstream review:-( You're
> getting lucky because I don't feel like reviewing this again.
> 
> I'll apply this series once I can apply patches for 3.10.
> 
> One note to anyone else reading this patch: It does look like this is
> duplicating code that was previously nicely shared in
> tegra_boot_secondary(). However, I believe it's appropriate to do this
> in this case, since the equivalent code for future SoCs (such as
> Tegra114) is extremely different, and so the current shared code won't
> end up being shared, and this would just make tegra_boot_secondary()
> over-complex with conditionals when adding Tegra114 support.

Hiroshi,

Per Stephen's comment, should we drop this patch? And refactoring this
later when I add support for Tegra114 CPU PM function.

How do you think? If no, I found a redundant blank line in this patch
that need a V2 to fix.

Thanks,
Joseph
