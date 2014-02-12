From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Feb 2014 12:05:10 +0100
Subject: [PATCH 1/2] arm64: Add seccomp support
In-Reply-To: <CAB5YjtB6XnXRd90AUw=rJCOBKyfcngTQd3Kxft33XLCK+K=Vuw@mail.gmail.com>
References: <1391767892-5395-1-git-send-email-takahiro.akashi@linaro.org>
 <2659759.AA5HtBcWYl@wuerfel>
 <CAB5YjtB6XnXRd90AUw=rJCOBKyfcngTQd3Kxft33XLCK+K=Vuw@mail.gmail.com>
Message-ID: <201402121205.10802.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 February 2014, Takahiro Akashi wrote:
> Thank you for your comment.
> I'm afraid that I can't do so because how compat syscall numbers
> are named varies from arch to arch. __NR_compat_read is used
> only on arm64, while __NR_ia32_read on x86. On other archs,
> __NR_read is common to 32-bit and 64-bit tasks.

It's fine, I'm the maintainer for asm-generic ;-)

All future architectures are required to do it the same way as
arm64 and use the generic syscall ABI. It just means we won't be
able to share this header with x86 or other architectures that
use a nonstandard string. We should have it in the generic place
even if arm64 is the only user for now.

	Arnd
