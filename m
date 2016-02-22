From: robdclark@gmail.com (Rob Clark)
Date: Mon, 22 Feb 2016 17:36:36 -0500
Subject: [PATCH 0/8] drm: msm: module rework
In-Reply-To: <1456175331-714117-1-git-send-email-arnd@arndb.de>
References: <1456175331-714117-1-git-send-email-arnd@arndb.de>
Message-ID: <CAF6AEGuYQqsH9TEoc-_cgMRNRvB99SveTqW3gSwJJvsvhaqNmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 4:08 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> I saw some regressions on today's Linux-next kernel after
> the Makefiles got reworked and tried to come up with a quick
> fix. This ended up taking much longer, but the new version should
> be cleaner and I no longer get any build errors in this
> driver.

fyi, for the time being, I've already kicked out the kconfig/makefile
splitup patches..

I'll go ahead and pull in the hdmi symbol rename patch, since that is
a sane thing to do.  I'm less sure about splitting things up into
separate .ko's.  And I think having the .ko name not match the drm
driver name (ie. what is passed in to drmOpen() in userspace) would
cause issues since libdrm could try to modprobe $drivername.ko.  (I
*think* that only matters in the non-udev case?  Which is at least not
a common case, but breaking userspace is breaking userspace...)

BR,
-R

> The first two patches are just preparation to avoid the
> namespace problems with global symbols and the module name.
>
> The next five patches separate out each subdirectory that has
> its own Makefile into a separate loadable module.
>
> The final patch is just a nice addon, it should work in theory
> but this needs to be tested well.
