From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 20 Feb 2012 15:51:55 +0200
Subject: [2.6.39.3] [MX25] oops in driver_register for ADC touchscreen
 support (imx_adc_ts)
In-Reply-To: <9741ebebcbc88e7e82a70d619e6c1d51@mail.fqingenieria.es>
References: <50e2a71500444a5e1b951e5856d474bf@mail.fqingenieria.es>
 <20120220094013.GA9921@sapphire.tkos.co.il>
 <70cdf2c4b729fb7dfa1d641c4609c6f5@mail.fqingenieria.es>
 <20120220101157.GB9921@sapphire.tkos.co.il>
 <9741ebebcbc88e7e82a70d619e6c1d51@mail.fqingenieria.es>
Message-ID: <20120220135155.GC9921@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi joancarles,

On Mon, Feb 20, 2012 at 02:42:14PM +0100, joancarles wrote:
> >>We are also trying a stock 3.3-rc kernel and can't get
> >>our i.MX25 to boot ... yet.
> >
> >This is on-topic here. Can you share more details?
> 
> Right now, the only tree we have to test here is a 3.2.0-rc2, but I
> will try a 3.3-rc kernel soon (slow Internet connection and an even
> slower computer to cross-compile kernels inhibits us perform work
> quicker). In case there is interest, this is the output of where it
> hangs.
> 
> I believe it might have something to do with the way of how MTD
> works, or doesn't in our case, with regard to 2.6.x kernels. It
> can't find a list of partitions.

[snip]

> Kernel command line: console=ttymxc0,115200 root=/dev/mtdblock2
> rootfstype=jffs2 mtdparts=physmap-flash.0:0x100000(u-boot),0x300000(kernel),0x3C00000(jffs2)
> bootcmd=tftpboot 0x81000000 /v2.1.8-rc/uImage

[snip]

> List of all partitions:
> No filesystem could mount root, tried:  jffs2
> Kernel panic - not syncing: VFS: Unable to mount root fs on
> unknown-block(0,0)
> [<c00181d0>] (unwind_backtrace+0x0/0xf0) from [<c0325f58>]
> (panic+0x60/0x198)
> [<c0325f58>] (panic+0x60/0x198) from [<c041db7c>]
> (mount_block_root+0x244/0x294)
> [<c041db7c>] (mount_block_root+0x244/0x294) from [<c041dd4c>]
> (prepare_namespace+0x11c/0x180)
> [<c041dd4c>] (prepare_namespace+0x11c/0x180) from [<c041d800>]
> (kernel_init+0xe8/0x11c)
> [<c041d800>] (kernel_init+0xe8/0x11c) from [<c0013cf4>]
> (kernel_thread_exit+0x0/0x8)

MTD support in your kernel seems to be missing.

What kind of flash do you have on your board? NOR? NAND?

Please post your kernel .config file.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
