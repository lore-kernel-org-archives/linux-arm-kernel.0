From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 27 Apr 2012 15:09:27 +0800
Subject: announcing the clk-next branch
In-Reply-To: <4F9A395A.3030306@st.com>
References: <CAJOA=zOGSh3et4nxE=JdojL4uDjgt8o+oiOU4pmbM=oU2U6prA@mail.gmail.com>
 <4F9A395A.3030306@st.com>
Message-ID: <20120427070925.GO2234@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 11:44:50AM +0530, Viresh Kumar wrote:
> Hi Mike and others,
> 
> I am finding difficulty in creating branch to be pulled in by Mike for clock
> stuff. Somebody please help.
> 
> SPEAr patches have dependency on few patchsets that are pulled in linux-next
> already.
> - SPEAr DT support
> - SPEAr Pinctrl support
> - Mike clk fixes
> - Misc Pinctrl patches
> 
I'm basically running into the same situation.  I have a bunch of mxs DT
patches touching the existing clock code, while I'm converting the clock
to framework and put the code into drivers/clk.  I originally thought
that the new mxs clock should go through Mike's tree since they are
sitting in drivers/clk.  But with a second thought, I feel it might be
easier to still have them go through arm-soc tree.

We can ask Arnd, Olof to pull clkdev from Russell, clk core from Mike,
and pinctrl from Linus into arm-soc as dependencies, take all the
platform clock/pinctrl porting into arm-soc, and sort out the conflicts
in arm-soc tree.  Otherwise, I'm a little worried about that we will
probably upset Torvalds with leaving so many conflicts to him.

So in short, I will send my mxs clock series to Arnd and Olof.

Regards,
Shawn

> Now, how should i create branch for SPEAr clk stuff over these dependencies?
> I tried to create a merge of first 3, but couldn't get a linux-next/master
> sha of a branch for Last dependency.
> 
> Should i cherrypick that one?
> 
> At last, i believe this branch, that i would create, must be in a compilable
> state? So, i can't just send a pull request for my clock patches rebased over
> Mike's branch directly?
