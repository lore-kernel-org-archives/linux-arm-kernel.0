From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Thu, 3 May 2018 09:52:16 +0200
Subject: [PATCH v2 00/10] PCI: leak fixes, removable generic PCI host,
 assorted stuff
In-Reply-To: <e15c1cf5-0844-e5f1-d7af-e196207be6d4@mentor.com>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
 <e15c1cf5-0844-e5f1-d7af-e196207be6d4@mentor.com>
Message-ID: <cc97108e-f3db-fc0c-3a88-ced7291be617@siemens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Vladimir,

On 2018-05-03 09:12, Vladimir Zapolskiy wrote:
> Hi Jan,
> 
> On 04/30/2018 08:48 AM, Jan Kiszka wrote:
>> Changes in v2:
>>  - patch 1: commit message reworking as suggested by Lorenzo
>>  - patch 3-6: split-up as suggested by Bjorn
>>  - patch 8: new
>>  - patch 10: select PCI_DOMAINS from PCI_HOST_GENERIC, rather than
>>    allowing manual choice, as suggested by Lorenzo
>>
>> This primarily enables to unbind the generic PCI host controller without
>> leaving lots of memory leaks behind. A previous proposal patch 5 was
>> rejected because of those issues [1].
>>
>> The fixes have been validated in the Jailhouse setup, where we add and
>> remove a virtual PCI host controller on hypervisor activation/
>> deactivation, with the help of kmemleak.
> 
> by chance I was looking into a memleak in of_pci_get_host_bridge_resources(),
> so I can give you a number of review tags.

Thanks for the reviews and tests! And the pointer for the maintainers to
the conflict around patch 7.

> 
> FWIW the state of unfixably broken https://patchwork.kernel.org/patch/9662893/
> should be changed to obsoleted/deprecated/rejected.

Indeed.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
