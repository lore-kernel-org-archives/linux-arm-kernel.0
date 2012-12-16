From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 16 Dec 2012 18:35:24 +0530
Subject: [PATCH 2/3] CLK: uninline clk_prepare_enable() and
 clk_disable_unprepare()
In-Reply-To: <20121216124013.GP14363@n2100.arm.linux.org.uk>
References: <1353403339-11679-1-git-send-email-dmitry.torokhov@gmail.com>
 <1353403339-11679-3-git-send-email-dmitry.torokhov@gmail.com>
 <CAKohpomA=vSGuKfD-_zwiSnXGkqAQjtiVqxT2Po=D-LDA_FESg@mail.gmail.com>
 <20121216115756.GO14363@n2100.arm.linux.org.uk>
 <CAKohpok7Lh_ozuBFZdObpPRj0u_B-MNqgWjmaaSik3v4SmgJcw@mail.gmail.com>
 <20121216124013.GP14363@n2100.arm.linux.org.uk>
Message-ID: <CAKohpom37Liqhz38YthaL9q+iFh4=iYHoUmrTOMq2=Ut-D0Dhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 December 2012 18:10, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Well, there's my comment against patch 2 which never got a reply:
>
> "Again, what about stuff not using drivers/clk/clk.c ?"
>
> Has this been addressed?

Hmm.. I misread it and thought it is same as breaking other platforms
because there are
no dummy routines. But i was wrong :(

So, the problem is, platform not using common-clock framework uses
this routine, and they
don't want it to be dummy but call prepare & enable..

Because Dmirty requires this one to be non-inline, either he can move
these routines to
drivers/clk/clk-devres.c (which would be wrong) or can add wrappers
over them in clk-devres
file.

--
viresh
