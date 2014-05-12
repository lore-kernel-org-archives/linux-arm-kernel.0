From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 12 May 2014 16:09:56 +0300
Subject: [PATCH] remoteproc: da8xx: don't select CMA on no-MMU
In-Reply-To: <1399560990-1402858-18-git-send-email-arnd@arndb.de>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-18-git-send-email-arnd@arndb.de>
Message-ID: <CAK=WgbZ1c6=_MT0tb0X_E58ia=bSSGc5o_kHV_g0jJuDCtB5oA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, May 8, 2014 at 5:56 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> We can only use CMA on systems that have an MMU, because of
> the requirement to use memory migration. NOMMU systems are
> rather constrained to start with, but it seems reasonable
> to assume that DMA allocations can still succeed in the
> constrained case for remoteproc on NOMMU, so this patch
> changes the da8xx implementation to not rely on CMA when
> the MMU is disabled.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: Robert Tivy <rtivy@ti.com>
> ---

Would you like me to pick this via the remoteproc tree or are you
planning to route this set elsewhere anyway?

Thanks,
Ohad.
