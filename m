From: ricardo.ribalda@gmail.com (Ricardo Ribalda Delgado)
Date: Thu, 29 Jan 2015 23:14:46 +0100
Subject: [PATCH] spi/xilinx: Cast ioread32/iowrite32 function pointers
In-Reply-To: <2800334.5ezTSQFkNQ@wuerfel>
References: <1422543073-21895-1-git-send-email-ricardo.ribalda@gmail.com>
 <CAMuHMdX5CMH0Q5S_BBjb-F-kJfzkTS+sP9H-FDe_K_gFRxK7pw@mail.gmail.com>
 <CAPybu_3O3Rcq1Rvxvbpc-GOSs+VbO74_u+vfH+UtXjLAQjWLQA@mail.gmail.com>
 <2800334.5ezTSQFkNQ@wuerfel>
Message-ID: <CAPybu_0OWLZeEFMByrrDg7HOfjAYbOnAoazLac-E8KV-mKSJSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd

On Thu, Jan 29, 2015 at 11:11 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > I think the definitions in include/asm-generic/iomap.h are actually wrong,
>> > as they lack a const:
>> >
>> >     extern unsigned int ioread8(void __iomem *);
>> >     extern unsigned int ioread16(void __iomem *);
>> >     extern unsigned int ioread16be(void __iomem *);
>> >     extern unsigned int ioread32(void __iomem *);
>> >     extern unsigned int ioread32be(void __iomem *);
>> >
>> > Note that the definitions in include/asm-generic/io.h do have the const:
>> >
>> >     static inline u8 ioread8(const volatile void __iomem *addr)
>> >     static inline u16 ioread16(const volatile void __iomem *addr)
>> >     static inline u32 ioread32(const volatile void __iomem *addr)
>> >     static inline u16 ioread16be(const volatile void __iomem *addr)
>> >     static inline u32 ioread32be(const volatile void __iomem *addr)
>>
> I think we don't need the 'volatile' keyword here. The main reason
> we have it on readl() is to shut up the compiler when dealing with
> ancient driver code that annotates iomem pointers as volatile.
>
> This is generally considered a (minor) driver mistake though, and
> modern drivers that for some reason use ioread*() typically don't
> do that (or they get a warning).

What about the different return type? u8 vs int
Thanks

-- 
Ricardo Ribalda
