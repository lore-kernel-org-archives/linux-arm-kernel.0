From: eric@anholt.net (Eric Anholt)
Date: Sat, 02 Jan 2016 10:14:37 -0800
Subject: [PATCH v2 1/3] clk: bcm2835: Add bindings for the auxiliary
 peripheral clock gates.
In-Reply-To: <20151231001859.19557.99512@quark.deferred.io>
References: <1450222559-22461-1-git-send-email-eric@anholt.net>
 <20151228223935.25842.28675@quark.deferred.io>
 <CAL_JsqLu7=66jEuaezesEuoPsBBhRAT0UQcLVNOLVwkEvQacRA@mail.gmail.com>
 <1477432.fTm0GUZ57A@wuerfel> <20151231001859.19557.99512@quark.deferred.io>
Message-ID: <87h9ivonle.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Turquette <mturquette@baylibre.com> writes:

> Hi Arnd,
>
> Quoting Arnd Bergmann (2015-12-30 01:29:02)
>> It's also ok to merge the header file and binding with either the dts file
>> changes or the driver and then do the other part the following release.
>> 
>> In the past, we've worked around the issue by merging the driver through
>> arm-soc, or by merging the dts changes through a driver tree, with the
>> appropriate Acks in each case. Both of those approaches work of course,
>> but the former always feels awkward to me as we are not using the right
>> maintainer path, and the latter approach tends to cause merge conflicts,
>> especially when multiple headers for different subsystems get added or
>> the dts files are added at the same time.
>> 
>> Having a shared branch for the header file is another way to do it, and
>> we can do that in some cases, but I'd prefer not to make it the default.
>
> Well, I'm thinking that an immutable branch isn't such a bad idea given
> that both you and Rob are OK with subsystems merging headers and binding
> descriptions.
>
> A while back Stephen Boyd and I started to use topic branches for every
> driver, all based on -rc1 and merging those into clk-next. This makes it
> trivial for us to push a shareable branch with minimal dependencies.
>
> So at least for the clk tree, how do you feel about us merging driver +
> header + binding description and then sharing our topic branch as-needed
> with arm-soc? We could even push our topic branches by default to cut
> down on coordinating over email back-and-forth.
>
> As an example, patch #1 from the Hi3519 series[0] includes the clk
> driver, binding description and a shared header. Any objection to me
> taking that patch as-is, based on -rc1, and pushing out that topic
> branch as clk-hi3519 to the clk git tree with the expectation that
> you'll just merge that if you need to?
>
> You can let me know if you've pulled it in, and then I won't rebase
> without consulting with the arm-soc folks first.
>
> Does this workflow agreement Solve All the Problems?
>
> (Note that the patch I referenced is still under review so the branch
> name I mentioned above doesn't exist yet. It is just an example)

For what it's worth, this is a nice workflow for me as a driver
developer.  I have a couple of .dts patches that ended up waiting this
cycle because I didn't have the shareable branches necessary.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160102/ac1cdc76/attachment.sig>
