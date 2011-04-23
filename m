From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 23 Apr 2011 18:37:23 +0200 (CEST)
Subject: genirq: Generic irq chip available in git
Message-ID: <alpine.LFD.2.02.1104231805321.3323@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The generic irq chip infrastructure patches are now available in

git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip irq/for-arm

The top commit is cfefd21e693dca791bf9ecfc9dd3794facad533c

Russell said, he'll pull that into his devel tree, so patches can be
applied there. SoC maintainers running their own git trees can pull it
as well so they can apply the patches for their platforms.

There is a small change in the interface vs. the previous posted
version:

irq_setup_generic_chip() has now an additional argument to pass init
flags in. There are two flags available right now:

 * @IRQ_GC_INIT_MASK_CACHE:     Initialize the mask_cache by reading mask reg

The original code checked for the set/clr_bit functions, but with that
change it can be used for other implementations as well.

 * @IRQ_GC_INIT_NESTED_LOCK:    Set the lock class of the irqs to nested for
 *                              irq chips which need to call irq_set_wake() on
 *                              the parent irq. Usually GPIO implementations

This is for those gpio chips which all have their own gpio_lock_class
and the setter loop.

I fixed up the patches I sent out earlier. They are available from:

  http://master.kernel.org/~tglx/patches-arm-gc.tar.bz2

if you don't want to fixup the stuff yourself.

Happy Easter!

      tglx
