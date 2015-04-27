From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Mon, 27 Apr 2015 19:34:05 +0200
Subject: Sahara performance on i.MX53
In-Reply-To: <553E6EE6.2050803@parkeon.com>
References: <553E6EE6.2050803@parkeon.com>
Message-ID: <20150427173405.GR19889@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Mon, Apr 27, 2015 at 07:16:22PM +0200, Martin Fuzzey wrote:
> Hi,
> 
> I've been trying the Sahara crypto module on i.MX53 [mainline 3.19
> kernel + b251638c46a (crypto: sahara - use the backlog)]
> 
> I tested using dm-crypt with AES-128:
> cryptsetup -v  --key-size=128 luksFormat /dev/mmcblk0p7
> cryptsetup luksOpen /dev/mmcblk0p7 cryptotest
> 
> dd if=/dev/mapper/cryptotest of=/dev/null bs=1M count=100
> 
> 
> CPU Freq (MHz)       Time (s) WITHOUT Sahara        Time (s) WITH Sahara
> 1200                          3.26         5.34
> 1000                          3.26         5.62
> 800                            4.0           6.24
> 400                            7.72         9.86
> 166                            18.42       18.87
> 
> I was hoping for something better.
> There is a reduction in CPU usage as expected but the performance
> figures aren't looking very good.
> As this is in kernel use by dm-crypt cryptodev or af_alg aren't involved.
> 
> Has anyone else done any measurements?
> 

Yes. My measurements wheren't overwhelming either. :-(
The problem with the Sahara is: NDAs. So, I am Jon Snow
and know nothing :-(

Everything I do know, is from the Freescale kernel git repo.
Maybe I missed something. The FSL driver is very cryptic if
you ask me; so it is absolutely possible.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
