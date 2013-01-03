From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 03 Jan 2013 14:16:41 -0700
Subject: [PATCH 0/9] ARM: Initial support for Tegra 114 SoC.
In-Reply-To: <20130103210036.GA4412@avionic-0098.adnet.avionic-design.de>
References: <1355996654-6579-1-git-send-email-hdoyu@nvidia.com>
 <20130103210036.GA4412@avionic-0098.adnet.avionic-design.de>
Message-ID: <50E5F539.8060600@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/2013 02:00 PM, Thierry Reding wrote:
> On Thu, Dec 20, 2012 at 11:43:58AM +0200, Hiroshi Doyu wrote:
>> Hi,
>> 
>> This patchset adds initial support for the NVIDIA's new Tegra
>> 114 SoC (T114) based on the ARM Cortex-A15 MP. It has the minimal
>> support to allow the kernel to boot up into shell console. This
>> can be used as a basis for adding other device drivers for this
>> SoC. Currently there are 2 evaluation boards available, "Dalmore"
>> and "Pluto".
>> 
>> This patchset is against Stephen Warren's linux-next_common
>> branch:
>> 
>> git://nv-tegra.nvidia.com/user/swarren/linux-2.6
>> linux-next_common
>> 
>> For those who want to try:
>> 
>> $ make ARCH=arm tegra_defconfig $ scripts/config -e
>> ARCH_TEGRA_114_SOC -d DRM -d SUSPEND \ -d PM_RUNTIME -d CPU_FREQ
>> -d CPU_IDLE
> 
> I wonder, what's the reason for disabling DRM? And while on the
> topic, are there any plans to release a Tegra114 TRM?

AFAIK, the HW is basically compatible with previous chips, so I expect
to see a DRM driver for it show up once all the various more basic
devices are supported.
