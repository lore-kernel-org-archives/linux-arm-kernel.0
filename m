From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 29 Aug 2017 14:03:43 +0200
Subject: [PATCH V3 1/8] drivers: Add boot constraints core
In-Reply-To: <20170829095217.GA3101@ubuntu>
References: <cover.1501578037.git.viresh.kumar@linaro.org>
 <1a844e27ee7e0b22acf8ea582bf4e8d35f54c84a.1501578037.git.viresh.kumar@linaro.org>
 <20170829063923.GD12198@kroah.com> <20170829095217.GA3101@ubuntu>
Message-ID: <20170829120343.GA4321@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 29, 2017 at 11:52:17AM +0200, Viresh Kumar wrote:
> On 29-08-17, 08:39, Greg Kroah-Hartman wrote:
> > How is this information getting to the kernel from the bootloader?  I
> > didn't see where that happened, just a single example driver that
> > somehow "knew" what had to happen, which seems odd...
> 
> I tried to do it with DT earlier, but we couldn't reach to an agreement on what
> bindings to add and so this series started doing things the old way. The kernel
> would have platform specific drivers, which would exactly know what constraints
> to set and we wouldn't need the bootloaders to pass anything for now.

Who couldn't reach an agreement?  So you gave up and decided to make a
whole bunch of kernel code instead of just using new DT entries?  That's
crazy...

> > This is a lot of new code for no users,
> 
> I agree and so added the patch 8/8 to show a real user. I will convert that to a
> patch going forward, which can be merged along with this series.
> 
> > I would like to see at least 3
> > real drivers that are using it before we merge it, as then you have a
> > chance of getting the user/kernel api correct.
> 
> Hmm, so I am quite sure that this is a fairly generic problem to solve,
> specifically for all the handheld devices. I can get code for few of the Qcom
> SoCs but they may end up using the same platform driver. Not sure if I can get
> code for multiple SoC families in the beginning.

Let's see a working system or two first here please.

But you are implying that existing handheld devices need this problem
solved, how do they do it today without this code as obviously they are
shipping working solutions.

thanks,

greg k-h
