From: stripathi@apm.com (Suman Tripathi)
Date: Mon, 1 Feb 2016 11:45:00 -0800
Subject: [PATCH v2 1/3] ata: Remove the AHCI_HFLAG_EDGE_IRQ support from
 libahci.
In-Reply-To: <20160131113249.GW32380@htj.duckdns.org>
References: <1453888197-11368-1-git-send-email-stripathi@apm.com>
 <1453888197-11368-2-git-send-email-stripathi@apm.com>
 <20160131113249.GW32380@htj.duckdns.org>
Message-ID: <CAOHikRBbTafF68qF9n+HNo4p6bwAShZtObw8sPDe45QmG0Xxiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 31, 2016 at 3:32 AM, Tejun Heo <htejun@gmail.com> wrote:
> On Wed, Jan 27, 2016 at 03:19:55PM +0530, Suman Tripathi wrote:
>> This patch removes the AHCI_HFLAG_EDGE_IRQ support from libahci.
>> The upcoming patches will have the flexibility to override
>> irq handlers in the LLD's. Controller's implementing a EDGE trigger
>> latch can implement their own interrupt handler inside the driver.
>>
>> Signed-off-by: Suman Tripathi <stripathi@apm.com>
>
> Shouldn't this patch come after the irq override is in place?
>
> 1. introduce irq override.
>
> 2. remove AHCI_HFLAG_EDGE_IRQ by moving the edge triggered handler to
>    ahci_xgene.
>
> 3. Update xgene irq handler to address the erratum.

Thought of remove the AHCI_HFLAG_EDGE entirely first because we don't
require it . Then implement the irq override capability.
>
> Thanks.
>
> --
> tejun



-- 
Thanks,
with regards,
Suman Tripathi
