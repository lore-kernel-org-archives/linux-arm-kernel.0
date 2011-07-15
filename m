From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Jul 2011 19:13:09 +0100
Subject: [PATCH] ARM: move memory layout sanity checking before meminfo
	initialization
In-Reply-To: <CAMbhsRSbXTLzhSzBbQ8ebJqAC227ESHGyY2bHS+J4cN+NgzXFg@mail.gmail.com>
References: <20110705185758.GI8286@n2100.arm.linux.org.uk>
	<CAMbhsRRQ9D+VXTZP3vB7egkROEtN9-FxssFa2EcxuqB3F-Uv6Q@mail.gmail.com>
	<20110714073453.GK23270@n2100.arm.linux.org.uk>
	<CAMbhsRT=NNYUYyYZXpz2=PpBXoBGANQHPgOkCE1oZ8XzHKN4og@mail.gmail.com>
	<CAMbhsRSgUcFPpdTFvEDTFfo_Wk0k7BQzwk6cRtXC6K7mpQ+YDg@mail.gmail.com>
	<20110715080950.GL23270@n2100.arm.linux.org.uk>
	<CAMbhsRRCV0ukwbzFc6w_ba6xdVxs=TFmJMGd06UKTiNQPEJqpw@mail.gmail.com>
	<20110715161628.GA24628@n2100.arm.linux.org.uk>
	<CAMbhsRSbXTLzhSzBbQ8ebJqAC227ESHGyY2bHS+J4cN+NgzXFg@mail.gmail.com>
Message-ID: <20110715181309.GD24628@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2011 at 10:35:14AM -0700, Colin Cross wrote:
> CMDLINE_EXTEND solves a real problem, and when it's not solved in the
> kernel, it ends up getting solved in every bootloader.  Every
> kernel/board requires some command line options (like "console="), and
> every bootloader ends up passing some special options.

And yet again, if you have a kernel with a built-in console= setting,
there is _no_ _way_ to disable that console via the kernel command
line.

So what if some of your platforms need one console, others need a different
console, but must not use the first one...

Do we need nomem= and noconsole= options too?  Or do we just do the
sane thing and get rid of CMDLINE_EXTEND - or insist that stuff like
console= and mem= options are never built-in ?
