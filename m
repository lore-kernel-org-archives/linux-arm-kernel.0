From: ccross@android.com (Colin Cross)
Date: Mon, 28 May 2012 09:37:26 -0700
Subject: [PATCH v2] RFC: ARM: cache-l2x0: update workaround for PL310
 errata 727915
In-Reply-To: <20120528101132.GA956@mudshark.cambridge.arm.com>
References: <1337546505-24660-1-git-send-email-linus.walleij@stericsson.com>
 <CAMQu2gy3VTtQhnVVvzgYGhr_vA=vnW=rSBW17yoBTNwkN3wHqQ@mail.gmail.com>
 <20120522085256.GA7286@mudshark.cambridge.arm.com>
 <4FBB5AE8.4000801@ti.com>
 <20120522093410.GC7286@mudshark.cambridge.arm.com>
 <CAMbhsRSJADaXBEpFr2Mk3xm0-c2brYiDUAcY8u1rzP-XwycfBA@mail.gmail.com>
 <20120525145603.GG13467@mudshark.cambridge.arm.com>
 <CAMbhsRS_RtuvkrOh1nJ=cdYDgfM0tY9MivnbuWDcS_+NcW0qjQ@mail.gmail.com>
 <20120528101132.GA956@mudshark.cambridge.arm.com>
Message-ID: <CAMbhsRTYq=Ezg-ypJfEKSxQTsKTJFuNWQJRoOXc7O8Oj2rsWwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 28, 2012 at 3:11 AM, Will Deacon <will.deacon@arm.com> wrote:
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
> so, assuming that it's the same problem, it seems that both r3p1 and r2p0
> are affected.

Ah, I missed that.  The issue I was seeing only affected 4430 (r2p0).

>> When I said I couldn't reproduce the issue with clean during boot, I
>> meant that I couldn't trigger the issue during boot by calling clean
>> repeatedly. ?I could still reproduce the issue after boot even if the
>> cache was cleaned during boot.
>
> Ok, that's interesting. I wonder if erratum #769419 is to blame? We now have
> a workaround in the kernel for that, so you could give it a try if you're in
> a position to do so.

I don't have any 4430 devices any more.
