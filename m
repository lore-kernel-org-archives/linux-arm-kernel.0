From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 12 Jul 2010 09:42:52 -0400 (EDT)
Subject: [RFC,
	PATCH 2/2] arm: use addruart macro to establish debug mappings
In-Reply-To: <1278903792.388155.428219242752.2.gpush@pororo>
References: <1278903792.388155.428219242752.2.gpush@pororo>
Message-ID: <alpine.LFD.2.00.1007120932510.10598@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Jul 2010, Jeremy Kerr wrote:

> Since we can call addruart with an argument to specify that we want a
> physical or virtual address, use addruart in the debug mapping code to
> find these addresses.
> 
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
> 
> ---
>  arch/arm/Kconfig.debug |    1 -
>  arch/arm/kernel/head.S |   15 ++++++++++++---
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index fbb094a..91344af 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -65,7 +65,6 @@ config DEBUG_STACK_USAGE
>  # These options are only for real kernel hackers who want to get their hands dirty.
>  config DEBUG_LL
>  	bool "Kernel low-level debugging functions"
> -	depends on !OF

Make sure you start a new topic branch for such features so to be sure 
it applies on top of a vanilla kernel independently.

BTW I'd like to see patch #3 of this series removing the now unused 
phys_io and io_pg_offst from struct machine_desc, and all corresponding 
initializations.


Nicolas
