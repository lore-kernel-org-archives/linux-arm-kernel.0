From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Thu, 22 Jan 2015 10:53:13 -0600
Subject: [PATCH 2/2] remoteproc: microblaze: Add support for microblaze
 on Zynq
In-Reply-To: <10276362c737fc9da863f1a07737fd91f7340242.1421662385.git.michal.simek@xilinx.com>
References: <a458462d2dc6901440bded015608f7a9df9e7942.1421662385.git.michal.simek@xilinx.com>
 <10276362c737fc9da863f1a07737fd91f7340242.1421662385.git.michal.simek@xilinx.com>
Message-ID: <54C12AF9.40200@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/19/2015 04:30 AM, Michal Simek wrote:
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 5e343bab9458..3955f42e9e9c 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -64,4 +64,15 @@ config DA8XX_REMOTEPROC
>  	  It's safe to say n here if you're not interested in multimedia
>  	  offloading.
> 
> +config MB_REMOTEPROC
> +	tristate "Support Microblaze remoteproc"
> +	depends on ARCH_ZYNQ && !DEBUG_SG
> +	select GPIO_XILINX
> +	select REMOTEPROC
> +	select RPMSG
> +	default m
> +	help
> +	  Say y here to support Xilinx Microblaze remote processors
> +	  on the Xilinx Zynq.
> +
>  endmenu

The dependency on !DEBUG_SG seems unusual, and worth a comment if it's
truly needed.  And the module should be disabled by default, no?
