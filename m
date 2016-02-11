From: robh@kernel.org (Rob Herring)
Date: Thu, 11 Feb 2016 15:46:04 -0600
Subject: breaking DT compatibility (was: Re: [PATCH v4] clk: sunxi:
 Refactor A31 PLL6 so that it can be reused)
In-Reply-To: <20160211100048.GK31506@lukather>
References: <1454358000-13594-1-git-send-email-maxime.ripard@free-electrons.com>
 <56B4E2FB.3050703@arm.com> <56BB2D79.6090402@arm.com>
 <CABGGiswOKztmRT40w4t_7BD729WgM8ueLtOD-UF_wgMbmcg4cg@mail.gmail.com>
 <20160210143755.GE31506@lukather> <20160210163001.GG2632@leverpostej>
 <20160211100048.GK31506@lukather>
Message-ID: <CAL_JsqKAjwQWZ5HpdHbMiWkuEQKFwwUNGUsb=iAZ-t7scb1FUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 11, 2016 at 4:00 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Wed, Feb 10, 2016 at 04:30:01PM +0000, Mark Rutland wrote:
>> On Wed, Feb 10, 2016 at 03:37:55PM +0100, Maxime Ripard wrote:
>> > Hi Rob,
>> >
>> > On Wed, Feb 10, 2016 at 07:42:02AM -0600, Rob Herring wrote:
>> > > On Wed, Feb 10, 2016 at 6:30 AM, Andre Przywara <andre.przywara@arm.com> wrote:
>> > > > Hi,
>> > > >
>> > > > just a ping:
>> > > >
>> > > > Are we really OK with breaking existing DTs in 4.6? (per the code in
>> > > > -next: f7d372ba54ea04d528a291b8dbe34716507bb60b, which is this patch).
>> > >
>> > > I only warn and make sure people are aware of the issue. I leave that
>> > > up to platform maintainers to decide. It depends on the maturity of
>> > > the platform and users.
>> >
>> > The impacted SoCs support is really partial. For the most supported
>> > one, big things like display or sound are totally missing, and we
>> > still update them on a regular basis to add support for new
>> > devices. As such, users are very likely to upgrade the DT from one
>> > version to another just because there's new devices available to
>> > them. And the newest SoC impacted just got introduced in 4.5, and only
>> > has the UART and MMC devices available.
>> >
>> > > If people complain about it then it's their mess. For platforms
>> > > supported in distros such as debian or fedora, I would strongly
>> > > recommend against breaking compatibility.
>> >
>> > None of them are officially supported:
>> > https://www.debian.org/releases/stable/armhf/ch02s01.html.en
>> > https://fedoraproject.org/wiki/Architectures/ARM#Fedora_23
>> >
>> > Only the older one are, and they are not affected by this patch.
>> >
>> > > They do ship dtbs, but it's a chicken and egg problem. If dtbs were
>> > > stable and provided by firmware, then they wouldn't have to provide
>> > > them. If dtbs are unstable, then they have no choice.
>> >
>> > And while it might work great on platforms that have all the needed
>> > documentation, or a perfect one, which is our case. Almost each
>> > release, we discover that something is not working as it was
>> > documented, when it was documented in the first place.
>> >
>> > It also seems that even on well documented platforms, supported by the
>> > vendors, the stable ABI dream is not going to happen:
>> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/arm/Atmel/README#n105
>> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/arm/marvell,berlin.txt#n4
>>
>> To be quite frank, I completely disagree with that stance.
>>
>> It seems like the only reason DT bindings aren't remaining stable is
>> because people are deliberately ignoring the requirement and reasoning
>> for doing so.
>
> And for DT maintainers saying on multiple occasions that it's bad but
> ok to break it and / or that they never actually said that it was a
> stable ABI...

It says so in the documentation, why do we need to repeat it? While I
do defer to platform maintainers judgement, if there is complete
disregard for the ABI then I won't. This single case alone doesn't
bother me so much, but if this is the pattern every kernel cycle I am
bothered.

Also, I'm inclined to go delete the text in the links above.

> I'm guessing it could be a stable ABI if there was bindings
> reviews. Rob actually started to review a significant amount of
> bindings lately, and that's really appreciated, but if you don't
> review all the bindings, then we're going to make mistakes.

Everything should be reviewed. Subsystem/platform maintainers are
responsible for reviewing and getting DT help if needed. There is
documentation about this too. Maybe this system is not working well
and needs to be revisited. I know the reviews are better for some
subsystems than others. I am trying to be more actively reviewing
things, but subsystem maintainers still need to review them. They
should know their bindings better than me.

Even if we review all bindings, there will still be mistakes.

Rob
