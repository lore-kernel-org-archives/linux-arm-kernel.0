From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Mon, 9 Jan 2012 14:37:17 -0800
Subject: [GIT PULL 05/11] SoC-level changes for tegra and omap
In-Reply-To: <1326147171-13752-6-git-send-email-arnd@arndb.de>
References: <1326147171-13752-1-git-send-email-arnd@arndb.de>
 <1326147171-13752-6-git-send-email-arnd@arndb.de>
Message-ID: <CA+55aFyaOnJhrZOFnRiShH9kTeGEG8O8m9spvKF=c36QzjSvBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 9, 2012 at 2:12 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> ?58 files changed, 1967 insertions(+), 818 deletions(-)

Hmm. You don't seem to use the "detect renames" flag -M when you
create these, so the end result doesn't match mine.

With -M, it looks like this:

 54 files changed, 1399 insertions(+), 250 deletions(-)

because it sees these:

  rename arch/arm/mach-tegra/{board-dt.c => board-dt-tegra20.c} (91%)
  rename arch/arm/mach-tegra/include/mach/{pinmux-t2.h =>
pinmux-tegra20.h} (96%)
  rename arch/arm/mach-tegra/{pinmux-t2-tables.c =>
pinmux-tegra20-tables.c} (95%)
  rename arch/arm/plat-omap/include/plat/{ti816x.h => ti81xx.h} (60%)

Please do use -M, because it ends up making diffstats *so* much more
readable when there are renames (instead of big delete-create diffs,
you get a small diffstat that actually is much more relevant to what
happened).

                     Linus
