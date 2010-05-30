From: martin.ereth@arcor.de (Martin Ereth)
Date: Sun, 30 May 2010 17:16:42 +0200
Subject: strange characters on serial port when booting kernel on at91sam9263
	board
Message-ID: <4C02815A.8090402@arcor.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I have a board which is based on the AT91SAM9263-EK but with a little
but annoying difference: SDRAM is smaller.

Thus I cannot use prebuilt images. I've compiled AT91Bootstrap-1.15
which directly loads the linux kernel (2.6.34).
I've tried a linux kernel built with buildroot and one compiled on my
own using the toolchain of buildroot. Both are in uncompressed uImage
format.

When watching the serial port I get the output shown here [1]. After the
last line, part [2] shows up. That looks like a wrong speed of the
serial port. But I've tried all known speeds (using cu) but no good
characters are showing up. :(

The serial port is configured for 115200 baud. I am starting linux with
console=ttyS0,115200.

I think this is a problem with the kernel, maybe a wrong frequency or
baud rate?

What can I try to get the kernel running on this board?
Is it better to compile the kernel on my own? What patches are recommended?
Do I need to change the SDRAM size somewhere in the kernel sources or is
this detected automatically?

Thanks a lot in advance,
Martin


[1] (please do not feel disturbed by some debugging output)
RomBOOT
>Start AT91Bootstrap...
init SDRAM
init sdramc_hw
sdramc_hw ok
SDRAM ok
======= load image header from nandflash =======
init nandflash_hw
nandflash_hw init ok
nandflash_cfg_8bits_dbw_init ok
======= load image from nandflash =======
init nandflash_hw
nandflash_hw init ok
nandflash_cfg_8bits_dbw_init ok
======= jump to entry point =======
Uncompressing Linux... done, booting the kernel.

[2]
?*S???N???A?
            ?1?Y?HWK???x*??A?
                              ???V?,1?q?*P/?????Y$?a?#
                                                      ???e?1
(and so on)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkwCgVkACgkQE5UqXaCvB8LyPgCgkjIUi3cMCOTzxqFey+OqKtE5
qq4AoLFu5OHbima0ipQNuj6PZ7qOH8Fq
=vfNO
-----END PGP SIGNATURE-----
