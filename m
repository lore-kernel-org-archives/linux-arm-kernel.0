From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 16 Jul 2012 14:37:14 +0200
Subject: [PATCHv3] I2C: MV64XXX: Add Device Tree support
In-Reply-To: <20120716142019.3f6cdc26@skate>
References: <1342430205-13702-1-git-send-email-andrew@lunn.ch>
 <1342430205-13702-2-git-send-email-andrew@lunn.ch>
 <20120716142019.3f6cdc26@skate>
Message-ID: <20120716123714.GG2489@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2012 at 02:20:19PM +0200, Thomas Petazzoni wrote:
> Le Mon, 16 Jul 2012 11:16:45 +0200,
> Andrew Lunn <andrew@lunn.ch> a ??crit :
> 
> > + - reg             : Offset and length of the register set for the device
> > + - compatible      : Should be "marvell,mv64xxx-i2c"
> > + - interrupts      : Te interrupt number
> 
>                         The
> 
> > +		i2c at 11000 {
> > +			compatible = "marvell,mv64xxx-i2c";
> > +			reg = <0x11000 0x20>;
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			interrupts = <29>;
> > +			clock-frequency = <400000>;
> > +			timeout-ms = <1000>;
> > +			status = "disable";
> 
> This should be "disabled".

Thanks.

> The #ifdef machinery in the ->probe() function looks a bit ugly, but I
> guess this can be cleaned up once all platforms using this driver will
> have been converted to DT + clock framework.

Yes, it is ugly :-(

The ARM platforms are moving in the right direction. They all have
clock framework support and only mv78xx0 has nobody working on DT, as
far as i know.

I've no idea if anybody is still working on the powerpc platforms.
There are two _defconfig files that use it.

     Andrew
