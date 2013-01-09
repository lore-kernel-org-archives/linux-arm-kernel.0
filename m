From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 Jan 2013 18:43:48 +0000
Subject: [PATCH] ARM: nommu: re-enable use of vexpress without
 ARCH_MULTIPLATFORM
In-Reply-To: <1357755328-17075-1-git-send-email-jonathan.austin@arm.com>
References: <1357755328-17075-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <201301091843.48942.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 January 2013, Jonathan Austin wrote:
> From: Will Deacon <will.deacon@arm.com>
> 
> Since 617276307cd4c ("ARM: vexpress: convert to multi-platform") it has
> been impossible to select ARCH_VEXPRESS without ARCH_MULTIPLATFORM.
> 
> ARCH_MULTIPLATFORM doesn't make sense for NOMMU targets, not least
> because of the need to hard-code the memory map. However, it should
> still be possible to run NOMMU kernels on top of the Versatile Express
> by selecting it as the only platform.
> 
> This patch creates a shim ARCH_VEXPRESS_NOMMU config option in the 'choice'
> for "ARM system type" to make this possible again.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
> CC: Nicolas Pitre <nico@fluxnic.net>
> CC: Arnd Bergmann <arnd@arndb.de>
> ---
> 
> Arnd and Nicolas: I've removed your acks as I've changed the location
> of the new block (as Nicolas suggested) and ever so slightly tweaked
> the name of the new option.

The patch is still good. Generally you can leave an Ack when doing
small changes but leaving the patch conceptually the same.

Acked-by: Arnd Bergmann <arnd@arndb.de>

On a related topic, I still think we should fix ARCH_MULTI_V7 not
to select ARCH_VEXPRESS unconditionally and come up with a better
way to avoid having an empty platform list to make 'allnoconfig'
still work.

	Arnd
