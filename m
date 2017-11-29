From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 29 Nov 2017 21:56:29 +0100
Subject: [PATCH v2 2/2] ARM: dts: at91: disable the nxp,se97b SMBUS
 timeout on the TSE-850
In-Reply-To: <20171129205311.GA20551@roeck-us.net>
References: <20171127163101.27859-1-peda@axentia.se>
 <20171127163101.27859-3-peda@axentia.se>
 <20171129205311.GA20551@roeck-us.net>
Message-ID: <20171129205629.GO21126@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/11/2017 at 12:53:11 -0800, Guenter Roeck wrote:
> On Mon, Nov 27, 2017 at 05:31:01PM +0100, Peter Rosin wrote:
> > The I2C adapter driver is sometimes slow, causing the SCL line to
> > be stuck low for more than the stipulated SMBUS timeout of 25-35 ms.
> > This causes the client device to give up which in turn causes silent
> > corruption of data. So, disable the SMBUS timeout in the client device.
> > 
> > Signed-off-by: Peter Rosin <peda@axentia.se>
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
> I assume this will be sent upstream through an arm tree.
> 

Yes, I'm applying it right now.

> Thanks,
> Guenter
> 
> > ---
> >  arch/arm/boot/dts/at91-tse850-3.dts | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/boot/dts/at91-tse850-3.dts b/arch/arm/boot/dts/at91-tse850-3.dts
> > index 5f29010cdbd8..9b82cc8843e1 100644
> > --- a/arch/arm/boot/dts/at91-tse850-3.dts
> > +++ b/arch/arm/boot/dts/at91-tse850-3.dts
> > @@ -221,6 +221,7 @@
> >  	jc42 at 18 {
> >  		compatible = "nxp,se97b", "jedec,jc-42.4-temp";
> >  		reg = <0x18>;
> > +		smbus-timeout-disable;
> >  	};
> >  
> >  	dpot: mcp4651-104 at 28 {
> > -- 
> > 2.11.0
> > 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
