From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 12 Mar 2013 22:38:10 -0600
Subject: [RFC PATCH] ARM: bcm2835: convert to multi-platform
In-Reply-To: <1363064399-19559-1-git-send-email-swarren@wwwdotorg.org>
References: <1363064399-19559-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <514002B2.8010102@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2013 10:59 PM, Stephen Warren wrote:
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

I have applied this to bcm2835's for-3.10/multiplatform branch, with the
TODO message removed from the commit description.
