From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 30 Mar 2017 21:22:24 +0800
Subject: [PATCH v2] ARM: imx_v6_v7_defconfig: Select SMSC_PHY
In-Reply-To: <0d4ff89ce2276dfbde2db8ced3fff10582a5b899.1490783707.git.leonard.crestez@nxp.com>
References: <0d4ff89ce2276dfbde2db8ced3fff10582a5b899.1490783707.git.leonard.crestez@nxp.com>
Message-ID: <20170330132222.GF683@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 01:48:02PM +0300, Leonard Crestez wrote:
> The imx6sl-evk board has a LAN8720A ethernet phy supported by SMSC_PHY.
> Add this driver to the default imx config since the device is present on
> one of the evaluation boards.
> 
> This used to work mostly fine with the generic phy driver until
> commit 0878fff1f42c ("net: phy: Do not perform software reset for
> Generic PHY"). The fact that soft reset is no longer performed
> apparently causes RX to sometimes failes which can cause netboot to
> timeout on DHCP. This is eventually retried and it works after link
> up/down but can takes 90 seconds to reach the login prompt.
> 
> This was generated with "make savedefconfig" and it includes a few
> additional minor cleanups.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Acked-by: Fugang Duan <fugang.duan@nxp.com>

Applied, thanks.
