From: keescook@chromium.org (Kees Cook)
Date: Thu, 16 Jun 2016 10:08:03 -0700
Subject: [PATCH v2] ARM: mm: fix location of _etext
In-Reply-To: <CAKv+Gu-my1pd43WO=A_gQFgvtG3efYD97Fh8P-vG93G9zmPynw@mail.gmail.com>
References: <20160615202447.GA5005@www.outflux.net>
 <CAKv+Gu-my1pd43WO=A_gQFgvtG3efYD97Fh8P-vG93G9zmPynw@mail.gmail.com>
Message-ID: <CAGXu5jKuwkiaVCtTSbcY-UAE4_5rJDX0t0e22O1+A+NYDUZ9oA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2016 at 5:04 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 15 June 2016 at 22:24, Kees Cook <keescook@chromium.org> wrote:
>> The _etext position is defined to be the end of the kernel text code,
>> and should not include any part of the data segments. This interferes
>> with things that might check memory ranges and expect executable code
>> up to _etext. Just to be conservative, leave the kernel resource as
>> it was, using __init_begin instead of _etext as the end mark.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>> v2:
>> - Switched resource tracker to using __init_begin, rmk
>
> Actually, Linus removed the x86 /proc/iomem resources for kernel segments in
>
> c4004b02f8e5 ("x86: remove the kernel code/data/bss resources from /proc/iomem")
>
> so I wonder if we should not just do the same for ARM and arm64?

Nope, that got reverted. Removing it breaks things.

4046d6e81f33b7ef50d6668b78076d54c5e066b6

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
