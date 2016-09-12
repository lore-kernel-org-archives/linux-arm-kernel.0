From: timur@tabi.org (Timur Tabi)
Date: Mon, 12 Sep 2016 11:21:29 -0500
Subject: ARM, SoC: About the use DT-defined properties by 3rd-party drivers
In-Reply-To: <57D6D2A9.3010006@laposte.net>
References: <57BDAF2E.10502@laposte.net>
 <CAOZdJXVjsR3NTWiJX33yT3jYk=FU65raWoMooTLD7OMN3sqP-A@mail.gmail.com>
 <57D69FB1.2020801@laposte.net> <20160912123809.GB13741@leverpostej>
 <57D6AA54.6000208@laposte.net> <20160912135549.GA14165@leverpostej>
 <57D6D2A9.3010006@laposte.net>
Message-ID: <57D6D609.1090702@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian Frias wrote:
>> You're not changing the code, but you are creating a binding.
>> Bindings
>>> are intended to be stable (i.e. a working DTB from today should
>>> continue to work in future), and thus there are ramifications.

> Ok, but who is responsible for such guarantee?

The developers who create the driver and modify it.  Only upstream 
contributions count.

> How is it enforced and verified?

The upstream reviewers verify it, and if they see a problem, they reject 
the patch.

> Exactly, that's why to I'm having trouble to understand why there is
>  so much insistence on "getting the DT 100% right", since a HW change
>  could imply that what made 100% sense yesterday, does not today.

I'm not sure what you're getting at. Everything is best-effort. The 
binding for a given device is supposed to accurately, but minimally, 
describe the hardware so that the driver can program the device 
properly. Specific properties are added to the binding to handle 
specific cases. If a binding includes a description of properties that 
are not used by the driver, the developer is typically asked to remove 
those.

So I don't understand the "100% right" comment.

> Could you be more precise on those two issues? Namely: "the effort"
> and the "lack of benefit for the community"?

1) The effort = the effort by upstream developers to review the binding.

2) lack of benefit = proprietary and out-of-tree drivers do not benefit 
the community.

> I can understand the effort it takes to review a binding and some
> driver, but if there's no driver, why would it matter if the DT
> binding is 100% right?

Why bother creating a binding if there's no driver to use it?

 > Hence, why would it take more effort?
> Furthermore, if there's no driver, there's no backward compatibility
>  to guarantee. Shouldn't it require less effort?

If a developer creates a binding without a driver, then it's very hard 
to know if that binding is correct.  That's like creating a recipe 
without attempting to make the food.  How do you know it actually tastes 
good?  No one would ever ask a chef to create a "technically correct" 
recipe without cooking it first and tasting it.

> Also, what sort of "benefits" does the community expects or
> requires? Because the idea behind the proposal is to put the HW
> description in DT, so basically the HW would be documented. Maybe
> there wouldn't be a driver right away, but the HW description would
> allow for drivers to exist.

I'm not sure how many times we need to repeat this, but the idea that 
the DT binding documentation can be used as official documentation for 
the hardware is absurd.  What's wrong with the ACTUAL hardware 
documentation provided by the manufacturer in PDF format?  The DT 
binding has no value without an actual driver.
