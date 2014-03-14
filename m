From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 14 Mar 2014 09:06:47 +0100
Subject: [PATCH 3/3] spi: psdev: add passive serial driver
In-Reply-To: <1394639617-26917-4-git-send-email-m.grzeschik@pengutronix.de>
References: <1394639617-26917-1-git-send-email-m.grzeschik@pengutronix.de>
 <1394639617-26917-4-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <20140314090647.55da971e@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Michael Grzeschik wrote:
> This patch introduces the psdev driver. It is used to communicate to an
> Altera passive serial connected FPGA by writing into an character
> device.
> 
> It simply initates the protocol on open and clocks the data into the
> FPGA by using the underlying SPI bus on write. The used SPI bus can also
> be an bitbang SPI bus. On close it will check for the response of the
> FPGA and tells if the write process was successful.
> 
[...]
+/*-------------------------------------------------------------------------*/
> +#ifdef CONFIG_OF
> +
> +static const struct of_device_id psdev_dt_ids[] = {
> +	{ .compatible = "altr,passive-serial" },
> +	{},
          ^
<nit>
Since '{}' always must be the last entry in the initializer list,
the comma doesn't make sense here.
Omitting it would cause entries added after it (e.g. due to a bad merge
conflict resolution) to generate a compile error.
</nit>


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
