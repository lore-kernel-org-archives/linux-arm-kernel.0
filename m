From: andreyknvl@google.com (Andrey Konovalov)
Date: Fri, 16 Mar 2018 14:49:00 +0100
Subject: arm64 kvm built with clang doesn't boot
Message-ID: <CAAeHK+xjnXnrG0p06r-QRcUucYi5vcTJOn3mSS-JVxX9_TYg4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I've recently tried to boot clang built kernel on real hardware
(Odroid C2 board) instead of using a VM. The issue that I stumbled
upon is that arm64 kvm built with clang doesn't boot.

Adding -fno-jump-tables compiler flag to arch/arm64/kvm/* helps. There
was a patch some time ago that did exactly that
(https://patchwork.kernel.org/patch/10060381/), but it wasn't accepted
AFAICT (see the discussion on that thread).

What would be the best way to get this fixed?

I've also had to disable CONFIG_JUMP_LABEL to get the kernel boot
(even without kvm enabled), but that might be a different (though
related) issue.

Thanks!
