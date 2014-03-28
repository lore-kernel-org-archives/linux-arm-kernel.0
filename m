From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 28 Mar 2014 15:56:30 +0000
Subject: [PATCH 05/75] ARM: l2c: remove unnecessary UL-suffix to mask
 values
In-Reply-To: <CAL_Jsq+qaQ=CtqMKbd5Fcp1YAY+E40mS24kWe8RMwb2Bz1A9kQ@mail.gmail.com>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYUW-0004WD-UP@rmk-PC.arm.linux.org.uk>
 <CAL_Jsq+qaQ=CtqMKbd5Fcp1YAY+E40mS24kWe8RMwb2Bz1A9kQ@mail.gmail.com>
Message-ID: <20140328155630.GM7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 10:50:32AM -0500, Rob Herring wrote:
> What about changing these callers to use l2x0_of_init(void) and
> creating l2x0_of_init_legacy(val, mask) for ones that need the aux
> ctrl setup? We do want to encourage people to either setup aux ctrl in
> the bootloader or via DT properties.

I have thought about that, but let's first sort out what platforms need.
It sounds like some platforms really do need to manipulate the register,
some really need to do it to have a functional setup because they never
set the hardware configuration of the cache size.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
