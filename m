From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 23 Sep 2013 22:49:35 +0200
Subject: at91sam9263 not booting on 3.12-rc1
Message-ID: <5240A95F.8000604@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi all,

I am trying to boot a 3.12-rc1 kernel on a calao USB-sam9263 (used
default sam9263 config file) but the board hangs at the message:

"Uncompressing Linux... done, booting the kernel."

After git bisecting, the commit preventing the board to boot is:

--------------------

commit ef1ab239c0c7de29072577bc8a39859074603948
Author: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date:   Fri May 24 06:52:06 2013 +0800

    ARM: at91: drop non DT: Calao USB-A96x

    as now we have full DT support of those board

    Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
    Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

----------------------

So I enabled the CONFIG_USE_OF, the dtb are correctly generated.

I tried to boot again, specifying the dtb address with bootm.

tftp 0x20000000 /var/lib/tftpboot/at91/arch/arm/boot/usb_a9263.dtb

tftp 0x21000000 /var/lib/tftpboot/at91/arch/arm/boot/uImage

bootm 0x21000000 - 0x20000000

but without success.

I am wondering what I could be doing wrong ...

Any help would be appreciate.

  -- Daniel


ps: u-boot is "U-Boot 2010.09 (Oct 27 2010 - 12:28:54)"


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
