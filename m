From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Fri, 6 Jul 2018 10:26:19 -0700
Subject: [PATCH] soc: ti: wkup_m3_ipc: mark PM functions as __maybe_unused
In-Reply-To: <20180706123651.2792927-1-arnd@arndb.de>
References: <20180706123651.2792927-1-arnd@arndb.de>
Message-ID: <b87566e9-c398-d390-e029-0a28b2c7fbf9@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/6/18 5:36 AM, Arnd Bergmann wrote:
> Everyone gets these #ifdefs wrong, leading to another warning here:
> 
> drivers/soc/ti/wkup_m3_ipc.c:547:12: error: 'wkup_m3_ipc_resume' defined but not used [-Werror=unused-function]
>   static int wkup_m3_ipc_resume(struct device *dev)
> drivers/soc/ti/wkup_m3_ipc.c:539:12: error: 'wkup_m3_ipc_suspend' defined but not used [-Werror=unused-function]
>   static int wkup_m3_ipc_suspend(struct device *dev)
> 
> The easiest way to get it right is to remove all the #ifdefs and
> let the compiler drop the unused functions silently after we
> mark them as __maybe_unused.
> 
> Fixes: 7a872b6fb7fd ("soc: ti: wkup_m3_ipc: Add rtc_only with ddr in self refresh mode support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
Applied. Thanks Arnd !!

Regards,
Santosh
