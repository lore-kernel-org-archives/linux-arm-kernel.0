From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Mon, 28 May 2012 15:47:23 +0530
Subject: [PATCH v2] RFC: ARM: cache-l2x0: update workaround for PL310
 errata 727915
In-Reply-To: <20120528101132.GA956@mudshark.cambridge.arm.com>
References: <1337546505-24660-1-git-send-email-linus.walleij@stericsson.com>
 <CAMQu2gy3VTtQhnVVvzgYGhr_vA=vnW=rSBW17yoBTNwkN3wHqQ@mail.gmail.com>
 <20120522085256.GA7286@mudshark.cambridge.arm.com> <4FBB5AE8.4000801@ti.com>
 <20120522093410.GC7286@mudshark.cambridge.arm.com>
 <CAMbhsRSJADaXBEpFr2Mk3xm0-c2brYiDUAcY8u1rzP-XwycfBA@mail.gmail.com>
 <20120525145603.GG13467@mudshark.cambridge.arm.com>
 <CAMbhsRS_RtuvkrOh1nJ=cdYDgfM0tY9MivnbuWDcS_+NcW0qjQ@mail.gmail.com>
 <20120528101132.GA956@mudshark.cambridge.arm.com>
Message-ID: <CAMQu2gwyRYjMYE4CsGCdPd8TB7LLzF6QwWQ8Oy-uzNWazCUkUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 28, 2012 at 3:41 PM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Colin,
>
> On Fri, May 25, 2012 at 09:04:22PM +0100, Colin Cross wrote:
>> On Fri, May 25, 2012 at 7:56 AM, Will Deacon <will.deacon@arm.com> wrote:
>> > Right, ok. This is definitely a different problem though. Firstly, r3p1 is
>> > not affected by the original erratum and secondly the symptoms do not
>> > include deadlock. The clean during boot also sounds highly suspicious -- is
>> > there a chance you boot the kernel with a dirty L2? Is the L2 enabled or
>> > disabled when entering the kernel [I think u8500 has it enabled]?
>>
>> In a previous thread, I wrote that the 4430 I was using had r2p0. ?I
>> can't verify the accuracy of that claim right now, but my patch was
>> based on that assumption. ?Where are you getting r3p1 from?
>
> Apologies, that's what Santosh mentioned here:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-May/101302.html
>
I was mainly talking about OMAP4460 and the WA extension needed
for clean_all along with clean and invalidate.

May be since patch has both changes, for r3px and r2px, the
confusion came in.

Regards
Santosh
