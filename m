From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 27 Sep 2016 09:50:31 +0100
Subject: ARM juno R2 board USB Issue (EHCI probe failed)
In-Reply-To: <CAGm_ybhc4DKYkDtE8dVzhC3-kJk138Lbm-zAhepQiyUnuqZQHg@mail.gmail.com>
References: <AT5PR84MB005284C92DEA45ADF67A4F55D9CC0@AT5PR84MB0052.NAMPRD84.PROD.OUTLOOK.COM>
 <CAGm_ybhc4DKYkDtE8dVzhC3-kJk138Lbm-zAhepQiyUnuqZQHg@mail.gmail.com>
Message-ID: <22e151c5-fc83-a48c-b130-f633fac8674f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vikas,

On 27/09/16 09:14, Vikas Sajjan wrote:
> Adding USB mailing list.
>
>
> On Tue, Sep 27, 2016 at 12:33 PM, Sajjan, Vikas C
> <vikas.cha.sajjan@hpe.com> wrote:
>> Hi All,
>>
>> I working on ARM juno R2 board, with latest kernel 4.8.rc7 and I get below
>> USB EHCI probe error while booting with acpi=force.
>>

Are you using the latest UEFI EDK2 ?

>> [    1.223662] VFIO - User Level meta-driver version: 0.3
>> [    1.229335] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
>> [    1.235882] ehci-pci: EHCI PCI platform driver
>> [    1.240359] ehci-platform: EHCI generic platform driver
>> [    1.245619] ehci-platform ARMH0D20:00: Error: DMA mask configuration failed
>> [    1.272491] ehci-platform: probe of ARMH0D20:00 failed with error -5
>> [    1.278876] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
>> [    1.285071] ohci-pci: OHCI PCI platform driver
>> [    1.289548] ohci-platform: OHCI generic platform driver
>> [    1.294884] usbcore: registered new interface driver usb-storage
>> [    1.301231] mousedev: PS/2 mouse device common for all mice
>> [    1.307197] rtc-efi rtc-efi: rtc core: registered rtc-efi as rtc0
>>
>> But this error goes off, if I don't force ACPI booting, i.e., if I remove
>> acpi=force from kernel command line , USB is detected  and my RFS which is
>> in the usb drive, gets mounted successfully.
>>

As I mentioned in private, I do get the same error if I drop _CCA in
USB object of ACPI DSDT. Can you give it a spin with latest UEFI ?

-- 
Regards,
Sudeep
