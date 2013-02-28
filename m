From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Thu, 28 Feb 2013 12:07:48 +0100
Subject: [PATCH v2 2/3] crypto: sahara: Add driver for SAHARA2 accelerator.
In-Reply-To: <1361961711-4603-3-git-send-email-javier.martin@vista-silicon.com>
 (Javier Martin's message of "Wed, 27 Feb 2013 11:41:50 +0100")
References: <1361961711-4603-1-git-send-email-javier.martin@vista-silicon.com>
 <1361961711-4603-3-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <87vc9chf23.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier Martin <javier.martin@vista-silicon.com> writes:

Hi,

> SAHARA2 HW module is included in the i.MX27 SoC from
> Freescale. It is capable of performing cipher algorithms
> such as AES, 3DES..., hashing and RNG too.

The rmmod oops is gone with this version, thanks.

>
> This driver provides support for AES-CBC and AES-ECB
> by now.
>
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
> ---
>  drivers/crypto/Kconfig  |   10 +
>  drivers/crypto/Makefile |    1 +
>  drivers/crypto/sahara.c | 1070 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1081 insertions(+)
>  create mode 100644 drivers/crypto/sahara.c
>
> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> index 87ec4d0..7d73f5a 100644
> --- a/drivers/crypto/Kconfig
> +++ b/drivers/crypto/Kconfig
> @@ -276,6 +276,16 @@ config CRYPTO_DEV_PICOXCELL
>  
>  	  Saying m here will build a module named pipcoxcell_crypto.
>  
> +config CRYPTO_DEV_SAHARA
> +	tristate "Support for SAHARA crypto accelerator"
> +	depends on MACH_MX27 && EXPERIMENTAL && OF

maybe switch to ARCH_MXC instead of MAC_MX27 ?

[...]

> +static struct platform_driver sahara_driver = {
> +	.probe		= sahara_probe,
> +	.remove		= __devexit_p(sahara_remove),

Please remove the __devexit_p too.


For information, you'll find below what I've changed to test the driver on my
imx51. It's not perfect but it's enough for testing things.


Arnaud
-------------- next part --------------
A non-text attachment was scrubbed...
Name: imx51-sahara.patch
Type: text/x-diff
Size: 5482 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130228/ba3ba53a/attachment-0001.bin>
