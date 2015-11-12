From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 12 Nov 2015 10:21:51 +0100
Subject: [PATCH v8 10/17] phy: Add driver for rockchip Display Port PHY
In-Reply-To: <5643FB43.6090408@rock-chips.com>
References: <1446020143-32645-1-git-send-email-ykk@rock-chips.com>
 <2368662.QeV0VQYq26@phil> <5643FB43.6090408@rock-chips.com>
Message-ID: <1942026.CO9sWmi7sq@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yakir,

Am Donnerstag, 12. November 2015, 10:36:51 schrieb Yakir Yang:
> On 11/12/2015 07:23 AM, Heiko Stuebner wrote:
> > Am Mittwoch, 28. Oktober 2015, 16:30:33 schrieb Yakir Yang:
> >> Add phy driver for the Rockchip DisplayPort PHY module. This
> >> is required to get DisplayPort working in Rockchip SoCs.
> >>
> >> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> >> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> > a general thing I have been pondering, we should probably move the
> > dp-phy under the GRF. Similar to the new power-domains being
> > a full child of the PMU, the dp-phy is a full child-device of the GRF.
> >
> > That would include:
> > - making the GRF a simply-mfd (just adding that property)
> > - moving the dts node under it
> > - making the driver get its regmap from its parent (just like
> >    drivers/soc/rockchip/pm_domains.c does)
> >
> >
> > The usbphy is another example of that, and I think I'll be moving it
> > below the grf as well.
> 
> Sounds great, pretty cool to collect those scattered "GRF" driver,
> if you want me do some rebase on your changes, please note me :)

nope, that won't be necessary ... I'm currently doing some usbphy
reorganization/cleanups for 4.5 first, so to keep conflicts down I'll do
the move probably for 4.6. As I expect your edp series to make it into
4.5 we'll also not have conflicts here then :-)


Heiko
