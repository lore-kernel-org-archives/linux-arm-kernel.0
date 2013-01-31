From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 31 Jan 2013 21:59:47 +0530
Subject: OMAP4 PM bootloader dependency problems
In-Reply-To: <alpine.DEB.2.00.1301311537530.23099@utopia.booyaka.com>
References: <alpine.DEB.2.00.1301220229140.25789@utopia.booyaka.com>
 <alpine.DEB.2.00.1301301706580.17105@utopia.booyaka.com>
 <1359622829.10415.40.camel@sokoban> <510A54F8.4090609@ti.com>
 <alpine.DEB.2.00.1301311537530.23099@utopia.booyaka.com>
Message-ID: <510A9BFB.5070802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 31 January 2013 09:10 PM, Paul Walmsley wrote:
> Hi,
>
> On Thu, 31 Jan 2013, Rajendra Nayak wrote:
>
>> Throw a pr_warn() at boot only when CONFIG_CPU_IDLE is enabled. Note
>> that it isn't enabled by default in omap2plus_defconfig. Also
>> throw one when a suspend fails, saying bootloader *could be* a possible
>> cause specifying the right version to be used.
>
> In my view, these steps aren't sufficient, for the reasons described in
>
> http://marc.info/?l=linux-omap&m=135964568904053&w=2
>
> Even with CONFIG_CPU_IDLE=n, it's still possible to attempt to enter
> full-chip retention idle on OMAP4 via 'echo mem > /sys/power/state', so it
> doesn't seem right to restrict a solution to that case.
>

I think rajendra also mentioned adding one in suspend path too
when it fails.
" Also throw one when a suspend fails, saying bootloader
*could be* a possible cause specifying the right version to be used."

I find Rajendra's suggestion reasonable because some one might
just miss the boot message but getting the message on failure
case cant' be missed.

Regards
Santosh
