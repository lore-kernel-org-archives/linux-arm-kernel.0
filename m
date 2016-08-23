From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Aug 2016 12:04:00 +0200
Subject: [PATCH 1/5] arm64: dts: add QorIQ LS1046A SoC support
In-Reply-To: <DB5PR0401MB21834BD67F0EA86B3A22E9D6E8150@DB5PR0401MB2183.eurprd04.prod.outlook.com>
References: <1467972944-12293-1-git-send-email-shh.xie@gmail.com>
 <1984740.gmAYAJ1bIT@wuerfel>
 <DB5PR0401MB21834BD67F0EA86B3A22E9D6E8150@DB5PR0401MB2183.eurprd04.prod.outlook.com>
Message-ID: <2061455.WN6nWWqTiZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, August 18, 2016 10:27:36 AM CEST Shaohui Xie wrote:
> Hello Arnd,
> 
> Thank you for reviewing!
> 
> I'm seriously Sorry for the late response! I was on business travel on a project and had been very busy for a  long time.

No worries.

> > -----Original Message-----
> > From: Arnd Bergmann [mailto:arnd at arndb.de]
> > Sent: Friday, July 08, 2016 8:00 PM
> > On Friday, July 8, 2016 6:15:40 PM CEST shh.xie at gmail.com wrote:
> > > +
> > > +   memory at 80000000 {
> > > +           device_type = "memory";
> > > +           reg = <0x0 0x80000000 0 0x80000000>;
> > > +                 /* DRAM space 1, size: 2GiB DRAM */
> > > +   };
> > 
> > The memory size is usually in the .dts file, unless this is on-chip eDRAM.
> [S.H] The memory size will be fixup by U-boot, if it's not proper to have it in .dtsti,
> How about remove it?
> 

Sounds fine to me. A lot of board specific files have a memory node
regardless of the override, but I don't see a reason to require it.

	Arnd
