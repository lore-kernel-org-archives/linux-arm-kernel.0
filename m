From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Wed, 27 Aug 2014 20:43:40 +0200
Subject: [RFC 2/7] bcm47xx-nvram: add new broadcom nvram driver with dt
 support
In-Reply-To: <53FE217B.7000401@gmail.com>
References: <1408915485-8078-1-git-send-email-hauke@hauke-m.de>
 <1408915485-8078-4-git-send-email-hauke@hauke-m.de>
 <CACna6rwJBDpg9VS4h5hfP4wtGRVwAdRUq5mELeA0OFWWzH9jsA@mail.gmail.com>
 <53FE217B.7000401@gmail.com>
Message-ID: <CACna6ryXtFwJxBhEoJe+2mZWut24egtgXzzybxQ=rtPn9+X+2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 August 2014 20:20, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 08/26/2014 10:54 PM, Rafa? Mi?ecki wrote:
>> Could we avoid that? Type of flash can easily be checked in the code.
>> All we need to do is to read BCMA_IOST register of BCMA_CORE_NS_ROM
>> core.
>
> So there is a boot status register you can read to tell what type of
> flash you booted from, but does that also give you the resource ranges
> for these type of flashes? Presumably they will be mapped into different
> addresses (at least bcm63xx is like that), that information needs to be
> listed somewhere.

Take a look at find_nvram in nvram_rw.c. It scans the whole region
which is up to 0x02000000 (SI_FLASH2_SZ) size.

In case of NAND limit is slightly different (nfl_boot_size function):
1) On ARM it's 0x800000 or 0x2600000
2) On MIPS it's 0x200000

-- 
Rafa?
