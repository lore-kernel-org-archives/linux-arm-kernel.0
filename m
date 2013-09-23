From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 23 Sep 2013 18:31:43 -0300
Subject: at91sam9263 not booting on 3.12-rc1
In-Reply-To: <5240A95F.8000604@linaro.org>
References: <5240A95F.8000604@linaro.org>
Message-ID: <CAOMZO5D6Dfh3utsK8DRNHXUZpo4sk7UmOqVchGf2hvbpoFW6Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 23, 2013 at 5:49 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

> So I enabled the CONFIG_USE_OF, the dtb are correctly generated.
>
> I tried to boot again, specifying the dtb address with bootm.
>
> tftp 0x20000000 /var/lib/tftpboot/at91/arch/arm/boot/usb_a9263.dtb
>
> tftp 0x21000000 /var/lib/tftpboot/at91/arch/arm/boot/uImage
>
> bootm 0x21000000 - 0x20000000
>
> but without success.
>
> I am wondering what I could be doing wrong ...
>
> Any help would be appreciate.
>
>   -- Daniel
>
>
> ps: u-boot is "U-Boot 2010.09 (Oct 27 2010 - 12:28:54)"

I am not familiar with this board, but most likely this old U-boot
does not support dtb booting.
You can check whether "#define CONFIG_OF_LIBFDT" is included in your
board config file.

You could also try to update the bootloader or try to generate a
kernel + dtb image (need to select CONFIG_ARM_APPENDED_DTB option in
the kernel).

Regards,

Fabio Estevam
