From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Jul 2015 11:06:13 +0200
Subject: [PATCH][v3] ARM: imx: pinctrl-imx: imx7d: add support for iomuxc
 lpsr
In-Reply-To: <1436295725-19011-1-git-send-email-aalonso@freescale.com>
References: <1436295725-19011-1-git-send-email-aalonso@freescale.com>
Message-ID: <CACRpkdYXaUsCFzbm9Dp7MtVCbyB_qcuDOp-rLPRx7_cSfT-1tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 7, 2015 at 9:02 PM, Adrian Alonso <aalonso@freescale.com> wrote:

> * Extend pinctrl-imx driver to support iomux lpsr conntroller,
> * iMX7D has two iomuxc controllers, iomuxc controller similar as
>   previous iMX SoC generation and iomuxc-lpsr which provides
>   low power state rentetion capabilities on gpios that are part of
>   iomuxc-lpsr (GPIO1_IO7..GPIO1_IO0).
> * Use IOMUXC_LPSR_SUPPORT and iput_val most significant bits to
>   properly configure iomuxc/iomuxc-lpsr settings.
>
> Signed-off-by: Adrian Alonso <aalonso@freescale.com>
>
> * Change from v1 to v2:
>   - Add suggested comment for input select register shared between
>     iomuxc-lpsr and normal iomuxc controller.
>   - Use IOMUXC_LPSR_MASK to extract pad group id and aling pin_id to
>     16 bit representation.
> * Change from v2 to v3
>   - Use devm_ioremap_resource instead of of_iomap to get iomuxc-lpsr
>     base register address.

I'm waiting for Shawn to review these patches.

Yours,
Linus Walleij
