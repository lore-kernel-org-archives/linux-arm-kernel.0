From: broonie@kernel.org (Mark Brown)
Date: Thu, 29 Aug 2013 16:49:29 +0100
Subject: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
In-Reply-To: <CAGa+x85u0OpB9o71xUTs15wt8Te-o5f0C9o22GHzZwOjn5F6=w@mail.gmail.com>
References: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
 <1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
 <CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
 <87txiasqhk.fsf@linaro.org>
 <CA+Bv8XZagHZ9mUuZB49hrH=901fXzoAcV8C0Fm3EfLa2eiBu0w@mail.gmail.com>
 <20130829110534.GV10783@sirena.org.uk>
 <CAGa+x85u0OpB9o71xUTs15wt8Te-o5f0C9o22GHzZwOjn5F6=w@mail.gmail.com>
Message-ID: <20130829154929.GJ10783@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 29, 2013 at 08:29:37AM -0700, Kevin Hilman wrote:
> On Thu, Aug 29, 2013 at 4:05 AM, Mark Brown <broonie@kernel.org> wrote:

> > Someone is going to have to walk me through the context for me to fully
> > understand what this is all about - what's the problem?

> The basic problem is how to have low-level platform code (or possibly
> firmware) send commands to a regulator to scale voltage.  This has to
> happen *very* late in the suspend process, so having the drivers do it
> themselves is not feasible.

Why does it have to happen this late and are the sequences definitely
fixed ones not ones that could depend on the system state at the time
we suspend?  It'd help to know what exactly is being controlled here...

> The proposal in this series is to define the i2c commands sequence to
> be sent to the regulator in the i2c node of the DT.  The
> platform-specific code then reads the sequence from the DT and sends
> the commands (or in in the case of the current series, passes the
> sequence to some firmware on a microcontroller which does the
> sequence.)

Surely specifying things in terms of the actual sequence would be better
than trying to specify the I2C commands if you want this to be done from
Linux?  If the firmware has to cope directly then this would require the
firmware to understand what it's doing of course.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130829/36460f8a/attachment.sig>
