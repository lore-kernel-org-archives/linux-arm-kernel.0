From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 20 Dec 2011 15:03:02 +0000
Subject: [PATCH 17/20] ARM: mach-s3c64xx: properly disable CPU idle call
In-Reply-To: <1324288069-21940-18-git-send-email-nico@fluxnic.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
 <1324288069-21940-18-git-send-email-nico@fluxnic.net>
Message-ID: <20111220150302.GE29727@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 04:47:46AM -0500, Nicolas Pitre wrote:

>  void __init s3c64xx_init_io(struct map_desc *mach_desc, int size)
>  {
> +	disable_hlt();  /* idle WFI usage needs to be confirmed */
> +

I'm not sure what the intention of the comment is but the CPU can use
WFI to idle (I've got a cpuidle driver which I've posted which does the
basics and some more updates in the pipeline).
