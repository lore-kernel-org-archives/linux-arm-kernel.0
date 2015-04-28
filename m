From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 28 Apr 2015 16:40:14 +0100
Subject: [RFC 5/6] usb: gadget: atmel_usba: use atmel_io.h to provide
 on-chip IO
In-Reply-To: <20150427205529.GH25136@saruman.tx.rr.com>
References: <1427370354-21247-1-git-send-email-ben.dooks@codethink.co.uk>
 <1427370354-21247-6-git-send-email-ben.dooks@codethink.co.uk>
 <20150326115647.GD16148@samfundet.no>
 <20150427205529.GH25136@saruman.tx.rr.com>
Message-ID: <553FA9DE.20406@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256


>>> 
>>> /* Register access macros */ -#ifdef CONFIG_AVR32 -#define
>>> usba_io_readl	__raw_readl -#define usba_io_writel	__raw_writel 
>>> -#define usba_io_writew	__raw_writew -#else -#define
>>> usba_io_readl	readl_relaxed -#define usba_io_writel
>>> writel_relaxed -#define usba_io_writew	writew_relaxed -#endif 
>>> +#define usba_io_readl	atmel_oc_readl +#define usba_io_writel
>>> atmel_oc_writel +#define usba_io_writew	atmel_oc_writew
>> 
>> Same comment as earlier patch, it would be nice to remove the
>> define usba_io_{read,write}{l,w} defines in a follow-up patch.
> 
> I'm fine with this too. Is this targetted at v4.2 ?

Yes, although we may move it to the soc specific include directories
to avoid adding more to linux/

I will be sorting this out next week.

- -- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVP6neAAoJEMuhVOkVU3uz6tQH/jmZ0MszsoDjiKWdTnG+etoy
WUhAEdnmaqPEfJSaBy2OPCcmj9T1O07wg1L/2rHQHBrVuR9bW0gWY/TyJQahnn3A
YG81fgfIvOTAwmxIkaF10mG1/haG1LgPQ4P6j7AaKz09Zowath0rsga17AhYuUyh
bps4Go7yHF/OpjuwB9VxSttMAbVAIHqXbuc5kufN89JAxDT6x5tV/BrqkqEoHpSV
kW7VvGb/V4Aeax1h9klfdUEBlL2czkVuYYtTnicc9lFN3T9+6XJ+SNwKLtSklEr3
SLM78DoIQQoKYWCf8vsg0FR0E9LeR1ytgZXPfOpdAoId+iZt39tBk9bMi/XOiBo=
=ceej
-----END PGP SIGNATURE-----
