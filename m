From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 02 Mar 2010 13:29:58 -0800
Subject: board/device file names, and machine names
Message-ID: <1267565398.8759.77.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I was wondering if you (or the list) had any suggestions for proper
names to use in these two cases. Under mach-msm we have tons of devices
that could be added, and it can sometimes be hard to isolate a sane
name ..

I'll use the Nexus One device as an example .. HTC originally called
this device the HTC Passion prior to release.. Google named the same
device "mahimahi" prior to release .. Then finally it was released as
Nexus One .

So one device has at least three names (more I'm sure),

	Passion
	Mahimahi
	Nexus One

Google has most of the code support under board files with the name
mahimahi.

To me it makes a lot more sense to use a mass marketed name like "Nexus
One" .. Few people know what an HTC Passion is, and extremely few know
what "mahimahi" is.

Here is a link to mach-msm from Google's tree so you can see the naming
they use,

http://android.git.kernel.org/?p=kernel/msm.git;a=tree;f=arch/arm/mach-msm;h=f67bef98c885df15781d3122e3325f6164884118;hb=refs/heads/android-msm-2.6.29-nexusone

Another example of this is,

arch/arm/mach-msm/board-trout.c

which in mainline we renamed to,

arch/arm/mach-msm/board-dream.c

Dream is actually a released name, so it seems to make more sense.
However, there are many other names we could have used.

machine_is_xx names have a similar kind of problem .. However, it's lot
easier to mainline a machine_is_xxx name ..

Any comments welcome, since this stuff is disputed and up in the air.
I'm sure many other projects have faced similar problems also.

Daniel
