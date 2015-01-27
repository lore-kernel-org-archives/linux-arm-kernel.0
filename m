From: olof@lixom.net (Olof Johansson)
Date: Mon, 26 Jan 2015 20:22:37 -0800
Subject: [GIT PULL] Allwinner fixes for 3.19
In-Reply-To: <20150125173914.GA26866@lukather>
References: <20150125173914.GA26866@lukather>
Message-ID: <20150127042237.GE22154@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 25, 2015 at 06:39:14PM +0100, Maxime Ripard wrote:
> Hi Arnd, Kevin, Olof,
> 
> Please pull the following commits for the 3.19 kernel.
> 
> Thanks!
> Maxime
> 
> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> 
>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-fixes-for-3.19
> 
> for you to fetch changes up to 117a2cc38ffe0b46bcc6f991a3534b345477439c:
> 
>   ARM: sunxi: dt: Fix aliases (2015-01-25 18:06:34 +0100)
> 
> ----------------------------------------------------------------
> Allwinner fixes for 3.19
> 
> A few minor fixes for the 3.19 kernel:
>   - The 8250 uart driver now respects the aliases, which pointed out that we
>     were using them wrong. Fixed them.

D'oh. We found this in time on Tegra, but I guess Allwinner snuck by without
anyone noticing before the code went in.

>   - The simplefb pipeline that was used on the A10 caused flickering and
>     tearing, and rendered it pretty much useless. Added a new simplefb node
>     with another pipeline that removes this issue. Note that we need to keep
>     the old node because u-boot 2015.01 uses it.
>   - Added a fix for the USB phy node on sun4i/sun5i
> 
> ----------------------------------------------------------------

Merged, thanks.


-Olof
