From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 28 Oct 2015 10:21:10 +0100
Subject: [PATCH] MAINTAINERS: Start using the 'reviewer' (R) tag
In-Reply-To: <20151028082446.GF5828@x1>
References: <1445960557-24328-1-git-send-email-lee.jones@linaro.org>
 <20151027172428.GB21070@earth> <20151027181555.GE5828@x1>
 <1445971482.2757.27.camel@perches.com>
 <CAJKOXPc_w2Dc8LvkCu_d+kjZZmYScXboQrpNWdicT2yfL_5D7Q@mail.gmail.com>
 <20151028082446.GF5828@x1>
Message-ID: <CABxcv=mGZstqyrkB95hjDCYCvhDJDVD=ga-Fg_5yPtXETuWe=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lee,

On Wed, Oct 28, 2015 at 9:24 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 2015-10-27 at 18:15 +0000, Lee Jones wrote:
>> On Tue, 27 Oct 2015, Sebastian Reichel wrote:
>> > On Tue, Oct 27, 2015 at 03:42:37PM +0000, Lee Jones wrote:
>> > > Since eafbaac ("MAINTAINERS: Add "R:" designated-reviewers tag") we
>> > > have been able to tag specific people as Reviewers.  These are key
>> > > individuals who are tasked with or volunteer to review code submitted
>> > > to a subsystem or specific file.  However, according to MAINTAINERS
>> > > we have 1046 Maintainers and only a mere 22 Reviewers.  I believe
>> > > these numbers to be incorrect, as many of these Maintainers are in
>> > > fact Reviewers.
>
> Most entries in MAINTAINERS seem to be vanity entries than actual
> active participants.  A person typically writes a driver, adds a
> MAINTAINER entry, then forgets about it and/or the hardware becomes
> outdated.
>
> This I agree with.
>
> On Wed, 28 Oct 2015, Krzysztof Kozlowski wrote:
>> 2015-10-28 3:44 GMT+09:00 Joe Perches <joe@perches.com>:
>> > On Tue, 2015-10-27 at 18:15 +0000, Lee Jones wrote:
>> > > On Tue, 27 Oct 2015, Sebastian Reichel wrote:> >
>> > > > I think you should CC the people, which are changed from "M:" to
>> > > > "R:", though.
>> > >
>> > > Yes, makes sense.
>> > >
>> > > I'd like to collect some Maintainer Acks first though.
>> >
>> > I think people from organizations like Samsung are actual
>> > maintainers not reviewers.
>
> So this all hinges on how we are describing Maintainers and Reviewers.
>
> My personal definition (until convinced otherwise) is that Reviewers
> care about their particular subsystem and/or files.  They conduct code
> reviews to ensure nothing gets broken and the code base stays in best
> possible state of worthiness.  On the other hand Maintainers usually
> conduct themselves as Reviewers but also have 'maintainership' duties
> as well; such as applying patches, *maintaining*, testing, rebasing,
> etc, an upstream branch and ultimately sending pull-requests to higher
> level Maintainers i.e. Linus.  Maintainers also have the ultimate say
> (unless over-ruled by Linus etc) over what gets applied.
>
>> > Their drivers are not thrown over a wall and forgotten.
>>

I've a different definition. For me it depends on much do you care
about the component. For example I maintain a couple of drivers in the
kernel and Device Tree files for some boards that are important to me
but I also care about some other subsystems (i.e: Exynos SoC support)
and I act as a reviewer (although I'm not officially listed as
reviewer in the MAINTAINERS file).

We do have in fact different tags for each type of involvement so I
usually answer with a Reviewed-by tag if I review code for a subsystem
I care but I don't maintainer or answer with an Acked-by tag if I
review *and agree* with a patch for a component I maintain (so the
maintainer knows that is good to apply differently from the list if
needed).

Now, that doesn't mean that I provide a pull request for the drivers
or boards I maintain on every release since that will depend on the
number of patches posted for that component per release. So if there
are only a couple of patches, I think is easier for the subsystem
maintainer to pick those directly from the list but if there are a lot
of them, then the maintainer may ask me to prepare a branch to pull
and I've done in the past for drivers I maintain to be sure that the
patches in the list are applied in the right order, no needed patches
were missed, etc.

Another difference is that when I'm listed as a maintainer, I feel an
obligation to answer to the patches touching that component but that's
not the case for components I usually act as a reviewer, I may review
it if I have time but if I don't, I let other people to review it.

>> At least for Samsung Multifunction PMIC drivers (and some of Maxim
>> MUICs and PMICs) these are actively used by us in existing and new
>> products. They are also continuously extended and actually maintained.
>> This means that it is not only about review of new patches but also
>> about caring that nothing will become broken.
>
> Exactly.  This what I expect of any good code Reviewer.
>
>> I would prefer to leave the "SAMSUNG MULTIFUNCTION PMIC DEVICE
>> DRIVERS" entry as is - maintainers.
>

I agree with Krzysztof here, I would prefer to keep them as
maintainers if they are maintaining the drivers.

> But you aren't maintaining the driver i.e. you don't collect patches
> and *maintain* them on an upstream branch.  Granted some of you guys
> are doing a great job of maintaining branches on your downstream or
> BSP kernels, but conduct a Reviewer type role for upstream.
>
> You guys are pushing back like this is some kind of demotion.  That's
> not the case at all.  All it does is better describe the (very worthy)
> function you *actually* provide.
>

But I think it makes description less accurate in fact, since without
$SUBJECT get_maintainers.pl reports for example:

Krzysztof Kozlowski <k.kozlowski@samsung.com> (supporter:MAXIM PMIC
AND MUIC DRIVERS FOR EXYNOS BASED BO...)
Lee Jones <lee.jones@linaro.org> (supporter:MULTIFUNCTION DEVICES (MFD))

and after the change:

Krzysztof Kozlowski <k.kozlowski@samsung.com> (reviewer)
Lee Jones <lee.jones@linaro.org> (supporter:MULTIFUNCTION DEVICES (MFD))

He also works for Samsung so the driver is not only maintained but
supported since he can actually take care of it as a part of his day
job (if I understood correctly).

> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
>

Best regards,
Javier
