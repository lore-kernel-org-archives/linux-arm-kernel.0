From: broonie@kernel.org (Mark Brown)
Date: Mon, 12 May 2014 13:17:29 +0100
Subject: [PATCH 2/3] arm64: Add big.LITTLE switcher stub
In-Reply-To: <5370877C.40409@arm.com>
References: <1399653631-4938-1-git-send-email-broonie@kernel.org>
 <1399653631-4938-2-git-send-email-broonie@kernel.org>
 <536D0AF4.1040705@arm.com> <20140509175005.GT12304@sirena.org.uk>
 <536D2533.6050100@arm.com> <20140509192921.GY12304@sirena.org.uk>
 <5370877C.40409@arm.com>
Message-ID: <20140512121729.GC12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 09:34:04AM +0100, Sudeep Holla wrote:
> On 09/05/14 20:29, Mark Brown wrote:
> >On Fri, May 09, 2014 at 07:57:55PM +0100, Sudeep Holla wrote:

> >>If some real platform that needs this support urgently, then we can think of
> >>similar short-term solution as part of adding support for cpufreq on that
> >>platform. Do you know any platform that needs this right now ?

...
> >There's some other non-public devices I am aware of - the whole reason I
> >wrote this series was for those.

> Correct all these are 32-bit platforms which are now in process of upstreaming.
> So far they had their own driver and never used the arm-big-little driver.
> And this current series deals with 64-bit platforms.

Except for the non-public devices on the end of the list there :)

> >There are real users who want to use this fairly urgently.  I can't be
> >specific, sorry.

> That's fine, I understand. But the main argument is that if these platforms
> will not add support for cpufreq upstream anytime soon, I don't see any value
> in rushing to this short term solution.

This all gets a bit circular though - the more patches people have to
carry to make upstream useful to them less useful working with upstream
seems to them, meaning the devices are less likely to appear upstream at
all at least in any sort of complete form.  One out of tree patch being
required isn't going to be a deal breaker by itself but they all add up
to a perception that upstream isn't useful.

There's definitely some taste considerations with how far you go to
cater for such systems - in this case I'd say it's just tweaking Kconfig
to allow people to use code that's already present rather than adding
really new code (there's the stubs but they're pretty insubstantial)
which means upstream doesn't have to carry anything that wasn't there
already.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140512/0bb21862/attachment-0001.sig>
