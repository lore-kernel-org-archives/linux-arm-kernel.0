From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 12 May 2018 21:00:22 +0200
Subject: [PATCH v2] tty: implement led triggers
In-Reply-To: <01dcbf5c-70a0-b067-20c3-f99e22ed4512@arm.com>
References: <0c1bb915-bd92-4433-61ec-78fdba453396@arm.com>
 <20180503201952.16592-1-u.kleine-koenig@pengutronix.de>
 <20180507080252.GO2285@localhost>
 <20180507084127.ekpd3ze2itkzo7fd@pengutronix.de>
 <20180507092710.GQ2285@localhost> <20180510111434.GC6977@amd>
 <01dcbf5c-70a0-b067-20c3-f99e22ed4512@arm.com>
Message-ID: <20180512190022.rx7ix5gpx5kncvcj@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2018 at 12:25:21PM +0100, Robin Murphy wrote:
> On 10/05/18 12:14, Pavel Machek wrote:
> > Hi!
> > 
> > > > > > @@ -499,6 +500,7 @@ static void flush_to_ldisc(struct work_struct *work)
> > > > > >   		struct tty_buffer *head = buf->head;
> > > > > >   		struct tty_buffer *next;
> > > > > >   		int count;
> > > > > > +		unsigned long delay = 50 /* ms */;
> > > > > 
> > > > > Comment after the semicolon?
> > > > 
> > > > Given that this comment is about the 50 and not the delay member, I
> > > > prefer it before the ;.
> > > 
> > > Hmm. I personally find it hard to read and can only find about 30
> > > instances of this comment style (for assignments) in the kernel. And
> > > arguably the comment applies equally well to the delay variable in this
> > > case too.
> > 
> > It is not too traditional, but I believe it makes sense....
> > 
> > (and yes, I wish we had kernel in Rust, so we could have real units
> > attached to our variables...)
> 
> Well, the variable itself could always be named "delay_ms" if it's really
> that important.

FTR: That's what I did for v3.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
