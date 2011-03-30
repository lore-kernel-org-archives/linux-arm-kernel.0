From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 30 Mar 2011 11:12:10 +0200
Subject: [PATCH v2 1/1] ARM: imx: add gpu device
In-Reply-To: <AANLkTimGUvNra0igyUGRJrzj5y3SwYFt4WEGKrLxd88-@mail.gmail.com>
References: <1301465128-401-1-git-send-email-richard.zhao@freescale.com>
	<20110330071658.GQ30938@pengutronix.de>
	<20110330081625.GB3195@b20223-02.ap.freescale.net>
	<AANLkTimGUvNra0igyUGRJrzj5y3SwYFt4WEGKrLxd88-@mail.gmail.com>
Message-ID: <20110330091210.GA19394@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Mar 30, 2011 at 05:03:45PM +0800, Eric Miao wrote:
> >> > @@ -203,6 +205,7 @@ static void __init mx35_3ds_init(void)
> >> > ? ? ? ? ? ? pr_warn("Init of the debugboard failed, all "
> >> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? "devices on the debugboard are unusable.\n");
> >> > ? ? imx35_add_imx_i2c0(&mx35_3ds_i2c0_data);
> >> > + ? imx35_add_mxc_gpu(&z160_revision);
> >> Do you really need to pass this by pointer? Wouldn't
> >> imx35_add_mxc_gpu(0) be good enough?
> > It's because sometimes z160_revision has different values with different
> > TO versions and z160_revision will be dup as plat data.
Yeah, I got that. I just meant how imx_add_mxc_gpu works. Just let it
take a int (instead of an int *) and pass the address of the local
parameter to imx_add_platform_device_dmamask.
 
> This is where platform_device_id comes into play, at least by registering
> device with different names, e.g. 'imx35-gpu' or 'imx51-gpu', and the
> driver can handle.
> 
> Difference between steppings is a bit tricky though, I think a QUIRK_
> way, and pass combined QUIRK_* flags will be better in imx35_add_mxc_gpu()
> function itself.
... or that

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
