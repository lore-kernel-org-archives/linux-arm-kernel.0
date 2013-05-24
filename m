From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 May 2013 10:07:54 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <20130524074616.GV18614@n2100.arm.linux.org.uk>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305232240.03959.arnd@arndb.de>
 <20130523230911.GR18614@n2100.arm.linux.org.uk>
 <201305240915.27847.arnd@arndb.de>
 <20130524074616.GV18614@n2100.arm.linux.org.uk>
Message-ID: <20130524100754.6b2d1bc9@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell King - ARM Linux,

On Fri, 24 May 2013 08:46:16 +0100, Russell King - ARM Linux wrote:

> Wrong, again.  Thomas has already said there are boot loaders shipping
> on boards which have the registers programmed to be at 0xf1xxxxxx _and_
> there's boards with boot loaders programmed for 0xd0xxxxxx.
> 
> The problem is here TODAY.

Right. And again, don't expect something like:

 * Board A = 0xd0xxxxxx
 * Board B = 0xf1xxxxxx

Depending on which bootloader, and which version of the bootloader you
run, on a given board, the kernel may be booted with 0xd0 or 0xf1.

And again, again. This 0xd0 was a mistake. We don't want to support
moving forward. The only thing we want to support is 0xf1, nothing else.

All the proposal is about a temporary workaround, just to make the
transition smoother.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
