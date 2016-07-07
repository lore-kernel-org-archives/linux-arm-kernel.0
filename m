From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 07 Jul 2016 09:22:43 +0200
Subject: [PATCH v4 4/5] soc: Add SoC driver for Freescale Vybrid platform
In-Reply-To: <f600ac1c747813b26c80149b6fdf32d42b114235.1467872014.git.maitysanchayan@gmail.com>
References: <cover.1467872014.git.maitysanchayan@gmail.com>
 <f600ac1c747813b26c80149b6fdf32d42b114235.1467872014.git.maitysanchayan@gmail.com>
Message-ID: <5371423.yp5pHjKp9V@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 7, 2016 12:09:29 PM CEST Sanchayan Maity wrote:
> root at colibri-vf:/sys/bus/soc/devices/soc0# cat family
> Freescale Vybrid VF610
> root at colibri-vf:/sys/bus/soc/devices/soc0# cat machine
> Freescale Vybrid
> 

I only have one very high-level comment: I think that "family"
is generally supposed to be the more generic one than "machine",
so maybe swap the contents of the two?

Can you have a look at the other users of soc_device and see how
they handle it? I realize that we are already inconsistent about
how we handle it, just try to make it do what the majority of the
others have.

Aside from that, it all looks reasonable.

	Arnd
