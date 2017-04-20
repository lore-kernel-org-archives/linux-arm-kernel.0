From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Wed, 19 Apr 2017 22:28:30 -0400
Subject: [PATCH V2] scsi: mpt3sas: remove redundant wmb
In-Reply-To: <1491591978-17880-1-git-send-email-okaya@codeaurora.org> (Sinan
 Kaya's message of "Fri, 7 Apr 2017 15:06:18 -0400")
References: <1491591978-17880-1-git-send-email-okaya@codeaurora.org>
Message-ID: <yq1y3uvq0c1.fsf@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sinan Kaya <okaya@codeaurora.org> writes:

> Due to relaxed ordering requirements on multiple architectures,
> drivers are required to use wmb/rmb/mb combinations when they need to
> guarantee observability between the memory and the HW.
>
> The mpt3sas driver is already using wmb() for this purpose.  However,
> it issues a writel following wmb(). writel() function on arm/arm64
> arhictectures have an embedded wmb() call inside.
>
> This results in unnecessary performance loss and code duplication.
>
> writel already guarantees ordering for both cpu and bus. we don't need
> additional wmb()

Broadcom folks, please review!

-- 
Martin K. Petersen	Oracle Linux Engineering
