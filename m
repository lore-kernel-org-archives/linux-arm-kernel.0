From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Feb 2013 10:52:33 +0000
Subject: [PATCH 2/2] dmaengine: OMAP: Register SDMA controller with
 Device Tree DMA driver
In-Reply-To: <1360184596-1603-3-git-send-email-jon-hunter@ti.com>
References: <1360184596-1603-1-git-send-email-jon-hunter@ti.com>
 <1360184596-1603-3-git-send-email-jon-hunter@ti.com>
Message-ID: <20130209105233.GI17852@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 06, 2013 at 03:03:16PM -0600, Jon Hunter wrote:
> @@ -673,7 +702,7 @@ static int omap_dma_init(void)
>  {
>  	int rc = platform_driver_register(&omap_dma_driver);
>  
> -	if (rc == 0) {
> +	if ((rc == 0) && (!of_have_populated_dt())) {

Looks good, the worst I can find is this over-use of parens...
