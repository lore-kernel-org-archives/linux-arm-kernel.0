From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 11 Sep 2013 10:43:44 +0200
Subject: [PATCH ] ARM: sunxi: Add Emac,SMP and Arch_timer support for
 sunxi A20;Add phy cnt arch timer for ARMv7 support.
In-Reply-To: <16b7467c.1f121.141089f3d81.Coremail.coosty@163.com>
References: <16b7467c.1f121.141089f3d81.Coremail.coosty@163.com>
Message-ID: <20130911084344.GH2746@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cini,

On Wed, Sep 11, 2013 at 12:05:55AM +0800, cini wrote:
> It has been tested on a Cubieboard 2. To use SMP you must set
> ARM_ARCH_TIMER and ARM_ARCH_TIMER_USE_PHYCNT when make xconfig.? If
> you have any questions or comments please feel free to contact me.
> ?Have a wonderful day!

Thanks for working on this!

You still have to work a bit on the submission part however.

First, make sure you read and follow
http://www.tuxradar.com/content/newbies-guide-hacking-linux-kernel
along with Documentation/SubmittingPatches

Basically, you should use git format-patch and git send-email to easily
contribute your patches to the right format.
Among other things, your current patches lack some files (platsmp.c,
headsmp.S, etc.), also lack the Signed-off-by tag (using your real
name).

You should also try to split the changes you're making into logical
changes.

In that case, that means that you would probably have different patches
to :
  - Add the SMP code to mach-sunxi
  - Add the SMP-related nodes to the DTSI
  - Make the modifications to the arch timers
  - And add the EMAC support

Finally, you should probably look at
http://linux-sunxi.org/Mainlining_Effort to get in sync with other
people doing sunxi-related stuff to avoid effort duplication.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130911/03027161/attachment.sig>
