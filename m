From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Wed, 26 Feb 2014 16:38:20 -0800
Subject: [PATCH v7 5/9] ARM: Enable erratum 798181 for Broadcom Brahma-B15
In-Reply-To: <20140226104702.GA8961@mudshark.cambridge.arm.com>
References: <1393410552-21497-1-git-send-email-marc.ceeeee@gmail.com>
 <1393410552-21497-6-git-send-email-marc.ceeeee@gmail.com>
 <20140226104702.GA8961@mudshark.cambridge.arm.com>
Message-ID: <CADtm3G7JcO6+Sc6Dsw1swY09F7+-KSXjsQU8CBcH-K6On2aP_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Wed, Feb 26, 2014 at 2:47 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Feb 26, 2014 at 10:29:08AM +0000, Marc Carino wrote:
>> From: Gregory Fong <gregory.0xf0@gmail.com>
>>
>> Broadcom Brahma-B15 (r0p0..r0p2) is also affected by Cortex-A15
>> erratum 798181, so enable the workaround for Brahma-B15.
>
> Really... *exactly* the same erratum? That sounds pretty unlikely, so I'd
> really like to be sure that the workaround we have indeed solves your
> problem (issuing a dummy TLBI to 0x0 + dsb, then followed by a dmb + clrex
> on each core). The point is that the workaround doesn't simply perform
> non-shareable invalidation on each core using IPIs.

Yes, it should be the same.  I've sent you more detail off-list.

Regards,
Gregory
