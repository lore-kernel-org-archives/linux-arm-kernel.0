From: timur@tabi.org (Timur Tabi)
Date: Mon, 12 Sep 2016 08:23:59 -0500
Subject: ARM, SoC: About the use DT-defined properties by 3rd-party drivers
In-Reply-To: <57D6AA54.6000208@laposte.net>
References: <57BDAF2E.10502@laposte.net>
 <CAOZdJXVjsR3NTWiJX33yT3jYk=FU65raWoMooTLD7OMN3sqP-A@mail.gmail.com>
 <57D69FB1.2020801@laposte.net> <20160912123809.GB13741@leverpostej>
 <57D6AA54.6000208@laposte.net>
Message-ID: <57D6AC6F.5040504@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian Frias wrote:
> 3rd parties could choose to write a driver (as opposed to use say, a user-mode
> library) if it fits their programming model better, if they think they would
> have better performance, or other reasons.
>
> The main idea is to make DT the authoritative source of HW description.

Do you really expect the open-source community to make a serious effort 
to support out-of-tree drivers written by developers who have no 
intention of upstreaming?

There's a process for writing a Linux kernel driver with a DT binding. 
That process is not broken.

>> >Putting smoething together that's only sufficient to support some
>> >out-of-tree driver with implicit assumptions that we are not aware of is
>> >far from fantastic.
> That does not seem very positive and it is not the case anyway, otherwise we
> would not be consulting here:-)

Mark is correct.  Trying to create a device tree binding, and getting it 
correct 100% the first time, without an actual drivers is just 
impossible.  To even attempt that is folly.

> Agreed, right now this whole thing seems like a really hypothetical question,

Yes, it is.

> but the intention is good.

I'm not sure I agree with that.

> Actually, I think it would encourage more SoC manufacturers to use DT as a way
> to document their HW, which is a good thing.

No it isn't.  SOC manufacturers should just release the documentation 
they have.

> But if I understood correctly your comment, you are basically saying that
> without an example is hard to say.
> Since the question seems understood, do you have an example of other SoC's
> doing something similar?

Similar to what?  Every upstream driver today is written the way we're 
talking about -- submit the driver with the binding, and both are 
reviewed together.

> I've seen some big DT descriptions, but it is difficult to know if we are the
> first ones trying to use the DT in this way.

Hopefully, you'll be the last.
