From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Oct 2012 21:51:13 +0200
Subject: [PATCH] [RFC] pinctrl: mvebu: reset pins to an UNKNOWN state on
 startup
In-Reply-To: <508843AF.7060803@gmail.com>
References: <1351106281-31288-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <508843AF.7060803@gmail.com>
Message-ID: <20121024215113.10640bf1@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian,

On Wed, 24 Oct 2012 21:38:23 +0200, Sebastian Hesselbarth wrote:

> how you make sure something you don't know about? The bootloader sets
> these pinmux settings for a reason and if the DT doesn't tell the kernel
> it should make no assumptions at all.

Apparently, the general feeling of the kernel people is that the kernel
should reduce as much as possible its dependency on the hardware
configuration set up by the bootloader. Therefore, even though your
bootloader does a certain pinmux configuration, your kernel should make
its own pinmux configuration and be fully independent from the one done
by the bootloader. If we want to achieve this, then it seemed like a
good idea to put all pins to an unknown state at boot time.

> IMHO it isn't - but maybe I am missing the point here. What is it that
> you don't like in the bootloaders choice of configuring pinmux?

Just because the kernel should not depend on hardware configuration
done by the bootloader, except for very core things like DRAM timings
and al. At least, that's my understanding of where the ARM kernel
people are trying to go. But I might have misunderstood, in which case
of course, the entire purpose of this patch disappears.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
