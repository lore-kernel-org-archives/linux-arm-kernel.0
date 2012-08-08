From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 8 Aug 2012 14:19:40 -0300
Subject: [PATCH] efikamx: reintroduce Genesi Efika MX Smarttop via device
 tree
In-Reply-To: <CAKGA1bkbp8_z+HSr97cp_jeCrdTHkQxuZPFu0QPWwnXphWVdZA@mail.gmail.com>
References: <1344375978-29981-1-git-send-email-matt@genesi-usa.com>
 <20120808151555.GE14718@S2101-09.ap.freescale.net>
 <CAKGA1bkbp8_z+HSr97cp_jeCrdTHkQxuZPFu0QPWwnXphWVdZA@mail.gmail.com>
Message-ID: <CAOMZO5DOEfV4wTSNW8ABaUhGwa_KG3Bkt0o-rs8k-cZk4P-=+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Matt,

On Wed, Aug 8, 2012 at 1:55 PM, Matt Sealey <matt@genesi-usa.com> wrote:

...
> or any setup at all for this. What's stopping this right now is you
> need a new U-Boot which we
> didn't release or mainline because we are still testing it (old U-Boot
> shipped on the boards
> cannot boot device tree anyway). While the number of users of this is

Actually you can boot a device tree kernel even on old bootloaders
that do not support dt.

You need to select:
CONFIG_ARM_APPENDED_DTB=y
CONFIG_ARM_ATAG_DTB_COMPAT=y

Then,

make -j4 zImage
make imx51-babbage.dtb
cat arch/arm/boot/zImage arch/arm/boot/ imx51-babbage.dtb  >
arch/arm/boot/zImage_dtb
mkimage -A arm -O linux -T kernel -C none -a 0x90008000 -e 0x90008000
-n Linux -d arch/arm/boot/zImage_dtb arch/arm/boot/uImage

and boot this generated uImage the same way as you used to do in the
non-dt case.

Regards,

Fabio Estevam
