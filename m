From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 8 Nov 2013 17:19:49 +0000
Subject: [PATCH trivial] arm64: constify hwcap_str
In-Reply-To: <CAKv+Gu_vvLmLxD_NfVzK16cRccXj9FOZwG39D39nqgedF3qVBA@mail.gmail.com>
References: <1383755567-17244-1-git-send-email-ard.biesheuvel@linaro.org>
 <20131107175010.GI13674@arm.com>
 <CAKv+Gu9zw-1p6q6vnQWi=ZU53V-oeN_-vDH5Jfo0XvnBjMqN2g@mail.gmail.com>
 <20131108143807.GB17212@arm.com>
 <CAKv+Gu_vvLmLxD_NfVzK16cRccXj9FOZwG39D39nqgedF3qVBA@mail.gmail.com>
Message-ID: <20131108171949.GD17212@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 08, 2013 at 05:14:16PM +0000, Ard Biesheuvel wrote:
> On 8 November 2013 15:38, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Thu, Nov 07, 2013 at 06:53:06PM +0000, Ard Biesheuvel wrote:
> [...]
> >> I agree that whether you want to put up with the additional layer of
> >> indirection, additional relocations etc is a matter of taste, but
> >> having writable pointers around that are easily dereferenced directly
> >> by unprivileged users is a bad idea in any case,
> >
> > "unprivileged users"?!
> 
> Well, I know this may seem far fetched, but /proc/cpuinfo lacks any
> kind of access control because it is deemed harmless, while, as an
> unprivileged user, having some pointers in .data that you can clobber
> (through some other vulnerability) without breaking anything, and can
> conveniently dereference at your leisure by cat'ing /proc/cpuinfo, may
> well be something that could potentially be used in the wrong way.

That's far fetched indeed ;). I'm pretty sure once you can write the
.data section there are far better way to hack the kernel.

> >> so if this is your preferred solution, it's fine by me.
> >
> > My preferred solution is to leave it as it is ;).
> 
> It's a trivial fix, so why not apply it?

So far my toolchain already places it in .rodata since there is no write
to these pointers.

-- 
Catalin
