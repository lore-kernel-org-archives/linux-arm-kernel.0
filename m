From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 28 Apr 2015 17:34:09 +0100
Subject: [RFC 5/6] usb: gadget: atmel_usba: use atmel_io.h to provide
 on-chip IO
In-Reply-To: <20150428163057.GE18263@saruman.tx.rr.com>
References: <1427370354-21247-1-git-send-email-ben.dooks@codethink.co.uk>
 <1427370354-21247-6-git-send-email-ben.dooks@codethink.co.uk>
 <20150326115647.GD16148@samfundet.no>
 <20150427205529.GH25136@saruman.tx.rr.com> <553FA9DE.20406@codethink.co.uk>
 <20150428163057.GE18263@saruman.tx.rr.com>
Message-ID: <553FB681.4040505@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 28/04/15 17:30, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Apr 28, 2015 at 04:40:14PM +0100, Ben Dooks wrote:
>>>>> /* Register access macros */ -#ifdef CONFIG_AVR32 -#define 
>>>>> usba_io_readl	__raw_readl -#define usba_io_writel
>>>>> __raw_writel -#define usba_io_writew	__raw_writew -#else
>>>>> -#define usba_io_readl	readl_relaxed -#define
>>>>> usba_io_writel writel_relaxed -#define usba_io_writew
>>>>> writew_relaxed -#endif +#define usba_io_readl
>>>>> atmel_oc_readl +#define usba_io_writel atmel_oc_writel
>>>>> +#define usba_io_writew	atmel_oc_writew
>>>> 
>>>> Same comment as earlier patch, it would be nice to remove
>>>> the define usba_io_{read,write}{l,w} defines in a follow-up
>>>> patch.
>>> 
>>> I'm fine with this too. Is this targetted at v4.2 ?
>> 
>> Yes, although we may move it to the soc specific include
>> directories to avoid adding more to linux/
>> 
>> I will be sorting this out next week.
> 
> I would rather not see drivers including anything from asm or
> mach-* (unless strictly necessary), otherwise it's a pain to
> build-test anything


Thanks. I think the soc/ include is available for all. I will check this
tomorrow.


- -- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVP7aBAAoJEMuhVOkVU3uzId4H/3ZsZ4Vogng63I04OpLtt5Qs
VopvttCvaLczye/wOWQKptXJuKIBmrs66BcV4ZsVi1SZjfbju9X1blzc0+6fxU9X
xE2rw3kDPZmtKm6v1GCRrE/uzhKeKgAnfp7Yf7pkdn98Lx2D9gy/s7GRN6Bkql28
pz/QIqr/H6Hp2frbubakKx/F7SFV88ZUNZXLkw8+vkn7gKGRX7ODcPFldjbjooIa
zyDdrZWiqhTHdWzQ813vNgKJfP1GiYNZuht+EhAh0ngLy0YnqnSXF0eZiOy/uF0Z
cCMlXZo1Q/2LkqVKEgywJDxGhCruT3RpPDWLk6eA9trlHF62j3WSn65nDxKtBwA=
=cqtq
-----END PGP SIGNATURE-----
