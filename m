From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Mar 2013 10:56:55 +0000
Subject: [Suggestion] Latest randconfig build errors for Head.S
In-Reply-To: <CAAQYJAvXLV38shKncAKKqgQ9G0SnXjh+=aJHBdhd29yzVtL80A@mail.gmail.com>
References: <51415428.1070401@asianux.com> <514270D2.9010205@asianux.com>
 <CAAQYJAvXLV38shKncAKKqgQ9G0SnXjh+=aJHBdhd29yzVtL80A@mail.gmail.com>
Message-ID: <201303151056.55819.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 March 2013, Andrea Adami wrote:
> On Fri, Mar 15, 2013 at 1:52 AM, Chen Gang <gang.chen@asianux.com> wrote:
> > ? 2013?03?15? 07:43, Russell King - ARM Linux ??:
> >> So our wonderful toolchain has decided to start producing NULL warnings
> >> for every "mcr     p15, 0, rX, c7, c10, 4" instruction?  I'd just ignore
> >> them and hope that the toolchain people fix it.
> 
> AFAIK Arnd is aware and waiting for feedback about his patch:
> 
> ARM: compressed/head.S: work around new binutils warning   Arnd Bergmann
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/144846.html

Right. The fact that as prints a warning for those instructions makes sense
given that we are telling it we want to run on *all* ARM architectures,
and that ARMv8 has deprecated them officially.

Of course, what is bogus about this is the "NULL" part rather than printing
the text that was meant to come out to explain the situation.  I don't
know how to report that bug other than what I tried before, but if it gets
fixed by printing the right text, we will still want to build a kernel
without getting any warnings.

	Arnd
