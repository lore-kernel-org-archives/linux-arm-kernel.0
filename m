From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 3 Jul 2012 18:58:39 +0200
Subject: [PATCH v2 07/12] I2C: MV64XXX: Add Device Tree support
In-Reply-To: <2232439.93KkEvHiYj@flexo>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <1341325365-21393-8-git-send-email-andrew@lunn.ch>
 <2232439.93KkEvHiYj@flexo>
Message-ID: <20120703165839.GA1519@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2012 at 05:59:13PM +0200, Florian Fainelli wrote:
> Hello Andrew,
> 
> On Tuesday 03 July 2012 16:22:40 Andrew Lunn wrote:
> > Extends the driver to get properties from device tree. Also extend the
> > kirkwood DT support to supply the needed properties.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> [snip]
> > -	if ((pd->id != 0) || !pdata)
> > +	if ((!pdata && !pd->dev.of_node) || (pdata && (pd->id != 0)))
> >  		return -ENODEV;
> 
> This is more a reminder than a real remark, but the driver here should not be 
> limiting us to a single platform_device. In fact kirkwood55 (88F6282) has two 
> I2C controllers for instance.

Yes, i don't understand this code. It looks impossible to use it using
platform_data with more than one controller. Any idea why its like
this? I didn't want to change the behavior because i don't understand
why its like this.

However, it should be possible to instantiate multiple I2C controllers
using DT. However, i've only tested it with one.

      Andrew
