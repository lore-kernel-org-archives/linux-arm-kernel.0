From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Oct 2012 23:42:35 +0100
Subject: alignment faults in 3.6
In-Reply-To: <CAG5Tg6XJJ9a4Y+5BXG_T30hQ-xE7pyvyG18rV6A=jmjckcrPUQ@mail.gmail.com>
References: <CAG5Tg6Wuybruc31x1eh6mFafsg=7cOgYLgpZUBuJUo75ap3osQ@mail.gmail.com>
 <506E3E58.80703@gmail.com>
 <CAG5Tg6V0Vj9HTy3=AU-q+Qa3DuJs6R1Kw+3uOWU_jOGfkgyXzw@mail.gmail.com>
 <20121005071216.GD4625@n2100.arm.linux.org.uk>
 <CAG5Tg6VciuxJ=k+fatzLugcehF54mGNOLHpUwdMX99oCnAVg8Q@mail.gmail.com>
 <20121005082439.GF4625@n2100.arm.linux.org.uk> <506ED18C.3010009@gmail.com>
 <20590.58864.527467.746403@pilspetsen.it.uu.se> <506F0454.3070304@gmail.com>
 <CAG5Tg6XJJ9a4Y+5BXG_T30hQ-xE7pyvyG18rV6A=jmjckcrPUQ@mail.gmail.com>
Message-ID: <20121005224235.GR4625@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 05, 2012 at 11:37:40PM +0100, Mans Rullgard wrote:
> The problem is the (__be32 *) casts.  This is a normal pointer to a 32-bit,
> which is assumed to be aligned, and the cast overrides the packed attribute
> from the struct.  Dereferencing these cast expressions must be done with the
> macros from asm/unaligned.h

Again, not going to happen.  DaveM is on record for saying as much, but
I guess you're going to reject that as well, so I'm not sure why I'm
even bothering to reply.
