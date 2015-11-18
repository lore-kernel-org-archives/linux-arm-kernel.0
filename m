From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Nov 2015 13:04:02 +0100
Subject: [PATCH v6 15/19] arm64: ilp32: force IPC_64 in msgctl, shmctl,
 semctl
In-Reply-To: <CAMuHMdVBCq4ZuDPoQ2TLpSH28jWHkNftqf4tNN=Rbo8a0y+_yQ@mail.gmail.com>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <32420376.JEdtXfitGi@wuerfel>
 <CAMuHMdVBCq4ZuDPoQ2TLpSH28jWHkNftqf4tNN=Rbo8a0y+_yQ@mail.gmail.com>
Message-ID: <4066882.1lnX6EA7g3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 November 2015 11:07:26 Geert Uytterhoeven wrote:
> >
> > I've done a complete list of what the architectures (see
> > https://docs.google.com/spreadsheets/d/18GxXEHE2ywnSr-SPoGFd1ABz6wEM1ex-JMu5lEraaH8/ )
> >
> > We have these categories:
> >
> > 1. uses IPC_PARSE_VERSION with sys_ipc, and has just introduced
> >    separate syscalls:
> >
> >     arm, avr32, powerpc, x86-32
> 
> x86-32, where?

My mistake. x86 uses a different way to do this, so I didn't see it
using grep and just assumed that Andy Lutomirski had patched it already
based on my memory of

https://sourceware.org/ml/libc-alpha/2015-09/msg00323.html

> > 2. uses IPC_PARSE_VERSION with sys_ipc, and has not yet introduced
> >    separate syscalls (currently producing a compile warning):
> >
> >    cris, frv, m32r, m68k, mips (o32), mn10300, s390, sh32, sparc
> >
> > 3. uses IPC_PARSE_VERSION with separate syscalls:
> >
> >    alpha, blackfin, microblaze, mips (n32/64), xtensa
> >
> > 4a. only new-style IPC with separate syscalls:
> >
> >     ia64, parisc, sh64
> 
> and x86-64?

right, that too. I got it in my spreadsheet by copied it wrong.

> > 4b. only new-style IPC with separate syscalls, using generic syscall
> >     table:
> >
> >     arc, arm64, c6x, h8300, hexagon, metag, nios2, openrisc, score,
> >     tile, unicore32
> >
> > So we should probably fix 1. and 2. before it's too late, but make
> > sure we don't break 3. in the process.
> 
> (Fortunately?) x86-32 doesn't seem to be converted in next yet?
> 
> I was hoping for them to do the heavy lifting for the generic solution 

yes, that would be nice ;-)

	Arnd
