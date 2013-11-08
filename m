From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 8 Nov 2013 18:14:16 +0100
Subject: [PATCH trivial] arm64: constify hwcap_str
In-Reply-To: <20131108143807.GB17212@arm.com>
References: <1383755567-17244-1-git-send-email-ard.biesheuvel@linaro.org>
 <20131107175010.GI13674@arm.com>
 <CAKv+Gu9zw-1p6q6vnQWi=ZU53V-oeN_-vDH5Jfo0XvnBjMqN2g@mail.gmail.com>
 <20131108143807.GB17212@arm.com>
Message-ID: <CAKv+Gu_vvLmLxD_NfVzK16cRccXj9FOZwG39D39nqgedF3qVBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 November 2013 15:38, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Thu, Nov 07, 2013 at 06:53:06PM +0000, Ard Biesheuvel wrote:
[...]
>> I agree that whether you want to put up with the additional layer of
>> indirection, additional relocations etc is a matter of taste, but
>> having writable pointers around that are easily dereferenced directly
>> by unprivileged users is a bad idea in any case,
>
> "unprivileged users"?!
>

Well, I know this may seem far fetched, but /proc/cpuinfo lacks any
kind of access control because it is deemed harmless, while, as an
unprivileged user, having some pointers in .data that you can clobber
(through some other vulnerability) without breaking anything, and can
conveniently dereference at your leisure by cat'ing /proc/cpuinfo, may
well be something that could potentially be used in the wrong way.

>> so if this is your preferred solution, it's fine by me.
>
> My preferred solution is to leave it as it is ;).
>

It's a trivial fix, so why not apply it?

-- 
Ard.
