From: olof@lixom.net (Olof Johansson)
Date: Sun, 4 Aug 2013 23:49:03 -0700
Subject: [ARM ATTEND] Interested in R/M-class (!MMU), automated testing
In-Reply-To: <20130804122527.GV3880@pengutronix.de>
References: <51FBF93D.8040707@arm.com> <20130804122527.GV3880@pengutronix.de>
Message-ID: <CAOesGMgnYLXRWRtKckofNpsxmRgT0cXL=JcAMirXibe92+AWOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 4, 2013 at 5:25 AM, Robert Schwebel
<r.schwebel@pengutronix.de> wrote:

>> - Ways to do more automated testing of ARM kernels, including hearing
>>   from other people what they use to build/boot/test/benchmark their
>>   code (perhaps even get a discussion going about using the diverse
>>   range of hardware people have around put to use as test-machines).
>
> That's pretty interesting; we have a test farm at PTX, but it mainly
> does nightly build + boot tests on mainline, for systems we care of.

I have a small (but growing) farm of boards here that I do some (so
far) limited boot testing, but I do it a few times a day on mainline,
and nightly on linux-next and arm-soc for-next branches. I also do it
for -stable but right now only for published releases since I so far
only handle pulling whole git branches.

I also build every defconfig on arm at the same cadence. Everything's
handled by a couple of scripts that emails me the results (as compared
to building a status webpage that I have to go check). So essentially
every morning I have an email with the fresh -next breakage waiting
for me to look at.

The hardware comes from various sources; some I've bought myself,
other I've been sent by kind vendors. All of them are "modern" though,
i.e. v7-class hardware with decent amount of memory, etc. I netboot
everything with local rootfs at the moment.


I honestly don't know if there's much point in doing complex
centralized testing/reporting. I've found that I never go look for the
results. I don't regularly check Russell's autobuilder status, for
example. Nor the kisskb -next build status. But having my own scripts
email me has been useful. I do hope that most ARM subplatform
maintainers have some semi-automated setup for frequent testing as
well, but I know that reality is that far from all do.

It could make sense to show what some of us use to give others
examples of what might work for them. There's a thousand ways to build
these kind of things, some elaborate and others quite simple. I've
definitely started at the simple end myself. :)


-Olof
