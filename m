From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 8 Jun 2017 18:22:43 +0100
Subject: [PATCH v7 0/3] Cavium ThunderX2 SMMUv3 errata workarounds
In-Reply-To: <CAJZ5v0gnjxwBXEQ--u6Sbviks74MXLFWTfN+J90cdDZbO2Q7+w@mail.gmail.com>
References: <1496145821-3411-1-git-send-email-gakula@caviumnetworks.com>
 <20170608163213.GA2216@red-moon>
 <CAJZ5v0gnjxwBXEQ--u6Sbviks74MXLFWTfN+J90cdDZbO2Q7+w@mail.gmail.com>
Message-ID: <f240a847-0799-860e-fa82-97e6d4faf15f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/17 18:13, Rafael J. Wysocki wrote:
> On Thu, Jun 8, 2017 at 6:32 PM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
>> On Tue, May 30, 2017 at 05:33:38PM +0530, Geetha sowjanya wrote:
>>> Cavium ThunderX2 SMMUv3 implementation has two Silicon Erratas.
>>> 1. Errata ID #74
>>>    SMMU register alias Page 1 is not implemented
>>> 2. Errata ID #126
>>>    SMMU doesnt support unique IRQ lines and also MSI for gerror,
>>>    eventq and cmdq-sync
>>>
>>> The following patchset does software workaround for these two erratas.
>>>
>>> This series is based on patchset.
>>> https://www.spinics.net/lists/arm-kernel/msg578443.html
>>
>> Yes so it is not standalone. How are we going to merge these
>> ACPI IORT/ACPICA/SMMU patches - inclusive of:
>>
>> [1] https://www.spinics.net/lists/arm-kernel/msg586458.html
>>
>> Rafael, do ACPICA patches go upstream via the ACPI tree pull request ?
> 
> Not as a rule.
> 
>> To remove dependency on ACPICA changes this series needs updating
>> anyway and for [1] above I think the only solution is for all the
>> patches to go via the ACPI tree (if ACPICA updates go upstream with it).
> 
> I think we may ask Lv to backport the header changes once they have
> been merged into Linux.
> 
> Lv, would that work?

FWIW, I have already sent a PR for the header patch for the new model
IDs to ACPICA upstream. I briefly considered the actual table update as
well, but didn't find time to comprehend the code changes that appeared
to be necessary for that.

Robin.

> 
> Thanks,
> Rafael
> 
