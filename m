From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Nov 2014 23:25:29 +0100
Subject: [RFC] ptrace: add generic SET_SYSCALL request
In-Reply-To: <OF152076B7.38277C08-ONC1257D8F.0050C2DF-C1257D8F.00516BF2@de.ibm.com>
References: <1415346443-28915-1-git-send-email-takahiro.akashi@linaro.org>
 <3899236.yrOvvrZHD6@wuerfel>
 <OF152076B7.38277C08-ONC1257D8F.0050C2DF-C1257D8F.00516BF2@de.ibm.com>
Message-ID: <1472197.o98pKNTkBz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 November 2014 15:49:20 Ulrich Weigand wrote:
> Arnd Bergmann <arnd@arndb.de> wrote on 13.11.2014 11:21:28:
> 
> > I have to admit that I don't really understand gdb internals, but from
> > a first look I get the impression that it will just do the right thing
> > if you reuse NT_S390_SYSTEM_CALL on ARM64 with the same semantics.
> 
> There's an interface between BFD and GDB proper involved here.  BFD will
> detect the presence of register set notes in the core dump, and will
> translate them into virtual sections; GDB will then simply look up such
> sections under well-known names.
> 
> In particular, the NT_S390_SYSTEM_CALL note will be translated by BFD
> into a virtual section named ".reg-s390-system-call"; GDB platform-
> specific code will look for sections of this particular name.
> 
> So if you were to create notes using the same note type, by default it
> would do nothing on ARM64.  You might add code to the ARM64 back-end
> to also look for a section ".reg-s390-system-call", but that would be
> somewhat confusing.  Using a new, platform-specific note type for ARM64
> would appear to fit better with existing precedent.

Ok, thanks a lot for your insight and for confirming what Takahiro AKASHI
said. Let's use a new NT_ARM64_SYSTEM_CALL type with a different
number then.

	Arnd
