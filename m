From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Mar 2013 12:33:32 +0000
Subject: [RFC PATCH] ARM: bcm2835: convert to multi-platform
In-Reply-To: <1363064399-19559-1-git-send-email-swarren@wwwdotorg.org>
References: <1363064399-19559-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201303121233.32476.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 March 2013, Stephen Warren wrote:
> This allows BCM2835 be included in a kernel build that supports multiple
> SoCs at once, which is useful for distro kernels.
> 
> This change:
> * Moves bcm2835's debug-macro.S into ARM's include/debug/, and hooks it
>   into the relevant menu.
> * Moves bcm2835's Kconfig into its own directory, as seems typical for
>   multi-platform conversions.
> * Removes bcm2835_soc.h, and moves the content to the files where it was
>   used; just one usage per define.
> * Deletes some headers and Makefile.boot that aren't needed now that we
>   support multi-platform.

Nice work!

> TO DO:
> * It'd be nice to restore uncompress.h. I need to take a look at Shawn
>   Guo's patches related to this, and presumably rebase this on top of
>   them.

As Shawn said, that should not even be necessary.
 
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
