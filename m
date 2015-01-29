From: ricardo.ribalda@gmail.com (Ricardo Ribalda Delgado)
Date: Thu, 29 Jan 2015 17:39:08 +0100
Subject: [PATCH] spi/xilinx: Cast ioread32/iowrite32 function pointers
In-Reply-To: <CAMuHMdX5CMH0Q5S_BBjb-F-kJfzkTS+sP9H-FDe_K_gFRxK7pw@mail.gmail.com>
References: <1422543073-21895-1-git-send-email-ricardo.ribalda@gmail.com>
 <CAMuHMdX5CMH0Q5S_BBjb-F-kJfzkTS+sP9H-FDe_K_gFRxK7pw@mail.gmail.com>
Message-ID: <CAPybu_3O3Rcq1Rvxvbpc-GOSs+VbO74_u+vfH+UtXjLAQjWLQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Geert

On Thu, Jan 29, 2015 at 4:56 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Thu, Jan 29, 2015 at 3:51 PM, Ricardo Ribalda Delgado
> <ricardo.ribalda@gmail.com> wrote:
>> IO functions prototypes may have different argument qualifiers
>> on different architectures.
>>
>> This patch cast the assignment of the function, to match the one defined
>> at iomap.h.
>
> Adding casts is (usually) not the solution to the problem.
>
> I think the definitions in include/asm-generic/iomap.h are actually wrong,
> as they lack a const:
>
>     extern unsigned int ioread8(void __iomem *);
>     extern unsigned int ioread16(void __iomem *);
>     extern unsigned int ioread16be(void __iomem *);
>     extern unsigned int ioread32(void __iomem *);
>     extern unsigned int ioread32be(void __iomem *);
>
> Note that the definitions in include/asm-generic/io.h do have the const:
>
>     static inline u8 ioread8(const volatile void __iomem *addr)
>     static inline u16 ioread16(const volatile void __iomem *addr)
>     static inline u32 ioread32(const volatile void __iomem *addr)
>     static inline u16 ioread16be(const volatile void __iomem *addr)
>     static inline u32 ioread32be(const volatile void __iomem *addr)


I think you are right: ioread/iowrite is poorly implemented in many arches :S

Would you mind sending the patch for asm-generic/iomap ? Or you want
me to do it.

Until this is fixed on iomap and sparc64 I think

99082eab63449f9d spi/xilinx: Remove iowrite/ioread wrappers

should be reverted and this patch ignored.

Sorry for the noise.

Thanks!



-- 
Ricardo Ribalda
