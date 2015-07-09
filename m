From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 9 Jul 2015 21:42:41 +0200
Subject: [PATCH v3] i2c: omap: improve duty cycle on SCL
In-Reply-To: <20150618172558.GC27790@saruman.tx.rr.com>
References: <1434569475-17378-1-git-send-email-balbi@ti.com>
 <55827CD7.7030207@nokia.com>
 <20150618172558.GC27790@saruman.tx.rr.com>
Message-ID: <20150709194241.GF4744@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 12:25:58PM -0500, Felipe Balbi wrote:
> On Thu, Jun 18, 2015 at 10:09:59AM +0200, Alexander Sverdlin wrote:
> > Hello Felipe,
> > 
> > On 17/06/15 21:31, ext Felipe Balbi wrote:
> > > With this patch we try to be as close to 50%
> > > duty cycle as possible. The reason for this
> > > is that some devices present an erratic behavior
> > > with certain duty cycles.
> > > 
> > > One such example is TPS65218 PMIC which fails
> > > to change voltages when running @ 400kHz and
> > > duty cycle is lower than 34%.
> > > 
> > > The idea of the patch is simple:
> > > 
> > > calculate desired scl_period from requested scl
> > > and use 50% for tLow and 50% for tHigh.
> > > 
> > > tLow is calculated with a DIV_ROUND_UP() to make
> > > sure it's slightly higher than tHigh and to make
> > > sure that we end up within I2C specifications.
> > 
> > if you refuse to change the calculations to achieve maximum possible
> > bus rate (as I've shown you with SCLL=9 and SCLH=9), maybe you want to
> > change the description? Because you are doing something else than is
> > written here. You are only in spec because you are not doing 50% duty
> > cycle. And you didn't mention here that you lower the bus speed below
> > 400kHz to achieve this.
> 
> and there's a comment where the calculation goes which states "as close
> to 50% as possible but we make sure tLow is higher than tHigh so we're
> still within spec".

So, is that ready to go in for-next?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150709/0b1eaa85/attachment.sig>
