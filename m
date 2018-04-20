From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 20 Apr 2018 09:13:34 +0100
Subject: Clang arm64 build is broken
In-Reply-To: <CAAeHK+wDMH_G=3UuGOda2t0g4TH4TmDAeyG-ydJwg9vmThd3eQ@mail.gmail.com>
References: <CAAeHK+wDMH_G=3UuGOda2t0g4TH4TmDAeyG-ydJwg9vmThd3eQ@mail.gmail.com>
Message-ID: <c61336a2-7c66-ea48-3daa-e644403d7a6e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey.

On 19/04/18 18:06, Andrey Konovalov wrote:
> Hi Marc!
> 
> Your recent commit [1] broke clang build on arm64.

Or rather, it has uncovered yet another missing feature in clang! ;-)

> The issue is that
> clang doesn't know about the "S" asm constraint. I reported this to
> clang [2], and hopefully this will get fixed. In the meantime, would
> it possible to work around using the "S" constraint in the kernel?

I have no idea, I've never used clang to build the kernel. Clang isn't
really supported to build the arm64 kernel anyway (as you mention
below), and working around clang deficiencies would mean that we leave
with the workaround forever. I'd rather enable clang once it is at
feature parity with GCC.

> While we're here, regarding the other issue with kvm [3], I didn't
> receive any comments as to whether it makes sense to send the fix that
> adds -fno-jump-tables flag when building kvm with clang.

Is that the only thing missing? Are you sure that there is no other way
for clang to generate absolute addresses that will then lead to a crash?
Again, I'd rather make sure we have the full picture.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
