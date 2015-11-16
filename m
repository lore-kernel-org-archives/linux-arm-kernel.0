From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 16 Nov 2015 20:02:38 +0100
Subject: [PATCH v2 10/12] ARM: only consider memblocks with NOMAP cleared
 for linear mapping
In-Reply-To: <20151116190003.GG8644@n2100.arm.linux.org.uk>
References: <1447698757-8762-1-git-send-email-ard.biesheuvel@linaro.org>
 <1447698757-8762-11-git-send-email-ard.biesheuvel@linaro.org>
 <20151116190003.GG8644@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu8_AUX9FAUhLKvsuC=iuD0bqt+ZvXCRyxkC_BjFjvSspQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 November 2015 at 20:00, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Nov 16, 2015 at 07:32:35PM +0100, Ard Biesheuvel wrote:
>> Take the new memblock attribute MEMBLOCK_NOMAP into account when
>> deciding whether a certain region is or should be covered by the
>> kernel direct mapping.
>
> It's probably worth looking at this as a replacement to the way
> arm_memblock_steal() works, provided NOMAP doesn't result in the
> memory being passed to the kernel allocators.  Thoughts?
>

Yes. The primary reason for NOMAP is that the memory is not removed,
so we don't lose the annotation that it is memory (which might be
useful, for instance, for /dev/mem attribute handling)
