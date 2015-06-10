From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 10 Jun 2015 10:05:53 +0200
Subject: [PATCH v6 5/6] i2c: at91: print hardware version
In-Reply-To: <5577428C.3090206@cogentembedded.com>
References: <cover.1433866582.git.cyrille.pitchen@atmel.com>
 <d1fbf4bce3b470409ef3198f551cfc3f8f22ac78.1433866582.git.cyrille.pitchen@atmel.com>
 <5577428C.3090206@cogentembedded.com>
Message-ID: <20150610080553.GO25800@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 09, 2015 at 10:46:20PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 06/09/2015 07:22 PM, Cyrille Pitchen wrote:
> 
> >The probe() function now prints the hardware version of the I2C
> >controller.
> 
> >Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> >---
> >  drivers/i2c/busses/i2c-at91.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> >diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> >index 817ae69..6e88b30 100644
> >--- a/drivers/i2c/busses/i2c-at91.c
> >+++ b/drivers/i2c/busses/i2c-at91.c
> [...]
> >@@ -908,7 +910,8 @@ static int at91_twi_probe(struct platform_device *pdev)
> >  		return rc;
> >  	}
> >
> >-	dev_info(dev->dev, "AT91 i2c bus driver.\n");
> >+	dev_info(dev->dev, "AT91 i2c bus driver (version: %#x).\n",
> 
>    It looks as if you rather print the driver's version. :-)

>From my point of view, having a version number for a Linux driver would
be strange so it's not confusing.

> 
> >+		 at91_twi_read(dev, AT91_TWI_VER));
> >  	return 0;
> >  }
> 
> WBR, Sergei
> 

Regards

Ludovic
