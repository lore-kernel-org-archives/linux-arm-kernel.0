From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 16 Jan 2015 15:38:58 +0000
Subject: [PATCH] arm64: uapi: expose our struct ucontext to the uapi
 headers
In-Reply-To: <20150116153715.GV7091@arm.com>
References: <1421416334-12588-1-git-send-email-will.deacon@arm.com>
 <20150116144737.GB10230@localhost> <1730317.ngMhCvdNtF@wuerfel>
 <20150116153505.GH13634@e104818-lin.cambridge.arm.com>
 <20150116153715.GV7091@arm.com>
Message-ID: <20150116153857.GI13634@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 03:37:15PM +0000, Will Deacon wrote:
> On Fri, Jan 16, 2015 at 03:35:06PM +0000, Catalin Marinas wrote:
> > On Fri, Jan 16, 2015 at 03:26:15PM +0000, Arnd Bergmann wrote:
> > > On Friday 16 January 2015 14:47:38 Catalin Marinas wrote:
> > > > However,
> > > > with the uapi headers change and maybe some additional commits, we end
> > > > up copying the uapi/asm-generic/ucontext.h to usr/include/asm/ in the
> > > > exported headers which differs from the arch ucontext.h as the latter
> > > > was never split in uapi/non-uapi parts (it wasn't in the
> > > > arch/arm/include/Kbuild).
> > > 
> > > Are you sure? When I look at the build/usr/include/asm directory, I
> > > only see wrappers like this one
> > > 
> > > #include <asm-generic/auxvec.h>  // inside usr/include/asm/auxvec.h
> > > 
> > > and the include/uapi/asm-generic/auxvec.h gets copied to usr/asm-generic/auxvec.h
> > > 
> > > However, I don't see this wrapper done for the arm or arm64 version
> > > of ucontext.h: we get a copy of the generic file in usr/include/asm/ucontext.h
> > > but no wrapper for it because arch/arm*/include/uapi/asm/Kbuild does not
> > > list ucontext.h.
> > 
> > I think you are right, maybe I just got confused with
> > usr/include/asm-generic/ucontext.h which doesn't matter as user space
> > should not include it.
> 
> Right; but exporting our own structure is still useful from a userspace
> perspective, otherwise they have to follow glibc's lead and define their
> own compatible layout.

That's fine, I think the patch still make sense (but not as urgent as we
haven't broken anything).

-- 
Catalin
