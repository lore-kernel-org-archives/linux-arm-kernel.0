From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 25 Jan 2018 16:31:25 +0530
Subject: [PATCH V6 Resend 00/13] drivers: Boot Constraint core
In-Reply-To: <CAL_Jsq+CtWCKENTQmiveoubxU4cDi9QBcpgvYZVfxPNsT-VX+g@mail.gmail.com>
References: <cover.1515554879.git.viresh.kumar@linaro.org>
 <CAL_Jsq+CtWCKENTQmiveoubxU4cDi9QBcpgvYZVfxPNsT-VX+g@mail.gmail.com>
Message-ID: <20180125110125.GA3307@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10-01-18, 17:13, Rob Herring wrote:
> On Tue, Jan 9, 2018 at 9:47 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > A typical example of that can be the LCD controller, which is used by
> > the bootloaders to show image(s) while the platform is booting into
> > Linux.  The LCD controller can be using some resources, like clk,
> > regulators, etc, that are shared between several devices. These shared
> > resources should be configured to satisfy need of all the users.  If
> > another device's (X) driver gets probed before the LCD controller driver
> > in this case, then it may end up disabling or reconfiguring these
> > resources to ranges satisfying the current users (only device X) and
> > that can make the LCD screen unstable.
> 
> We already have simple fb and a binding for it. It only handles clocks
> I think, but could be extended to other things. I rather not extend
> it, but it is there already and we don't need different solutions for
> this.

Got a bit busy lately and wasn't able to look into the details of it.

So AFAICT the basic problem I was trying to solve still exists with simple-fb
as well. And the problem is that nothing prevents another driver to get probed
before the display driver (or simple-fb) and reconfigure the resources. Even if
we let simple-fb come up really early, the resources like clk/regulator may not
be available. And so the ordering thing is still unsolved for me.

-- 
viresh
