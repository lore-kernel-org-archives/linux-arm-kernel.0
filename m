From: mikpe@it.uu.se (Mikael Pettersson)
Date: Sat, 27 Nov 2010 16:16:10 +0100
Subject: [BUG] 2.6.37-rc3 massive interactivity regression on ARM
Message-ID: <19697.8378.717761.236202@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The scenario is that I do a remote login to an ARM build server,
use screen to start a sub-shell, in that shell start a largish
compile job, detach from that screen, and from the original login
shell I occasionally monitor the compile job with top or ps or
by attaching to the screen.

With kernels 2.6.37-rc2 and -rc3 this causes the machine to become
very sluggish: top takes forever to start, once started it shows no
activity from the compile job (it's as if it's sleeping on a lock),
and ps also takes forever and shows no activity from the compile job.

Rebooting into 2.6.36 eliminates these issues.

I do pretty much the same thing (remote login -> screen -> compile job)
on other archs, but so far I've only seen the 2.6.37-rc misbehaviour
on ARM EABI, specifically on an IOP n2100. (I have access to other ARM
sub-archs, but haven't had time to test 2.6.37-rc on them yet.)

Has anyone else seen this? Any ideas about the cause?

/Mikael
