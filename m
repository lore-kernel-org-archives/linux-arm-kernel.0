From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 30 Nov 2017 18:26:06 +0100
Subject: [PATCH v2 2/2] ARM: dts: at91: disable the nxp,se97b SMBUS
 timeout on the TSE-850
In-Reply-To: <20171130171638.GA17788@roeck-us.net>
References: <20171127163101.27859-1-peda@axentia.se>
 <20171127163101.27859-3-peda@axentia.se>
 <20171129205311.GA20551@roeck-us.net>
 <20171129205629.GO21126@piout.net>
 <20171130171638.GA17788@roeck-us.net>
Message-ID: <20171130172606.GZ21126@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/11/2017 at 09:16:38 -0800, Guenter Roeck wrote:
> On Wed, Nov 29, 2017 at 09:56:29PM +0100, Alexandre Belloni wrote:
> > On 29/11/2017 at 12:53:11 -0800, Guenter Roeck wrote:
> > > On Mon, Nov 27, 2017 at 05:31:01PM +0100, Peter Rosin wrote:
> > > > The I2C adapter driver is sometimes slow, causing the SCL line to
> > > > be stuck low for more than the stipulated SMBUS timeout of 25-35 ms.
> > > > This causes the client device to give up which in turn causes silent
> > > > corruption of data. So, disable the SMBUS timeout in the client device.
> > > > 
> > > > Signed-off-by: Peter Rosin <peda@axentia.se>
> > > 
> > > Acked-by: Guenter Roeck <linux@roeck-us.net>
> > > 
> > > I assume this will be sent upstream through an arm tree.
> > > 
> > 
> > Yes, I'm applying it right now.
> > 
> Are you going to apply the patch for 4.15, or queue it up for 4.16 ?
> I have been arguing with myself if this is a feature or a bug fix.
> So far I queued the driver change up for 4.16, but I am open to
> applying it to 4.15. Any thoughts ?
> 

I was wondering that myself. I'm open to have it as a fix in 4.15. Or
maybe Peter can send the series to stable if he needs it in 4.14.

Peter, what do you think/want?


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
