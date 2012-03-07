From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Mar 2012 12:47:51 +0000
Subject: [PATCH 14/15] watchdog/mpcore_wdt: Add clock framework support
In-Reply-To: <CAOh2x=mCMdSVAGXtEg3=P8aJxc5kmk-UqDYeKLGnQZpUYu0DrA@mail.gmail.com>
References: <cover.1331115751.git.viresh.kumar@st.com>
 <9ec7141baa4b1c1a0503893749e7ce0e19bb5029.1331115752.git.viresh.kumar@st.com>
 <20120307111833.GQ17370@n2100.arm.linux.org.uk>
 <CAOh2x==z1Mhc5k7qSJ++ix+TPaWcUfCKNdyfnzzZwiGO59Sudg@mail.gmail.com>
 <20120307122732.GS17370@n2100.arm.linux.org.uk>
 <CAOh2x=mCMdSVAGXtEg3=P8aJxc5kmk-UqDYeKLGnQZpUYu0DrA@mail.gmail.com>
Message-ID: <20120307124751.GU17370@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2012 at 04:37:12AM -0800, viresh kumar wrote:
> On 3/7/12, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > Drivers have no business interpreting anything but an IS_ERR() return from
> > clk_get() as invalid.  Everything else is the CLK APIs business, not the
> > driver's business.  So, to start using NULL as a special case is wrong.
> 
> But driver isn't comparing return value of clk_get with NULL (that would have
> been wrong) or interpreting its return value in a wrong way.

What if clk_get() returned NULL?

Hint: as far as _you_ are concerned as a driver writer, a struct clk is
an opaque cookie.  IS_ERR(clk) means the cookie is invalid.  Everything
else is potentially valid.  You must not interpret anything which is
potentially valid as some kind of special case.

> Instead it is using the same pointer/variable to check if clk_* APIs are
> supported or not by making it NULL. And that's a driver convention.

Bollocks it is.

Plain and simple NAK to this patch until clue is forthcoming.
