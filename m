From: sreekanth.reddy@broadcom.com (Sreekanth Reddy)
Date: Fri, 21 Apr 2017 13:26:29 +0530
Subject: [PATCH V2] scsi: mpt3sas: remove redundant wmb
In-Reply-To: <yq1y3uvq0c1.fsf@oracle.com>
References: <1491591978-17880-1-git-send-email-okaya@codeaurora.org>
 <yq1y3uvq0c1.fsf@oracle.com>
Message-ID: <CAK=zhgpmcmq-CnWuU9=WRJpAaEduw63LSPLE9yZzF_sUHkM4AA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 20, 2017 at 7:58 AM, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
> Sinan Kaya <okaya@codeaurora.org> writes:
>
>> Due to relaxed ordering requirements on multiple architectures,
>> drivers are required to use wmb/rmb/mb combinations when they need to
>> guarantee observability between the memory and the HW.
>>
>> The mpt3sas driver is already using wmb() for this purpose.  However,
>> it issues a writel following wmb(). writel() function on arm/arm64
>> arhictectures have an embedded wmb() call inside.

[Sreekanth] Whether same thing applicable for SPARC & POWER
architectures. If yes then we are fine with this patch changes.

>>
>> This results in unnecessary performance loss and code duplication.
>>
>> writel already guarantees ordering for both cpu and bus. we don't need
>> additional wmb()
>
> Broadcom folks, please review!
>
> --
> Martin K. Petersen      Oracle Linux Engineering
