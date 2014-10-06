From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 6 Oct 2014 16:48:35 +0200
Subject: [PATCHv7 1/2] pwm: Add Allwinner SoC support
In-Reply-To: <20141006143008.GC15599@piout.net>
References: <1410983638-24915-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1410983638-24915-2-git-send-email-alexandre.belloni@free-electrons.com>
 <20141006132404.GC26921@ulmo> <20141006143008.GC15599@piout.net>
Message-ID: <20141006144835.GB1744@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 06, 2014 at 04:30:08PM +0200, Alexandre Belloni wrote:
> On 06/10/2014 at 15:24:05 +0200, Thierry Reding wrote :
> > On Wed, Sep 17, 2014 at 09:53:57PM +0200, Alexandre Belloni wrote:
> > [...]
> > > diff --git a/drivers/pwm/pwm-sunxi.c b/drivers/pwm/pwm-sunxi.c
> > > new file mode 100644
> > > index 000000000000..643f84ea013e
> > > --- /dev/null
> > > +++ b/drivers/pwm/pwm-sunxi.c
> > > @@ -0,0 +1,371 @@
> > > +/*
> > > + * Driver for Allwinner Pulse Width Modulation Controller
> > > + *
> > > + * Copyright (C) 2014 Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > 
> > This is somewhat weird. So you are the copyright holder, not your
> > employer? The email address is somewhat misleading.
> > 
> 
> It has been done on my free, unpaid time so yes...
> 
> Anyway, even my employer could not actually claim to hold copyright on
> what I'm writing as this right is not transferable in France.

Interesting. And yet there's a bunch of Copyright.*Free Electrons in the
kernel. There's also this little mention on Wikipedia:

	"The droit d?auteur or authors' rights, in France, Belgium or
	Germany, grant (subject to some exceptions) the benefice of the
	right to natural persons (the author or his heir(s)) and denies
	it to legal persons (except for collective works, and for
	software), ..."[0]

Which indicates that for software this isn't true. Anyway, what I meant
to say was that it's unusual (at least in my experience) to submit code
authored and copyrighted using a corporate email address. So typically
I've seen people that work on open source in their spare time use a
different email address to separate these "identities".

But I don't mind this all that much, it just jumped out at me.

[0]: http://en.wikipedia.org/wiki/Copyright_law_of_France#Difference_between_copyright_and_droit_d.27auteur

> > > +static const u32 prescaler_table[] = {
> > > +	120,
> > > +	180,
> > > +	240,
> > > +	360,
> > > +	480,
> > > +	0,
> > > +	0,
> > > +	0,
> > > +	12000,
> > > +	24000,
> > > +	36000,
> > > +	48000,
> > > +	72000,
> > > +	0,
> > > +	0,
> > > +	0, /* Actually 1 but tested separately */
> > > +};
> > 
> > Did I already mention that this was really weird?
> > 
> 
> I'm not sure what you want to do here then. This is simply coming from
> the datasheet. The last one (0xF) being a bypass is actually only existing on 

No need to do anything about it. I just think it's really, really weird.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141006/5d748bdd/attachment-0001.sig>
