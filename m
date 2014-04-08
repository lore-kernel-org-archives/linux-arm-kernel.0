From: robherring2@gmail.com (Rob Herring)
Date: Tue, 8 Apr 2014 07:55:26 -0500
Subject: [PATCH] of: Fix the section mismatch warnings.
In-Reply-To: <1396936087-23043-1-git-send-email-Li.Xiubo@freescale.com>
References: <1396936087-23043-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <CAL_JsqKuvKwEv89hOSknc-0Pq3aiwyPFhB-kPA-cRjGK831oFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 8, 2014 at 12:48 AM, Xiubo Li <Li.Xiubo@freescale.com> wrote:
> In tag next-20140407, building with CONFIG_DEBUG_SECTION_MISMATCH
> enabled, the following WARNING is occured:
>
> WARNING: drivers/built-in.o(.text.unlikely+0x2220): Section mismatch
> in reference from the function __reserved_mem_check_root() to the
> function .init.text:of_get_flat_dt_prop()
> The function __reserved_mem_check_root() references
> the function __init of_get_flat_dt_prop().
> This is often because __reserved_mem_check_root lacks a __init
> annotation or the annotation of of_get_flat_dt_prop is wrong.
>
> WARNING: vmlinux.o(.text.unlikely+0xb9d0): Section mismatch in reference
> from the function __reserved_mem_check_root() to the (unknown reference)
> .init.data:(unknown)
> The function __reserved_mem_check_root() references
> the (unknown reference) __initdata (unknown).
> This is often because __reserved_mem_check_root lacks a __initdata
> annotation or the annotation of (unknown) is wrong.
>
> This is cause by :
> 'drivers: of: add initialization code for dynamic reserved memory'.
>
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>

Applied.

Rob
