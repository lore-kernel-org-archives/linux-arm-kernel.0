From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 27 Jan 2015 09:43:37 +0100
Subject: [GIT PULL] Allwinner fixes for 3.19
In-Reply-To: <20150127042237.GE22154@quad.lixom.net>
References: <20150125173914.GA26866@lukather>
 <20150127042237.GE22154@quad.lixom.net>
Message-ID: <20150127084337.GC7200@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 26, 2015 at 08:22:37PM -0800, Olof Johansson wrote:
> On Sun, Jan 25, 2015 at 06:39:14PM +0100, Maxime Ripard wrote:
> > Hi Arnd, Kevin, Olof,
> > 
> > Please pull the following commits for the 3.19 kernel.
> > 
> > Thanks!
> > Maxime
> > 
> > The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> > 
> >   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> > 
> > are available in the git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-fixes-for-3.19
> > 
> > for you to fetch changes up to 117a2cc38ffe0b46bcc6f991a3534b345477439c:
> > 
> >   ARM: sunxi: dt: Fix aliases (2015-01-25 18:06:34 +0100)
> > 
> > ----------------------------------------------------------------
> > Allwinner fixes for 3.19
> > 
> > A few minor fixes for the 3.19 kernel:
> >   - The 8250 uart driver now respects the aliases, which pointed out that we
> >     were using them wrong. Fixed them.
> 
> D'oh. We found this in time on Tegra, but I guess Allwinner snuck by without
> anyone noticing before the code went in.

Yeah, almost all of the boards use uart0 as their "main" UART, and so
only the secondary UART were affected by this, which made us catch it
pretty late.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150127/ec7b1bf4/attachment.sig>
