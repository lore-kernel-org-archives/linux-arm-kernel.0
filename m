From: tn@semihalf.com (Tomasz Nowicki)
Date: Mon, 18 Apr 2016 15:33:24 +0200
Subject: [PATCH V6 00/13] Support for generic ACPI based PCI host
 controller
In-Reply-To: <CAKc_7PVC6O4oh+bTmpLQRrhHrqGbaKB2hynecKOLmc5fBc-VVQ@mail.gmail.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <571130BB.9030508@redhat.com>
 <CAKc_7PVC6O4oh+bTmpLQRrhHrqGbaKB2hynecKOLmc5fBc-VVQ@mail.gmail.com>
Message-ID: <5714E224.1030307@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.04.2016 17:31, Jayachandran C wrote:
> On Fri, Apr 15, 2016 at 11:49 PM, Jon Masters <jcm@redhat.com> wrote:
>> On 04/15/2016 01:06 PM, Tomasz Nowicki wrote:
>>>  From the functionality point of view this series might be split into the
>>> following logic parts:
>>> 1. Necessary fixes as the preparation for using driver on ARM64.
>>> 2. New ECAM API and update for users of the pci-host-common API
>>> 3. Use new MCFG interface and implement generic ACPI based PCI host controller driver.
>>> 4. Enable above driver on ARM64
>>>
>>> Patches has been built on top of 4.6-rc2 and can be found here:
>>> git at github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v6)
>>>
>>> This has been tested on Cavium ThunderX server. Any help in reviewing and
>>> testing is very appreciated.
>>>
>>> v5 -> v6
>>> - dropped idea of x86 MMCONFIG code refactoring
>>> - integrated JC's patches which introduce new ECAM API:
>>>    https://lkml.org/lkml/2016/4/11/907
>>>    git: https://github.com/jchandra-brcm/linux/ (arm64-acpi-pci-v3)
>>> - integrated Sinan's fix for releasing IO resources, see patch [06/13]
>>> - added ACPI support for ThunderX ECAM and PEM drivers
>>> - rebased to 4.6-rc2
>>
>> JC: can you explicitly confirm that you're ok with letting Tomasz drive
>> this? We would like to see one driver. Either that is Tomasz, or
>> Lorenzo, or it is you. But we need to have one overall cooordinated
>> effort to get this enablement into upstream as quickly as possible.
>
> I have been concentrating on the ECAM code and ECAM based ACPI
> host controller, the rest of the code is from Tomasz original patchset.
>
> I am not happy with the way the ACPI quirk handling is done in Tomasz's
> current patchset. I believe that it has to be done in a separate patchset
> with another set of discussions. It introduces additional complexity and
> mixing that discussion with the ECAM one will not help in making progress.

Of course we can split discussion into the two topics:
1. ECAM based ACPI host controller - patches [1-10]
2. Quirks handling and examples.

IMO, it is very helpful for reviewers to go with one unified patch set 
and see the whole picture. Also, as you can see, quirks handling allows 
people to test it easily with their servers (not only QEMU but real HW).

Thanks,
Tomasz
