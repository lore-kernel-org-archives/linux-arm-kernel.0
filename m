From: vapier.adi@gmail.com (Mike Frysinger)
Date: Sun, 8 May 2011 22:38:43 -0400
Subject: [PATCH] atomic: add *_dec_not_zero
In-Reply-To: <201105081133.50824.sven@narfation.org>
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
	<20110508092403.GB27807@n2100.arm.linux.org.uk>
	<201105081133.50824.sven@narfation.org>
Message-ID: <BANLkTim+z0mv7oXZHr0YnoxtfnoDZTEr9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 8, 2011 at 05:33, Sven Eckelmann wrote:
> Russell King - ARM Linux wrote:
> [...]
>> Do we need atomic_dec_not_zero() et.al. in every arch header - is there no
>> generic header which it could be added to?
>
> Mike Frysinger already tried to answer it in
> <BANLkTimctgbto3dsnJ3d3r7NggS0KF9_Sw@mail.gmail.com>:
>> that's what asm-generic is for. ?if the arch isnt using it, it's
>> either because the arch needs to convert to it, or they're using SMP
>> and asm-generic doesnt yet support that for atomic.h.
>>
>> for example, the Blackfin port only needed updating for the SMP case.
>> in the non-SMP case, we're getting the def from asm-generic/atomic.h.
>
> Feel free to change that but I just followed the style used by all other
> macros and will not redesign the complete atomic*.h idea.

what you're doing is currently correct.  i think merging SMP support
into asm-generic for atomic* will take a bit of pondering first.
-mike
