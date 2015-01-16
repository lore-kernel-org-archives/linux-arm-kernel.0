From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Jan 2015 16:26:15 +0100
Subject: [PATCH] arm64: uapi: expose our struct ucontext to the uapi
 headers
In-Reply-To: <20150116144737.GB10230@localhost>
References: <1421416334-12588-1-git-send-email-will.deacon@arm.com>
 <20150116144737.GB10230@localhost>
Message-ID: <1730317.ngMhCvdNtF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 January 2015 14:47:38 Catalin Marinas wrote:
> However,
> with the uapi headers change and maybe some additional commits, we end
> up copying the uapi/asm-generic/ucontext.h to usr/include/asm/ in the
> exported headers which differs from the arch ucontext.h as the latter
> was never split in uapi/non-uapi parts (it wasn't in the
> arch/arm/include/Kbuild).

Are you sure? When I look at the build/usr/include/asm directory, I
only see wrappers like this one

#include <asm-generic/auxvec.h>  // inside usr/include/asm/auxvec.h

and the include/uapi/asm-generic/auxvec.h gets copied to usr/asm-generic/auxvec.h

However, I don't see this wrapper done for the arm or arm64 version
of ucontext.h: we get a copy of the generic file in usr/include/asm/ucontext.h
but no wrapper for it because arch/arm*/include/uapi/asm/Kbuild does not
list ucontext.h.

	Arnd
