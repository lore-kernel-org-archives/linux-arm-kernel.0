From: bhelgaas@google.com (Bjorn Helgaas)
Date: Fri, 26 Feb 2016 13:34:30 -0600
Subject: next-20160225 build: 2 failures 44 warnings (next-20160225)
In-Reply-To: <20160226090830.41a63a86@free-electrons.com>
References: <E1aYsmb-0006qb-76@optimist> <20160226030411.GK18327@sirena.org.uk>
 <20160226090830.41a63a86@free-electrons.com>
Message-ID: <CAErSpo4d_roPQO2XmSvCDexDy_wm-L0GReh_TT6ZR-gdLAyVkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 2:08 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Mark,
>
> On Fri, 26 Feb 2016 12:04:11 +0900, Mark Brown wrote:
>
>> Today's -next fails to build an arm64 allmodconfig due to:
>>
>> >     arm64-allmodconfig
>> > ../drivers/pci/host/pci-mvebu.c:755:12: error: dereferencing pointer to incomplete type 'struct pci_sys_data'
>> > ../drivers/pci/host/pci-mvebu.c:855:31: error: dereferencing pointer to incomplete type 'struct pci_sys_data'
>> > ../drivers/pci/host/pci-mvebu.c:904:16: error: storage size of 'hw' isn't known
>> > ../drivers/pci/host/pci-mvebu.c:919:2: error: implicit declaration of function 'pci_common_init_dev' [-Werror=implicit-function-declaration]
>> > ../drivers/pci/host/pci-mvebu.c:1282:3: error: implicit declaration of function 'pci_ioremap_io' [-Werror=implicit-function-declaration]
>>
>> caused by b4f596b19624 (arm64: add mvebu architecture entry) which
>> enables MVBEU on arm64, the commit was present for a little while and
>> the error cropped up but didn't get reported due to other things masking
>> it.  This looks like the driver needs modernization and probably ought
>> to have a !ARM64 dependency for now.
>
> This has already been fixed by:
>
>         [PATCH] PCI: mvebu: Restrict build to 32-bit ARM
>
> submitted by Thierry Redding. I'm Cc'ing Bjorn, who is the one in
> charge of merging this fix.

I applied Thierry's patch ("PCI: mvebu: Restrict build to 32-bit ARM")
to my for-linus branch, so it should appear in Linus' tree before
v4.5.

Bjorn
