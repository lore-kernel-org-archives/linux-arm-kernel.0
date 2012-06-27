From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 27 Jun 2012 07:28:40 +0300
Subject: [PATCH v11 0/4] MTD: at91: Add PMECC support for at91 nand
 flash driver
In-Reply-To: <4FEA87E5.9010604@atmel.com>
References: <1340618866-28776-1-git-send-email-josh.wu@atmel.com>
 <1340768981.2317.7.camel@koala> <4FEA87E5.9010604@atmel.com>
Message-ID: <1340771320.2317.13.camel@koala>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-06-27 at 12:11 +0800, Josh Wu wrote:
> Hi, Artem
> 
> On 6/27/2012 11:49 AM, Artem Bityutskiy wrote:
> > On Mon, 2012-06-25 at 18:07 +0800, Josh Wu wrote:
> >> Those patches is based on v3.5-rc4
> >>
> >> Changes since v10,
> >> 	add one more patch in this patch set, which add 'int' return value for write_page()/write_page_raw() functions in structure of nand_ecc_ctrl.
> >> 	Instead of calling BUG(), atmel_nand_pmecc_write_page() will return -EIO when time out to read the pmecc status register.
> >> 	increase the time-out duration to 100ms, which has more toleration.
> >> 	add oob_required argument for pmecc read/write functions to align with v3.5-rc4.
> > I have issues compiling l2-mtd.git tree (based on 3.5-rc5) with the
> > attached defconfig. Probably not your fault, but may be you have a
> > fix/suggestion? I did not have time to look closer. Aiaiai reports:
> 
> I think the name of kernel config for AT91 is changed, so you can try 
> add following two line in your original config file.
> 
> CONFIG_SOC_AT91SAM9=y
> CONFIG_SOC_AT91RM9200=y
> 
> run the make menuconfig will get new config, that can pass the compile.

I get "arm-unknown-linux-gnueabi-ld: no machine record defined". I think
it wants me to select the board. I've tried one and get another
compilation issue:

arch/arm/mach-at91/built-in.o:(.arch.info.init+0xbc): undefined
reference to `at91sam926x_timer'

It looks like AT91 stuff is not looked after carefully.

Can you please send me a working defconfig based on the one I sent you -
just modify it.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120627/eba33f8d/attachment-0001.sig>
