From: mingo@kernel.org (Ingo Molnar)
Date: Thu, 13 Aug 2015 08:50:41 +0200
Subject: [PATCH 0/2] x86/KASAN updates for 4.3
In-Reply-To: <1439444244-26057-1-git-send-email-ryabinin.a.a@gmail.com>
References: <1439444244-26057-1-git-send-email-ryabinin.a.a@gmail.com>
Message-ID: <20150813065040.GA17983@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:

> These 2 patches taken from v5 'KASAN for arm64' series.
> The only change is updated changelog in second patch.
> 
> I hope this is not too late to queue these for 4.3,
> as this allow us to merge arm64/KASAN patches in v4.4
> through arm64 tree.
> 
> Andrey Ryabinin (2):
>   x86/kasan: define KASAN_SHADOW_OFFSET per architecture
>   x86/kasan, mm: introduce generic kasan_populate_zero_shadow()
> 
>  arch/x86/include/asm/kasan.h |   3 +
>  arch/x86/mm/kasan_init_64.c  | 123 ++--------------------------------
>  include/linux/kasan.h        |  10 ++-
>  mm/kasan/Makefile            |   2 +-
>  mm/kasan/kasan_init.c        | 152 +++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 170 insertions(+), 120 deletions(-)
>  create mode 100644 mm/kasan/kasan_init.c

It's absolutely too late in the -rc cycle for v4.3!

I can create a stable topic tree for it, tip:mm/kasan or so, which arm64 could 
pull and base its own ARM specific work on, if that's OK with everyone.

Thanks,

	Ingo
