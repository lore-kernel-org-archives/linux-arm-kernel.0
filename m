From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 20 Jun 2013 13:35:51 +0200
Subject: BUG: commit "ARM: Remove __ARCH_WANT_INTERRUPTS_ON_CTXSW on
 pre-ARMv6 CPUs" breaks armv5 with CONFIG_PREEMPT
In-Reply-To: <20130620111255.GD18536@arm.com>
References: <51C2C0B5.8020802@pengutronix.de> <20130620095705.GA18536@arm.com>
 <51C2D5EF.3040803@pengutronix.de> <20130620102856.GC18536@arm.com>
 <20130620111255.GD18536@arm.com>
Message-ID: <51C2E917.9000708@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/20/2013 01:12 PM, Catalin Marinas wrote:
> On Thu, Jun 20, 2013 at 11:28:56AM +0100, Catalin Marinas wrote:
>> We may need to place the preempt disable/enable at a higher level in the
>> scheduler. My theory is that we have a context switch from prev to next.
>> We get preempted just before finish_arch_post_lock_switch(), so the MMU
>> hasn't been switched yet. The new switch during preemption happens to a
>> thread with the same next mm, so the scheduler no longer switch_mm() and
>> the TIF_SWITCH_MM isn't set for the new thread.
>>
>> I'll come back with another patch shortly.
> 
> Here's another attempt (as before, only compile-tested):

booting kernel from /image
zImage: concatenated oftree detected
booting Linux kernel with devicetree

...dead...

Does every process have a "mm"? Even Kernel threads?

Marc
-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130620/26b07f5f/attachment.sig>
