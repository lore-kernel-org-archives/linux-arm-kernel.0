From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Fri, 16 Mar 2012 16:22:44 +0800
Subject: [PATCH v1 1/5] ARM: imx28: add basic dt support
In-Reply-To: <20322.61501.432329.124466@ipc1.ka-ro>
References: <1331628428-24017-2-git-send-email-b29396@freescale.com>
 <20120313172351.97C5E3E053B@localhost>
 <20120314124512.GG1180@shlinux2.ap.freescale.net>
 <20120314141643.GP3852@pengutronix.de>
 <20120315030206.GB13022@shlinux2.ap.freescale.net>
 <20321.37353.63115.664975@ipc1.ka-ro>
 <20120315105927.GE13022@shlinux2.ap.freescale.net>
 <20321.53468.310199.875966@ipc1.ka-ro>
 <20120316030134.GA5161@shlinux2.ap.freescale.net>
 <20322.61501.432329.124466@ipc1.ka-ro>
Message-ID: <20120316082243.GA13065@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2012 at 03:48:13PM +0800, Lothar Wa?mann wrote:
> Hi,
> 
> Dong Aisheng writes:
> > On Thu, Mar 15, 2012 at 07:22:04PM +0800, Lothar Wa?mann wrote:
> [...]
> > My proposal is only set the fixed part(first two octets) in board dts file,
> > each board knows it's value, and read the left 4 octets from OCOTP dynamically.
> >
> The OUI part is three bytes, not two! But anyway, since there is no
> definition on how the MAC has to be stored in OCOTP there is no way
> for the driver to know how to interpret the data it may read from
> there.
> 
I may miss this, i will double check it.
Thanks for the info. :-)

> > > Anyway there is no definite spec how the MAC address(es) are stored
> > > in the fuse map. Thus reading the MAC from there is more or less
> > > platform specific.
> > > 
> > It's just provide one more option since there are customers storing the MAC
> > in the fuse map.
> > 
> How would the driver know, whether and how the customer has stored the
> MAC address in OCOTP? E.g. on our TX28 modules the FULL MAC is stored
> in the CUSTOM registers in OCOTP.
> 
> > > Currently I'm setting up the MAC address for our TX28 from the fuses
> > > in the platform code passed via platform_data, but that will obviously
> > > not work with DT.
> > > 
> > Non-dt can also use my proposal, then you only need to pass the fixed part of
> > MAC via platfrom data, the left will be read by fec driver.
> > 
> Reading the MAC from fuses is platform sepcific. The driver cannot
> know how the MAC is stored there and needs to rely on platform
> specific code to do this.
> 
> > > The correct way would probably be to pass the MAC from the bootloader
> > > via a DT blob. But that would require all bootloaders to be updated
> > > first to support DTS. :(
> > > 
> > But uboot will face the same problem that can not define a valid MAC
> > in dts, did i undertand correctly?
> > 
> That's why I said "would require all bootloaders to be updated first
> to support DTS".

Regards
Dong Aisheng
