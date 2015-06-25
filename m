From: tony@atomide.com (Tony Lindgren)
Date: Wed, 24 Jun 2015 22:01:38 -0700
Subject: [RESEND] [PATCH v2 1/2] arm: devtree: Set system_rev from DT
 revision
In-Reply-To: <20150506114417.GI30910@pali>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
 <3577431.y872Foi4kj@wuerfel> <20150506103752.GG30910@pali>
 <3529567.PeFp1NNa1q@wuerfel> <20150506114417.GI30910@pali>
Message-ID: <20150625050138.GL4156@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pali Roh?r <pali.rohar@gmail.com> [150506 04:45]:
> On Wednesday 06 May 2015 13:04:01 Arnd Bergmann wrote:
> > > 
> > > It needs to be done in this code, so "system_rev" variable is set
> > > properly...
> > 
> > What I mean is which code accesses this variable that early?
> > 
> 
> ATAG code is doing it at same early stage, so I added it to same early
> stage...

Yes we should do this early like the other atags.
 
> > > > Also, it seems strange to have a string property and then use kstrtouint
> > > > to convert it into a number. I think it should either be specified in a DT
> > > > binding to be a string and then have the kernel not assume that it is a number,
> > > > or we should define it to be binary.
> > > > 
> > > >       Arnd
> > > 
> > > Variable "system_rev" is number and it always was. So chaning type will
> > > break more parts.
> > > 
> > > And it is string DT property to be human readable. Some other developers
> > > suggested for v2 to change it to string (from number).
> > 
> > Both of them would be human readable, you just use something else to
> > read them ;-)
> > 
> > If we have a string here, we should just change all uses of system_rev
> > in the kernel accordingly, there are only a few of them:

Let's just keep it as a hex as it was. After all it's an existing
interface in /proc that user space programs may expect to be in
hex format already.

Pali, care to repost the whole set again right after -rc1 with
with rev property naming and documentation added? Just keep it
as hex and let's forget any string conversion.

Regards,

Tony
