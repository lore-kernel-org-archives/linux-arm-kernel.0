From: andreyknvl@google.com (Andrey Konovalov)
Date: Thu, 19 Apr 2018 19:06:31 +0200
Subject: Clang arm64 build is broken
Message-ID: <CAAeHK+wDMH_G=3UuGOda2t0g4TH4TmDAeyG-ydJwg9vmThd3eQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc!

Your recent commit [1] broke clang build on arm64. The issue is that
clang doesn't know about the "S" asm constraint. I reported this to
clang [2], and hopefully this will get fixed. In the meantime, would
it possible to work around using the "S" constraint in the kernel?

While we're here, regarding the other issue with kvm [3], I didn't
receive any comments as to whether it makes sense to send the fix that
adds -fno-jump-tables flag when building kvm with clang.

Thanks!

[1] https://github.com/torvalds/linux/commit/44a497abd621a71c645f06d3d545ae2f46448830

[2] https://github.com/ClangBuiltLinux/linux/issues/13

[3] https://lkml.org/lkml/2018/3/16/476
