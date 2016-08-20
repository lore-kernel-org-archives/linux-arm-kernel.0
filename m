From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 20 Aug 2016 17:23:17 +0100
Subject: [PATCH 0/2] add interworking support to Thumb2 kernel
In-Reply-To: <1471679131-3570-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1471679131-3570-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160820162317.GX1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 20, 2016 at 09:45:29AM +0200, Ard Biesheuvel wrote:
> In the core kernel, interworking is supported since vmlinux is a static
> binary, and the linker takes care of fixing up the bl instructions and
> emitting veneers if necessary. For modules, however, all function objects
> must currently be in the same mode, since the kernel's module loader does
> not handle interworking switches at all.

I'm not sure what the usefulness of this is - you're effectively
encouraging people to build modules with a different configuration
from the main kernel, which is bad news.  Since it's the configuration
which dictates whether the kernel (and modules) are built as ARM or
as Thumb2, you'd have to use two different configurations, one for the
main kernel and one for the modules.

That's really something we should not be encouraging.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
