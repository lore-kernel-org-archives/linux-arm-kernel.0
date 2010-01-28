From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 28 Jan 2010 08:23:07 +0000
Subject: RFC: change device building for s3c24xx/s3c64xx/s5p series
Message-ID: <20100128082307.GU10014@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After thinking a bit about the current build for the Samsung architectures
I decided to try the patch included below to change from using Kconfig
to define what is needed to use a build instead.

This is one of the soultions I was thinking about, but does not currently
remove the need for the default setup code for each device... that may be
sorted by a different solution that I will try and sort out a set of
patches for if i feel it will be useful.

If we use the lib target we will end up always building the necessary
device files and then leave it up to the linker to actually pick the ones
that the included board needs. As a note, a small increase in the build
time to ensure that these are created should not be a problem.

Currently we haven't tried the same attempt with the setup code as that
will end up forcing the necessary device definitions into the kernel
unless it is changed to the board calling the necessary default
functions. This would move them out of the SoC setup code, but mean
that all boards would need to be altered. It would also mean that each
board would need to know which SoC it is using.

Any views on the subject would be useful.
