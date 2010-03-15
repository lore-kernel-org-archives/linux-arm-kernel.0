From: konkers@google.com (Erik Gilling)
Date: Mon, 15 Mar 2010 15:38:36 -0700
Subject: [RFC/PATCH] ARM: add Tegra support
In-Reply-To: <4B96798C.6060201@compulab.co.il>
References: <4B96798C.6060201@compulab.co.il>
Message-ID: <4344f3c71003151538r7dc30e01uc9885ca5d3f327cd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 9, 2010 at 9:38 AM, Mike Rapoport <mike@compulab.co.il> wrote:
> This patch adds basic support for Nvidia Tegra2 platform.

This code seems to be our port from
git://android.git.kernel.org/kernel/tegra.git with some features
removed, minor cleanups, and many trivial changes.  These changes make
it difficult for us to track improvements and bug fixes in either
direction.  We're happy that other people are interested in our work
however are disappointed that our opinions were not sought before
making these changes and posting nor was any attribution given to the
work's authors.

We're still in the process here at Google of cleaning up the port for
submission.  We should have our changes rebased on 34-rc1 without the
android-common code by the end of the day.  We've been maintaining a
patchstack which separates out the functional subsystems.  Would
people here prefer to see that or a collapsed patch like this one.

Specific issues with this patch with respect to our work:

Lots of trival changes like moving files around, renaming variables,
and re-wording/re-formating comments (sometimes changing the meaning
of the comment incorrectly)

Removal of SMP, L2 cache, and pinmux support.

Removal of the gpio_names header.  Because tegra does not define GPIOs
numerically, it is impossible to convert a gpio name (i.e. PN6) from a
schematic to a GPIO number without consulting and interpreting the
datasheet.

Removal of the tegra_gpio_enable and tegra_gpio_disable functions.
Because of the way pin muxing is implemented in tegra, gpio
configuration does not map into the pinmuxing subsystem.

Removal of pr_debug lines from the clock code.

Changing the way peripheral clocks are defined to use two separate
tables which are required to be kept in sync by hand.

Removal of some pll entries.

-Erik
