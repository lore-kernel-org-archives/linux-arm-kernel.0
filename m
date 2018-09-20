From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 21 Sep 2018 00:04:30 +0200
Subject: [PATCH] arm64: Trap WFI executed in userspace
In-Reply-To: <20180807093326.5090-1-marc.zyngier@arm.com>
References: <20180807093326.5090-1-marc.zyngier@arm.com>
Message-ID: <20180920220430.GA27468@xo-6d-61-c0.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2018-08-07 10:33:26, Marc Zyngier wrote:
> It recently came to light that userspace can execute WFI, and that
> the arm64 kernel doesn trap this event. This sounds rather benign,
> but the kernel should decide when it wants to wait for an interrupt,
> and not userspace.
> 
> Let's trap WFI and treat it as a way to yield the CPU to another
> process.

I don't think that's reasonable. Userspace should not be doing that, and we do not want
to encourage it. SIGILL would be reasonable, I'd  say.

(Very old mail, was forgotton in the queue)
