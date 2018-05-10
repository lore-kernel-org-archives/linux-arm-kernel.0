From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 10 May 2018 13:14:34 +0200
Subject: [PATCH v2] tty: implement led triggers
In-Reply-To: <20180507092710.GQ2285@localhost>
References: <0c1bb915-bd92-4433-61ec-78fdba453396@arm.com>
 <20180503201952.16592-1-u.kleine-koenig@pengutronix.de>
 <20180507080252.GO2285@localhost>
 <20180507084127.ekpd3ze2itkzo7fd@pengutronix.de>
 <20180507092710.GQ2285@localhost>
Message-ID: <20180510111434.GC6977@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > > @@ -499,6 +500,7 @@ static void flush_to_ldisc(struct work_struct *work)
> > > >  		struct tty_buffer *head = buf->head;
> > > >  		struct tty_buffer *next;
> > > >  		int count;
> > > > +		unsigned long delay = 50 /* ms */;
> > > 
> > > Comment after the semicolon?
> > 
> > Given that this comment is about the 50 and not the delay member, I
> > prefer it before the ;.
> 
> Hmm. I personally find it hard to read and can only find about 30
> instances of this comment style (for assignments) in the kernel. And
> arguably the comment applies equally well to the delay variable in this
> case too.

It is not too traditional, but I believe it makes sense....

(and yes, I wish we had kernel in Rust, so we could have real units
attached to our variables...)

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180510/fe3e817a/attachment.sig>
