From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 10 Mar 2010 17:17:37 +0000
Subject: [PATCH 2.6.34] ARM: SAMSUNG: Fix build after "ARM: Eliminate
	decompressor -Dstatic= PIC hack"
In-Reply-To: <1267469542-19633-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1267469542-19633-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20100310171736.GJ6850@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 01, 2010 at 06:52:22PM +0000, Mark Brown wrote:
> Commit 5de813b6 (ARM: Eliminate decompressor -Dstatic= PIC hack) among
> other things changed the declared type of the error() function to an
> extern, conflicting with the forward declartion in the Samsung
> plat/uncompress.h which appears to have been relying on the static
> being defined away, causing build failures since error() ends up with
> a GOT relocation but the linker script discards all GOT relocated
> data and functions:

This is now required in mainline (2.6.34-rc1 fails to build) - given the
severity and lack of response I'm just going to go ahead and send it to
the patch tracker, hope that's OK.
