From: broonie@kernel.org (Mark Brown)
Date: Thu, 29 Aug 2013 12:05:34 +0100
Subject: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
In-Reply-To: <CA+Bv8XZagHZ9mUuZB49hrH=901fXzoAcV8C0Fm3EfLa2eiBu0w@mail.gmail.com>
References: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
 <1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
 <CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
 <87txiasqhk.fsf@linaro.org>
 <CA+Bv8XZagHZ9mUuZB49hrH=901fXzoAcV8C0Fm3EfLa2eiBu0w@mail.gmail.com>
Message-ID: <20130829110534.GV10783@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 06:05:34PM -0700, Russ Dill wrote:
> On Tue, Aug 27, 2013 at 3:44 PM, Kevin Hilman <khilman@linaro.org> wrote:

> > The framework already has a concept of suspend voltage, suspend mode
> > etc.  Maybe it needs some generalizing so low-level platform code could
> > query the framework for the sequence so it can be done late in platform
> > idle/suspend paths.  Especially for regmap drivers, this seems feasible.

> Yes, my main hesitation for going down this path is possible lack of
> support for such an interface upstream.

Someone is going to have to walk me through the context for me to fully
understand what this is all about - what's the problem?

Generally for suspend if the sequencing is being done by the processor
it's been handled by the drivers for the components in question.  For
sequencing beyond that you're into hardware features which aren't all
that regular sadly and often aren't controllable either.  It sounds like
this is the latter case but the thing that manages some of the late
power down stages does so using a firmware we can rewrite?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130829/03182f12/attachment.sig>
