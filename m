From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 20 Sep 2018 23:33:20 +0100
Subject: [PATCH] arm64: Trap WFI executed in userspace
In-Reply-To: <20180920220430.GA27468@xo-6d-61-c0.localdomain>
References: <20180807093326.5090-1-marc.zyngier@arm.com>
 <20180920220430.GA27468@xo-6d-61-c0.localdomain>
Message-ID: <86lg7vx0i7.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Sep 2018 23:04:30 +0100,
Pavel Machek <pavel@ucw.cz> wrote:
> 
> On Tue 2018-08-07 10:33:26, Marc Zyngier wrote:
> > It recently came to light that userspace can execute WFI, and that
> > the arm64 kernel doesn trap this event. This sounds rather benign,
> > but the kernel should decide when it wants to wait for an interrupt,
> > and not userspace.
> > 
> > Let's trap WFI and treat it as a way to yield the CPU to another
> > process.
> 
> I don't think that's reasonable. Userspace should not be doing that,
> and we do not want to encourage it. SIGILL would be reasonable, I'd
> say.

This ship has already sailed. Sending SIGILL changes the ABI in an
incompatible way. Immediately returning to userspace without doing
anything else (see v2 [1]) is the best we can do without changing the
behaviour of userspace.

Thanks,

	M.

[1] https://patchwork.kernel.org/patch/10562517/

-- 
Jazz is not dead, it just smell funny.
