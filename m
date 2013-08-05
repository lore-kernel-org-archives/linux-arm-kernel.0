From: olof@lixom.net (Olof Johansson)
Date: Sun,  4 Aug 2013 21:09:50 -0700
Subject: [PATCH 0/3] ARM: vexpress: TC2 MCPM/SPC cleanups
Message-ID: <1375675793-16492-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's a short series on top of Nico's TC2 MCPM series to move the SPC driver
back under mach-vexpress where it should be, and a couple of tiny cleanups
to the driver.

I'll pick this up together with the base branch in arm-soc for-next, but I
haven't staged it in a next/* branch so it can be rebased/changed/dropped
if needed.

There's still one thing left to iron out, and that's the actual binding
for the "SPC" node. Since the spc code needs a non-zero SPC_BASE, it
implies that there's more than just SPC described by the device node. So
either the naming and description needs to be changed, or there's need
for more than one device node to describe the other register ranges. The
former might be easier in this case...

Pawel, I'd appreciate a quick test from you to make sure I didn't break
anything since I don't have a way to boot this myself.


-Olof
