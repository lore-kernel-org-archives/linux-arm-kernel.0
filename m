From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 7 May 2012 23:05:06 -0600 (MDT)
Subject: Broken UART I/O wakeups on v3.4-rc4+
Message-ID: <alpine.DEB.2.00.1205072249090.9984@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Govindraj,

After your commit bce492c04ba8fc66a4ea0a52b181ba255daaaf54 ("ARM: OMAP2+: 
UART: Fix incorrect population of default uart pads"), the kernel does not 
return from static suspend when off-mode is enabled upon an incoming 
serial character.

The following steps reproduce the problem:

echo 1 > /debug/pm_debug/enable_off_mode
echo mem > /sys/power/state
(send a serial character after suspend is entered)

(N.B., on the BeagleBoard, the GPIO-connected "USER" button can be used to 
wake the system at this point.)

Could you please fix this?  We probably aren't too far from the v3.5 merge 
window opening, so there isn't much time to fix it.


thanks

- Paul
