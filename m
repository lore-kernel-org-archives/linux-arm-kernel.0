From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Dec 2015 12:09:22 +0000
Subject: [PATCH v2] ARM: PJ4: make coprocessor access sequences buildable
 in Thumb2 mode
In-Reply-To: <1450768869-13450-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1450768869-13450-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20151222120922.GD8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 08:21:09AM +0100, Ard Biesheuvel wrote:
> The PJ4 inline asm sequence to write to cp15 cannot be built in Thumb-2
> mode, due to the way it performs arithmetic on the program counter, so it
> is built in ARM mode instead. However, building C files in ARM mode under
> CONFIG_THUMB2_KERNEL is problematic, since the instrumentation performed
> by subsystems like ftrace does not expect having to deal with interworking
> branches.
> 
> Since the sequence in question is simply a poor man's ISB instruction,
> let's use a straight 'isb' instead when building in Thumb2 mode. Thumb2
> implies V7, so 'isb' should always be supported in that case.

I think, given how close Christmas is, and I suspect that the merge
window will be opening shortly afterwards, it'll be better to drop
the change and sort it out in the new year, rather than trying to
rush this in, especially as we're already at the 3rd iteration of
this supposedly simple change.  It obviously isn't quite as simple
as it looks.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
