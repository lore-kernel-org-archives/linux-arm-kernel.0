From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 18 Jan 2018 21:43:59 -0500
Subject: [PATCH] scsi: fas216: fix sense buffer initialization
In-Reply-To: <20180118131650.893849-1-arnd@arndb.de> (Arnd Bergmann's message
 of "Thu, 18 Jan 2018 14:16:38 +0100")
References: <20180118131650.893849-1-arnd@arndb.de>
Message-ID: <yq13732o9e8.fsf@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Arnd,

> While testing with the ARM specific memset() macro removed, I ran
> into a compiler warning that shows an old bug:
>
> drivers/scsi/arm/fas216.c: In function 'fas216_rq_sns_done':
> drivers/scsi/arm/fas216.c:2014:40: error: argument to 'sizeof' in 'memset' call is the same expression as the destination; did you mean to provide an explicit length? [-Werror=sizeof-pointer-memaccess]
>
> It turns out that the definition of the scsi_cmd structure changed back
> in linux-2.6.25, so now we clear only four bytes (sizeof(pointer)) instead
> of 96 (SCSI_SENSE_BUFFERSIZE). I did not check whether we actually need
> to initialize the buffer here, but it's clear that if we do it, we
> should use the correct size.

Applied to 4.16/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
