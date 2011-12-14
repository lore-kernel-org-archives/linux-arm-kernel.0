From: mturquette@ti.com (Turquette, Mike)
Date: Tue, 13 Dec 2011 20:02:42 -0800
Subject: [PATCH v4 0/6] common clk framework
In-Reply-To: <1323834838-2206-1-git-send-email-mturquette@linaro.org>
References: <1323834838-2206-1-git-send-email-mturquette@linaro.org>
Message-ID: <CAJOA=zOnbUZAyNab5z-upeOHJPiLBYwTpiHogY+teSLcKMoKxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 7:53 PM, Mike Turquette <mturquette@linaro.org> wrote:
> From: Mike Turquette <mturquette@ti.com>
>
> The common clk framework is an attempt to define a generic struct clk
> which most platforms can use to build a clk tree and perform a set of
> well-defined operations.

Forgot to mention: these patches are based on v3.2-rc5 and can be pulled from:
http://git.linaro.org/gitweb?p=people/mturquette/linux.git;a=shortlog;h=refs/heads/v3.2-rc5-clkv4
git://git.linaro.org/people/mturquette/linux.git v3.2-rc5-clk-v4

Regards,
Mike

> The previous patchset, v3, can be found at,
> http://article.gmane.org/gmane.linux.kernel/1218622
>
> New stuff in v4:
> ?* clk rate change notifiers
> ?* clk debug info via debugfs (instead of sysfs)
> ?* lots of bug fixes
>
> Stuff that is known to be missing in v4:
> ?* basic mux and divider clk types
> ?* fix for migrating clk_prepare_count/clk_enable_count in
> ? clk_set_parent
> ?* minor rework comments from v3
> ?* Documentation/clk.txt needs love
>
> All of the mising items above will be rolled into v5 ASAP. ?I wanted to
> go ahead and push out the new notifier changes for review and gather
> comments on those since those were a big gap in the v3 patchset.
>
> Paul W. also had some good comments about the greater clk API, and the
> opportunity to fix some of that stuff while this patchset is still under
> discussion. ?I didn't address those here because they require more
> thought, and more comments from reviewers.
>
> Finally, OMAP4 support for the common struct clk will be posted
> immediately after this patch series to LAKML and LOML, along with some
> hack patches that show how to use the recursive clk_set_rate for
> propagating rate changes up the tree for CPUfreq and how to use the new
> clk rate change notifiers in a driver.
>
> Mike Turquette (6):
> ?clk: Kconfig: add entry for HAVE_CLK_PREPARE
> ?Documentation: common clk API
> ?clk: introduce the common clock framework
> ?clk: introduce rate change notifiers
> ?clk: basic gateable and fixed-rate clks
> ?clk: export the clk tree topology to debugfs
>
> ?Documentation/clk.txt ? | ?312 +++++++++++++++
> ?drivers/clk/Kconfig ? ? | ? 23 ++
> ?drivers/clk/Makefile ? ?| ? ?4 +-
> ?drivers/clk/clk-basic.c | ?208 ++++++++++
> ?drivers/clk/clk.c ? ? ? | ?992 +++++++++++++++++++++++++++++++++++++++++++++++
> ?include/linux/clk.h ? ? | ?230 +++++++++++-
> ?6 files changed, 1765 insertions(+), 4 deletions(-)
> ?create mode 100644 Documentation/clk.txt
> ?create mode 100644 drivers/clk/clk-basic.c
> ?create mode 100644 drivers/clk/clk.c
>
> --
> 1.7.5.4
>
