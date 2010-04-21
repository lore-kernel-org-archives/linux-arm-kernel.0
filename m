From: jamie@shareable.org (Jamie Lokier)
Date: Wed, 21 Apr 2010 01:33:06 +0100
Subject: kernel virtual memory access (from app) does not generate segfault
In-Reply-To: <20100420224108.GA1432@n2100.arm.linux.org.uk>
References: <4BCD7076.9030802@browserseal.com>
	<20100420093441.GD6684@trinity.fluff.org>
	<000001cae074$1b564ff0$4044010a@Emea.Arm.com>
	<20100420142047.GA7398@desktop>
	<20100420170944.GE2234@trinity.fluff.org>
	<20100420192813.GA29831@n2100.arm.linux.org.uk>
	<20100420223106.GQ11723@shareable.org>
	<20100420224108.GA1432@n2100.arm.linux.org.uk>
Message-ID: <20100421003306.GU11723@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Tue, Apr 20, 2010 at 11:31:06PM +0100, Jamie Lokier wrote:
> > But a possible NAK: What happens when the kernel does get/put_user()
> > on an address > TASK_SIZE with kernel-only mapping?  user_mode()
> > returns 0, so the LDRT will loop in the kernel, won't it?
> 
> No - the first data fault will cause the pgd entry to be copied, and then
> the subsequent data fault will be a permission fault.
> 
> The difference between instruction faults and data faults is that we
> always interpret instruction faults on pre-ARMv6 CPUs as a 'translation
> fault' rather than a permission fault since they can't tell us what the
> problem was.

Subtle, but nice.

So are the ifar_info and ifsr_info tables completely redundant
pre-ARMv6, or is it just ifsr_info?

-- Jamie
