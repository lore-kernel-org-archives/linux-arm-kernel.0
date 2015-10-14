From: mohun106@gmail.com (Radha Mohan)
Date: Wed, 14 Oct 2015 09:16:58 -0700
Subject: arm64 memcpy_{from|to}io and memset_io
In-Reply-To: <20151014161213.GH4239@e104818-lin.cambridge.arm.com>
References: <CAC8NTUUgQk0CNaBj2p=38U+yyFWE6ZQkSgs1KA=MviQg3g_X=Q@mail.gmail.com>
 <20151014161213.GH4239@e104818-lin.cambridge.arm.com>
Message-ID: <CAC8NTUU_Jrq_8VVoN-7wCn=a=zyQcZGObEJLA_EG_WyE9DevZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2015 at 9:12 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Tue, Oct 13, 2015 at 11:12:18PM -0700, Radha Mohan wrote:
>> I see that the memcpy_{from|to}io and memset_io are not in an
>> optimized manner. I guess these are just a copy from
>> arch/arm/include/asm/io.h where there could be problem with different
>> implementations.
>
> I think you may be looking at an older kernel version. In the latest
> mainline, memcpy_*io functions are more optimised in the sense that they
> use 64-bit accesses if the alignment permits.
>
>> Do we still need these to be byte write ?
>
> No but see above.
>
>> Can we convert them to use a more optimized memcpy ?
>
> There is a risk to converting them to something like memcpy() as the
> latter does not guarantee aligned accesses. Alignment is mandatory for
> Device memory access.
>
>> We have some drivers, like framebuffer driver using these functions
>> and end up writing byte-by-byte. This causes a very poor VGA
>> performance.
>
> You probably have an old kernel version.

Yes, I was alternating between old and new kernels. The newer implementation
 is much better. I will try that. Thanks.

>
> --
> Catalin
