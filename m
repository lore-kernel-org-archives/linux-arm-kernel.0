From: plaes@plaes.org (Priit Laes)
Date: Mon, 07 Dec 2015 11:10:17 +0200
Subject: [PATCH 2/2] input: gt801_2plus1 - Add initial support for
 Goodix GT801 2+1
In-Reply-To: <alpine.DEB.2.02.1512070933400.2037@localhost6.localdomain6>
References: <201512071608.oGt2n0Wn%fengguang.wu@intel.com>
 <alpine.DEB.2.02.1512070933400.2037@localhost6.localdomain6>
Message-ID: <1449479417.6984.2.camel@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-12-07 at 09:34 +0100, Julia Lawall wrote:
> It looks like braces may be mising.? Please check.

Thanks, nice catch!

It's actually messed up indenting. Code works as intended.
> 
> julia
> 
> On Mon, 7 Dec 2015, kbuild test robot wrote:
> 
> > Hi Priit,
> > 
> > [auto build test WARNING on mripard/sunxi/for-next]
> > [also build test WARNING on next-20151203]
> > [cannot apply to input/next v4.4-rc4]
> > 
> > url:??? https://github.com/0day-ci/linux/commits/Priit-Laes/input-D
> river-for-Goodix-GT801-2-1-touchscreen/20151207-152831
> > base:?? https://git.kernel.org/pub/scm/linux/kernel/git/mripard/lin
> ux.git?sunxi/for-next
> > :::::: branch date: 46 minutes ago
> > :::::: commit date: 46 minutes ago
> > 
> > >> drivers/input/touchscreen/gt801_2plus1.c:119:3-30: code aligned
> with following code on line 120
> > 
> > git remote add linux-review https://github.com/0day-ci/linux
> > git remote update linux-review
> > git checkout d66df313f96e04572821e49cada65cb5c1bea9e2
> > vim +119 drivers/input/touchscreen/gt801_2plus1.c
> > 
> > d66df313 Priit Laes 2015-12-07? 113???????????return;
> > d66df313 Priit Laes 2015-12-07? 114? 
> > d66df313 Priit Laes 2015-12-07? 115???/* Build touch map */
> > d66df313 Priit Laes 2015-12-07? 116???touch_num = 0;
> > d66df313 Priit Laes 2015-12-07? 117???for (i = 0; (touch_raw != 0)
> && (i < ts->max_touch_num); i++) {
> > d66df313 Priit Laes 2015-12-07? 118???????????if (touch_raw & 1)
> > d66df313 Priit Laes 2015-12-07
> @119???????????????????touch_map[touch_num++] = i;
> > d66df313 Priit Laes 2015-12-07 @120???????????????????touch_raw >>=
> 1;
> > d66df313 Priit Laes 2015-12-07? 121???}
> > d66df313 Priit Laes 2015-12-07? 122? 
> > d66df313 Priit Laes 2015-12-07? 123???/* Calculate checksum */
> > 
> > ---
> > 0-DAY kernel test infrastructure??????????????? Open Source
> Technology Center
> > https://lists.01.org/pipermail/kbuild-all??????????????????; Intel
> Corporation
> > 
