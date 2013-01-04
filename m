From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 4 Jan 2013 21:08:20 +0100
Subject: [PATCH] ARM: tegra: add kexec support to defconfig
In-Reply-To: <50E5FBDE.90804@wwwdotorg.org>
References: <1357161141-26430-1-git-send-email-swarren@wwwdotorg.org>
 <20130103210541.GB4412@avionic-0098.adnet.avionic-design.de>
 <50E5F5A3.1060507@wwwdotorg.org>
 <20130103212903.GA27749@avionic-0098.adnet.avionic-design.de>
 <50E5FBDE.90804@wwwdotorg.org>
Message-ID: <20130104200820.GC4577@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 03, 2013 at 02:45:02PM -0700, Stephen Warren wrote:
> On 01/03/2013 02:29 PM, Thierry Reding wrote:
> > On Thu, Jan 03, 2013 at 02:18:27PM -0700, Stephen Warren wrote:
> >> On 01/03/2013 02:05 PM, Thierry Reding wrote:
> >>> On Wed, Jan 02, 2013 at 02:12:21PM -0700, Stephen Warren
> >>> wrote:
> >>>> From: Stephen Warren <swarren@nvidia.com>
> >>>> 
> >>>> Signed-off-by: Stephen Warren <swarren@nvidia.com> --- 
> >>>> arch/arm/configs/tegra_defconfig |    1 + 1 file changed, 1 
> >>>> insertion(+)
> >>>> 
> >>>> diff --git a/arch/arm/configs/tegra_defconfig 
> >>>> b/arch/arm/configs/tegra_defconfig index 742dc41..e621603
> >>>> 100644 --- a/arch/arm/configs/tegra_defconfig +++ 
> >>>> b/arch/arm/configs/tegra_defconfig @@ -34,6 +34,7 @@ 
> >>>> CONFIG_AEABI=y CONFIG_HIGHMEM=y CONFIG_ZBOOT_ROM_TEXT=0x0 
> >>>> CONFIG_ZBOOT_ROM_BSS=0x0 +CONFIG_KEXEC=y CONFIG_CPU_FREQ=y 
> >>>> CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y CONFIG_CPU_IDLE=y
> >>> 
> >>> Interesting. What do you plan to use this for? kdump?
> >> 
> >> I plan to burn a kernel (and a small stub, and a DTB) into flash 
> >> instead of U-Boot, and hence not have to rely on any bootloader.
> > 
> > Why does that require kexec support?
> 
> Because I'd be using that kernel plus an initrd to download the "real"
> kernel over e.g. TFTP and kexec it.

Right, that makes sense. Thanks for explaining.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130104/395cb0d5/attachment.sig>
