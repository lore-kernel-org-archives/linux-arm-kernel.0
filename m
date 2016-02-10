From: rob.herring@linaro.org (Rob Herring)
Date: Wed, 10 Feb 2016 08:02:45 -0600
Subject: [PATCH v4] clk: sunxi: Refactor A31 PLL6 so that it can be reused
In-Reply-To: <20160210125936.GD31506@lukather>
References: <1454358000-13594-1-git-send-email-maxime.ripard@free-electrons.com>
 <56B4E2FB.3050703@arm.com> <20160210125936.GD31506@lukather>
Message-ID: <CABGGisxORFOxLVQiTZ=gEr6j2JnVcjQxTLJFPa7uG93g46CKwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 6:59 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Fri, Feb 05, 2016 at 05:59:23PM +0000, Andre Przywara wrote:
>> Hi Maxime,
>>
>> just found this while looking at your current git branch, so sorry for
>> the late reply.
>>
>> CC:ing DT people, since you touch both existing DTs(!) and the binding doc.

[...]

>> So are you really breaking all those systems by changing the DT and the
>> driver in an incompatible way?
>
> Yes.
>
>> Please correct me if this assessment is wrong, but to me it looks like
>> any user out there is either stuck with 4.5 at best _or_ will only be
>> able to run 4.6 and later (depending on which version of the DT she is
>> using)? And no, switching DTs along with the kernel is _not_ an option.
>
> It is. And it is one that every other ARM platform chose. And so did
> every distribution.

I do leave it to platform maintainers judgement (perhaps that should
be reconsidered), but it should still be case by case basis not an all
out disregard for the ABI. If you decide to ignore the ABI, then there
is no decision for the distros or other users.

>> That is not how I understand DT.
>
> I'm sorry for that. This has never been something we said was
> happening.
>
>> Also this totally ignores any other DT user (U-Boot, FreeBSD, you
>> name it).
>
> Which all have their own DT copies, with their own bindings, that we
> (ie Linux) never agreed on.

That is not really true. There are some differences ATM, but they are
largely derivatives of the kernel copy and the goal is to align them.
If we don't maintain an ABI, that will never happen.

> By further extending that argument, you're currently looking at the DT
> from Allwinner, do you want to support theirs as well?

Vendor ones we treat like vendor kernels. However, if the differences
come down to bikeshedding, then we will take vendor bindings to
maintain the ABI. That's generally only when the compatible string
differs though.

Rob
