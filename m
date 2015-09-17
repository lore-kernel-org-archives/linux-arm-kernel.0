From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 17 Sep 2015 19:57:48 -0300
Subject: i.MX27 device tree
In-Reply-To: <55FB2AC4.4070907@phoenixsoftware.it>
References: <55FB2AC4.4070907@phoenixsoftware.it>
Message-ID: <CAOMZO5BNQ3NyywH6YGydYZbZsfWhG_8RqbESibUxTPMY_7hvdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2015 at 6:04 PM, Pierluigi Passaro
<pierluigi.passaro@phoenixsoftware.it> wrote:
> Hi all,
> I do need to test latest 4.1 kernel on i.MX27 PDK, but I'm not able to find
> any bootloader providinfg dts support.
>
> Could you give any suggestion?

You can use Redboot to boot a mainline kernel on mx27pdk.

make imx_v4_v5_defconfig
make menuconfig

Boot options--->

then select:

[*] Use appended device tree blob to zImage (EXPERIMENTAL)
[*]   Supplement the appended DTB with traditional ATAG information

Build the kernel: make
Build the dtb: make imx27-pdk.dtb

Append the dtb to the kernel:
cat arch/arm/boot/zImage arch/arm/boot/dtb/imx27_pdk.dtb > zImage_combined

Rename zImage_combined to zImage and then boot it as it were a normal zImage.

Regards,

Fabio Estevam
