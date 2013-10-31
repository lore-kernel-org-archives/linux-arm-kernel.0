From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 31 Oct 2013 16:09:01 +0000
Subject: [PATCH RFC] ARM: dts: imx6qdl: make pinctrl nodes board specific
In-Reply-To: <CAHCPf3vTcu9RCk8=9MUs4nkyJ-8jevh5koxfzdLzE5+qM0ZspQ@mail.gmail.com>
References: <1382672542-16100-1-git-send-email-shawn.guo@linaro.org>
 <20131031080326.GK24559@pengutronix.de>
 <20131031102908.GX16735@n2100.arm.linux.org.uk>
 <CAHCPf3vTcu9RCk8=9MUs4nkyJ-8jevh5koxfzdLzE5+qM0ZspQ@mail.gmail.com>
Message-ID: <20131031160901.GD16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 10:45:08AM -0500, Matt Sealey wrote:
> I suggested this to Shawn a couple weeks ago and got a bit of pushback.
> 
> There's probably a ton more to do in this regard to keep the DT
> per-board more concise, but this drops tree size by a respectable
> amount on i.MX51 too (just on a tree I have internally, it's something
> like 8.5KiB) and I can't see any redundant data in the ones he
> patched.

The issue I have is that this pushes support for Carrier-1 through to
_six_ months before it appears in a mainline -final kernel - the timeline
ends up looking like this:

- Prepare and merge this patch to allow DAT3 to be configured in the
  merge window starting next week.
- Rebase Carrier-1 changes on that when it hits mainline
- Wait for 3.13-rc1
- Get Carrier-1 DT files merged into the IMX tree for the following
  merge window at some point
- Wait for v3.13 to be released about three months from now.
- Carrier-1 support gets merged into mainline
- Carrier-1 support appears in v3.14 three months after that.

That's an awfully long turn-around time given that the DT description
is functional today, and has been for the last month, and the only
thing that's really blocking it is the problems of that DAT3 signal.
