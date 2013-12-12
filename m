From: broonie@kernel.org (Mark Brown)
Date: Thu, 12 Dec 2013 12:06:49 +0000
Subject: [PATCH 2/3] arm64: topology: Tell the scheduler about the
 relative power of cores
In-Reply-To: <20131212113512.GC28621@e103034-lin>
References: <1386792029-23148-1-git-send-email-broonie@kernel.org>
 <1386792029-23148-2-git-send-email-broonie@kernel.org>
 <20131212113512.GC28621@e103034-lin>
Message-ID: <20131212120649.GB5367@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 11:35:12AM +0000, Morten Rasmussen wrote:

> I know that this is how it is currently done for ARMv7 and one could
> argue that we should do the same for ARMv8 until we have a better
> solution. I just want to highlight that setting cpu_power this way is
> not generally the right thing to do for big.LITTLE. It will have to be
> fixed eventually.

Right, there's a good solid reason for all the work on the scheduler.  I
definitely think we ought to be following the same approach on both
ARMv7 and ARMv8 to avoid confusion between people based on the platform
they're working on.

If you're saying that the current ARMv7 code is always worse than doing
nothing then clearly we ought to be removing that code from ARMv7 rather
than hurting performance.  I'd been under the impression that what we
had there was not ideal but better than nothing in mainline rather than
actively harmful.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/853b289e/attachment.sig>
