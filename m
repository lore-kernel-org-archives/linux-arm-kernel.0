From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 25 Sep 2015 09:50:34 -0700
Subject: [PATCH v5 1/7] pinctrl: freescale: imx: fix system crash if
 enable two pinctl instances
In-Reply-To: <1443128043-21063-1-git-send-email-aalonso@freescale.com>
References: <1443128043-21063-1-git-send-email-aalonso@freescale.com>
Message-ID: <CACRpkdaW+_K=nsP+PFu7o0HZaR++xs2iQ+WcJwx23=_mon-AMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2015 at 1:53 PM, Adrian Alonso <aalonso@freescale.com> wrote:

> From: Robin Gong <b38343@freescale.com>
>
> Fix system chrash caused by groups whose number is smaller than the number
> of groups of the last pinctl instance which is not initialized.
>
> iMX7D supports two iomux controllers (iomuxc-lpsr and iomuxc) on probing
> the second instance (iomuxc) the chrash below occurs.

Looks like this is not a regression so should not be applied separately
for fixes?

I am waiting for one of the Freescale maintainers to review this, Markus
is raising issues with the DT handling and so the SoC maintainers need
to be involved in this: Shawn and/or Sascha.

Yours,
Linus Walleij
