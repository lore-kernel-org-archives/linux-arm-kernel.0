From: omycle@gmail.com (Li Haifeng)
Date: Wed, 20 Feb 2013 10:01:18 +0800
Subject: A noobish question on mm
In-Reply-To: <CAHbM+PNL+m098RWZN1EjYeLh-kLUsoOJAYBDXecmJ0-ci7oYgA@mail.gmail.com>
References: <CAHbM+PPcATz+QdY3=8ns_oFnv5vNi_NerU8hLnQ-EPVDwqSQpw@mail.gmail.com>
 <CAFNq8R5q7=wx6WgDwYUrgntMfewHEU=YHTCG4CZp3JcYZsCzhw@mail.gmail.com>
 <CAHbM+PNL+m098RWZN1EjYeLh-kLUsoOJAYBDXecmJ0-ci7oYgA@mail.gmail.com>
Message-ID: <CAFNq8R5c-E4s5RyZukAR--Qy4xADDATwti1-Lmw6QmSQ+HO4pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/2/19 Soham Chakraborty <sohamwonderpiku4u@gmail.com>:
>
>
> On Tue, Feb 19, 2013 at 12:08 PM, Li Haifeng <omycle@gmail.com> wrote:
>>
>> 2013/2/19 Soham Chakraborty <sohamwonderpiku4u@gmail.com>:
>> > Hey dude,
>> >
>> > Apologies for this kind of approach but I was not sure whether I can
>> > directly mail the list with such a noobish question. I have been poking
>> > around in mm subsystem for around 2 years now and I have never got a
>> > fine,
>> > bullet proof answer to this question.
>> >
>> > Why would something swap even if there is free or cached memory
>> > available.
>>
>> It's known that swap operation is done with memory reclaiming.There
>> are three occasions for memory reclaiming: low on memory reclaiming,
>> Hibernation reclaiming, periodic reclaiming.
>>
>> For periodic reclaiming, some page may be swapped out even if there is
>> free or cached memory available.
>
>
> So, meaning even if there is free or cached memory available, periodic
> reclaiming might cause some pages to be swapped out. Is this the rationale.
> If so, which part of the source explains this behavior
>

The following sentences is from "Understanding Linux Kernel 3rd".

If _ _alloc_pages( ) discovers that all memory zones suitable for a
memory allocation have a number of free page frames below a "warning"
threshold essentially, a value based on the pages_low and protection
fields of the memory zone descriptor then the function wakes up the
kswapd kernel threads of the corresponding memory nodes. Essentially,
the kernel starts to reclaim some page frames in order to avoid much
more dramatic "low on memory" conditions.

About kswapd kernel threads, please look at kswapd() in file of "mm/vmscan.c".

Regards,
Haifeng Li

>>
>> Please correct me if my understanding is wrong.
>>
>> Regards,
>> Haifeng Li
>> >
>> > I have read about all possible theories including lru algorithm,
>> > vm.swappiness, kernel heuristics, overcommit of memory and all. But I
>> > for
>> > the heck of me, can't understand what is the issue. And I can't make the
>> > end
>> > users satisfied too. I keep blabbering kernel heuristics too much.
>> >
>> > Do you have any answer to this question. If you think this is worthy of
>> > going to list, I will surely do so.
>> >
>> > Soham
>
>
