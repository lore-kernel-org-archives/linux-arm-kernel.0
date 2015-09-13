From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 13 Sep 2015 08:19:26 -0700
Subject: Build regressions/improvements in v4.3-rc1
In-Reply-To: <CAMuHMdV31w=aDD-=uUPOqW71xLpOnH1jWeQpH=6x=vxNSo94FQ@mail.gmail.com>
References: <1442134868-17607-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdV31w=aDD-=uUPOqW71xLpOnH1jWeQpH=6x=vxNSo94FQ@mail.gmail.com>
Message-ID: <20150913151926.GA19850@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 13, 2015 at 11:03:51AM +0200, Geert Uytterhoeven wrote:
> On Sun, Sep 13, 2015 at 11:01 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > Below is the list of build error/warning regressions/improvements in
> > v4.3-rc1[1] compared to v4.2[2].
> >
[ ... ]

> 
> >   + /home/kisskb/slave/src/arch/powerpc/kvm/book3s_pr.c: error: 'last_sc' may be used uninitialized in this function [-Werror=uninitialized]:  => 1094:31
> 
> powerpc-allyesconfig, powerpc-randconfig, powerpc-allmodconfig
> 

I think that only affects powerpc-randconfig.

Also:

alpha:allmodconfig:

drivers/video/fbdev/aty/atyfb_base.c: In function 'atyfb_setup_generic':
drivers/video/fbdev/aty/atyfb_base.c:3447:2: error: implicit declaration of function 'ioremap_uc'

arm:rpc_defconfig:

fs/fat/dir.c: In function 'fat_ioctl_filldir':
fs/fat/dir.c:752:43: internal compiler error: Max. number of generated reload insns per insn is achieved (90)

[ gcc 4.9.1, 4.9.2 ]

arm64:allmodconfig:

drivers/firmware/qcom_scm-32.c:196:4: error: expected string literal before ?__asmeq?
drivers/firmware/qcom_scm-32.c:221:2: error: implicit declaration of function ?secure_flush_area?
drivers/firmware/qcom_scm-32.c:239:2: error: implicit declaration of function ?outer_inv_range?
drivers/firmware/qcom_scm-32.c:331:4: error: expected string literal before ?__asmeq?
drivers/firmware/qcom_scm-32.c:361:4: error: expected string literal before ?__asmeq?

h8300:edosk2674_defconfig, h8300:h8s-sim_defconfig:

drivers/clk/h8300/clk-h8s2678.c: In function ?h8s2678_pll_clk_setup?:
drivers/clk/h8300/clk-h8s2678.c:99:14: error: implicit declaration of function ?kzalloc?
drivers/clk/h8300/clk-h8s2678.c:138:2: error: implicit declaration of function ?kfree?

Guenter
