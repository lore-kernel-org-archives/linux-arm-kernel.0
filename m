From: khilman@ti.com (Kevin Hilman)
Date: Fri, 18 May 2012 07:13:08 -0700
Subject: [PATCHv5 3/8] ARM: OMAP4460: Workaround for ROM bug because of
 CA9 r2pX gic control register change
In-Reply-To: <CAMQu2gyqhxVP1M7ftxJ5qqmZ8Bp0ZmHd=7EjJZ7G1Y=Md=vT=g@mail.gmail.com>
 (Santosh Shilimkar's message of "Fri, 18 May 2012 11:35:36 +0530")
References: <1336989796-26594-1-git-send-email-t-kristo@ti.com>
 <1336989796-26594-4-git-send-email-t-kristo@ti.com>
 <87zk99ce5q.fsf@ti.com> <4FB3707B.2080200@ti.com>
 <4FB39C5A.5080404@ti.com> <87mx586pci.fsf@ti.com>
 <CAMQu2gxKmeEnZr8PHZjuC_PUUzjbn7gDkG5NDKM6h2kuS+aJVQ@mail.gmail.com>
 <87txzeybhu.fsf@ti.com>
 <CAMQu2gyqhxVP1M7ftxJ5qqmZ8Bp0ZmHd=7EjJZ7G1Y=Md=vT=g@mail.gmail.com>
Message-ID: <87likpo9vv.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:

> On Thu, May 17, 2012 at 10:45 PM, Kevin Hilman <khilman@ti.com> wrote:

[...]

>> What's not at all clear is what the ROM code does *after* this. ?Does it
>> clear both bits? ?or just bit 0? ?Since it's r1pX based, I would expect
>> that it doesn't touch anything other than bit 0.
>>
> Actually since the condition of control register == 1 is not satisfied,
> It re-inits entire GIC thinking it's not configured at all. So everything
> will be cleared and including non-secure GIC dist. enable bit.

Aha, that's the missing piece of the puzzle: The ROM code is clearing
bits that are unused on r1pX (but used on r2pX).  That is the root of
this bug and needs more description.

Thanks for clarifying.

[...]

>> Santosh, I do understand what is happening here. ?But I play dumb so
>> that it will be described in great detail in the changelog so that when
>> I forget (and you forget) we can go back to this and get a quick
>> understanding of both the bug and the workaround.
>>
>> Since you are very deeply familiar with this bug, it's understandably
>> hard to write this changelog since most things probably seem obvious to
>> you. ?A suggestion would be to have a few colleagues that are not
>> familiar with this bug read the changelog and try and describe it back
>> to you.
>>
> I agree with you. This is side effect of knowing some BUGs too much.
> I will work with Tero so that change log captures more details.

Thanks.

Maybe Jon Hunter can help review the changelog too.  IMO, he is the
reigning champion of thorough, descriptive and detailed changelogs.  :)

Kevin
