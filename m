From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 7 Nov 2012 18:35:23 +0000 (UTC)
Subject: [PATCHv9 0/8] ARM: OMAP4: core retention support
In-Reply-To: <87d2zrg04t.fsf@deeprootsystems.com>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
 <87d2zrg04t.fsf@deeprootsystems.com>
Message-ID: <alpine.DEB.2.00.1211071831370.20704@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 5 Nov 2012, Kevin Hilman wrote:

> # echo mem > /sys/power/state 
> [  102.271087] PM: Syncing filesystems ... done.
> [  102.282196] Freezing user space processes ... (elapsed 0.02 seconds) done.
> [  102.312133] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.
> [  102.343353] Suspending console(s) (use no_console_suspend to debug)
> ???[  102.363433] PM: suspend of devices complete after 10.650 msecs
> [  102.365631] PM: late suspend of devices complete after 2.166 msecs
> [  102.369201] PM: noirq suspend of devices complete after 3.509 msecs
> [  102.369232] Disabling non-boot CPUs ...
> [  102.373016] CPU1: shutdown

[...]

By the way, looks like you're seeing the same garbage character generated 
as I was on v3.6 with these patches.  It's the first character of the line 
that's dated "102.363433".  At 230kbps, it comes across as a "5" that the 
OMAP thinks originates from the host computer, sent to the Panda.

Would be useful if someone could identify what's causing this.  None of 
the OMAP3 boards currently exhibit this behavior.  Would na?vely assume 
that the OMAP4 is waking up fast enough to capture some of the bits of the 
serial wakeup character, but have not confirmed this.


- Paul
