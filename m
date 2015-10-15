From: eric@anholt.net (Eric Anholt)
Date: Wed, 14 Oct 2015 17:29:28 -0700
Subject: [PATCH] bcm2835: Add Raspberry Pi CPU frequency control to the
 device tree
In-Reply-To: <1444592795-15129-1-git-send-email-lkundrak@v3.sk>
References: <1444592795-15129-1-git-send-email-lkundrak@v3.sk>
Message-ID: <87bnc1gejb.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lubomir Rintel <lkundrak@v3.sk> writes:

> This adds a device tree binding for Broadcom BCM2834 CPU frequency control
> driven via Raspberry Pi VideoCore 4 firmware interface.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: linux-rpi-kernel at lists.infradead.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-pm at vger.kernel.org
> ---
> Depends on the RPi Firmware driver submitted on linux-rpi-kernel a while ago. 
> Can't see it in arm-soc or linux-next yet though (?). Available in branch 
> 'rpi-firmware' of https://github.com/anholt/linux

Looks like the firmware driver slipped through the cracks for 4.3.  I'll
be sending a pull request for it for 4.4.

With the cprman clock driver, we could set CPU frequency natively from
Linux.  What we get from doing things through the VPU right now are that
the MAX (overclock) setting can be set by the user in config.txt, and
the VPU does some watching of thermals to decide when to throttle back
to non-overclock.

Unless we do native thermal control from Linux (which we don't have a
driver for) to get equivalent protection, then I think we should
probably go ahead with the VPU-based cpufreq control.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151014/8c285a51/attachment-0001.sig>
