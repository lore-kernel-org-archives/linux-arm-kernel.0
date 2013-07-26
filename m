From: robherring2@gmail.com (Rob Herring)
Date: Fri, 26 Jul 2013 17:11:32 -0500
Subject: DT bindings as ABI [was: Do we have people interested in device
 tree janitoring / cleanup?]
In-Reply-To: <51F1C412.1010602@wwwdotorg.org>
References: <CAOesGMhJ+je8FZqeFxhAcYwU0CHYer+aGP6DA_8x3azrzfA2sw@mail.gmail.com>
 <CAL_JsqJQWOLC9f1igEpsgJB2X8mFDpqLDaFFRjGGVHctjWZLgQ@mail.gmail.com>
 <20130725193135.GT23879@titan.lakedaemon.net>
 <CAL_Jsq+vWbTb8wNEDCR2c_M6sBnKW6e5HGk48QzmXSujQUdddA@mail.gmail.com>
 <51F1C412.1010602@wwwdotorg.org>
Message-ID: <CAL_JsqLweU0Mt_8zsBu=-3Mx4Tc3Gn088j3xN27Hnq57etCofw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 7:34 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 07/25/2013 01:16 PM, Rob Herring wrote:
>> On Thu, Jul 25, 2013 at 2:31 PM, Jason Cooper <jason@lakedaemon.net> wrote:
>>> On Thu, Jul 25, 2013 at 02:11:31PM -0500, Rob Herring wrote:
>>>> On Thu, Jul 25, 2013 at 11:09 AM, Olof Johansson <olof@lixom.net> wrote:
>>>
>>>>> One problem that needs to be solved is obviously how a binding
>>>>> graduates from tentative to locked. This work isn't going to be very
>>>>> interesting to most people, I suspect. Think standards committee type
>>>>> work.
>>>>
>>>> I think a time based stabilization period would be better than a
>>>> separate directory to apply bindings too. Or time plus periodic review
>>>> perhaps.
>>>
>>> The only problem with a time-based versus separate directory is how do
>>> users who've downloaded the tree determine which bindings are stable?
>>> If they pull a tarball, or receive an SDK, there is most likely no git
>>> history attached.
>>
>> Well, if time based includes moving the binding out of the kernel,
>> then that is what defines it as stable or not. I guess that is a form
>> of a separate directory. I don't think we want to be moving bindings
>> twice: tentative -> stable and kernel -> DT repo.
>>
>> The policy could be as simple as an binding without change in at least
>> N kernel releases is moved out and stable.
>
> That might not be quite the right criteria. Just because something
> didn't change doesn't mean it's "correct" and that any problems in the
> binding have been addressed. As one example, on Tegra, we have a few
> bindings that haven't changed in a while, yet rely on custom properties
> for describing which DMA channel to use, rather than using the
> fairly-recently-introduced standard DMA DT properties (this particular
> example is being rectified now, but I'm sure there are plenty of similar
> examples)

In this case, I would suggest that both bindings are stable and the
conversion from one to the other is a platform decision. You could
make the kernel support both if you wanted. Or you know the platform
is not stable and are okay with having to keep dtb and kernel in sync.

I think this highlights the need to separate stable bindings and
stable dts files.

Rob
