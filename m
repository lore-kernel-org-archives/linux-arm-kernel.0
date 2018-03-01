From: bp@alien8.de (Borislav Petkov)
Date: Thu, 1 Mar 2018 16:01:44 +0100
Subject: [PATCH 02/11] ACPI / APEI: Generalise the estatus queue's
 add/remove and notify code
In-Reply-To: <20180215185606.26736-3-james.morse@arm.com>
References: <20180215185606.26736-1-james.morse@arm.com>
 <20180215185606.26736-3-james.morse@arm.com>
Message-ID: <20180301150144.GA4215@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 06:55:57PM +0000, James Morse wrote:
> Keep the oops_begin() call for x86,

That oops_begin() in generic code is such a layering violation, grrr.

> arm64 doesn't have one of these,
> and APEI is the only thing outside arch code calling this..

So looking at:

arch/arm/kernel/traps.c:die()

it does call oops_begin() ... oops_end() just like the x86 version of
die().

I'm wondering if we could move the code to do die() in a prepatch? My
assumption is that all the arches should have die()... A quick grep does
show a bunch of other arches having die()...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
