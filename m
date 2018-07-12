From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 12 Jul 2018 12:20:15 +0100
Subject: [RFC PATCH] arm64: topology: Map PPTT node offset to logic
 physical package id
In-Reply-To: <20180712110628.GA16043@arm.com>
References: <1530177508-15298-1-git-send-email-shunyong.yang@hxt-semitech.com>
 <20180712110628.GA16043@arm.com>
Message-ID: <bf1406d7-66db-c854-2f3e-b0b47c533bad@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 12/07/18 12:06, Will Deacon wrote:
> On Thu, Jun 28, 2018 at 05:18:28PM +0800, Shunyong Yang wrote:

[..]

>>
>> And as long as the nodes with Physical package field set in PPTT keeps
>> the real hardware order, the logic id can map to hardware package id to
>> some extent.
>>
>> Hope to get feedback from you.
> 
> I'm assuming this is no longer needed now that we have queued the series
> from Sudeep?
> 

The series relating to topology/numa that you have queued helps us to
re-introduces numa mask check that was reverted partial in v4.18 and is
not related to the issue reported or addressed by this patch.

However, there's no proper solution to the issue reported in this thread
and the one from Andrew Jones[1]. The only solution is to rely on ACPI
firmware for that instead of trying to fix in OS and we have already
merged the patch to fix that in acpi/pptt.c (Commit 30998033f62a ("ACPI
/ PPTT: use ACPI ID whenever ACPI_PPTT_ACPI_PROCESSOR_ID_VALID is set"))

In short, all the know issues are addressed so far and nothing else
needs to be queued for now.

-- 
Regards,
Sudeep

[1]
https://lore.kernel.org/lkml/20180629180308.zdl4taihzv2zwarc at kamzik.brq.redhat.com/T/#t
