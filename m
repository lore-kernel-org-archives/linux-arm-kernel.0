From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 11 Jul 2011 15:35:25 +0800
Subject: [PATCH v2 1/7] spi/imx: do not make copy of spi_imx_devtype_data
In-Reply-To: <19994.41750.920408.162356@ipc1.ka-ro>
References: <1310231801-18761-1-git-send-email-shawn.guo@linaro.org>
	<1310231801-18761-2-git-send-email-shawn.guo@linaro.org>
	<19994.41750.920408.162356@ipc1.ka-ro>
Message-ID: <20110711073523.GA19105@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 09:15:34AM +0200, Lothar Wa?mann wrote:
> Hi,
> 
> Shawn Guo writes:
> > spi_imx_devtype_data has already been driver private data.  There is
> > really no need to make a copy in spi_imx_data.  Instead, a reference
> > pointer works perfectly fine.
> > 
> You obviously overlooked, that the copy is done on purpose to keep
> only the data that is actually needed and discard everything else
> after initialisation.
> 
I did not overlook that, as I removed __devinitdata there.

-- 
Regards,
Shawn
