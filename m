From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 3 Nov 2011 18:56:20 +0100
Subject: [PATCH 1/2] atmel/spi: fix missing probe
In-Reply-To: <4EB2D467.7050901@gmail.com>
References: <1320342082-18573-1-git-send-email-plagnioj@jcrosoft.com>
	<4EB2D467.7050901@gmail.com>
Message-ID: <20111103175620.GM7136@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18:50 Thu 03 Nov     , Daniel Mack wrote:
> On 11/03/2011 06:41 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >Commit 940ab889 "drivercore: Add helper macro for platform_driver boilerplate"
> >converted this driver to use module_platform_driver, but due to the use
> >of platform_driver_probe(), this resulted in the call to atmel_spi_probe being
> >lost. Place the call to this function into the driver structure.
> >
> >Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD<plagnioj@jcrosoft.com>
> >Cc: Greg Kroah-Hartman<gregkh@suse.de>
> >Cc: Grant Likely<grant.likely@secretlab.ca>
> >Cc: Russell King - ARM Linux<linux@arm.linux.org.uk>
> >---
> >v3:
> >
> >	update commit message
> >  drivers/spi/spi-atmel.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> >diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> >index 79665e2..3cd4f49 100644
> >--- a/drivers/spi/spi-atmel.c
> >+++ b/drivers/spi/spi-atmel.c
> >@@ -1072,6 +1072,7 @@ static struct platform_driver atmel_spi_driver = {
> >  	},
> >  	.suspend	= atmel_spi_suspend,
> >  	.resume		= atmel_spi_resume,
> >+	.prove		= atmel_spi_probe,
>          ^^^^^
> 
> This is certainly a typo. Didn't you even compile-test this?
I did I make the typo when editing the commit message before sending the
patch
Dame

Best Regards,
J.
