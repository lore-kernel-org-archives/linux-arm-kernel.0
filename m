From: olof@lixom.net (Olof Johansson)
Date: Tue, 14 Jul 2015 11:16:12 +0200
Subject: [PATCH 2/2] ARM: ux500: fix MMC/SD card regression
In-Reply-To: <1436361322-27732-1-git-send-email-linus.walleij@linaro.org>
References: <1436361322-27732-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20150714091612.GB20686@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 08, 2015 at 03:15:22PM +0200, Linus Walleij wrote:
> Ux500 is regressing due to commit
> a21763a0b1e5a5ab8310f581886d04beadc16616
> "pinctrl: nomadik: activate strict mux mode" which disallows
> Nomadik GPIO 5 to be muxed in as a level shifter voltage select
> pin, as it is currently described as being used for RX on UART1.
> 
> The behaviour is correct, instead the hardware config has been
> incorrecly specified: UART1 is indeed unused on HREFv60plus and
> Snowball and that is why HREFv60plus can use the pins it would
> normally occupy as the voltage select line for the MMC/SD
> levelshifter (Snowball uses it for I2C4).
> 
> The reason UART1 was anyway enabled on these platforms was
> probably to secure the port enumeration to userspace. This
> can be solved by using aliases (done in a separate patch) so
> we can now deactivate UART1 and let MMC/SD use it properly
> on HREFv60plus. We explicitly activate it only for the
> older HREFprev60 board.
> 
> To complete, we set up the pin configuration for these pins
> properly in the sdi0 node.
> 
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC guys: if it looks OK, please apply this patch directly
> for fixes along with 1/1.

Thanks, applied together with the newer version of 1/2.


-Olof
