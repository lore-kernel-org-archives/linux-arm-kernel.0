From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Dec 2015 16:07:05 +0000
Subject: [PATCH 05/12] tty: amba-pl011: add register lookup table
In-Reply-To: <20151224155432.GI8644@n2100.arm.linux.org.uk>
References: <20151116173935.GQ8644@n2100.arm.linux.org.uk>
 <E1ZyNlS-0003jg-46@rmk-PC.arm.linux.org.uk>
 <20151224065437.GA18445@robwan01-pc.asiapac.arm.com>
 <CAOZdJXWmBYrjgC2GcY2NSeuJ2MAuwvtYVLP9AvTMkLUWsi9DhQ@mail.gmail.com>
 <20151224150552.GF8644@n2100.arm.linux.org.uk>
 <CAOZdJXXdMHG7c9yDTo+oh7uNPCmH_Mc08s5YCoL3j--7uj5Mow@mail.gmail.com>
 <20151224154027.GH8644@n2100.arm.linux.org.uk>
 <CAOZdJXWdbbxT7jQ1=xatnunNnzRqbECAtvw-cVhrJUKuUx-mVw@mail.gmail.com>
 <20151224155432.GI8644@n2100.arm.linux.org.uk>
Message-ID: <20151224160705.GJ8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 24, 2015 at 03:54:32PM +0000, Russell King - ARM Linux wrote:
> On Thu, Dec 24, 2015 at 09:50:16AM -0600, Timur Tabi wrote:
> > On Thu, Dec 24, 2015 at 9:40 AM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > >>         while (readl(port->membase + REG_FR) & UART01x_FR_TXFF)
> > >>
> > >> is broken because REG_FR is equal to 1.
> > >
> > > Patch 4, which changes to the REG_* stuff, does not (explicitly) touch
> > > this because it _will_ break stuff.
> > 
> > I'm just telling you what's in Greg's tty-next repository:
> > 
> > https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git/log/drivers/tty/serial/amba-pl011.c?h=tty-next
> > 
> > https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git/tree/drivers/tty/serial/amba-pl011.c?h=tty-next#n2302
> 
> I wonder where Greg got those patches from, because it's not _this_ patch
> set (I checked patch 4 from this posting before my previous reply.)

Based on just that, Greg seems to have picked up the old series from
November 3rd, not this series from November 16th...  So you have the
problems from the first series. :(

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
