From: rabin@rab.in (Rabin Vincent)
Date: Sun, 25 Oct 2015 23:07:01 +0100
Subject: Build regressions/improvements in v4.3-rc7
In-Reply-To: <20151025190318.GA3320@afzalpc>
References: <1445767971-22415-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdX9X8SRCA4K++LvRz1sK3Ewyj5wKbvrdAy06L6v2XTduA@mail.gmail.com>
 <CAMuHMdUkNad7-zHSEfy__rPXKV2t0_7O+MtHiW1hUN=t30KWoA@mail.gmail.com>
 <20151025140822.GA32532@n2100.arm.linux.org.uk>
 <CAMuHMdVdSa2899nEYq4dg_WghdCWgj4jZqnd_8FE7_221O0CFQ@mail.gmail.com>
 <20151025190318.GA3320@afzalpc>
Message-ID: <20151025220701.GA5635@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2015 at 12:33:18AM +0530, Afzal Mohammed wrote:
> On Sun, Oct 25, 2015 at 06:38:18PM +0100, Geert Uytterhoeven wrote:
> > I think we should have at least one arm-nommu platform in the upstream kernel,
> > with a suitable defconfig, so 0build will catch regressions.
> 
> afaik, there are 4 arm-nommu defconfig's. Has been recently playing
> with Vybrid nommu platform, did not notice any build error w/ it's
> defconfig (vf610m4) and able to boot too. Just now tried -rc7, it too
> was success.

vf610m4 won't use patch.c since it has CONFIG_XIP_KERNEL=y.  The failing
config is a randconfig[1], but the error can be triggered by, for
example, enabling CONFIG_JUMP_LABEL=y on lpc18xx_defconfig.

[1] http://kisskb.ellerman.id.au/kisskb/buildresult/12531538/
