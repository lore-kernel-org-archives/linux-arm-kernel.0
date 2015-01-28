From: robh@kernel.org (Rob Herring)
Date: Wed, 28 Jan 2015 09:34:10 -0600
Subject: [PATCH] ARM: cns3xxx: fix typo in PCI config accessor
In-Reply-To: <20150128151712.GA12050@google.com>
References: <2000255.rnmr9HfSOg@wuerfel> <20150128151712.GA12050@google.com>
Message-ID: <CAL_Jsq+-Tn=nCAVAE8sqPD1_aHBSv4jTdAZxWS4B3cOYaGgdow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 9:17 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Wed, Jan 28, 2015 at 02:53:07PM +0100, Arnd Bergmann wrote:
>> The recent patch to convert the cns3xxx PCI code added an
>> extraneous opening bracket, which makes the build fail,
>> so remove this.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Fixes: 10e2c5540d48 ("ARM: cns3xxx: Convert PCI to use generic config accessors")
>> ---
>>
>> Hi Bjorn,
>>
>> The broken patch just showed up in linux-next. Please apply this one on top,
>> or fold it into the original patch if you don't mind rebasing.
>
> I folded it in, thanks!  I guess Fengguang's autobuilder must not build
> this config, because I got a success report from it.

Sorry about this. I had fixed this in my tree, but forgot to send out
the update. I've double checked and this was the only fix I had.

How do you get success reports? I only ever get failures.

Rob

>
>> diff --git a/arch/arm/mach-cns3xxx/pcie.c b/arch/arm/mach-cns3xxx/pcie.c
>> index e41fc339d100..c622c306c390 100644
>> --- a/arch/arm/mach-cns3xxx/pcie.c
>> +++ b/arch/arm/mach-cns3xxx/pcie.c
>> @@ -101,7 +101,7 @@ static int cns3xxx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
>>                * for a PCIe bridge. So we must fixup the class code
>>                * to 0x604 here.
>>                */
>> -             *val = (((((*val << shift) & 0xff) | (0x604 << 16)) >> shift) & mask;
>> +             *val = ((((*val << shift) & 0xff) | (0x604 << 16)) >> shift) & mask;
>>
>>       return ret;
>>  }
>>
