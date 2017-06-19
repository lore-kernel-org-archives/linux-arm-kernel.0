From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 Jun 2017 06:53:12 -0700
Subject: [PATCH v3 0/4] Generalize fncpy availability
In-Reply-To: <20170619122444.GJ10246@leverpostej>
References: <20170617000744.22158-1-f.fainelli@gmail.com>
 <20170619122444.GJ10246@leverpostej>
Message-ID: <20170619135312.GM3730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mark Rutland <mark.rutland@arm.com> [170619 05:25]:
> On Fri, Jun 16, 2017 at 05:07:40PM -0700, Florian Fainelli wrote:
> > 
> > This is helpful in making SoC-specific power management code become true drivers
> > that can be shared between different architectures.
> 
> Could you elaborate on what this is needed for?
> 
> My understanding was that on 32-bit, this was to handle idle / suspend
> cases, whereas for arm64 that should be handled by PSCI.
> 
> what exactly do you intend to use this for?

Well idle / suspend can have multiple needs such as running
core while DDR is in self-refresh mode and saving and restoring
of some context registers in that state.

Also clock drivers may need this to reprogram some core clocks.

Regards,

Tony
