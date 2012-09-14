From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 14 Sep 2012 22:18:10 +0400
Subject: [PATCH v4 12/24] xen/arm: introduce CONFIG_XEN on ARM
In-Reply-To: <1347621207-11294-12-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1209141145150.29232@kaball.uk.xensource.com>
 <1347621207-11294-12-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <505374E2.5080308@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 09/14/2012 03:13 PM, Stefano Stabellini wrote:

> Changes in v2:

> - mark Xen guest support on ARM as EXPERIMENTAL.

> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  arch/arm/Kconfig |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 2f88d8d..e92518d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1897,6 +1897,16 @@ config DEPRECATED_PARAM_STRUCT
>  	  This was deprecated in 2001 and announced to live on for 5 years.
>  	  Some old boot loaders still use this way.
>  
> +config XEN_DOM0
> +	def_bool y
> +
> +config XEN
> +	bool "Xen guest support on ARM (EXPERIMENTAL)"
> +	depends on EXPERIMENTAL && ARM && OF
> +	select XEN_DOM0

   What's the point of selecting it if it's always "y"?

WBR, Sergei
