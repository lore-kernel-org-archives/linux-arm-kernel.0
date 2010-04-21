From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Apr 2010 20:36:53 +0100
Subject: kernel virtual memory access (from app) does not generatesegfault
In-Reply-To: <20100421124317.GA9408@desktop>
References: <4BCD7076.9030802@browserseal.com>
	<20100420093441.GD6684@trinity.fluff.org>
	<000001cae074$1b564ff0$4044010a@Emea.Arm.com>
	<20100420142047.GA7398@desktop>
	<20100420170944.GE2234@trinity.fluff.org>
	<20100420192813.GA29831@n2100.arm.linux.org.uk>
	<20100420223106.GQ11723@shareable.org>
	<20100420224108.GA1432@n2100.arm.linux.org.uk>
	<000001cae144$4281a9a0$4044010a@Emea.Arm.com>
	<20100421124317.GA9408@desktop>
Message-ID: <20100421193653.GD26616@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 21, 2010 at 08:43:17PM +0800, anfei wrote:
> On Wed, Apr 21, 2010 at 12:17:41PM +0100, Dave P. Martin wrote:
> > Note that my observations were on an armv7 kernel.  Should we still hit the
> > same bit of code in this case, or have I misdiagnosed the problem?
> > 
> You said your kernel is .28, so it seems too old and this commit may fix
> it: 
> commit d25ef8b86e6a58f5476bf6e4a8da730b335f68fa
> 	ARM: 5728/1: Proper prefetch abort handling on ARMv6 and ARMv7

Indeed, yes.  However, I think the fix is still value for older CPUs.
