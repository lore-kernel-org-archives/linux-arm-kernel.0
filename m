From: dianders@chromium.org (Doug Anderson)
Date: Tue, 27 Nov 2018 09:39:09 -0800
Subject: [PATCH v5 2/4] kgdb: Fix kgdb_roundup_cpus() for arches who used
 smp_call_function()
In-Reply-To: <201811271333.8ZTVxYUT%fengguang.wu@intel.com>
References: <20181127035133.225592-3-dianders@chromium.org>
 <201811271333.8ZTVxYUT%fengguang.wu@intel.com>
Message-ID: <CAD=FV=V087x+56aWFtJxg31O09cFUm00grH7bq1rLSwoq68WdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 26, 2018 at 9:39 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Douglas,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on kgdb/kgdb-next]
> [also build test ERROR on v4.20-rc4 next-20181126]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Douglas-Anderson/kgdb-Fix-kgdb_roundup_cpus/20181127-115425
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jwessel/kgdb.git kgdb-next
> config: sparc64-allyesconfig (attached as .config)
> compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=sparc64
>
> Note: the linux-review/Douglas-Anderson/kgdb-Fix-kgdb_roundup_cpus/20181127-115425 HEAD b8d0502e65f2d7a2187baa69870146a6fbf18c9f builds fine.
>       It only hurts bisectibility.
>
> All errors (new ones prefixed by >>):
>
>    kernel/debug/debug_core.c: In function 'kgdb_roundup_cpus':
> >> kernel/debug/debug_core.c:261:18: error: 'struct debuggerinfo_struct' has no member named 'rounding_up'
>        kgdb_info[cpu].rounding_up = false;
>                      ^

Oops, I squashed this into the wrong patch.  It should have been in
patch #3.  Sorry about that.  I'll send out a quick v6.
