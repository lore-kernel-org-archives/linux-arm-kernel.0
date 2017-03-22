From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 22 Mar 2017 14:09:26 -0700
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select SMSC_PHY
In-Reply-To: <82d0aeeaed87ae5c9390b889cef4c54d715cde61.1490191972.git.leonard.crestez@nxp.com>
References: <82d0aeeaed87ae5c9390b889cef4c54d715cde61.1490191972.git.leonard.crestez@nxp.com>
Message-ID: <5b1b4048-0499-313b-eaeb-167c6e6d50ae@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/22/2017 07:27 AM, Leonard Crestez wrote:
> The imx6sl-evk board has a LAN8720A ethernet phy supported by SMSC_PHY.
> Add this driver to the default imx config since the device is present on
> one of the evaluation boards.
> 
> This used to work mostly fine with the generic phy driver but since
> commit 0878fff1f42c18e448ab5b8b4f6a3eb32365b5b6 that driver no longer
> performs a soft reset on startup. This causes netboot to sometimes
> timeout on DHCP because RX doesn't work right. DHCP is eventually retried and
> it works the second time but it takes 90+ seconds to get a login prompt.
> 
> This was generated with "make savedefconfig" and it includes a few
> additional minor cleanups.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
