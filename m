From: vagrant@debian.org (Vagrant Cascadian)
Date: Wed, 13 May 2015 10:53:28 -0700
Subject: [PATCH] ARM: dts: imx5: Add dts files for USB armory.
In-Reply-To: <87y4ldnvqd.fsf@aikidev.net>
References: <87h9t6i40r.fsf@aikidev.net> <20150427081428.GC9231@dragon>
 <87y4ldnvqd.fsf@aikidev.net>
Message-ID: <87vbfwe547.fsf@aikidev.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-04-27, Vagrant Cascadian wrote:
> On 2015-04-27, Shawn Guo wrote:
>> On Fri, Mar 27, 2015 at 01:23:00PM -0700, Vagrant Cascadian wrote:
>>> Add support for the USB armory board by Inverse Path. This board
>>> features a Freescale iMX53 SoC, 512MB RAM, and USB OTG operating in
>>> either peripheral or host mode, and 5 GPIO pins.
>>> 
>>> One .dtb is generated for operating in peripheral mode, and one is
>>> generated for operating in host mode.
>>
>> Is it possible to ask bootloader to patch the dtb instead of maintaining
>> a new one for just changing one USB property?
>
> It does appear to be possible with u-boot:
>
>   load mmc 0:1 $fdt_addr_r $fdtfile
>   fdt addr $fdt_addr_r
>   fdt set /soc/aips at 50000000/usb at 53f80000 dr_mode host
>
> Since the user would have to manually select the appropriate .dtb
> anyways, it may be reasonable to drop the host_mode.dtb and rely on the
> u-boot to tweak the fdt on boot to switch between usb modes.

Given that it is possible to set from u-boot, I'm wondering if it
wouldn't be worth reworking the patch to only generate a single .dtb for
now, and revisit the options for switching between USB host mode and
peripheral mode later?

live well,
  vagrant
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150513/07daa1b2/attachment.sig>
