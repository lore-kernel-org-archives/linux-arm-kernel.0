From: brking@linux.vnet.ibm.com (Brian King)
Date: Fri, 21 Apr 2017 10:10:57 -0500
Subject: [PATCH V2] scsi: mpt3sas: remove redundant wmb
In-Reply-To: <CAK=zhgpmcmq-CnWuU9=WRJpAaEduw63LSPLE9yZzF_sUHkM4AA@mail.gmail.com>
References: <1491591978-17880-1-git-send-email-okaya@codeaurora.org>
 <yq1y3uvq0c1.fsf@oracle.com>
 <CAK=zhgpmcmq-CnWuU9=WRJpAaEduw63LSPLE9yZzF_sUHkM4AA@mail.gmail.com>
Message-ID: <c83bd8cf-cd83-f1d2-b982-a0cacf81370f@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2017 02:56 AM, Sreekanth Reddy wrote:
> On Thu, Apr 20, 2017 at 7:58 AM, Martin K. Petersen
> <martin.petersen@oracle.com> wrote:
>> Sinan Kaya <okaya@codeaurora.org> writes:
>>
>>> Due to relaxed ordering requirements on multiple architectures,
>>> drivers are required to use wmb/rmb/mb combinations when they need to
>>> guarantee observability between the memory and the HW.
>>>
>>> The mpt3sas driver is already using wmb() for this purpose.  However,
>>> it issues a writel following wmb(). writel() function on arm/arm64
>>> arhictectures have an embedded wmb() call inside.
> 
> [Sreekanth] Whether same thing applicable for SPARC & POWER
> architectures. If yes then we are fine with this patch changes.

This is also true for Power. 

Reviewed-by: Brian King <brking@linux.vnet.ibm.com>

-Brian

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center
