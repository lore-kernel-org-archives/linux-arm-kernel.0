From: will.deacon@arm.com (Will Deacon)
Date: Wed, 1 May 2013 17:38:17 +0100
Subject: [PATCH v3] ARM: imx: replicate the diagnostic register of boot
 cpu into secondary cores
In-Reply-To: <5181408C.8090606@gmail.com>
References: <1366948645-12060-1-git-send-email-shawn.guo@linaro.org>
 <20130426132130.GE30858@mudshark.cambridge.arm.com>
 <20130426134722.GA1943@S2101-09.ap.freescale.net>
 <5181357E.3090805@gmail.com>
 <20130501153828.GC24055@mudshark.cambridge.arm.com>
 <5181408C.8090606@gmail.com>
Message-ID: <20130501163817.GD24055@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 01, 2013 at 05:19:24PM +0100, Dirk Behme wrote:
> Am 01.05.2013 17:38, schrieb Will Deacon:
> > On Wed, May 01, 2013 at 04:32:14PM +0100, Dirk Behme wrote:
> Just for a better understanding: What's wrong with using the same 
> register values on all CPUx? I.e. with copying them from CPU0? 
> Shouldn't all CPUx use the same setting? Or at least the same errata 
> bits enabled?

There's this thing called big.LITTLE... In this case, we're all A9s, but it
still feels horrible.

> > I'd rather we
> > orr'd in the bits we actually need, like we would in __v7_setup. Perhaps the
> > code there should be factored out into arm_errata_xxxx asm macros,
> 
> I'm not as much in the details as Shawn and you, but it's my 
> understanding that we moved the errata handling recently from the 
> kernel to the boot loader? After this, we now find that the boot 
> loader does the errata handling only for CPU0, and now we start to 
> discuss to move it back to the kernel?

In Shawn's case, I don't think the secondary CPUs execute any code prior to
kernel text, but he can correct me if I'm wrong.

Will
