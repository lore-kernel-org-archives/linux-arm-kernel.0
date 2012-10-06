From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 6 Oct 2012 17:31:00 +0100
Subject: alignment faults in 3.6
In-Reply-To: <CAG5Tg6Ut9Q_Sn4xT+owr=ZxCc36NERhg=eATceQKQ=mKj7G-gg@mail.gmail.com>
References: <CAG5Tg6V0Vj9HTy3=AU-q+Qa3DuJs6R1Kw+3uOWU_jOGfkgyXzw@mail.gmail.com>
 <20121005071216.GD4625@n2100.arm.linux.org.uk>
 <CAG5Tg6VciuxJ=k+fatzLugcehF54mGNOLHpUwdMX99oCnAVg8Q@mail.gmail.com>
 <20121005082439.GF4625@n2100.arm.linux.org.uk> <506ED18C.3010009@gmail.com>
 <20590.58864.527467.746403@pilspetsen.it.uu.se> <506F0454.3070304@gmail.com>
 <CAG5Tg6XJJ9a4Y+5BXG_T30hQ-xE7pyvyG18rV6A=jmjckcrPUQ@mail.gmail.com>
 <20121005224235.GR4625@n2100.arm.linux.org.uk>
 <CAG5Tg6Ut9Q_Sn4xT+owr=ZxCc36NERhg=eATceQKQ=mKj7G-gg@mail.gmail.com>
Message-ID: <20121006163100.GS4625@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 06, 2012 at 05:04:33PM +0100, Mans Rullgard wrote:
> On 5 October 2012 23:42, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Oct 05, 2012 at 11:37:40PM +0100, Mans Rullgard wrote:
> >> The problem is the (__be32 *) casts.  This is a normal pointer to a 32-bit,
> >> which is assumed to be aligned, and the cast overrides the packed attribute
> >> from the struct.  Dereferencing these cast expressions must be done with the
> >> macros from asm/unaligned.h
> >
> > Again, not going to happen.
> 
> There are only two options for fixing this:
> 
> 1. Ensure the struct is always aligned.
> 2. Declare it packed (and fix casts).
> 
> Refusing to do either leaves us with a broken kernel.  Is that what you want?

How about you start reading the emails that you receive rather than
seemingly insisting that I somehow fix the Linux networking stack -
which would involve me talking to someone who has publically tried
to oust me from being ARM maintainer, and whom would probably reject
any attempt to fix this _because_ I was the person involved in proposing
the fix?

It's far better that someone else sorts this out, they are much more
likely to get a favourable response.
