From: tj@kernel.org (Tejun Heo)
Date: Thu, 25 Aug 2011 14:17:10 +0200
Subject: try_to_freeze() called with IRQs disabled on ARM
In-Reply-To: <20110825121416.GB8883@n2100.arm.linux.org.uk>
References: <20110823151936.GM9232@opensource.wolfsonmicro.com>
	<201108232351.55432.rjw@sisk.pl>
	<CAOS58YNUSn2eVLDLzqKmrtL7M5tSetkhZ1ODecLK54NSDnZVAA@mail.gmail.com>
	<20110823220056.GK3895@n2100.arm.linux.org.uk>
	<CAOS58YNuCbaOsWBfmjSUsXsArZ5ng6c0B30yswFbRAWkho6L6Q@mail.gmail.com>
	<20110823221314.GL3895@n2100.arm.linux.org.uk>
	<CAOS58YNtQEuke=Ko9J2oNGMECjabzxj=Nrg1o64X1JC3YRmJuw@mail.gmail.com>
	<20110825121416.GB8883@n2100.arm.linux.org.uk>
Message-ID: <20110825121710.GK3286@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Russell.

On Thu, Aug 25, 2011 at 01:14:16PM +0100, Russell King - ARM Linux wrote:
> was introduced, every other architecture should have been updated for
> that change...  So this call in the ARM signal handling code to
> try_to_freeze() should just be deleted as it should've been done five
> years ago.

I agree.  I don't think it's necessary there, so for now, let's just
delete that call, but get_signal_to_deliver() expects to be called
with IRQ enabled so it would still be a good idea to turn on/off IRQs
explicitly around it.

Thanks.

-- 
tejun
