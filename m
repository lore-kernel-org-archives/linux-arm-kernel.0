From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 17 Aug 2013 17:38:02 +0200
Subject: [RFC v1 5/5] ARM: mvebu: add board init for Armada 1500
In-Reply-To: <1376682098-10580-6-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376682098-10580-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376682098-10580-6-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130817173802.71da1d14@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian Hesselbarth,

On Fri, 16 Aug 2013 21:41:38 +0200, Sebastian Hesselbarth wrote:

> I am not so sure about the .map_io but I didn't yet fully understand
> the mapping requirement. Anyway, it is required for iomap and friends
> to work and basically remaps physical register addressed onto the same
> virtual addresses.

You should normally be able to completely avoid the ->map_io() hook. If
you leave it set to NULL, it will automatically call
debug_ll_io_init(), which will setup the virt->phys mapping needed by
DEBUG_LL stuff. All the other mappings will be created dynamically with
ioremap().

The static mapping covering all registers is really no longer needed.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
