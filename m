From: dianders@chromium.org (Doug Anderson)
Date: Sun, 7 Sep 2014 21:43:25 -0700
Subject: Unable to boot mainline on snow chromebook since 3.15
In-Reply-To: <540C7F5B.6070307@gmail.com>
References: <20140905115704.GO13515@arm.com> <20140905122232.GP13515@arm.com>
 <CAD=FV=VfioJf9VYoSYL0QBk-bN93-Ecx3=0n9hb5Q4rcx43-_g@mail.gmail.com>
 <540C202E.2060009@collabora.co.uk> <540C7F5B.6070307@gmail.com>
Message-ID: <CAD=FV=XXHvF8zjADH7bmM11nEiZ4WXFKZCuB=Q7CYFfQgkdbDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Sep 7, 2014 at 8:52 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Now with regulators this is pretty straightforward, but with clocks I
> believe it's an open issue. AFAIR we've discussed this on MLs some time
> ago (at least I remember Doug commenting on that topic) and kind of
> concluded that SoC clock drivers could include lists of clocks to be
> enabled at boot-up (as a HACK to enable things like simplefb until
> proper support for respective features are added).

I think my old problem was with earlyprintk and a core clock getting
disabled.  See (44ff025 clk: exynos5420: Remove aclk66_peric from the
clock tree description).  I think I've seen others solve the same
problem with the concept of "critical clocks".

I agree that regulator and clock frameworks allow very different "hacks".  ;)

-Doug
