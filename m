From: minipli@googlemail.com (Mathias Krause)
Date: Thu, 26 Mar 2015 21:49:06 +0100
Subject: String literals in __init functions
In-Reply-To: <1427392393.15849.16.camel@perches.com>
References: <5512F6C6.1020304@free.fr> <1427306517.2717.0.camel@perches.com>
 <5513FE2F.3040306@free.fr> <1427386390.15849.13.camel@perches.com>
 <CA+rthh9Fb2q+O_wicc6eNcbo6SzwOVZed=tnThJLF-xuoQ-+Cw@mail.gmail.com>
 <1427392393.15849.16.camel@perches.com>
Message-ID: <CA+rthh8irf+tTSbomivu=bgN-L1k99TQ-q6UYgmMRC1PNOG7qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 March 2015 at 18:53, Joe Perches <joe@perches.com> wrote:
> On Thu, 2015-03-26 at 17:37 +0100, Mathias Krause wrote:
>> On 26 March 2015 at 17:13, Joe Perches <joe@perches.com> wrote:
>> > On Thu, 2015-03-26 at 13:40 +0100, Mason wrote:
>> >> On 25/03/2015 19:01, Joe Perches wrote:
>> >> > On Wed, 2015-03-25 at 18:56 +0100, Mason wrote:
>> >> >
>> >> >> I started wondering if the string literals used in an __init functions
>> >> >> were automatically marked __initdata.
>> >> >>
>> >> > One proposal:
>> >> >
>> >> > https://lkml.org/lkml/2014/8/21/255
>> >>
>> >> Basically, if I understand correctly, Ingo NAKed the patch, saying
>> >> this should be done automatically by the toolchain. That would make
>> >> for an interesting side-project...
>> >
>> > True.  It's probably not feasible though.
>> >
>> > Tracking string deduplication/reuse would be pretty difficult.
>>
>> [...] Therefore I'm still not convinced that solving the
>> problem in the toolchain is the right thing to do. It's *way* more
>> complicated and probably gets it wrong more often than not. Therefore
>> the straight simple approach of manually marking the strings is IMHO
>> the best solution. Unfortunately, not everyone shares this opinion :/
>
> At least a few do though.
>
> The first 4 patches still apply and are useful in my opinion.
>
> Maybe you could resend them as a new patch set and cc Andrew Morton.
> (cc'd here too)

Andrew briefly commented on v2 of the patch set so I added him to the
Cc list when sending v3, linked above. But he did say nothing so I
guess Ingo's dislike of the approach is still valid?

Andrew, what's your opinion on such a patch set? Do you too think it's
useful? Or do you share Ingo's fear about the additional maintenance
burden?

Thanks,
Mathias
