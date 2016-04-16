From: jchandra@broadcom.com (Jayachandran C)
Date: Sat, 16 Apr 2016 21:01:28 +0530
Subject: [PATCH V6 00/13] Support for generic ACPI based PCI host
 controller
In-Reply-To: <571130BB.9030508@redhat.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <571130BB.9030508@redhat.com>
Message-ID: <CAKc_7PVC6O4oh+bTmpLQRrhHrqGbaKB2hynecKOLmc5fBc-VVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2016 at 11:49 PM, Jon Masters <jcm@redhat.com> wrote:
> On 04/15/2016 01:06 PM, Tomasz Nowicki wrote:
>> From the functionality point of view this series might be split into the
>> following logic parts:
>> 1. Necessary fixes as the preparation for using driver on ARM64.
>> 2. New ECAM API and update for users of the pci-host-common API
>> 3. Use new MCFG interface and implement generic ACPI based PCI host controller driver.
>> 4. Enable above driver on ARM64
>>
>> Patches has been built on top of 4.6-rc2 and can be found here:
>> git at github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v6)
>>
>> This has been tested on Cavium ThunderX server. Any help in reviewing and
>> testing is very appreciated.
>>
>> v5 -> v6
>> - dropped idea of x86 MMCONFIG code refactoring
>> - integrated JC's patches which introduce new ECAM API:
>>   https://lkml.org/lkml/2016/4/11/907
>>   git: https://github.com/jchandra-brcm/linux/ (arm64-acpi-pci-v3)
>> - integrated Sinan's fix for releasing IO resources, see patch [06/13]
>> - added ACPI support for ThunderX ECAM and PEM drivers
>> - rebased to 4.6-rc2
>
> JC: can you explicitly confirm that you're ok with letting Tomasz drive
> this? We would like to see one driver. Either that is Tomasz, or
> Lorenzo, or it is you. But we need to have one overall cooordinated
> effort to get this enablement into upstream as quickly as possible.

I have been concentrating on the ECAM code and ECAM based ACPI
host controller, the rest of the code is from Tomasz original patchset.

I am not happy with the way the ACPI quirk handling is done in Tomasz's
current patchset. I believe that it has to be done in a separate patchset
with another set of discussions. It introduces additional complexity and
mixing that discussion with the ECAM one will not help in making progress.

I hope things will be clearer when more maintainers chime in. When
there is clarity on if the ECAM split is fine, I think we can look at how
to drive the whole patchset forward, otherwise we are back to square one.

> Some of the Enterprise folks are going to otherwise end up in a very
> nasty situation of supporting the previous non-upstream patches for many
> years, which is absolutely something we want to avoid...

Not having ACPI/PCI support upstream is a huge problem for us too...

JC.
