From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Aug 2018 14:10:08 +0200
Subject: [PATCH 11/15] soc: octeontx2: Add Marvell OcteonTX2 CGX driver
In-Reply-To: <1535453838-12154-12-git-send-email-sunil.kovvuri@gmail.com>
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-12-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <CAK8P3a0q0P-FuG6cTgMNkeZbtXE4pMk1iJq36_x20WRddtwaDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 12:58 PM <sunil.kovvuri@gmail.com> wrote:
>
> From: Sunil Goutham <sgoutham@marvell.com>
>
> This patch adds basic template for Marvell OcteonTX2's
> CGX ethernet interface driver. Just the probe.
> RVU AF driver will use APIs exported by this driver
> for various things like PF to physical interface mapping,
> loopback mode, interface stats etc.
>
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> ---
>  drivers/soc/marvell/Kconfig            |  10 +++
>  drivers/soc/marvell/octeontx2/Makefile |   2 +
>  drivers/soc/marvell/octeontx2/cgx.c    | 117 +++++++++++++++++++++++++++++++++
>  drivers/soc/marvell/octeontx2/cgx.h    |  20 ++++++

If this is a regular PCI ethernet driver, why do you put it into driver/soc
rather than drivers/net/ethernet/ ?

      Arnd
