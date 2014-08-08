From: tom@sharkbay.at (Thomas Scheiblauer)
Date: Fri, 08 Aug 2014 16:37:51 +0200
Subject: [BUG]: imx6q (wandboard): Very unstable ethernet since kernel 3.16
In-Reply-To: <CAOMZO5BVPfXCzihwPQZYrNOmuBEWALW5rQq=M2qVmCLjmFFZig@mail.gmail.com>
References: <1407503758.19455.1.camel@sharkbay.at>
 <20140808132754.GC30282@n2100.arm.linux.org.uk>
 <1407507023.19455.3.camel@sharkbay.at>
 <CAOMZO5BVPfXCzihwPQZYrNOmuBEWALW5rQq=M2qVmCLjmFFZig@mail.gmail.com>
Message-ID: <1407508671.19455.5.camel@sharkbay.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fabio,

On Fre, 2014-08-08 at 11:17 -0300, Fabio Estevam wrote:
> Thomas,
> 
> On Fri, Aug 8, 2014 at 11:10 AM, Thomas Scheiblauer <tom@sharkbay.at> wrote:
> 
> > These lines in arch/arm/boot/dts/imx6qdl-wandboard.dtsi already seem to
> > be a workaround for some hardware errata:
> > ERR006687 ?ENET: Only the ENET wake-up interrupt request can wake the
> > system from Wait mode?
> >
> > See the original mail containing the patch:
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/221204.html
> 
> This commit is also in 3.15 kernel. Do you have this instability issue in 3.15?
> 
> It would be helpful if you could revert commit 9fc77821b17155c6e0 with
> 3.16 and try again, just to make sure that the workaround is not
> introducing issues.

in 3.15 and earlier I had similar issues. See the the original thread:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/202519.html
I increased TX_RING_SIZE from 16 to 64 as suggested by Duan Fugang from
Freescale to work around that problem. It didn't completely remedy it
but made it occur less often.
But probably that patch had already been applied to these kernels
because I usually patch my i.mx6 kernels with Robert C. Nelson's
patchset http://eewiki.net/display/linuxonarm/Wandboard which is
basically a collection of the patches found in this mailing list before
they are officially applied.
