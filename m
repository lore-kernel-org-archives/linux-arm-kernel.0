From: broonie@kernel.org (Mark Brown)
Date: Thu, 28 Jan 2016 12:44:17 +0000
Subject: [PATCH] arm64: asm: Explicitly include linux/personality.h in
 asm/page.h
In-Reply-To: <1453983508-20410-1-git-send-email-broonie@kernel.org>
References: <1453983508-20410-1-git-send-email-broonie@kernel.org>
Message-ID: <20160128124417.GE6078@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 12:18:28PM +0000, Mark Brown wrote:
> asm/page.h uses READ_IMPLIES_EXEC from linux/personality.h but does not
> explicitly include it causing build failures in -next where whatever was
> causing it to be implicitly included has changed to remove that
> inclusion.  Add an explicit inclusion to fix this.

Argh, sorry - this causes problems further down the line with linking
vdso.lds due to enums getting into the linker script and upsetting the
linker (there are several compile errors today so it was masked).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160128/30ed13da/attachment.sig>
