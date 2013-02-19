From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 19 Feb 2013 12:00:15 +0000
Subject: [RFC v3] Better BE support for ARM
In-Reply-To: <1360752927-29331-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1360752927-29331-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130219120015.GB1978@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 13, 2013 at 10:55:18AM +0000, Ben Dooks wrote:
> This is a smaller version of the previous series that adds some fixes
> for ARM big endian (BE8) mode on some of the latest ARMv7 systems as
> well as fix a few issues that where found whilst doing this.
> 
> The new series should be less intrusive, as we alter less and use an
> assembly macro to remove anything we do not need if we are not in BE8
> mode. If it was not for secondary CPU initialisations and resume paths
> we could do this with a pre-boot shim for loading from LE boot loaders.x
> 
> Since the issue of the ATAGS endian-ness is still in discussion, this
> has been removed from the series. If the system was booted from an LE
> enviromnent which uses FDT, then this patch set should work. The ATAGS
> code will be posted as a separate series.
> 
> The fixes for ASID allocation when big endian has already been sent to
> the patch system.

You may also want to take a look at the following series -- I don't remember
how mature this stuff was, but it doesn't look like it every got merged.
It could make sense to combine some parts of it with your series, unless
the author wants to pick it up again.

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-December/075728.html

This contains draft fixes for some things we don't yet have, like non-broken
module loading.

Cheers
---Dave
