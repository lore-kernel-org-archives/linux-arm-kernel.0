From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 24 Jun 2013 09:19:10 -0600
Subject: [PATCH] ARM: tegra: fix section mismatch in tegra_pmc_parse_dt
In-Reply-To: <1372041600.12718.4.camel@jlo-ubuntu-64.nvidia.com>
References: <1371854347-12091-1-git-send-email-swarren@wwwdotorg.org>
 <1372041600.12718.4.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <51C8636E.1030707@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/23/2013 08:40 PM, Joseph Lo wrote:
> On Sat, 2013-06-22 at 06:39 +0800, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> tegra_pmc_parse_dt() references __initconst data. Fix it to be __init.
>> This matches its only usage; a call from tegra_pmc_init() which is
>> already __init. This fixes:
>>
>> WARNING: vmlinux.o(.text.unlikely+0x580): Section mismatch in reference
>> from the function tegra_pmc_parse_dt() to the (unknown reference)
>> .init.rodata:(unknown)
>>
> Hi Stephen,
> 
> Just curious, I don't see this warning message on my system. Does this
> cause by some other patch or something else?

The warning only shows up with CONFIG_DEBUG_SECTION_MISMATCH=y, which
isn't in tegra_defconfig.
