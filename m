From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 1 May 2018 20:15:19 +0530
Subject: =?UTF-8?Q?Re:_[PATCH_v9_00/27]_ARM:_davinci:_convert_to_common_cloc?=
 =?UTF-8?Q?k_framework=e2=80=8b?=
In-Reply-To: <20180427001745.4116-1-david@lechnology.com>
References: <20180427001745.4116-1-david@lechnology.com>
Message-ID: <1ea1b841-24da-e74a-50a8-98b0793e61a5@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 April 2018 05:47 AM, David Lechner wrote:
> This series converts mach-davinci to use the common clock framework.
> 
> The series works like this, the first 3 patches fix some issues with the clock
> drivers that have already been accepted into the mainline kernel.
> 
> Then, starting with "ARM: davinci: pass clock as parameter to
> davinci_timer_init()", we get the mach code ready for the switch by adding the
> code needed for the new clock drivers and adding #ifndef CONFIG_COMMON_CLK
> around the legacy clocks so that we can switch easily between the old and the
> new.
> 
> "ARM: davinci: switch to common clock framework" actually flips the switch
> to start using the new clock drivers. Then the next 8 patches remove all
> of the old clock code.
> 
> The final four patches add device tree clock support to the one SoC that
> supports it.
> 
> This series has been tested on TI OMAP-L138 LCDK (both device tree and legacy
> board file).

I have reviewed this series and looks good to me except some comments I
gave and some issues you have identified yourself in patches 25 and 26.

I think this is a good compromise to achieve platform device based
clocks as far as possible with current kernel framework. I know Bartosz
is working on solving the problem generically and I guess once thats
agreed upon, DaVinci can convert too.

But I think this series has been in the works for far too long and
should be merged (the remoteproc dependencies that Bartosz pointed out
should be resolved too). You can wait for clock maintainers opinion
though before spinning another version.

I have not tested this series yet, will do so soon.

Thanks,
Sekhar

PS: I started giving a Reviewed-by: for the mach-davinci patches before
realizing the futility of doing so and stopped mid-way. They will have
my sign-off anyway once I test and merge them.
