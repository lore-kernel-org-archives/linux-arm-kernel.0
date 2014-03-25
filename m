From: joe@perches.com (Joe Perches)
Date: Tue, 25 Mar 2014 07:01:54 -0700
Subject: [PATCH v3] i2c: new bus driver for efm32
In-Reply-To: <20140325091148.GA2570@katana>
References: <1395414236-22647-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140324170131.GB7524@katana> <20140325090700.GL23076@pengutronix.de>
 <20140325091148.GA2570@katana>
Message-ID: <1395756114.3010.16.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-03-25 at 10:11 +0100, Wolfram Sang wrote:
> On Tue, Mar 25, 2014 at 10:07:00AM +0100, Uwe Kleine-K?nig wrote:
> > Hello,
> > 
> > On Mon, Mar 24, 2014 at 06:01:31PM +0100, Wolfram Sang wrote:
> > > And checkpatch said:
> > > 
> > > WARNING: braces {} are not necessary for any arm of this statement
> > > #345: FILE: drivers/i2c/busses/i2c-efm32.c:239:
> > > +		if (cur_msg->flags & I2C_M_RD) {
> > > ...
> > hmm the whole block reads:
> > 
> >         case REG_STATE_STATE_DATA:
> >                 if (cur_msg->flags & I2C_M_RD) {
> >                         efm32_i2c_recv_next_byte(ddata);
> >                 } else {
> >                         /* wait for Ack or Nack of slave */
> >                 }
> >                 break;
> > 
> > so just removing the braces does the wrong thing. Is this a false
> > positive checkpatch warning? Andy? Joe?
> > 
> > I can make it:
> > 
> > 		if (cur_msg->flags & I2C_M_RD)
> > 			efm32_i2c_recv_next_byte(ddata);
> > 		/* in the write case wait for Ack or Nack of slave */
> > 
> > but I consider the version above more readable.
> 
> Well, OK, I let you decide.

A Semi-Positive I think.

I think your first block is more readable myself.

Adding a semicolon would shut checkpatch up and it's
debatable whether it might be better too.

	if (foo) {
		bar();
	} else {
		/* single line comment */
		;
	}

But please feel free to ignore any checkpatch warning
where your taste is better than its.

checkpatch is brainless, you're not.
