From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Feb 2011 11:08:08 +0000
Subject: [PATCH v2] ARM: Define wfi() macro for v6 processors
In-Reply-To: <1297162885-2975-1-git-send-email-dave.martin@linaro.org>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org>
Message-ID: <20110208110808.GA22877@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 08, 2011 at 11:01:25AM +0000, Dave Martin wrote:
> For v6, wfi is architected as a defined MCR instruction, so
> use that definition.
> 
> Doing a no-op instead of wfi() is probably bad, so for older
> processors than v6, wfi() is not defined.  If needed, some CPU-
> specific wfi() will have to be defined elsewhere.

This is something we kind-of already handle in a different way - see
the individual processor idle function in arch/arm/mm/proc*.S.

There's various errata work-arounds older CPUs need for wfi (or rather
its mcr equivalent) so maybe wfi() should just be an alias for a call
to that function.  Or maybe we shouldn't have a wfi() macro at all.
