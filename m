From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 27 Aug 2014 11:20:43 -0700
Subject: [RFC 2/7] bcm47xx-nvram: add new broadcom nvram driver with dt
 support
In-Reply-To: <CACna6rwJBDpg9VS4h5hfP4wtGRVwAdRUq5mELeA0OFWWzH9jsA@mail.gmail.com>
References: <1408915485-8078-1-git-send-email-hauke@hauke-m.de>
 <1408915485-8078-4-git-send-email-hauke@hauke-m.de>
 <CACna6rwJBDpg9VS4h5hfP4wtGRVwAdRUq5mELeA0OFWWzH9jsA@mail.gmail.com>
Message-ID: <53FE217B.7000401@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/26/2014 10:54 PM, Rafa? Mi?ecki wrote:
> On 24 August 2014 23:24, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>> +On NorthStar ARM SoCs the NAND flash is available at 0x1c000000 and the
>> +NOR flash is at 0x1e000000
>> +
>> +Example:
>> +
>> +nvram0: nvram at 0 {
>> +       compatible = "brcm,bcm47xx-nvram";
>> +       reg = <0x1c000000 0x01000000>;
>> +};
> 
> Could we avoid that? Type of flash can easily be checked in the code.
> All we need to do is to read BCMA_IOST register of BCMA_CORE_NS_ROM
> core.

So there is a boot status register you can read to tell what type of
flash you booted from, but does that also give you the resource ranges
for these type of flashes? Presumably they will be mapped into different
addresses (at least bcm63xx is like that), that information needs to be
listed somewhere.
--
Florian
