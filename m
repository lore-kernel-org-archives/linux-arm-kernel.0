From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Jan 2013 15:07:03 +0000
Subject: [PATCHv2 08/11] arm: arch_timer: add arch_counter_set_user_access
In-Reply-To: <20130111145451.GD19765@e106331-lin.cambridge.arm.com>
References: <1357747640-18594-1-git-send-email-mark.rutland@arm.com>
 <1357747640-18594-9-git-send-email-mark.rutland@arm.com>
 <50F01646.4010203@ti.com>
 <20130111145451.GD19765@e106331-lin.cambridge.arm.com>
Message-ID: <20130111150703.GA13717@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 02:54:52PM +0000, Mark Rutland wrote:
> On Fri, Jan 11, 2013 at 01:40:22PM +0000, Santosh Shilimkar wrote:
> > So how do you expect platform to enabled the user-space access in case
> > they want to access it for some cases.
> 
> Unlike AArch64, at the moment we don't have the infrastructure to map this for
> userspace accesses, so it isn't much of a problem.
> 
> If in future we wish to map it on 32bit platforms, the arm implementation of
> arch_counter_set_user_access can be modified to allow userspace access to
> specific registers, and additional code would be required to actually map it
> into the user address space, etc.

I'd also add that it's not up to a platform to decide whether to expose
this to userspace: it needs to be an architecture-wide decision. Otherwise,
userspace becomes SoC-specific, which is a complete disaster.

So, if userspace people want these available, they need to convince us to
flip the switch. In the meantime, it should default to off so that if/when
we do enable it we can do it in a sane manner for ARM (perhaps via the
vectors page).

Will
