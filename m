From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 1 Nov 2018 16:11:55 +0100
Subject: [PATCH] RFC: ARM: do not handle Spectre V2 on Vexpress CA9
In-Reply-To: <20181101140143.GA27913@e107155-lin>
References: <20181101125406.8874-1-linus.walleij@linaro.org>
 <42704270-8d9f-3f7a-9af1-4bd87f413815@arm.com>
 <20181101140143.GA27913@e107155-lin>
Message-ID: <CACRpkda-_ENuFpUsxWcYO_mOGnHqUc8d+c8CnYgwWvi7mXsKTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 1, 2018 at 3:01 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> On Thu, Nov 01, 2018 at 01:56:41PM +0000, Robin Murphy wrote:

> > As far as I remember, the usual V2P_CA9 problem where the L2 cache locks up
> > for unfathomable reasons can come and go reasonably consistently depending
> > on the exact kernel configuration/version, and ultimately seems like it
> > might be more sensitive to the general shape and timing of the early boot
> > code than any particular feature. As such I'd be wary that there might still
> > be some other combinations of options which would manage to boot with the
> > mitigation left enabled, and others which won't even if (or at worst
> > *because*) we do skip it.
>
> Indeed, I was about ask if disabling L2 makes it any consistent.
> We did try increasing the read/write/tag latencies in the past but never
> got it fully consistent to push the change.

Yeah I have a patch increasing tag latencies in my tree that I got from
Russell, but it doesn't help with this.

I will try to run it with L2 disabled, if that works maybe the solution is
simply to permanently disable L2 on Vexpress CA9 if it's this
unpredictable, or are there people using this reference design in
performance-critical setups so that is an absolute nono?

I remember I even saw Android ported to this machine at one point,
is that something that is being continously maintained to newer
kernels and Adroid AOSPs?

Yours,
Linus Walleij
