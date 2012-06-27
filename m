From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 27 Jun 2012 10:39:14 +0200
Subject: [PATCH v11 0/4] MTD: at91: Add PMECC support for at91 nand flash
 driver
In-Reply-To: <1340771320.2317.13.camel@koala>
References: <1340618866-28776-1-git-send-email-josh.wu@atmel.com>
 <1340768981.2317.7.camel@koala> <4FEA87E5.9010604@atmel.com>
 <1340771320.2317.13.camel@koala>
Message-ID: <4FEAC6B2.6030104@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/27/2012 06:28 AM, Artem Bityutskiy :
> On Wed, 2012-06-27 at 12:11 +0800, Josh Wu wrote:
>> Hi, Artem
>> 
>> On 6/27/2012 11:49 AM, Artem Bityutskiy wrote:
>>> On Mon, 2012-06-25 at 18:07 +0800, Josh Wu wrote:
>>>> Those patches is based on v3.5-rc4
>>>> 
>>>> Changes since v10, add one more patch in this patch set,
>>>> which add 'int' return value for
>>>> write_page()/write_page_raw() functions in structure of
>>>> nand_ecc_ctrl. Instead of calling BUG(),
>>>> atmel_nand_pmecc_write_page() will return -EIO when time out
>>>> to read the pmecc status register. increase the time-out
>>>> duration to 100ms, which has more toleration. add
>>>> oob_required argument for pmecc read/write functions to align
>>>> with v3.5-rc4.
>>> I have issues compiling l2-mtd.git tree (based on 3.5-rc5) with
>>> the attached defconfig. Probably not your fault, but may be you
>>> have a fix/suggestion? I did not have time to look closer.
>>> Aiaiai reports:
>> 
>> I think the name of kernel config for AT91 is changed, so you can
>> try add following two line in your original config file.
>> 
>> CONFIG_SOC_AT91SAM9=y CONFIG_SOC_AT91RM9200=y
>> 
>> run the make menuconfig will get new config, that can pass the
>> compile.
> 
> I get "arm-unknown-linux-gnueabi-ld: no machine record defined". I
> think it wants me to select the board. I've tried one and get
> another compilation issue:
> 
> arch/arm/mach-at91/built-in.o:(.arch.info.init+0xbc): undefined 
> reference to `at91sam926x_timer'
> 
> It looks like AT91 stuff is not looked after carefully.

AT91 is looked after carefully, yes it is.

The thing is that CAP9 SoC (the defconfig that you are using)
has been obsoleted then removed for 3.4:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=9918ceafd4a9e013572e03983f528017c29bb1cb

Defconfigs for AT91 may need some update though.

Best regards,
- -- 
Nicolas Ferre


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJP6sORAAoJEAf03oE53VmQyEoIAIhnUw2Vjv5xNQymHDXBqzEK
PwiLwOQROSQ2bFBqfYmV5vZ5FglYa0v+dnNu8bJ7Fpah5KlHPNDWb3r+0HKQfaep
CzyZnDHhNA+QL3GnirCiyal9GtDrhJzPdnkrO4SFvS6c72AptqSAyOEGMZGenhaT
dnyLsHj7m5Po5OGmiSpKwJfv2S8YFQLLWYyMcNe/lkyE/QhYVb3kX8C3gm24nSnA
s80j9O1a6SLdRBZRh+jPFjKNUZMcWVN+DIuJnoUOUeDpU4en3PRGJ/88VSxs4k/c
xUXkpx7m8QXVCs5khMpKXkK5fj5dATuUjlzslI3FFZTDCjYf5eXzv/6ZupVutI0=
=8MqL
-----END PGP SIGNATURE-----
