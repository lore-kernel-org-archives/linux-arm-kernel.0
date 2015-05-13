From: eric@anholt.net (Eric Anholt)
Date: Wed, 13 May 2015 12:00:06 -0700
Subject: RPi firmware driver v2
Message-ID: <1431543609-19646-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's a new version of the firmware driver.  This series applies on
top of for-rpi-next from Lee Jones's tree:

git://git.kernel.org/pub/scm/linux/kernel/git/rpi/linux-rpi.git

But it won't actually probe without merging in mailbox-for-next:

https://git.linaro.org/landing-teams/working/fujitsu/integration.git

I've dropped the pm-domains code for now, since it wasn't doing
anything useful for us yet without the drivers/base support.  However,
this code has been useful for building a proper clk provider for the
Pi, which can be found at:

https://github.com/anholt/linux/tree/rpi-dt-clocks

Andrea Merello apparently got a cpufreq driver working on top of the
non-DT version of this clk provider:

https://github.com/andreamerello/linux-mach-bcm/tree/bcm2836-cpufreq

I think we might manage with a generic dt-cpufreq implementation,
though.
