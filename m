From: bp@alien8.de (Borislav Petkov)
Date: Thu, 1 Mar 2018 23:35:29 +0100
Subject: [PATCH 02/11] ACPI / APEI: Generalise the estatus queue's
 add/remove and notify code
In-Reply-To: <87sh9jbrgc.fsf@e105922-lin.cambridge.arm.com>
References: <20180215185606.26736-1-james.morse@arm.com>
 <20180215185606.26736-3-james.morse@arm.com>
 <20180301150144.GA4215@pd.tnic>
 <87sh9jbrgc.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <20180301223529.GA28811@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 06:06:59PM +0000, Punit Agrawal wrote:
> You're looking at support for the 32-bit ARM systems.

I know. That's why I'm asking.

> The 64-bit support lives in arch/arm64 and the die() there doesn't
> contain an oops_begin()/oops_end(). But the lack of oops_begin() on
> arm64 doesn't really matter here.

Yap.

> One issue I see with calling die() is that it is defined in different
> includes across various architectures, (e.g., include/asm/kdebug.h for
> x86, include/asm/system_misc.h in arm64, etc.)

I don't think that's insurmountable.

The more important question is, can we do the same set of calls when
panic severity on all architectures which support APEI or should we have
arch-specific ghes_panic() callbacks or so.

As it is now, it would turn into a mess if we start with the ifdeffery
and the different requirements architectures might have...

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
