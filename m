From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Sep 2014 14:50:22 +0200
Subject: [PATCH v4 1/4] ethernet: arc: Add support for Rockchip SoC layer
 device tree bindings
In-Reply-To: <12261801.xhz3LcucGs@diego>
References: <1409740036-8117-1-git-send-email-romain.perier@gmail.com>
 <3774938.44qiV4hEoE@wuerfel> <12261801.xhz3LcucGs@diego>
Message-ID: <3545574.7Z5WmaTlg0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 September 2014 14:20:50 Heiko St?bner wrote:
> > 
> > One last question: is this the location given as .grf_offset the
> > only thing in grf that is potentially of concern to this driver?
> > 
> > If it is, you can change the binding to include the register number
> > in the syscon reference, like
> > 
> >       rockchip,grf = <&grf 0x154>;
> > 
> > and then read it from there, to simplify the code needed to get the
> > number from the device id.
> 
> I would disagree here 
> 
> Specific to the emac, there also exists a second register in the grf (0xa8 for 
> the rk3188) that contains a field 
> 
> ----
> emac_newrcv_en - the selection of RMII receive selection
> 0: don't support the data package without header
> 1: support the data package without header
> ----
> 
> which we don't handle currently but somebody might want to in the future.
> [There also is no documentation of this at all]

Ok, fair enough. If there is a chance that there would be more of these
fields that we may want to support in the future, the table approach
seems reasonable.

The main advantage of putting the register number into the syscon
reference is to support future models without driver changes, but
it's not clear if that's worth it.

	Arnd
