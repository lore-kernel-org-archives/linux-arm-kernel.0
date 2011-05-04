From: vapier.adi@gmail.com (Mike Frysinger)
Date: Wed, 4 May 2011 04:33:24 -0400
Subject: [PATCH] atomic: add *_dec_not_zero
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AD0D@saturn3.aculab.com>
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
	<AE90C24D6B3A694183C094C60CF0A2F6D8AD0D@saturn3.aculab.com>
Message-ID: <BANLkTimctgbto3dsnJ3d3r7NggS0KF9_Sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 4, 2011 at 04:05, David Laight wrote:
>> Introduce an *_dec_not_zero operation. ?Make this a special case of
>> *_add_unless because batman-adv uses atomic_dec_not_zero in different
>> places like re-broadcast queue or aggregation queue management. There
>> are other non-final patches which may also want to use this macro.
>
> Isn't there a place where a default definition of this can be
> defined? Instead of adding it separately to every architecture.

that's what asm-generic is for.  if the arch isnt using it, it's
either because the arch needs to convert to it, or they're using SMP
and asm-generic doesnt yet support that for atomic.h.

for example, the Blackfin port only needed updating for the SMP case.
in the non-SMP case, we're getting the def from asm-generic/atomic.h.
-mike
