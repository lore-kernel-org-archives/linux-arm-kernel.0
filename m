From: will.deacon@arm.com (Will Deacon)
Date: Thu, 11 Jan 2018 17:33:10 +0000
Subject: [PATCH 2/2] kasan: clean up KASAN_SHADOW_SCALE_SHIFT usage
In-Reply-To: <ff221eca3db7a1f208c30c625b7d209fba33abb9.1515684162.git.andreyknvl@google.com>
References: <cover.1515684162.git.andreyknvl@google.com>
 <ff221eca3db7a1f208c30c625b7d209fba33abb9.1515684162.git.andreyknvl@google.com>
Message-ID: <20180111173309.GG13216@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 11, 2018 at 04:29:09PM +0100, Andrey Konovalov wrote:
> Right now the fact that KASAN uses a single shadow byte for 8 bytes of
> memory is scattered all over the code.
> 
> This change defines KASAN_SHADOW_SCALE_SHIFT early in asm include files
> and makes use of this constant where necessary.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  arch/arm64/include/asm/kasan.h  | 3 ++-
>  arch/arm64/include/asm/memory.h | 3 ++-
>  arch/arm64/mm/kasan_init.c      | 3 ++-
>  arch/x86/include/asm/kasan.h    | 8 ++++++--
>  include/linux/kasan.h           | 2 --
>  5 files changed, 12 insertions(+), 7 deletions(-)

For the arm64 parts:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
