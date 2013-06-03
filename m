From: tom.leiming@gmail.com (Ming Lei)
Date: Mon, 3 Jun 2013 23:28:37 +0800
Subject: [PATCH 2/6] ARM: OMAP2+: Remove board-omap4panda.c
In-Reply-To: <20130517191753.468.1734.stgit@localhost>
References: <20130517191304.468.73487.stgit@localhost>
 <20130517191753.468.1734.stgit@localhost>
Message-ID: <CACVXFVOp6n3RhZnWD_hRxqE8a8amPA5SRWfkVhz+yCGZTtGjvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, May 18, 2013 at 3:17 AM, Tony Lindgren <tony@atomide.com> wrote:
> We can now boot with device tree. If you don't want to update u-boot,
> you can boot with appended DTB with the following instructions:
>
> 1. Make sure you have the appended DTB support in .config
>
>    CONFIG_ARM_APPENDED_DTB=y
>    CONFIG_ARM_ATAG_DTB_COMPAT=y
>    CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND=y
>
> 2. Build the zImage
>
>    $ ARCH=arm CROSS_COMPILE=... make zImage
>
> 3. Build the device tree blobs
>
>    $ ARCH=arm CROSS_COMPILE=... make dtbs
>
> 4. Append the correct panda dtb to zImage
>
>    Depending on your hardware it's omap4-panda.dtb, omap4-panda-a4.dtb
>    or omap4-panda-es.dtb.
>
>    $ cat arch/arm/boot/zImage arch/arm/boot/dts/omap4-panda-es.dtb > /tmp/appended
>
> 5. Use mkimage to produce the appended device tree uImage
>
>    $ mkimage -A arm -O linux -T kernel -C none -a 0x80008000 -e 0x80008000 \
>      -n "Linux" -d /tmp/appended /tmp/uImage

I followed the above steps and tried devicetree on Pandaboard against
3.10.0-rc3-next-20130528, and the board will hang during boot, but works
well with legacy mode.

         Hardware: Pandaboard A1
         dtb: omap4-panda.dtb

See 'dmesg' on below link:

         http://kernel.ubuntu.com/~ming/up/panda-dts.dmesg


Thanks,
-- 
Ming Lei
