From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 20 Mar 2017 10:51:08 +0100
Subject: [PATCH] clk: sunxi: ccu-sun5i needs nkmp
In-Reply-To: <CAK8P3a13rqommB90NP_aNPgcoYXb9u=LYs7ep3U=c3C6-3wPHA@mail.gmail.com>
References: <20170214213005.2848151-1-arnd@arndb.de>
 <20170216175318.fuj375743jt43um4@lukather>
 <CAK8P3a13rqommB90NP_aNPgcoYXb9u=LYs7ep3U=c3C6-3wPHA@mail.gmail.com>
Message-ID: <20170320095108.nru6wnl5lcigzsoc@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, Mar 13, 2017 at 05:24:10PM +0100, Arnd Bergmann wrote:
> On Thu, Feb 16, 2017 at 6:53 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Tue, Feb 14, 2017 at 10:29:45PM +0100, Arnd Bergmann wrote:
> >> A randconfig build ran into this rare link error:
> >>
> >> drivers/clk/sunxi-ng/ccu-sun5i.o:(.data.__compound_literal.1+0x4): undefined reference to `ccu_nkmp_ops'
> >> drivers/clk/sunxi-ng/ccu-sun5i.o:(.data.__compound_literal.7+0x4): undefined reference to `ccu_nkmp_ops'
> >>
> >> This adds the missing 'select'.
> >>
> >> Fixes: 5e73761786d6 ("clk: sunxi-ng: Add sun5i CCU driver")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Queued as a fix for 4.11, thanks!
> 
> I just checked my old patches and this seems to still be required as of
> 4.11-rc2. I see it in linux-next through sunxi/sunxi/for-next, but not as
> part of a clk-fixes merge.

Sorry, I went to holidays without sending the PR. I just did,
hopefully, it should be on Linus' way for the next rc.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/8904798f/attachment.sig>
