From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 18 May 2017 08:49:49 +0200
Subject: [PATCH] clk: sunxi-ng: enable SUNXI_CCU_MP for PRCM
In-Reply-To: <CAGb2v67EHRVrbR9dsNtMuuG+L11WxHcoqVw4GyyD0-hhJ3EPnw@mail.gmail.com>
References: <20170517212035.3100471-1-arnd@arndb.de>
 <CAGb2v67EHRVrbR9dsNtMuuG+L11WxHcoqVw4GyyD0-hhJ3EPnw@mail.gmail.com>
Message-ID: <20170518064949.4i3jebpijpjbvm5q@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 10:25:23AM +0800, Chen-Yu Tsai wrote:
> On Thu, May 18, 2017 at 5:19 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > The newly added PRCM CCU driver uses SUNXI_CCU_MP_WITH_MUX_GATE, which causes
> > a link error when no other driver enables SUNXI_CCU_MP:
> >
> > drivers/clk/built-in.o:(.data+0x5c8c8): undefined reference to `ccu_mp_ops'
> >
> > This adds an explicit 'select' statement for it.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170518/2d4db7c2/attachment.sig>
