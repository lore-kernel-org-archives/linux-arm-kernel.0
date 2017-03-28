From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 28 Mar 2017 14:16:50 +0300
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select SMSC_PHY
In-Reply-To: <20170324064318.GD12604@b29396-OptiPlex-7040>
References: <82d0aeeaed87ae5c9390b889cef4c54d715cde61.1490191972.git.leonard.crestez@nxp.com>
 <20170324064318.GD12604@b29396-OptiPlex-7040>
Message-ID: <1490699810.3546.10.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-03-24 at 14:43 +0800, Dong Aisheng wrote:
> Hi Leonard,
> 
> On Wed, Mar 22, 2017 at 04:27:37PM +0200, Leonard Crestez wrote:
> > 
> > The imx6sl-evk board has a LAN8720A ethernet phy supported by SMSC_PHY.
> > Add this driver to the default imx config since the device is present on
> > one of the evaluation boards.
> Upstream currently no evaluation board support.
> 
> This may leave to Shawn to decide whether apply it.

Really? But the dts for this eval board is included in upstream. Shouldn't the
default config try to work with the default imx*.dts files included?

> > This used to work mostly fine with the generic phy driver but since
> > commit 0878fff1f42c18e448ab5b8b4f6a3eb32365b5b6 that driver no longer
> I guess you should get a checkpatch error here.

Because I didn't reference that other commit right? Sorry about this.

Should I submit again with an improved commit message?

> > performs a soft reset on startup. This causes netboot to sometimes
> > timeout on DHCP because RX doesn't work right. DHCP is eventually retried
> > and
> Probably another checkpatch warning.

Why, line too long?

> > This was generated with "make savedefconfig" and it includes a few
> > additional minor cleanups.
> > 
> It is a bit strange, after apply your patch, i still get a lot difference
> as follows when savedefconfig:
>?
> I don't know what's wrong. Toolchains difference?

Maybe, kconfig acts strangely sometimes. It's not clear option ordering is
guaranteed to be stable. I don't think it matters though.

--
Regards,
Leonard
