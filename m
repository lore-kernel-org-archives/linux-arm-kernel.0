From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Fri, 7 Sep 2018 19:10:20 +0300
Subject: [PATCH v6 00/18] khwasan: kernel hardware assisted address
 sanitizer
In-Reply-To: <cover.1535462971.git.andreyknvl@google.com>
References: <cover.1535462971.git.andreyknvl@google.com>
Message-ID: <8fb4852e-a88e-2d3b-88ba-4b73ac2c890d@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/29/2018 02:35 PM, Andrey Konovalov wrote:

> Andrey Konovalov (18):
>   khwasan, mm: change kasan hooks signatures
>   khwasan: move common kasan and khwasan code to common.c
>   khwasan: add CONFIG_KASAN_GENERIC and CONFIG_KASAN_HW
>   khwasan, arm64: adjust shadow size for CONFIG_KASAN_HW
>   khwasan: initialize shadow to 0xff
>   khwasan, arm64: untag virt address in __kimg_to_phys and
>     _virt_addr_is_linear
>   khwasan: add tag related helper functions
>   khwasan: preassign tags to objects with ctors or SLAB_TYPESAFE_BY_RCU
>   khwasan, arm64: fix up fault handling logic
>   khwasan, arm64: enable top byte ignore for the kernel
>   khwasan, mm: perform untagged pointers comparison in krealloc
>   khwasan: split out kasan_report.c from report.c
>   khwasan: add bug reporting routines
>   khwasan: add hooks implementation
>   khwasan, arm64: add brk handler for inline instrumentation
>   khwasan, mm, arm64: tag non slab memory allocated via pagealloc
>   khwasan: update kasan documentation
>   kasan: add SPDX-License-Identifier mark to source files
> 

Aside from nit in 16/18 patch looks fine for me.

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
