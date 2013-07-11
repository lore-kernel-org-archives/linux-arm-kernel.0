From: sr@denx.de (Stefan Roese)
Date: Thu, 11 Jul 2013 17:34:14 +0200
Subject: [PATCH] ARM: OMAP3: Beagle: Fix USB Host on beagle xM Ax/Bx
In-Reply-To: <51DEC2CE.70400@ti.com>
References: <1366024808-4691-1-git-send-email-rogerq@ti.com>
 <51DC09E7.1070302@denx.de> <51DC164B.5010608@ti.com>
 <51DC1B47.7070504@denx.de> <51DE87D3.5030600@ti.com>
 <51DEA7F1.1050902@denx.de> <51DEC2CE.70400@ti.com>
Message-ID: <51DED076.3040000@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/2013 04:35 PM, Roger Quadros wrote:
>> BTW: I noticed a git ID (8e1cacd) in your kernel that I can't identify.
>> Do you have any patches locally applied to the kernel.org version that
>> might be helpful with this USB issue I'm seeing?
> 
> Yes I had tested it on a more recent kernel with some local patches applied
> that I've recently sent for review.
> 
> But to cross check with your setup I've retested it with commit d2b4a646 
> with the 2 below patches on top
> 
> https://lkml.org/lkml/2013/6/20/327
> https://lkml.org/lkml/2013/6/20/339

Thanks. I have exactly those 2 patches applies as well. But on a
different git commit. And with some local (unrelated) patches as well.
I'll revert to exactly your version tomorrow and test again.

> I've tried it again with the ELDK 5.3 root but still can't get it to fail.
> 
> I think we should match our u-boot as well. Could you please let me know
> your u-boot commit and uEnv.txt?

Good idea. I'm currently using a "dirty" local version. I'll try to
switch to an officially available version tomorrow. And send you the
version/git id.

> My network setup is pretty simple, beagle-xm is connected directly to my laptop's
> ethernet port. No network switch in between.

I have a switch in between the target and my PC. But this network setup
is also quite "simple" and works with all other boards as well. So this
shouldn't be a problem.

> When you get the problem do you cold boot the board or warm boot it?
> I've been always cold booting it.

I'm usually warm booting (pushbutton reset).

As mentioned above, I have some "homework" now to move to a
setup/configuration (official git commits) that you can reproduce on
your version C2 beagleboard as well. Stay tuned... ;)

Thanks,
Stefan
