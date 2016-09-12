From: sf84@laposte.net (Sebastian Frias)
Date: Mon, 12 Sep 2016 15:15:00 +0200
Subject: ARM, SoC: About the use DT-defined properties by 3rd-party drivers
In-Reply-To: <20160912123809.GB13741@leverpostej>
References: <57BDAF2E.10502@laposte.net>
 <CAOZdJXVjsR3NTWiJX33yT3jYk=FU65raWoMooTLD7OMN3sqP-A@mail.gmail.com>
 <57D69FB1.2020801@laposte.net> <20160912123809.GB13741@leverpostej>
Message-ID: <57D6AA54.6000208@laposte.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 09/12/2016 02:38 PM, Mark Rutland wrote:
>>
>> 3rd party users of said SoC could then write kernel modules for such HW
>> blocks using the DT description. The DT would thus become the authoritative
>> source of information regarding register programming for the SoC.
> 
> I don't follow this part entirely. Why are you expecting thrid parties
> to write a driver for those blocks rather than upstreaming a driver for
> them?

3rd parties could choose to write a driver (as opposed to use say, a user-mode
library) if it fits their programming model better, if they think they would
have better performance, or other reasons.

The main idea is to make DT the authoritative source of HW description.

> 
>> Currently, HW blocks for which there is no public driver (that it is
>> accessed through user-mode libraries or firmware) require a separate
>> HW description (be it Documentation, headers, etc.)
>>
>> Since the DT describes the HW, it would make sense to expose the HW through
>> DT, that would centralise the HW description.
> 
> I would generally agree that the hardware should be described in DT.
> The difficulty is that without a 'real' user it's not always possible to
> tell if we're describing the thing correctly.
> 

That may be true, but so far we are not discussing changing DT's API so it
should not have big ramifications.
Besides, what "makes sense now" may "not make sense tomorrow" depending on
how the HW is modified.
We have somehow learned the hard-way that "le mieux est l'ennemi du bien"
(the better is the enemy of the good) and we are trying to take a more
practical (and flexible) approach.

> Putting smoething together that's only sufficient to support some
> out-of-tree driver with implicit assumptions that we are not aware of is
> far from fantastic.

That does not seem very positive and it is not the case anyway, otherwise we
would not be consulting here :-)
Agreed, right now this whole thing seems like a really hypothetical question,
but the intention is good.

Actually, I think it would encourage more SoC manufacturers to use DT as a way
to document their HW, which is a good thing.

> 
>> However, after discussing over IRC, it looks like there was no guidance on
>> this. Some people think submitting DT properties/nodes without a corresponding
>> Linux driver is frowned upon, while others thought it was an odd limitation
>> and suggested asking here.
> 
> Unfortunately, I think that the area is sufficiently vague that there
> simply is no clear and general answer.
> 
> For the sake of discussion, an example of a particular block, along with
> what you expect/need to describe would be helpful.

I don't have a more concrete example now.

As I stated, right now HW description is not centralised, and thus different
bits of information are cherry-picked by hand from HW description into DT for
bootloader, DT for Linux, Documentation/headers for 3rd-parties, etc.

But if I understood correctly your comment, you are basically saying that
without an example is hard to say.
Since the question seems understood, do you have an example of other SoC's
doing something similar?

I've seen some big DT descriptions, but it is difficult to know if we are the
first ones trying to use the DT in this way.

Best regards,

Sebastian
