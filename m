From: olof@lixom.net (Olof Johansson)
Date: Sat, 19 May 2012 08:11:30 -0700
Subject: [PATCH] mtd: nand: gpmi: fix compile error caused by pinctrl call
In-Reply-To: <1337432773-24000-1-git-send-email-shawn.guo@linaro.org>
References: <1337432773-24000-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAOesGMhfByBhx9Kn1PhYMoaKfbD8NeOrYHCG5sTkRLDwmPW-MA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 19, 2012 at 6:06 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Fix following compile error caused by commit 39febc0 (mtd: nand: gpmi:
> adopt pinctrl support).
>
> ?CC ? ? ?drivers/mtd/nand/gpmi-nand/gpmi-nand.o
> drivers/mtd/nand/gpmi-nand/gpmi-nand.c: In function ?acquire_resources?:
> drivers/mtd/nand/gpmi-nand/gpmi-nand.c:499:45: error: ?pdev? undeclared (first use in this function)
>
> Reported-by: Subodh Nijsure <snijsure@grid-net.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> Hi Arnd, Olof,
>
> Can you please apply the patch on top of arm-soc/imx/pinctrl branch or
> amend commit 39febc0 (mtd: nand: gpmi: adopt pinctrl support) with the
> fixing? ?Sorry for this mistake.

Applied to imx/pinctrl (and next/pinctrl).

Given that the mxs defconfig doesn't expose this error, would you mind
adding the driver to the platforms where it makes sense so we get
build coverage in linux next and for those who use defconfigs to
provide it?


Thanks!

-Olof
