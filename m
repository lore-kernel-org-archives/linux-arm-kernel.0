From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 03 Jan 2013 14:18:27 -0700
Subject: [PATCH] ARM: tegra: add kexec support to defconfig
In-Reply-To: <20130103210541.GB4412@avionic-0098.adnet.avionic-design.de>
References: <1357161141-26430-1-git-send-email-swarren@wwwdotorg.org>
 <20130103210541.GB4412@avionic-0098.adnet.avionic-design.de>
Message-ID: <50E5F5A3.1060507@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/2013 02:05 PM, Thierry Reding wrote:
> On Wed, Jan 02, 2013 at 02:12:21PM -0700, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>> 
>> Signed-off-by: Stephen Warren <swarren@nvidia.com> --- 
>> arch/arm/configs/tegra_defconfig |    1 + 1 file changed, 1
>> insertion(+)
>> 
>> diff --git a/arch/arm/configs/tegra_defconfig
>> b/arch/arm/configs/tegra_defconfig index 742dc41..e621603 100644 
>> --- a/arch/arm/configs/tegra_defconfig +++
>> b/arch/arm/configs/tegra_defconfig @@ -34,6 +34,7 @@
>> CONFIG_AEABI=y CONFIG_HIGHMEM=y CONFIG_ZBOOT_ROM_TEXT=0x0 
>> CONFIG_ZBOOT_ROM_BSS=0x0 +CONFIG_KEXEC=y CONFIG_CPU_FREQ=y 
>> CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y CONFIG_CPU_IDLE=y
> 
> Interesting. What do you plan to use this for? kdump?

I plan to burn a kernel (and a small stub, and a DTB) into flash
instead of U-Boot, and hence not have to rely on any bootloader.

Even ignoring that, a quick scp of a new kernel to a target followed
by a kexec is faster than rebooting all the way through U-Boot's
slower Ethernet support to boot a new kernel.
