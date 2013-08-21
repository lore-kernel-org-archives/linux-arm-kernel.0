From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 21 Aug 2013 10:08:36 +0200
Subject: [PATCH 28/33] ARM: ux500: Remove AUXDATA relating to MSP (Audio)
 clock-name bindings
In-Reply-To: <1370521041-32318-29-git-send-email-lee.jones@linaro.org>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
 <1370521041-32318-29-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYE7SgJiacneBq=cZ=7dAO2x3sBscFW075cDODxesYUWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 6, 2013 at 2:17 PM, Lee Jones <lee.jones@linaro.org> wrote:

> @@ -232,15 +232,6 @@ static struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
>         /* Requires device name bindings. */
>         OF_DEV_AUXDATA("stericsson,db8500-pinctrl", U8500_PRCMU_BASE,
>                 "pinctrl-db8500", NULL),
> -       /* Requires clock name and DMA bindings. */

The comment is just wrong.

> -       OF_DEV_AUXDATA("stericsson,ux500-msp-i2s", 0x80123000,
> -               "ux500-msp-i2s.0", &msp0_platform_data),

Look, it also adds &msp0_platform_data, which is vital.

Result after boot:
ALSA device list:
  No soundcards found.

Before the patch set we had audio and I kind of liked it :-)

I think you're able to set the device name as NULL though so
we only add this platform data, try it out.

Yours,
Linus Walleij
