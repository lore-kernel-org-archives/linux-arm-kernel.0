From: sf84@laposte.net (Sebastian Frias)
Date: Mon, 12 Sep 2016 18:07:05 +0200
Subject: ARM, SoC: About the use DT-defined properties by 3rd-party drivers
In-Reply-To: <20160912135549.GA14165@leverpostej>
References: <57BDAF2E.10502@laposte.net>
 <CAOZdJXVjsR3NTWiJX33yT3jYk=FU65raWoMooTLD7OMN3sqP-A@mail.gmail.com>
 <57D69FB1.2020801@laposte.net> <20160912123809.GB13741@leverpostej>
 <57D6AA54.6000208@laposte.net> <20160912135549.GA14165@leverpostej>
Message-ID: <57D6D2A9.3010006@laposte.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 09/12/2016 04:01 PM, Mark Rutland wrote:
>> 3rd parties could choose to write a driver (as opposed to use say, a user-mode
>> library) if it fits their programming model better, if they think they would
>> have better performance, or other reasons.
> 
> A vendor can always choose to "add value" in this manner. The general
> expectation of *some* driver being upstreamed remains.

Yes, that's the idea.

>>
>> That may be true, but so far we are not discussing changing DT's API so it
>> should not have big ramifications.
> 
> You're not changing the code, but you are creating a binding. Bindings
> are intended to be stable (i.e. a working DTB from today should continue
> to work in future), and thus there are ramifications.

Ok, but who is responsible for such guarantee?
How is it enforced and verified?

> 
> Few devices these says are entirely independent, and most devices can be
> instantiated multiple times (even if there happens to only be a single
> instance in practice). For the example of a userspace driver there are
> very real ABI concerns, such as how the device(s) are discovered, how
> any related components like regulators and clocks are controlled, etc.
> 
> There are ramifications here, and it's a dangerous over simplification
> to say that this doesn't matter because we're not changing kernel code.
> 
>> Besides, what "makes sense now" may "not make sense tomorrow" depending on
>> how the HW is modified.
> 
> That's always the case when a new generation of hardware comes out, so I
> don't think that's relevant to the topic at hand.

Exactly, that's why to I'm having trouble to understand why there is so much
insistence on "getting the DT 100% right", since a HW change could imply
that what made 100% sense yesterday, does not today.
Since that is a possibility we have to live with, then the "100% right" goal
is most likely unachievable.
That's different from "backwards compatibility" for which some technique,
like alternate descriptions, can be put in place.

Maybe I will get a better understanding of this once my previous question
about who and how guarantees the stability of a given DT blob.

>>
>> Actually, I think it would encourage more SoC manufacturers to use DT as a way
>> to document their HW, which is a good thing.
> 
> Writing and reviewing bindings is a very tricky topic, as it can require
> fairly intimate knowledge of a piece of hardware. I've repeatedly found
> that binding descriptions did not match the realities of the hardware,
> and I've only managed to do so by looking at accompanying driver code.
> 
> Given that manuals and other information on devices are often not freely
> available (if they exist at all), the proposal effectively limits myself
> and others to spot common (anti)patterns, which is far less than ideal,
> and will result in more mistakes.
> 
> As it stands, the proposal asks for effort for the community (in terms
> of review and maintenance of bindings), with no benefit to the kernel
> community, and a number of pitfalls that we would rather avoid.

Could you be more precise on those two issues? Namely:
"the effort" and the "lack of benefit for the community"?

I can understand the effort it takes to review a binding and some
driver, but if there's no driver, why would it matter if the DT binding is
100% right? Hence, why would it take more effort?
Furthermore, if there's no driver, there's no backward compatibility to
guarantee. Shouldn't it require less effort?

Also, what sort of "benefits" does the community expects or requires?
Because the idea behind the proposal is to put the HW description in DT, so
basically the HW would be documented. Maybe there wouldn't be a driver right
away, but the HW description would allow for drivers to exist.

> 
> In an ideal world, writing and reviewing bindings would be a simple
> affair, and this could happen separately from work on any particular OS.
> In practice, things are sufficiently complicated that you need *some*
> demonstration that a binding is suitable, which is what I'm personally
> after when I ask for a Linux driver.
> 
>>>> However, after discussing over IRC, it looks like there was no guidance on
>>>> this. Some people think submitting DT properties/nodes without a corresponding
>>>> Linux driver is frowned upon, while others thought it was an odd limitation
>>>> and suggested asking here.
>>>
>>> Unfortunately, I think that the area is sufficiently vague that there
>>> simply is no clear and general answer.
>>>
>>> For the sake of discussion, an example of a particular block, along with
>>> what you expect/need to describe would be helpful.
>>
>> I don't have a more concrete example now.
> 
> For this discussion to go somewhere, we need an example. Otherwise we're
> all coming at this with differing implicit assumptions and no clear
> evidence for any assertions.

Ok, I'll try to come up with some example.

>> But if I understood correctly your comment, you are basically saying that
>> without an example is hard to say.
>> Since the question seems understood, do you have an example of other SoC's
>> doing something similar?
> 
> I do not have an example. I know that others are using DT for data
> beyond what Linux or another OS requires, but it's my understanding that
> that is typically in a separate DTB.
> 

I see, although I don't understand how accepting such solution (i.e.: having the
information in a different DT) benefits the open-source community, since it
basically means that the open-source community settles for less information.

Best regards,

Sebastian
