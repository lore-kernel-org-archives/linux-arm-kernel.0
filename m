From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Sep 2012 14:17:18 +0000
Subject: [RFC PATCH 0/3] ARM: uncompress.h multi-platform enablement
In-Reply-To: <506307A0.7010701@am.sony.com>
References: <1348613212-21897-1-git-send-email-swarren@wwwdotorg.org>
 <20120926104421.GA7040@n2100.arm.linux.org.uk> <506307A0.7010701@am.sony.com>
Message-ID: <201209261417.18883.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 September 2012, Tim Bird wrote:
> Will those of us not interested in a single kernel binary
> that works everywhere be able to configure an ARM kernel image
> without a lot of bloat?

I'm not aware of increase in code size from the single kernel
image yet. If you find something, let us know.

For the platforms that are being converted to multiplatform in
3.7, the kernel binary should be essentially the same between
building a single-platform kernel before the patches, and a
multiplatform kernel with only one platform enabled after the
patches.

We had to add a few indirect function pointers, e.g. for
SMP startup, but that overhead is measured in bytes, not
kilobytes.

	Arnd
