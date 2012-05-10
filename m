From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 May 2012 09:59:39 +0100
Subject: [GIT PULL] SPEAr clk updates for v-3.5
In-Reply-To: <CAOesGMj5ubYcjXWRM2z9ZYOfHGn11sXKgDx8dgXy_bDYLH3HLg@mail.gmail.com>
References: <1336562022-24368-1-git-send-email-viresh.kumar@st.com>
 <CAOesGMj5ubYcjXWRM2z9ZYOfHGn11sXKgDx8dgXy_bDYLH3HLg@mail.gmail.com>
Message-ID: <20120510085939.GC3190@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 12:14:39AM -0700, Olof Johansson wrote:
> Russell has published a clkdev branch that you pull instead of
> applying his patch manually, that way there will be no surprises with
> respect to conflicts, etc:
> 
> git://ftp.arm.linux.org.uk/~rmk/linux-next.git clkdev
> 
> It is also in arm-soc as depends/rmk/clkdev now.

I'll mention that I'm considering a patch on top of this to add __must_check
to the return values for these clkdev clk registration functions.  I've
noticed that many users aren't checking that, so there's no real way to
be sure that these things are being created.

The alternative is we make these functions void and/or add pr_err() inside
them to report the failures.
