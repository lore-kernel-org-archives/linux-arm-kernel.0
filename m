From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 20:45:01 -0700
Subject: [GIT PULL] Allwinner H3 changes for 4.13
In-Reply-To: <20170614202316.3tsepyo52tb4spw6@flea.home>
References: <20170614202316.3tsepyo52tb4spw6@flea.home>
Message-ID: <20170619034501.GV30022@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 14, 2017 at 10:23:16PM +0200, Maxime Ripard wrote:
> Hi Arnd, Olof,
> 
> This time again, due to the shared DTSI between the H3 and H5, we had
> to create a common branch shared by both arm and arm64 (commits up to
> 0eba511a3cac).
> 
> This one is built on top of that common branch and the H5 will be
> built the same way.

Ok, that works well for us. We might just fold the two dt branches in our tree
at some point, but not yet.

> 
> Thanks!
> Maxime
> 
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt-h3-for-4.13
> 
> for you to fetch changes up to 7a78ef92cdc5813cab2c3a8ca2334eaaedc6818c:
> 
>   ARM: sun8i: h3: Enable EMAC with external PHY on Orange Pi Plus 2E (2017-06-10 11:24:39 +0200)
> 
> ----------------------------------------------------------------
> Allwinner H3 changes for 4.13
> 
> This tag is about bringing the EMAC support to the H3 boards.

Merged, thanks.


> ----------------------------------------------------------------
> Chen-Yu Tsai (2):
>       ARM: sunxi: h3-h5: Convert R_CCU raw numbers to macros
>       ARM: sun8i: h3: Enable EMAC with external PHY on Orange Pi Plus 2E
> 
> Corentin Labbe (10):
>       arm: sun8i: sunxi-h3-h5: Add dt node for the syscon control module
>       arm: sun8i: sunxi-h3-h5: add dwmac-sun8i ethernet driver
>       arm: sun8i: orangepi-pc: Enable dwmac-sun8i
>       arm: sun8i: orangepi-one: Enable dwmac-sun8i
>       arm: sun8i: orangepi-2: Enable dwmac-sun8i
>       arm: sun8i: orangepi-pc-plus: Set EMAC activity LEDs to active high
>       arm: sun8i: nanopi-neo: Enable dwmac-sun8i
>       ARM: sun8i: orangepi-plus: Enable dwmac-sun8i
>       ARM: sun8i: bananapi-m2-plus: Enable dwmac-sun8i
>       arm: sun8i: orangepi-zero: Enable dwmac-sun8i

Nit: We tend to use ARM: dts: for prefix, and it seems like the
dwmac-sun8i could just as well have been folded into one or just a
few patches.


-Olof
