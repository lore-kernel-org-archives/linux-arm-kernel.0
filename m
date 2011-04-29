From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 29 Apr 2011 22:12:37 +0200
Subject: [PATCH 8/9] ARM: zImage: remove the static qualifier from global
	data variables
In-Reply-To: <1304031024-5121-9-git-send-email-nico@fluxnic.net>
References: <1304031024-5121-1-git-send-email-nico@fluxnic.net>
	<1304031024-5121-9-git-send-email-nico@fluxnic.net>
Message-ID: <20110429201237.GZ31131@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2011 at 06:50:23PM -0400, Nicolas Pitre wrote:
> From: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> To be able to relocate the .bss section at run time independently from
> the rest of the code, we must make sure that no GOTOFF relocations are
> used with .bss symbols.  This usually means that no global variables can
> be marked static unless they're also const.
> 
> Let's remove the static qualifier from current offenders, or turn them
> into const variables when possible.  Next commit will ensure the build
> fails if one of those is reintroduced due to otherwise enforced coding
> standards for the kernel.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> ---
>  arch/arm/mach-davinci/include/mach/uncompress.h |    5 +++--
>  arch/arm/mach-gemini/include/mach/uncompress.h  |    2 +-
>  arch/arm/mach-iop32x/include/mach/uncompress.h  |    2 +-
>  arch/arm/mach-iop33x/include/mach/uncompress.h  |    2 +-
>  arch/arm/mach-ixp4xx/include/mach/uncompress.h  |    2 +-
>  arch/arm/mach-mmp/include/mach/uncompress.h     |    2 +-
>  arch/arm/mach-mxs/include/mach/uncompress.h     |    2 +-
>  arch/arm/mach-ns9xxx/include/mach/uncompress.h  |    2 +-
mach-ns9xxx is about to be removed. So maybe just drop the corresponding
hunk.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
