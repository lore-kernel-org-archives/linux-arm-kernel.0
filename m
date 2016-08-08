From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Aug 2016 23:34:31 +0200
Subject: [PATCH 2/4] soc: qcom: add EBI2 driver
In-Reply-To: <1470691445-27571-3-git-send-email-linus.walleij@linaro.org>
References: <1470691445-27571-1-git-send-email-linus.walleij@linaro.org>
 <1470691445-27571-3-git-send-email-linus.walleij@linaro.org>
Message-ID: <4682049.SjGsnbmFIW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 8, 2016 11:24:03 PM CEST Linus Walleij wrote:
> This adds a driver for the Qualcomm External Bus Interface EBI2
> found in the MSM8660 and APQ8060 SoCs (at least).
> 
> This was tested with the SMSC9112 ethernet on the APQ8060
> Dragonboard sitting on top of the SLOW CS2.
> 
> Some of my understanding if very vague and based on guesses and
> extrapolations: the documentation in APQ8060 Qualcomm Application
> Processor User Guide 80-N7150-14 Rev. A describes select features but
> does not document the register bit fields.
> 
> However I had to do something like this to provide a serious driver,
> I have marked the guesses with /* GUESS */
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/soc/qcom/Kconfig  |   8 +
>  drivers/soc/qcom/Makefile |   1 +
>  drivers/soc/qcom/ebi2.c   | 371 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 380 insertions(+)
>  create mode 100644 drivers/soc/qcom/ebi2.c
> 

This should probably live in drivers/memory, or possibly drivers/bus.

	Arnd
