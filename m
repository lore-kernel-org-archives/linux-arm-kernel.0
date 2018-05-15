From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Tue, 15 May 2018 10:39:30 +0200
Subject: [PATCH v3 0/8] PCI: leak fixes, removable generic PCI host,
 assorted stuff
In-Reply-To: <72f23e5f-4641-9ef3-09e6-70c4724f21a4@mentor.com>
References: <cover.1526363896.git.jan.kiszka@siemens.com>
 <72f23e5f-4641-9ef3-09e6-70c4724f21a4@mentor.com>
Message-ID: <8f40ba94-d730-5f45-c113-2cd53c722467@siemens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-05-15 09:58, Vladimir Zapolskiy wrote:
> Hi Jan,
> 
> On 05/15/2018 08:58 AM, Jan Kiszka wrote:
>> Changes in v3:
>>  - refactor series to be both bisectable and simpler while reworking
>>    of_pci_get_host_bridge_resources()
>>  - include of_pci_get_host_bridge_resources() removal
>>  - include devm_of_pci_get_host_bridge_resources() error path fixes
>>  - effectively, no functional changes to v2
> 
> while the previous version of the changeset plus the fixup found on Bjorn's
> pci/resource branch is sufficient, I can't argue with the fact that this
> series is way better.

0day-testing found a build breakage in the middle of the old series.
Wasn't straightforward to fix, so Bjorn suggested a different series
structure which I try to implement with v3.

> 
> In case if this series is accepted I'll review and test the fix of
> of_pci_get_host_bridge_resources() memleak again, no worries.

Thanks, will address that issue first.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
