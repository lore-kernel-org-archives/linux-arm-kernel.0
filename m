From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 31 May 2013 12:02:26 +0100
Subject: [PATCH RFC 6/6] arm64/xen: introduce CONFIG_XEN and hypercall.S
 on ARM64
In-Reply-To: <1369930713-6063-6-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1305301705500.4799@kaball.uk.xensource.com>
 <1369930713-6063-6-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20130531110225.GD18045@localhost.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 30, 2013 at 05:18:33PM +0100, Stefano Stabellini wrote:
> Introduce CONFIG_XEN and the implementation of hypercall.S (that is
> the only ARMv8 specific code in Xen support for ARM).
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> ---
>  arch/arm64/Kconfig         |   11 +++++
>  arch/arm64/Makefile        |    1 +
>  arch/arm64/xen/Makefile    |    1 +
>  arch/arm64/xen/hypercall.S |  105 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 118 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm64/xen/Makefile
>  create mode 100644 arch/arm64/xen/hypercall.S
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 56b3f6d..f35751f 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -182,6 +182,17 @@ config HW_PERF_EVENTS
>  
>  source "mm/Kconfig"
>  
> +config XEN_DOM0
> +	def_bool y
> +	depends on XEN
> +
> +config XEN
> +	bool "Xen guest support on ARM64 (EXPERIMENTAL)"
> +	depends on ARM64 && OF
> +	depends on !GENERIC_ATOMIC64

I don't think we need this depends on !GENERIC_ATOMIC64, we don't enable
it on arm64.

-- 
Catalin
